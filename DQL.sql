CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	name VARCHAR (50),
	age INT,
	campus_id INT,
	total_grade FLOAT
);

SELECT * FROM students;

INSERT INTO students (name, age, campus_id, total_grade)
VALUES
	('Rafif Iman', 20, 1, 85.5),
    ('Hana Arisona', 21, 2, 90.2),
    ('Raka Purnomo', 19, 1, 78.9),
    ('Danu Irfansyah', 20, 3, 92.7),
    ('Rachman Ardhi', 22, 2, 88.1);

CREATE TABLE campus (
	id SERIAL PRIMARY KEY,
	campus_name VARCHAR (50),
	batch VARCHAR (50),
	start_date DATE
);

INSERT INTO campus (campus_name, batch, start_date)
VALUES
	('Remote', 'RMT-1', '2023-01-01'),
    ('Jakarta', 'HCK-2', '2023-02-01'),
    ('BSD', 'BSD-4', '2023-03-01'),
    ('Surabaya', 'SUB-1', '2023-04-01'),
    ('Singapore', 'SIN-1', '2023-05-01');

SELECT * FROM campus;

-- DISTINCT
-- 1. Select distinct age from the "students" table
SELECT DISTINCT * FROM students;

-- 2. Select distinct combinations of campus names and batches from the "campus" table
SELECT DISTINCT campus_name, batch FROM campus;

-- WHERE
-- 1. Select all students from the "students" table where thei age is 20
SELECT * FROM students WHERE age = 20;

-- 2. Select all students from the "students" table where their total grade is not equal to 85.5
SELECT * FROM students WHERE total_grade != 85.5;

-- 3. Select all students from the "students" table where their age is greater than 21
SELECT * FROM students WHERE age > 21;

-- 4. Select all campuses from the "campus" table where the start date is less than or equal to '2023-03-01'
SELECT * FROM campus WHERE start_date <= '2023-03-01';

-- 5. Select all students from the "students" table where their age is between 18 and 20 (inclusive)
SELECT * FROM students WHERE age BETWEEN 18 and 20;

-- 6. Select all students from the "students" table where their campus ID is either 1, 2, or 3
SELECT * FROM students WHERE campus_id IN (1, 2, 3);

-- 7. Select all campuses from the "campus" table where the campus name starts with 'J'
SELECT * FROM campus WHERE campus_name LIKE 'J%';

-- 8. Select all campuses from the "campus" table where the campus name contains 'sin' (case-insensitive)
SELECT * FROM campus WHERE campus_name LIKE '%Sin%';

-- 9. Select all students from the "students" table where their age is not 22
SELECT * FROM students WHERE age != 22;

-- 10. Select all students from the "students" table where their name does not start with 'R' and their age is greater than or equal to 20
SELECT * FROM students WHERE name NOT LIKE 'R%' AND age >= 20;

-- GROUP BY AND AGGREGATION
-- 1. Average aggregate
SELECT AVG(total_grade) as avg_total_grade FROM students;

-- 2. Max aggregate
SELECT MAX(age) as max_age FROM students;

-- 3. Min aggregate
SELECT MIN(age) as min_age FROM students;

-- 4. Count aggregate
SELECT COUNT(name) as name_count FROM students;

-- 5. Sum aggregate
SELECT SUM(campus_id) as sum_campus_id FROM students;

-- 6. Select aggregation columns, group by campus id
SELECT campus_id, AVG(total_grade)as avg_total_grade, MAX(total_grade)as max_total_grade, MIN(age) as min_age FROM students
GROUP BY campus_id;

-- 7. Select aggregation columns, group by campus id and age
SELECT campus_id, age, AVG(total_grade) as avg_total_grade, MAX(total_grade) as max_total_grade, MIN(total_grade) as min_total_grade FROM students
GROUP BY campus_id, age;

-- 8. Select filtered aggregation columns
SELECT campus_id, age, AVG(total_grade) as avg_total_grade, MAX(total_grade) as max_total_grade, MIN(total_grade) as min_total_graade 
FROM students
WHERE age < 25
GROUP BY campus_id, age
HAVING AVG (total_grade) > 80;

-- 9. Order by ascending or descending
SELECT * FROM students
ORDER BY campus_id ASC;

-- 10. Limit
SELECT age FROM students
LIMIT 3;

CREATE TABLE assignment_scores (
	id SERIAL PRIMARY KEY,
	students_id INTEGER,
	assignment_id INTEGER,
	score FLOAT
);

SELECT * FROM assignment_scores;

INSERT INTO assignment_scores (students_id, assignment_id, score)
VALUES
    (1, 1, 90.0),
    (1, 2, 85.0),
    (2, 1, 92.5),
    (2, 2, 88.5),
    (3, 1, 80.0),
    (4, 2, 79.5),
    (4, 1, 95.0),
    (4, 2, 90.5),
    (5, 1, 88.0),
    (5, 2, 86.0),
    (6, 2, 86.0);

-- 11. Join
SELECT s.name, s.age, c.campus_name, c.start_date FROM students s
JOIN campus c
ON
s.campus_id = c.id;

-- URUTAN BASIC DQL
SELECT
FROM
WHERE
JOIN
ON
GROUP BY
HAVING
ORDER BY
LIMIT