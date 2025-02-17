create database class2;
use class2;
-- task-1
drop table if exists test_identity;
CREATE TABLE test_identity (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO test_identity (name) VALUES 
('A'), ('B'), ('C'), ('D'), ('E');

DELETE FROM test_identity;

INSERT INTO test_identity (name) VALUES ('F');

SELECT * FROM test_identity;

TRUNCATE TABLE test_identity;

INSERT INTO test_identity (name) VALUES ('G');

SELECT * FROM test_identity;

DROP TABLE test_identity;

SELECT * FROM test_identity;


-- task-2
DROP TABLE IF EXISTS data_types_demo;

CREATE TABLE data_types_demo (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50),
    age TINYINT,
    salary DECIMAL(10,2),
    is_active BIT,
    birth_date DATE,
    login_time TIME,
    created_at DATETIME,
    notes TEXT,
    binary_data VARBINARY(50)
);

INSERT INTO data_types_demo 
(name, age, salary, is_active, birth_date, login_time, created_at, notes, binary_data) 
VALUES 
('Alice', 25, 50000.75, 1, '1998-07-12', '08:30:00', GETDATE(), 'First record', 0x41),
('Bob', 30, 75000.50, 0, '1993-05-22', '09:15:30', GETDATE(), 'Second record', 0x42),
('Charlie', 40, 100000.99, 1, '1984-11-02', '12:45:15', GETDATE(), 'Third record', 0x43);

SELECT * FROM data_types_demo;

-- task-3

DROP TABLE IF EXISTS photos;

CREATE TABLE photos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    image_data VARBINARY(MAX)
);

INSERT INTO photos (image_data)
SELECT BulkColumn FROM OPENROWSET(BULK 'C:\Users\User\Desktop\sql\sqlhomeworks\lesson-2\homework\python.img', SINGLE_BLOB) AS img;

SELECT * FROM photos;


-- task-4

DROP TABLE IF EXISTS students;

CREATE TABLE students (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    classes INT NOT NULL,
    tuition_per_class DECIMAL(10,2) NOT NULL,
    total_tuition AS (classes * tuition_per_class) PERSISTED
);

INSERT INTO students (name, classes, tuition_per_class)
VALUES 
    ('Ali Valiyev', 5, 150.00),
    ('Madina Karimova', 3, 200.50),
    ('Olim Saidov', 7, 175.75);

SELECT * FROM students;

-- task-5

DROP TABLE IF EXISTS worker;

CREATE TABLE worker (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

BULK INSERT worker
FROM 'C:\Users\User\Desktop\sql\sqlhomeworks\lesson-2\task5.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

SELECT * FROM WORKER;


