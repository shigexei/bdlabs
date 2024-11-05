CREATE DATABASE lab6;

--2
CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

INSERT INTO locations(street_address, postal_code, city, state_province)
VALUES ('Tolebi', '1HS5', 'Almaty', 'province1'),
       ('Gogol', 'fdb8', 'Almaty', 'province4'),
       ('Street', 'xwsms3', 'Astana', 'province2');

INSERT INTO departments(department_name, budget, location_id)
VALUES ('Dep1', 10000, 1),
       ('Dep2', 20000, 3),
       ('Dep3', 35000, 2);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id)
VALUES ('Aizifa', 'A', 'a_a', '877777777', 1000000, 1),
       ('ASDF', 'asd', 'asdfff', '856789', 700000, 2),
       ('ghj', 'Li', 'ghjjj', '82356787', 6000000, 2);


--3
EXPLAIN ANALYZE
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id;

--4
EXPLAIN ANALYZE
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id in (80, 40);

CREATE INDEX department_id_index on departments(department_id);
DROP INDEX department_id_index;

--5
EXPLAIN ANALYZE
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN locations l ON d.location_id = l.location_id;

--6
SELECT d.department_id, department_name FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY (d.department_id, d.department_name);

--7
SELECT first_name, last_name, e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;