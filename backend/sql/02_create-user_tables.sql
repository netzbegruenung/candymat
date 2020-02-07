-- create table for users
create table candymat_data.person
(
    id         serial primary key,
    first_name character varying(200),
    last_name  character varying(200),
    about      character varying(2000),
    created_at timestamp default now()
);
grant select, update, delete on table candymat_data.person to candymat_person;

-- create table for accounts
create table candymat_data_privat.person_account
(
    person_id     integer primary key references candymat_data.person (id) on delete cascade,
    email         character varying(320) not null unique check (email ~* '^.+@.+\..+$'),
    password_hash character varying(256) not null,
    role          candymat_data.role
);
alter table candymat_data.person
    enable row level security;
create policy update_person on candymat_data.person for update to candymat_person
    with check (id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);
create policy delete_person on candymat_data.person for delete to candymat_person
    using (id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);
create policy select_person_public on candymat_data.person for select to candymat_person
    using (
        (
            select person_account.role
            from candymat_data_privat.person_account
            where person_account.person_id = id
        ) in ('candymat_editor', 'candymat_candidate')
  );
