-- Task: Creating Employee Table --
CREATE DATABASE bank_db

use bank_db

CREATE TABLE employees (
emp_id INT IDENTITY(100,1) PRIMARY KEY,
fname NVARCHAR(100) NOT NULL,
lname NVARCHAR(100) NOT NULL UNIQUE,
job_title NVARCHAR(100) NOT NULL,
department NVARCHAR(50),
salary DECIMAL(10,2) DEFAULT 30000.00,
hire_date DATE NOT NULL DEFAULT CONVERT(date, GETDATE()),
city NVARCHAR(50)
)

EXEC sp_help 'employees'

INSERT INTO employees 
(fname, lname, job_title, department, salary, hire_date, city)
VALUES
('Aarav', 'Sharma', 'Director', 'Management', 180000, '2019-02-10', 'Mumbai'),
('Diya', 'Patel', 'Lead Engineer', 'Tech', 120000, '2020-08-15', 'Bengaluru'),
('Rohan', 'Mehra', 'Software Engineer', 'Tech', 85000, '2022-05-20', 'Bengaluru'),
('Priya', 'Singh', 'HR Manager', 'Human Resources', 95000, '2019-11-05', 'Mumbai'),
('Arjun', 'Kumar', 'Data Scientist', 'Tech', 110000, '2021-07-12', 'Hyderabad'),
('Ananya', 'Gupta', 'Marketing Lead', 'Marketing', 90000, '2020-03-01', 'Delhi'),
('Vikram', 'Reddy', 'Sales Executive', 'Sales', 75000, '2023-01-30', 'Mumbai'),
('Sameera', 'Rao', 'Software Engineer', 'Tech', 88000, '2023-06-25', 'Pune'),
('Ishaan', 'Verma', 'Recruiter', 'Human Resources', 65000, '2022-09-01', 'Mumbai'),
('Kavya', 'Joshi', 'Product Designer', 'Design', 92000, '2021-04-18', 'Bengaluru'),
('Nisha', 'Desai', 'Jr. Data Analyst', 'Tech', 70000, '2024-02-01', 'Hyderabad'),
('Zain', 'Khan', 'Sales Manager', 'Sales', 115000, '2019-09-14', 'Delhi'),
('Aditya', 'Nair', 'Marketing Analyst', 'Marketing', 68000, '2022-10-10', 'Delhi'),
('Fatima', 'Ali', 'Sales Executive', 'Sales', 78000, '2022-11-22', 'Mumbai');

SELECT * FROM employees

SELECT * FROM employees WHERE emp_id = 111
SELECT * FROM employees WHERE department='Sales' 

SELECT * FROM employees WHERE department != 'Sales' 

SELECT * FROM employees WHERE salary > 100000

SELECT * FROM employees WHERE hire_date > '2020-12-31'

SELECT DISTINCT department FROM employees

SELECT * FROM employees ORDER BY salary  --ASEC

SELECT * FROM employees ORDER BY salary DESC

SELECT * FROM employees ORDER BY hire_date DESC

SELECT * FROM employees ORDER BY fname DESC

SELECT department, fname FROM employees ORDER BY department

SELECT department, fname FROM employees ORDER BY department, fname

SELECT * FROM employees WHERE department LIKE '%Human%'

SELECT * FROM employees WHERE fname LIKE 'a%'

SELECT * FROM employees WHERE fname LIKE '_a%'

SELECT * FROM employees

SELECT TOP 3 * FROM employees

SELECT TOP 3 * FROM employees ORDER BY salary DESC

SELECT TOP 5 * FROM	employees 


-- Subqueries ---   ek query ke andar ek aur query ----

SELECT fname, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

SELECT fname 
FROM employees
WHERE emp_id IN (
    SELECT emp_id
    FROM employees
    WHERE city = 'Mumbai'
);

CREATE NONCLUSTERED INDEX idx_name
ON employees(fname);


-- Store Procedures --

CREATE VIEW emp_id AS
SELECT fname, salary
FROM employees;

CREATE PROCEDURE GetfnameByemp_id
    @id INT
AS
BEGIN
    SELECT * FROM employees
    WHERE emp_id = @id;
END;

EXEC GetfnameByemp_id @id = 2;