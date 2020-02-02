create extension if not exists "pgcrypto";

-- create roles
create role candymat_data_postgraphile login password 'postgres!dev';
create role candymat_data_editor;
grant candymat_data_editor to candymat_data_postgraphile;
create role candymat_data_candidate;
grant candymat_data_candidate to candymat_data_postgraphile;
create role candymat_data_person;
grant candymat_data_person to candymat_data_postgraphile, candymat_data_candidate, candymat_data_editor;
create role candymat_data_anonymous;
grant candymat_data_anonymous to candymat_data_postgraphile;

-- set table wide permissions
grant usage on schema candymat_data to candymat_data_anonymous, candymat_data_person;

grant select on table candymat_data.person to candymat_data_anonymous, candymat_data_person;
grant select on table candymat_data.person_account to candymat_data_person;
grant update, delete on table candymat_data.person to candymat_data_person;
grant delete on table candymat_data.person_account to candymat_data_person;
grant update on table candymat_data.person_account to candymat_data_editor;

grant select on table candymat_data.person to candymat_data_anonymous, candymat_data_person;
grant select on table candymat_data.answer to candymat_data_anonymous, candymat_data_person;
grant select on table candymat_data.question to candymat_data_anonymous, candymat_data_person;
grant select on table candymat_data.category to candymat_data_anonymous, candymat_data_person;

grant insert, update, delete on table candymat_data.question to candymat_data_editor;
grant insert, update, delete on table candymat_data.question to candymat_data_editor;
grant usage on sequence candymat_data.question_id_seq to candymat_data_editor;
grant usage on sequence candymat_data.category_id_seq to candymat_data_editor;

grant insert, update, delete on table candymat_data.answer to candymat_data_candidate;
grant delete on table candymat_data.answer to candymat_data_editor;


-- define helper functions
alter default privileges revoke execute on functions from public;

create function candymat_data.person_full_name(person candymat_data.person) returns text as $$
  select person.first_name || ' ' || person.last_name
$$ language sql stable;
grant execute on function candymat_data.person_full_name(candymat_data.person) to candymat_data_anonymous, candymat_data_person;

create function candymat_data.register_person(
  first_name text,
  last_name text,
  email text,
  new_password text
) returns candymat_data.person as $$
declare
  person candymat_data.person;
begin
  insert into candymat_data.person (first_name, last_name) values
    (first_name, last_name)
    returning * into person;

  insert into candymat_data.person_account (person_id, email, password_hash) values
    (person.id, email, crypt(new_password, gen_salt('bf')));

  return person;
end;
$$ language plpgsql strict security definer;
grant execute on function candymat_data.register_person(text, text, text, text) to candymat_data_anonymous;

-- jwt token stuff
create type candymat_data.jwt_token as (
  role text,
  person_id integer,
  exp bigint
);

create function candymat_data.authenticate(
  email text,
  password text
) returns candymat_data.jwt_token as $$
declare
  account candymat_data.person_account;
  account_role candymat_role;
begin
  select a.* into account
  from candymat_data.person_account as a
  where a.email = $1;

  select * into account_role from candymat_data.account_role
  where person_id = account.id;

  if account.password_hash = crypt(password, account.password_hash) then
    return (account_role.candymat_role, account.person_id, extract(epoch from (now() + interval '2 days')))::candymat_data.jwt_token;
  else
    return null;
  end if;
end;
$$ language plpgsql strict security definer;
grant execute on function candymat_data.authenticate(text, text) to candymat_data_anonymous, candymat_data_person;

create function candymat_data.current_person() returns candymat_data.person as $$
  select *
  from candymat_data.person
  where id = nullif(current_setting('jwt.claims.person_id', true), '')::integer
$$ language sql stable;
grant execute on function candymat_data.current_person() to candymat_data_anonymous, candymat_data_person;


-- Row level security

alter table candymat_data.person enable row level security;
alter table candymat_data.person_account enable row level security;
alter table candymat_data.answer enable row level security;

-- Account access control
-- Everyone can view persons if their role is either candidates or editors 
create policy select_person_public on candymat_data.person for select
  using (
    (
      select candymat_role 
      from candymat_data.person_account 
      where person_account.person_id = id
    ).candymat_role in ('editor', 'candidate')
  );

-- persons can view there own details and role
create policy select_person_account on candymat_data.person_account for select to candymat_data_person
  using (person_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);

-- persons can delete own entry in person
create policy delete_person on candymat_data.person for delete to candymat_data_person
  using (id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);
create policy delete_person_account on candymat_data.person_account for delete to candymat_data_person
  using (person_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);
-- persons can update own account details (except their role)
create policy update_person on candymat_data.person for update to candymat_data_person
  with check (id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);
create policy update_person_account on candymat_data.person_account for update to candymat_data_person
  with check (person_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);

-- editors can view every person and update their role
create policy select_person_editor on candymat_data.person for select to candymat_data_editor
  using (true);
create policy select_person_account_editor on candymat_data.person_account for select to candymat_data_editor
  using (true);

-- only candidate can write answer and only update the own answer
create policy insert_answer on candymat_data.answer for insert to candymat_data_candidate
  with check (person_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);
create policy update_answer on candymat_data.answer for update to candymat_data_candidate
  with check (person_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);
create policy delete_answer on candymat_data.answer for delete to candymat_data_candidate
  using (person_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);

-- role management helper functions
create function candymat_data.change_role(
  person_id text,
  new_role candymat_role
) returns candymat_data.person as $$
begin
  update candymat_data.person_account 
  set person_account.candymat_role = new_role
  where person_account.person_id = person_id;

  select * 
  from candymat_data.person
  where person.id = person_id;
end;
$$ language plpgsql;
grant execute on function candymat_data.change_role(text, candymat_role) to candymat_data_editor;
