create database class11
go
use class11;

-- ==============================================================
--                          Puzzle 1 DDL                         
-- ==============================================================

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);


-- ==============================================================
--                          Puzzle 2 DDL
-- ==============================================================

CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);


-- ==============================================================
--                          Puzzle 3 DDL
-- ==============================================================

CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

-- puzzle 1
select * into #emptransfers
from Employees

update #emptransfers
set Department = 
case 
	when Department = 'HR' then 'it'
	when Department = 'it' then 'sales'
	when Department = 'sales' then 'hr'
end;

select * from #emptransfers

-- puzzle 2
declare @missingorders table(
	orderid int,
	customername varchar(50),
	product varchar(50),
	quantity int
);

insert into @missingorders
select *
from Orders_DB1
where OrderID not in (select OrderID from Orders_DB2);

select * from @missingorders;

-- puzzle 3
create view vw_MonthlyWorkSummary as 
select 
	employeeid,
	EmployeeName,
	Department,
	sum(HoursWorked) as totalhoursworked,
	sum(sum(hoursworked)) over(partition by department) as totalhoursdept,
	avg(HoursWorked) over(partition by department) as avaragehours
from WorkLog
group by EmployeeID, EmployeeName, Department;

select * from vw_MonthlyWorkSummary;
