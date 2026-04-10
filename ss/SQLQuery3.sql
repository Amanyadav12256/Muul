-- Logical Operators 
-- AND Operators
use bank_db

SELECT * FROM employees WHERE salary = 75000 AND department = 'sales'    -- AND

SELECT * FROM employees WHERE salary = 75000 OR department = 'sales'     -- OR

SELECT * FROM employees WHERE salary = 75000 AND department = 'sales' OR city = 'Mumbai'     --Multiple OR

SELECT * FROM employees WHERE department IN('Marketing', 'Sales', 'Tech')     --IN 

SELECT * FROM employees WHERE salary BETWEEN 75000 AND 100000        --- Between 

SELECT * FROM employees 
WHERE department NOT IN ('Marketing', 'Sales', 'Tech');

--- Conditional Expression ---

-- CASE --

SELECT fname, lname, salary,
CASE 
WHEN salary > 100000 THEN 'High Earner'
WHEN salary BETWEEN 80000 AND 100000 THEN 'Medium Earner'
ELSE 'Standard Earner'
END as sal_cat
FROM employees


-- Calculate Bonus --

SELECT fname, lname, department, salary,
CASE
WHEN department IN ('Sales', 'Marketing') THEN salary*0.10
WHEN department = 'Tech' THEN salary*0.12
ELSE salary*0.05
END as bonus
FROM employees

SELECT * FROM employees WHERE FNAME is null;

SELECT * FROM employees WHERE fname NOT LIKE 'A%'


-- AGGREGATE FUNCTIONS --
-- How to find total no of employees
-- Employee with Max or Min salary 
-- Average salary of employees 
-- sum/total salary paid 

SELECT COUNT(EMP_ID) FROM employees

SELECT MIN(salary) FROM employees

SELECT MAX(salary) FROM employees

SELECT AVG(salary) FROM employees

SELECT SUM(salary) FROM employees

-- GROUP BY --
-- no of employees in each departments 

SELECT department FROM employees GROUP BY department

SELECT department, COUNT(emp_id) FROM employees GROUP BY department

SELECT city, COUNT(emp_id) FROM employees GROUP BY city

SELECT department, SUM(salary) AS COUNT FROM employees GROUP BY department


-- Multilevel/Multicolumn grouping --

SELECT department, city, COUNT(emp_id)
FROM employees GROUP BY department, city
ORDER BY department

-- Having Clause --
-- Only work with group by --

SELECT department, COUNT(emp_id) as count
FROM employees
GROUP BY department HAVING COUNT(emp_id) > 2

SELECT job_title, AVG(salary) FROM employees GROUP BY job_title
HAVING AVG(salary) > 90000

SELECT department, SUM(salary) as total
FROM employees
GROUP BY department HAVING SUM(salary) > 200000

-- Group By Rollup is an extension of Group By ---

SELECT department, COUNT(emp_id) as count FROM employees GROUP BY ROLLUP(department)

SELECT department, SUM(salary) as count FROM employees GROUP BY ROLLUP(department)

SELECT department, city, COUNT(emp_id) as count FROM employees GROUP BY ROLLUP(department, city)
ORDER BY department

SELECT department, COALESCE(city,'Total'),COUNT(emp_id) as count FROM employees GROUP BY ROLLUP(department, city)
ORDER BY department





