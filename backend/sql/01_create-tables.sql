/connect candymat_db

-- Create schema for candymat_data
CREATE SCHEMA candymat_data;

-- Create table for users
CREATE TABLE candymat_data."user"
(
    login character varying(8) primary key,
    name character varying(300),
    surname character varying(300),
    email character varying(320)
);

-- Create table for user groups
CREATE TABLE candymat_data."group"
(
    id serial primary key,
    name character varying(300) UNIQUE,
    access_right character varying(1000)
);

-- Create table for relation of users and groups
CREATE TABLE candymat_data.user_group
(
    group_id integer REFERENCES candymat_data."group" (id) ON UPDATE CASCADE ON DELETE CASCADE,
    user_login character varying(8) REFERENCES candymat_data."user" (login) ON UPDATE CASCADE ON DELETE CASCADE,
    primary key (group_id, user_login)
);


-- Create table for categories
CREATE TABLE candymat_data.category
(
    id serial primary key,
    title character varying(300) UNIQUE NOT NULL,
    description character varying(5000)
);

-- Create table for questions
CREATE TABLE candymat_data.question
(
    id serial primary key,
    category_id integer REFERENCES candymat_data"category" (id) ON UPDATE CASCADE ON DELETE SET NULL,
    text character varying(3000) NOT NULL,
    description character varying(5000)
);

-- Create table for answers
CREATE TABLE candymat_data.answer
(
    question_id integer REFERENCES candymat_data."question" (id) ON UPDATE CASCADE ON DELETE CASCADE,
    user_login character varying(8) REFERENCES candymat_data."user" ON UPDATE CASCADE ON DELETE CASCADE,
    position integer NOT NULL,
    text character varying(5000),
    primary key (question_id, user_login)
);
