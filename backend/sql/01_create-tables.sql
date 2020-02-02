\connect candymat_db

-- Create schema for candymat_data
create SCHEMA candymat_data;

create type candymat_role as enum (
  'editor',
  'candidate',
  'person'
);

-- create table for users
create table candymat_data.person (
  id               serial primary key,
  first_name       character varying(200),
  last_name        character varying(200),
  about            character varying(2000),
  created_at       timestamp default now()
);

-- create table for accounts
create table candymat_data.person_account (
  person_id        integer primary key references candymat_data.person(id) on delete cascade,
  email            character varying(320) not null unique check (email ~* '^.+@.+\..+$'),
  password_hash    character varying(256) not null,
  candymat_role    candymat_role not null default 'person'
);

-- create table for categories
create table candymat_data.category (
    id serial primary key,
    title character varying(300) UNIQUE NOT NULL,
    description character varying(5000)
);

-- create table for questions
create table candymat_data.question (
    id serial primary key,
    category_id integer REFERENCES candymat_data.category (id) ON UPDATE CASCADE ON DELETE SET NULL,
    text character varying(3000) NOT NULL,
    description character varying(5000)
);

-- create table for answers
create table candymat_data.answer (
    question_id integer REFERENCES candymat_data.question (id) ON UPDATE CASCADE ON DELETE CASCADE,
    person_id integer REFERENCES candymat_data.person (id) ON UPDATE CASCADE ON DELETE CASCADE,
    position integer NOT NULL,
    text character varying(5000),
    primary key (question_id, person_id)
);
