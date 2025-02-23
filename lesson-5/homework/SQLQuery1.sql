create database class5
go 
use class5;

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

select * from employees;

-- TASK-1
--Assign a Unique Rank to Each Employee Based on Salary

select employeeid, Name, Department, salary,
	   rank() over(order by salary desc) as salaryrank
from Employees;

-- TASK-2
--Find Employees Who Have the Same Salary Rank

select *,
 DENSE_RANK() over(order by salary desc) as salaryrank
from employees;

-- TASK-3
--Identify the Top 2 Highest Salaries in Each Department

SELECT *, RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank 
FROM Employees;

-- TASK-4
--Find the Lowest-Paid Employee in Each Department

SELECT *, RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank 
FROM Employees;

-- TASK-5
--Calculate the Running Total of Salaries in Each Department

select name, department, salary,
	sum(salary) over(partition by department order by employeeid) as totalsalary_each
from Employees

-- TASK-6
--Find the Total Salary of Each Department Without GROUP BY

select distinct department,
	sum(salary) over(partition by department) as total_salary
from employees;

-- TASK-7
--Calculate the Average Salary in Each Department Without GROUP BY

select distinct department,
	avg(salary) over(partition by department) as avg_salary
from employees;

-- TASK-8
--Find the Difference Between an Employee’s Salary and Their Department’s Average

select name, department, salary,
	salary - avg(salary) over(partition by department) as dfc_salary
from Employees;

-- TASK-9
--Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

select name, department, salary,
	avg(salary) over(order by employeeid rows between 1 preceding and 1 following) as moving_salary
from employees;

-- TASK-10
--Find the Sum of Salaries for the Last 3 Hired Employees

select name, department, salary, hiredate,
	sum(salary) over(order by hiredate rows between 2 preceding and current row) as sum_salary
from employees;

-- TASK-11
--Calculate the Running Average of Salaries Over All Previous Employees

select name, department, salary,
	avg(salary) over(order by employeeid rows between unbounded preceding and current row) as runavg_salary
from employees;

-- TASK-12
--Find the Maximum Salary Over a Sliding Window of 2 Employees Before and After

select name, department, salary,
	max(salary) over(order by employeeid rows between 2 preceding  and 2 following) as  max_salary
from employees;

-- TASK-13
--Determine the Percentage Contribution of Each Employee’s Salary to Their Department’s Total Salary

SELECT Name, Department, Salary, 
    cast(Salary * 100.0 / SUM(Salary) OVER (PARTITION BY Department) as decimal(10,2)) AS PercentageOfDeptTotal
FROM Employees;