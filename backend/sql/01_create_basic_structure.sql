\connect candymat_db

-- Create schema for candymat_data
create SCHEMA candymat_data;
create SCHEMA candymat_data_privat;

-- create roles
create role candymat_postgraphile login password 'postgres!dev';
create role candymat_person;
create role candymat_data_anonymous;
create role candymat_editor;
create role candymat_candidate;

grant candymat_editor to candymat_postgraphile;
grant candymat_candidate to candymat_postgraphile;
grant candymat_person to candymat_postgraphile, candymat_candidate, candymat_editor;
grant candymat_data_anonymous to candymat_postgraphile;

create type candymat_data.role as enum (
  'candymat_editor',
  'candymat_candidate',
  'candymat_person'
);

-- set table wide permissions
grant usage on schema candymat_data to candymat_data_anonymous, candymat_person;

-- make functions non executeable w/o further checks
alter default privileges revoke execute on functions from public;
