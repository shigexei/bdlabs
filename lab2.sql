CREATE DATABASE lab2;
CREATE TABLE countries(
    country_id serial PRIMARY KEY,
    country_name char(30),
    region_id int,
    population int
);

INSERT INTO countries(country_name, region_id, population)
VALUES ('asdasd', 1, 2000);

INSERT INTO countries(country_id, country_name)
VALUES (2, 'skibidi');

INSERT INTO countries(region_id)
VALUES (NULL);

INSERT INTO countries(country_name, region_id, population)
VALUES
('asd',2,123),
('dsa', 3,123123),
('popo', 4, 12312312312);

ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries(country_name,region_id, population)
VALUES ('Kazakhstan', 5,12121212)

