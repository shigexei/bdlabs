CREATE DATABASE lab4;
CREATE TABLE Warehouses
(
    code     serial PRIMARY KEY,
    location varchar(255),
    capacity int
);

CREATE TABLE Boxes(
    code char(4),
    contents varchar(255),
    value real,
    warehouse int,
    FOREIGN KEY (warehouse) references Warehouses(code)
);

INSERT INTO Warehouses
VALUES (1,'Chicago', 3),
       (2,'Chicago', 4),
       (3, 'New York', 7),
       (4, 'Los Angeles', 2),
       (5, 'San Francisco', 8);
INSERT INTO Boxes
VALUES ('0MN7', 'Rocks', 180,3),
       ('4H8P', 'Rocks', 250,1),
       ('4RT3','Scissors', 190,4),
       ('7G3H','Rocks', 200, 1),
       ('8JN6', 'Papers', 75, 1),
       ('8Y6U', 'Papers', 50,3),
       ('9J6F', 'Papers', 175,2),
       ('LL08','Rocks', 140,4),
       ('P0H6', 'Scissors', 125,1),
       ('P2T6', 'Scissors', 150, 2),
       ('TU55', 'Papers', 90, 5);



SELECT * FROM Warehouses;
SELECT * FROM Boxes
WHERE value > 150;

SELECT DISTINCT ON(contents) * FROM Boxes;

SELECT warehouse, count(*)
FROM Boxes
group by warehouse;

SELECT warehouse, count(*)
FROM boxes
GROUP BY warehouse
HAVING count(*) > 2;

INSERT INTO warehouses(location, capacity)
VALUES ('New York', 3);

INSERT INTO boxes
VALUES ('H5RT', 'Papers', 200, 2);

UPDATE boxes
SET value = value * 0.85
WHERE value = (SELECT DISTINCT ON(value) value FROM boxes ORDER BY value DESC OFFSET 2 LIMIT 1);

DELETE FROM boxes WHERE value < 150
RETURNING *;

DELETE FROM boxes
WHERE warehouse IN (SELECT code FROM warehouses WHERE location = 'New York')
RETURNING *;

