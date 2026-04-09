EXEC sp_databases -- List of all existing databases
SELECT name FROM sys.databases  -- List of all existing databases

-- CREATING A DATABASE
CREATE DATABASE school_db
USE school_db  -- for a particuler databse
SELECT DB_NAME()   -- For selected database 


-- CRUD Databse - Create, Read, Update and Delete
-- Creating Tables
CREATE TABLE students(
student_id INT,
name NVARCHAR(100),
age INT,
grade INT
)

-- Checking existing tables 
EXEC sp_help 'students'

-- Inserting data 
INSERT INTO students(student_id, name, age, grade)
VALUES(101, 'Raju', 10, 5)

INSERT INTO students(student_id, name, age, grade)
VALUES(102, 'kaju', 12, 7), (103, 'Sham' , 14, 9)

INSERT INTO students(student_id, name, age, grade)
VALUES(104, 'Shivi', 15, 9)


-- Reading Data

SELECT * FROM students
SELECT name FROM students

SELECT * FROM students WHERE student_id = 102
SELECT age FROM students WHERE student_id = 102
-- Updating Data
UPDATE students
SET grade=12
WHERE student_id=102

-- Deleting data
DELETE FROM students
WHERE student_id = 103

DELETE FROM students
WHERE 1=1

-- Truncate 
TRUNCATE table students

-- Data Types and Constraints 
-- Constraints 
-- Primary Key


