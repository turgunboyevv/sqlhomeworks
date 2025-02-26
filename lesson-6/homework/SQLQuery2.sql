create database class6
go
use class6;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary)
VALUES
    (1, 'Alice', 101, 60000),
    (2, 'Bob', 102, 70000),
    (3, 'Charlie', 101, 65000),
    (4, 'David', 103, 72000),
    (5, 'Eva', NULL, 68000);


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);


INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
    (101, 'IT'),
    (102, 'HR'),
    (103, 'Finance'),
    (104, 'Marketing');


CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName NVARCHAR(50),
    EmployeeID INT
);

INSERT INTO Projects (ProjectID, ProjectName, EmployeeID)
VALUES
    (1, 'Alpha', 1),
    (2, 'Beta', 2),
    (3, 'Gamma', 1),
    (4, 'Delta', 4),
    (5, 'Omega', NULL);

SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Projects;

-- inner join
--Write a query to get a list of employees along with their department names.

select e.employeeid, e.name, d.departmentname
from employees e
inner join departments d
on e.departmentid = d.DepartmentID;

--left join
--Write a query to list all employees, including those who are not assigned to any department.

select e.employeeid, e.name, d.departmentname
from employees e
left join Departments d
on e.DepartmentID = d.DepartmentID;

--right join
--Write a query to list all departments, including those without employees.

select e.employeeid, e.name, d.departmentname
from Employees e
right join Departments d
on e.DepartmentID = d.DepartmentID;

--full outer join
--Write a query to retrieve all employees and all departments, even if there’s no match between them.

select e.employeeid, e.name, d.departmentname
from Employees e
full outer join departments d
on e.DepartmentID = d.DepartmentID;

--join with aggregation
--Write a query to find the total salary expense for each department.

select d.departmentname, sum(e.salary) as total_salary
from employees e
inner join departments d
on e.DepartmentID = d.DepartmentID
group by d.DepartmentName;

--cross join
--Write a query to generate all possible combinations of departments and projects.

select d.departmentname, p.projectname
from Departments d
cross join Projects p;

--multiple joins
--Write a query to get a list of employees with their department names and assigned project names. Include employees even if they don’t have a project.

select e.employeeid, e.name, d.departmentname, p.projectname
from Employees e
left join departments d
on e.DepartmentID = d.DepartmentID
left join Projects p
on e.EmployeeID = p.EmployeeID