CREATE DATABASE company_db

use school_db

CREATE TABLE employees(
emp_id INT IDENTITY(100,1) PRIMARY KEY,
fname NVARCHAR(500) NOT NULL,
lname NVARCHAR(500) NOT NULL,
job_title NVARCHAR(100) NOT NULL,
department NVARCHAR(50) NOT NULL,
salary DECIMAL(10,2) DEFAULT 45000,
hire_date DATE DEFAULT GETDATE(),
city NVARCHAR(50)
)

INSERT INTO employees 
(fname, lname, job_title, department, salary, hire_date, city)
VALUES
('Aarav', 'Sharma', 'Director', 'Management', 180000, '2019-02-10', 'Mumbai'),
('Diya', 'Patel', 'Lead Engineer', 'Tech', 120000, '2020-08-15', 'Bengaluru'),
('Rohan', 'Mehra', 'Software Engineer', 'Tech', 85000, '2022-05-20', 'Bengaluru'),
('Priya', 'Singh', 'HR Manager', 'HR', 95000, '2019-11-05', 'Mumbai'),
('Arjun', 'Kumar', 'Data Scientist', 'Tech', 110000, '2021-07-12', 'Hyderabad'),
('Ananya', 'Gupta', 'Marketing Lead', 'Marketing', 90000, '2020-03-01', 'Delhi'),
('Vikram', 'Reddy', 'Sales Executive', 'Sales', 75000, '2023-01-30', 'Mumbai'),
('Sameera', 'Rao', 'Software Engineer', 'Tech', 88000, '2023-06-25', 'Pune'),
('Ishaan', 'Verma', 'Recruiter', 'HR', 65000, '2022-09-01', 'Mumbai'),
('Kavya', 'Joshi', 'Product Designer', 'Design', 92000, '2021-04-18', 'Bengaluru'),
('Nisha', 'Desai', 'Data Analyst', 'Tech', 70000, '2024-02-01', 'Hyderabad'),
('Zain', 'Khan', 'Sales Manager', 'Sales', 115000, '2019-09-14', 'Delhi'),
('Aditya', 'Nair', 'Marketing Analyst', 'Marketing', 68000, '2022-10-10', 'Delhi'),
('Fatima', 'Ali', 'Sales Executive', 'Sales', 78000, '2022-11-22', 'Mumbai'),
('Rahul', 'Das', 'Backend Developer', 'Tech', 95000, '2021-06-15', 'Kolkata'),
('Sneha', 'Iyer', 'Frontend Developer', 'Tech', 87000, '2023-03-10', 'Chennai'),
('Karan', 'Malhotra', 'Business Analyst', 'Management', 99000, '2020-12-05', 'Delhi'),
('Pooja', 'Bansal', 'HR Executive', 'HR', 60000, '2022-07-19', 'Jaipur'),
('Manish', 'Yadav', 'Support Engineer', 'Tech', 72000, '2021-09-23', 'Noida'),
('Neha', 'Kapoor', 'UX Designer', 'Design', 88000, '2023-05-14', 'Gurgaon');

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

SELECT * FROM employees WHERE department = 'Tech'

SELECT * 
FROM employees
WHERE salary > 90000;

SELECT * FROM employees
WHERE department = 'Tech' AND salary> 90000

SELECT * FROM employees
WHERE salary BETWEEN 50000 AND 100000;

SELECT * FROM employees
WHERE department = 'Sales' AND salary < 80000;

SELECT fname, lname, salary
FROM employees
WHERE department = 'Sales' AND salary < 80000;

SELECT * FROM employees
WHERE department = 'Sales' AND salary <80000
ORDER BY salary ASC;

SELECT * FROM employees
WHERE department NOT IN ('Tech')

SELECT * FROM employees
WHERE fname LIKE 's%'

SELECT TOP 3 * FROM employees ORDER BY salary DESC

SELECT * FROM employees
WHERE salary BETWEEN 70000 AND 100000

SELECT COUNT(emp_id) FROM employees

SELECT AVG(salary) FROM employees

SELECT department, COUNT(emp_id) FROM employees GROUP BY department

SELECT city, AVG(salary) FROM employees GROUP BY city

SELECT department, AVG(salary) FROM employees GROUP BY department

