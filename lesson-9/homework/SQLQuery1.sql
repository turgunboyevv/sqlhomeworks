create database class9;
go
use class9;

CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

select * from Employees;

-- Task-1

WITH EmployeeHierarchy AS (
    SELECT 
        EmployeeID, 
        ManagerID, 
        JobTitle, 
        0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL -- Start from the President (root)
    
    UNION ALL
    
    SELECT 
        e.EmployeeID, 
        e.ManagerID, 
        e.JobTitle, 
        eh.Depth + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh 
        ON e.ManagerID = eh.EmployeeID
)
SELECT EmployeeID, ManagerID, JobTitle, Depth
FROM EmployeeHierarchy
ORDER BY Depth, EmployeeID;

-- Task-2

DECLARE @N INT = 10;

WITH FactorialCTE AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, Factorial * (Num + 1)
    FROM FactorialCTE
    WHERE Num < @N
)
SELECT Num, Factorial
FROM FactorialCTE
OPTION (MAXRECURSION 100);	

-- Task-3

DECLARE @N INT = 10;

WITH FibonacciCTE AS (
    SELECT 1 AS n, 0 AS Fibonacci_Number, 1 AS NextNumber
    UNION ALL
    SELECT n + 1, NextNumber, Fibonacci_Number + NextNumber
    FROM FibonacciCTE
    WHERE n < @N
)
SELECT n, Fibonacci_Number
FROM FibonacciCTE
OPTION (MAXRECURSION 100);

