CREATE DATABASE lab1;

CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    firstname varchar(50),
    lastname varchar(50)
);

ALTER TABLE  users
ADD  isadmin int;
ALTER TABLE users
ALTER COLUMN isadmin TYPE bool
USING isadmin::boolean;
ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT FALSE;

CREATE TABLE tasks(
    id SERIAL PRIMARY KEY,
    name varchar(50),
    user_id int
);

DROP TABLE tasks;
DROP DATABASE lab1;