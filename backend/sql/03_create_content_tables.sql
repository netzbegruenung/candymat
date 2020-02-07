-- create table for categories
create table candymat_data.category (
    id              serial primary key,
    title           character varying(300) UNIQUE NOT NULL,
    description     character varying(5000)
);
grant select on table candymat_data.category to candymat_person;
grant insert, update, delete on table candymat_data.category to candymat_editor;
grant usage on sequence candymat_data.category_id_seq to candymat_editor;

-- create table for questions
create table candymat_data.question (
    id              serial primary key,
    category_id     integer REFERENCES candymat_data.category (id) ON UPDATE CASCADE ON DELETE SET NULL,
    text            character varying(3000) NOT NULL,
    description     character varying(5000)
);
grant select on table candymat_data.question to candymat_person;
grant insert, update, delete on table candymat_data.question to candymat_editor;
grant usage on sequence candymat_data.question_id_seq to candymat_editor;

-- create table for answers
create table candymat_data.answer(
                                     question_id integer REFERENCES candymat_data.question (id) ON UPDATE CASCADE ON DELETE CASCADE,
                                     person_id   integer REFERENCES candymat_data.person (id) ON UPDATE CASCADE ON DELETE CASCADE,
                                     position    integer NOT NULL,
                                     text        character varying(5000),
                                     created_at  timestamp default now(),
                                     primary key (question_id, person_id)
);
grant select on table candymat_data.answer to candymat_person;
grant insert, update, delete on table candymat_data.answer to candymat_candidate;

alter table candymat_data.answer enable row level security;
create policy insert_answer on candymat_data.answer for insert to candymat_candidate
  with check (person_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);
create policy update_answer on candymat_data.answer for update to candymat_candidate
  with check (person_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);
create policy delete_answer on candymat_data.answer for delete to candymat_candidate
  using (person_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);
