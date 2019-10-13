-- Create table for users
CREATE TABLE public."user"
(
    login character varying(8) primary key,
    name character varying(300),
    surname character varying(300),
    email character varying(320)
);

-- Create table for user groups
CREATE TABLE public."group"
(
    id serial primary key,
    name character varying(300) UNIQUE,
    access_right character varying(1000)
);

-- Create table for relation of users and groups
CREATE TABLE public.user_group
(
    group_id integer REFERENCES public."group" (id) ON UPDATE CASCADE ON DELETE CASCADE,
    user_login character varying(8) REFERENCES public."user" (login) ON UPDATE CASCADE ON DELETE CASCADE,
    primary key (group_id, user_login)
);


-- Create table for catgeories
CREATE TABLE public.category
(
    id serial primary key,
    title character varying(300) UNIQUE NOT NULL,
    description character varying(5000)
);

-- Create table for questions
CREATE TABLE public.question
(
    id serial primary key,
    category_id integer REFERENCES public."category" (id) ON UPDATE CASCADE ON DELETE SET NULL,
    text character varying(3000) NOT NULL,
    description character varying(5000)
);

-- Create table for answers
CREATE TABLE public.answer
(
    question_id integer REFERENCES public."question" (id) ON UPDATE CASCADE ON DELETE CASCADE,
    user_login character varying(8) REFERENCES public."user" ON UPDATE CASCADE ON DELETE CASCADE,
    postition integer NOT NULL,
    text character varying(5000),
    primary key (question_id, user_login)
);
