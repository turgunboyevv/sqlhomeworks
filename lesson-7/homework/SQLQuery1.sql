create database class7
go
use class7;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);


INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');

-- task-1
SELECT 
    C.CustomerID,
    C.CustomerName,
    O.OrderID,
    O.OrderDate
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID;

	
--task-2
SELECT 
    C.CustomerID,
    C.CustomerName
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;

--task-3
SELECT 
    O.OrderID,
    P.ProductName,
    OD.Quantity
FROM 
    Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID;

--task-4
SELECT 
    C.CustomerID,
    C.CustomerName,
    COUNT(O.OrderID) AS OrderCount
FROM 
    Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName
HAVING COUNT(O.OrderID) > 1;

--task-5
SELECT 
    OD.OrderID,
    P.ProductName,
    OD.Price
FROM 
    OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
WHERE OD.Price = (SELECT MAX(Price) FROM OrderDetails WHERE OrderID = OD.OrderID);

--task-6
SELECT 
    C.CustomerID,
    C.CustomerName,
    MAX(O.OrderDate) AS LatestOrderDate
FROM 
    Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName;

--task-7
SELECT 
    C.CustomerID,
    C.CustomerName
FROM 
    Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY C.CustomerID, C.CustomerName
HAVING 
    COUNT(DISTINCT CASE WHEN P.Category != 'Electronics' THEN 1 END) = 0;


--task-8
SELECT DISTINCT 
    C.CustomerID,
    C.CustomerName
FROM 
    Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE P.Category = 'Stationery';

--task-9
SELECT 
    C.CustomerID,
    C.CustomerName,
    SUM(OD.Quantity * OD.Price) AS TotalSpent
FROM 
    Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY 
    C.CustomerID, C.CustomerName;










