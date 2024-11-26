--1
CREATE FUNCTION increase_value(INOUT value INTEGER) AS
$$
    BEGIN
        value = value + 10;
    end;
$$
LANGUAGE plpgsql;
SELECT * FROM increase_value(15);

--2
CREATE FUNCTION compare_numbers(IN a INTEGER, b INTEGER)
RETURNS VARCHAR AS
$$
    BEGIN
        IF a < b THEN RETURN 'Lesser';
        ELSIF a > b THEN RETURN 'Greater';
        ELSE RETURN 'Equal';
        END IF;
    end;
$$
LANGUAGE plpgsql;
SELECT * FROM compare_numbers(2, 5);
SELECT * FROM compare_numbers(10, 10);

--3
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
    RETURNS TEXT AS
$$
    DECLARE res TEXT := '';
    BEGIN
        FOR i IN 1..n LOOP
            res := res || i || ' ';
            end loop;
        RETURN res;
    end;
$$
LANGUAGE plpgsql;
--DROP FUNCTION number_series(n INTEGER);
SELECT * FROM number_series(6);

--4
CREATE OR REPLACE FUNCTION find_employee(IN emp_name VARCHAR)
RETURNS TABLE(id INTEGER, nname VARCHAR, nsalary INTEGER) AS
$$
    BEGIN
        RETURN QUERY SELECT emp_id, name, salary FROM employees
        WHERE name = emp_name;
    end;
$$
LANGUAGE plpgsql;

CREATE DATABASE lab9;
CREATE TABLE employees(
    emp_id INTEGER,
    name VARCHAR,
    salary INTEGER
);
INSERT INTO employees VALUES (7001, 'Sasha', 500000);
INSERT INTO employees VALUES (7002, 'Vika', 600000);

SELECT * FROM find_employee('Sasha');

--5
CREATE OR REPLACE FUNCTION list_products(category_name INTEGER)
RETURNS TABLE(pr_id INTEGER, pr_name VARCHAR, pr_category INTEGER) AS
$$
    BEGIN
    RETURN QUERY SELECT id, name, category FROM products
        WHERE category = category_name;
    end;
$$
LANGUAGE plpgsql;

CREATE TABLE products(
    id INTEGER,
    name VARCHAR,
    category INTEGER
);
INSERT INTO products VALUES (5001, 'pepsi', 1);
INSERT INTO products VALUES (5002, 'cola', 1);

SELECT * FROM list_products(1);

--6
CREATE OR REPLACE FUNCTION calculate_bonus(employee_id INTEGER)
RETURNS INTEGER AS
$$
    DECLARE bonus INTEGER;
BEGIN
        SELECT salary*0.1 INTO bonus FROM employees
        WHERE emp_id = employee_id;
        RETURN bonus;
    end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(employee_id INTEGER)
RETURNS TABLE(id INTEGER, nname VARCHAR, nsalary INTEGER) AS
$$
    DECLARE bonus INTEGER;
    BEGIN
        bonus := calculate_bonus(employee_id);
        RETURN QUERY UPDATE employees SET salary = salary + bonus
        WHERE emp_id = employee_id RETURNING *;
    end;
$$
LANGUAGE plpgsql;

SELECT * FROM update_salary(7001);

--7
CREATE OR REPLACE FUNCTION complex_calculation(n INTEGER, str VARCHAR)
RETURNS VARCHAR AS
$$<<outer_block>>
    DECLARE res VARCHAR;
    BEGIN
    <<inner_block1>>
    BEGIN
        n = n * n;
    end inner_block1;
    <<inner_block2>>
    BEGIN
        str = '!' || str || '!';
    end inner_block2;
    res = str || n;
    RETURN res;
    end outer_block;
$$
LANGUAGE plpgsql;

SELECT * FROM complex_calculation(5, 'sentence');