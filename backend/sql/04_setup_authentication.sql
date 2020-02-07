create extension if not exists "pgcrypto";

-- Define JWT claim structure
create type candymat_data.jwt_token as (
  role text,
  person_id integer,
  exp bigint
);

create function candymat_data.current_person() returns candymat_data.person as $$
  select *
  from candymat_data.person
  where id = nullif(current_setting('jwt.claims.person_id', true), '')::integer
$$ language sql stable;
grant execute on function candymat_data.current_person() to candymat_person;

create function candymat_data.register_person(
    first_name text,
    last_name text,
    email text,
    password text
) returns candymat_data.person as $$
declare
    person candymat_data.person;
begin
    insert into candymat_data.person (first_name, last_name)
    values ($1, $2)
    returning * into person;

    insert into candymat_data_privat.person_account (person_id, email, password_hash)
    values (person.id, $3, crypt($4, gen_salt('bf')));

    return person;
end;
$$ language plpgsql strict security definer;
grant execute on function candymat_data.register_person(text, text, text, text) to candymat_data_anonymous;

create function candymat_data.authenticate(
  email text,
  password text
) returns candymat_data.jwt_token as $$
declare
    account candymat_data_privat.person_account;
begin
    select a.*
    into account
    from candymat_data_privat.person_account as a
    where a.email = $1;

    if account.password_hash = crypt(password, account.password_hash) then
        return (account.role, account.person_id,
                extract(epoch from (now() + interval '2 days')))::candymat_data.jwt_token;
    else
        return null;
    end if;
end;
$$ language plpgsql strict security definer;
grant execute on function candymat_data.authenticate(text, text) to candymat_data_anonymous, candymat_person;

create function candymat_data.change_role(
  person_id text,
  new_role candymat_data.role
) returns candymat_data.person as $$
begin
    update candymat_data_privat.person_account
    set person_account.role = new_role
    where person_account.person_id = $1;

    select *
    from candymat_data.person
    where person.id = person_id;
end;
$$ language plpgsql;
grant execute on function candymat_data.change_role(text, candymat_data.role) to candymat_editor;
