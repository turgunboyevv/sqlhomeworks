-- TASK-3
drop table if exists Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES 
    (1, 'Laptop', 'Electronics', 1200, 15),
    (2, 'Smartphone', 'Electronics', 800, 30),
    (3, 'Desk Chair', 'Furniture', 150, 5),
    (4, 'LED TV', 'Electronics', 1400, 8),
    (5, 'Coffee Table', 'Furniture', 250, 0),
    (6, 'Headphones', 'Accessories', 200, 25),
    (7, 'Monitor', 'Electronics', 350, 12),
    (8, 'Sofa', 'Furniture', 900, 2),
    (9, 'Backpack', 'Accessories', 75, 50),
    (10, 'Gaming Mouse', 'Accessories', 120, 20);

select * from Products;

SELECT Category, ProductName, Price, Stock,
       CASE 
           WHEN Stock = 0 THEN 'Out of Stock'
           WHEN Stock BETWEEN 1 AND 10 THEN 'Low Stock'
           ELSE 'In Stock'
       END AS InventoryStatus
FROM Products
ORDER BY Price DESC
OFFSET 5 ROWS;
