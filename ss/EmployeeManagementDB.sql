CREATE DATABASE EmployeeManagementDB;

USE EmployeeManagementDB;

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(100),
    Location VARCHAR(100),
    CreatedBy INT,        -- EmployeeID who created
    CreatedOn DATETIME DEFAULT GETDATE(),
    ModifiedBy INT NULL,
    ModifiedOn DATETIME NULL
);


INSERT INTO Department (DepartmentName, Location, CreatedBy)
SELECT d.DepartmentName, c.City, 1  -- 1 = Admin employee
FROM (VALUES ('HR'), ('IT'), ('Finance'), ('Sales'), ('Support')) AS d(DepartmentName)
CROSS JOIN (VALUES ('Delhi'), ('Mumbai'), ('Chennai'), ('Bangalore'), ('Pune')) AS c(City);

GO

CREATE TABLE Role (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName VARCHAR(50)
);

INSERT INTO Role (RoleName)
VALUES ('Admin'), ('Manager'), ('Employee'), ('HR');


CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(20),
    Salary DECIMAL(10,2),
    DepartmentID INT,
    RoleID INT,
    HireDate DATE,
    CreatedBy INT,
    CreatedOn DATETIME DEFAULT GETDATE(),
    ModifiedBy INT NULL,
    ModifiedOn DATETIME NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID)
);


INSERT INTO Employee (FirstName, LastName, Email, PhoneNumber, Salary, DepartmentID, RoleID, HireDate, CreatedBy)
SELECT TOP 3000
    'First_' + CAST(ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS VARCHAR),
    'Last_' + CAST(ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS VARCHAR),
    'user' + CAST(ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS VARCHAR) + '@mail.com',
    '+91' + RIGHT('0000000000' + CAST(ABS(CHECKSUM(NEWID())) % 10000000000 AS VARCHAR),10),
    ABS(CHECKSUM(NEWID()) % 50000) + 30000,           -- Salary 30k–80k
    ABS(CHECKSUM(NEWID()) % 25) + 1,                  -- DepartmentID 1–25
    ABS(CHECKSUM(NEWID()) % 4) + 1,                   -- RoleID 1–4
    DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 1000), GETDATE()),  -- Random hire date
    1                                                 -- CreatedBy = Admin
FROM sys.objects a CROSS JOIN sys.objects b;

GO

SELECT TOP 10 * FROM Employee;

CREATE NONCLUSTERED INDEX idx_employee_department
ON Employee(DepartmentID);

CREATE NONCLUSTERED INDEX idx_employee_salary
ON Employee(Salary);

CREATE UNIQUE NONCLUSTERED INDEX idx_employee_email
ON Employee(Email);

CREATE TABLE Login (
    LoginID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    Username VARCHAR(50) UNIQUE,
    PasswordHash VARBINARY(256),  -- Using hash
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

SELECT * FROM Login

INSERT INTO Login (EmployeeID, Username, PasswordHash)
SELECT 
    EmployeeID,
    'user' + CAST(EmployeeID AS VARCHAR),
    HASHBYTES('SHA2_256', 'pass' + CAST(EmployeeID AS VARCHAR))  -- Password: pass<EmployeeID>
FROM Employee;

SELECT TOP 10 * FROM Login;

CREATE TABLE Project (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    DepartmentID INT,
    CreatedBy INT,
    CreatedOn DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Insert 30 random projects
WITH ProjectCTE AS (
    SELECT 
        'Project_' + CAST(ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS VARCHAR) AS ProjectName,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 1000), GETDATE()) AS StartDate,
        DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 365), GETDATE()) AS EndDate,
        ABS(CHECKSUM(NEWID()) % 25) + 1 AS DepartmentID,
        1 AS CreatedBy,
        ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS rn
    FROM sys.objects a CROSS JOIN sys.objects b
)
INSERT INTO Project (ProjectName, StartDate, EndDate, DepartmentID, CreatedBy)
SELECT ProjectName, StartDate, EndDate, DepartmentID, CreatedBy
FROM ProjectCTE
WHERE rn <= 30;


CREATE TABLE EmployeeProject (
    EmployeeID INT,
    ProjectID INT,
    AssignedOn DATE DEFAULT GETDATE(),
    RoleInProject VARCHAR(50) NULL,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);


INSERT INTO EmployeeProject (EmployeeID, ProjectID, RoleInProject)
SELECT 
    e.EmployeeID,
    p.ProjectID,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 THEN 'Lead' ELSE 'Member' END
FROM Employee e
CROSS APPLY (SELECT TOP 2 ProjectID FROM Project ORDER BY NEWID()) p;


SELECT TOP 20 e.FirstName, e.LastName, p.ProjectName, ep.RoleInProject
FROM EmployeeProject ep
JOIN Employee e ON ep.EmployeeID = e.EmployeeID
JOIN Project p ON ep.ProjectID = p.ProjectID;


-- Drop view if exists
IF OBJECT_ID('EmployeeDepartmentView', 'V') IS NOT NULL
    DROP VIEW EmployeeDepartmentView;
GO

CREATE VIEW EmployeeDepartmentView AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Email,
    e.PhoneNumber,
    e.Salary,
    r.RoleName,
    d.DepartmentName,
    d.Location,
    e.HireDate,
    e.CreatedBy,
    e.CreatedOn,
    e.ModifiedBy,
    e.ModifiedOn
FROM Employee e
JOIN Department d ON e.DepartmentID = d.DepartmentID
JOIN Role r ON e.RoleID = r.RoleID;


CREATE VIEW EmployeeProjectView AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    p.ProjectName,
    ep.RoleInProject,
    ep.AssignedOn,
    d.DepartmentName,
    d.Location
FROM EmployeeProject ep
JOIN Employee e ON ep.EmployeeID = e.EmployeeID
JOIN Project p ON ep.ProjectID = p.ProjectID
JOIN Department d ON e.DepartmentID = d.DepartmentID;


SELECT TOP 20 * FROM EmployeeProjectView;

SELECT d.DepartmentName, d.Location, AVG(e.Salary) AS AvgSalary
FROM Employee e
JOIN Department d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName, d.Location
ORDER BY AvgSalary DESC;

-- Highest Salary per Role
SELECT r.RoleName, MAX(e.Salary) AS MaxSalary
FROM Employee e
JOIN Role r ON e.RoleID = r.RoleID
GROUP BY r.RoleName
ORDER BY MaxSalary DESC;


-- Employees with above-average salary
SELECT FirstName, LastName, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee)
ORDER BY Salary DESC;


SELECT e.EmployeeID, e.FirstName, e.LastName, 
       createdBy.FirstName AS CreatedByName,
       modifiedBy.FirstName AS ModifiedByName,
       e.CreatedOn, e.ModifiedOn
FROM Employee e
LEFT JOIN Employee createdBy ON e.CreatedBy = createdBy.EmployeeID
LEFT JOIN Employee modifiedBy ON e.ModifiedBy = modifiedBy.EmployeeID
ORDER BY e.CreatedOn DESC;


SELECT p.ProjectName, d.DepartmentName, COUNT(ep.EmployeeID) AS TotalEmployees
FROM EmployeeProject ep
JOIN Project p ON ep.ProjectID = p.ProjectID
JOIN Department d ON p.DepartmentID = d.DepartmentID
GROUP BY p.ProjectName, d.DepartmentName
ORDER BY TotalEmployees DESC;


-- Example: See all projects of a specific employee
SELECT * 
FROM EmployeeProjectView
WHERE EmployeeID = 10; -- Change 10 to desired EmployeeID


SELECT 
    d.DepartmentName,
    d.Location,
    COUNT(e.EmployeeID) AS TotalEmployees
FROM Employee e
JOIN Department d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName, d.Location
ORDER BY TotalEmployees DESC;


-- Employees with their Projects
SELECT 
    e.FirstName,
    e.LastName,
    e.Email,
    p.ProjectName,
    ep.RoleInProject
FROM EmployeeProject ep
JOIN Employee e ON ep.EmployeeID = e.EmployeeID
JOIN Project p ON ep.ProjectID = p.ProjectID
ORDER BY e.EmployeeID;


SELECT *
FROM Employee
WHERE DepartmentID = 4
  AND Salary > 50000
ORDER BY Salary DESC;


SELECT * FROM Employee

INSERT INTO Employee 
(FirstName, LastName, Email, PhoneNumber, Salary, DepartmentID, RoleID, HireDate, CreatedBy)
VALUES
('Rahul', 'Kumar', 'rahul@gmail.com', '9876543210', 40000, 1, 1, '2023-06-27', 1),
('Rahul', 'Kumar', 'rahul@gmail.com', '9876543210', 40000, 1, 1, '2023-06-27', 1);