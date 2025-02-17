use class2;

-- task-1
--1. DELETE vs TRUNCATE vs DROP (with IDENTITY example)
--Create a table test_identity with an IDENTITY(1,1) column and insert 5 rows.
--Use DELETE, TRUNCATE, and DROP one by one (in different test cases) and observe how they behave.
--Answer the following questions:
--What happens to the identity column when you use DELETE?
--What happens to the identity column when you use TRUNCATE?
--What happens to the table when you use DROP?
drop table if exists test_identity;
CREATE TABLE test_identity (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO test_identity (name) VALUES 
('A'), ('B'), ('C'), ('D'), ('E');

SELECT * FROM test_identity;

DELETE FROM test_identity WHERE id >= 1;

INSERT INTO test_identity (name) VALUES ('F');

SELECT * FROM test_identity;

TRUNCATE TABLE test_identity;

INSERT INTO test_identity (name) VALUES ('G');

SELECT * FROM test_identity;

DROP TABLE test_identity;

SELECT * FROM test_identity; -- ERROR!


--task-2
--2. Common Data Types
--Create a table data_types_demo with columns covering at least one example of each data type covered in class.
--Insert values into the table.
--Retrieve and display the values.

DROP TABLE IF EXISTS data_types_demo; -- Toza muhit yaratish

CREATE TABLE data_types_demo (
    id INT IDENTITY(1,1) PRIMARY KEY,    -- Integer (IDENTITY bilan)
    name VARCHAR(50),                    -- String (varchar)
    age TINYINT,                          -- Tiny Integer (0-255)
    salary DECIMAL(10,2),                 -- Decimal (aniq kasr son)
    is_active BIT,                        -- Boolean (0 yoki 1)
    birth_date DATE,                      -- Date (YYYY-MM-DD)
    login_time TIME,                      -- Time (HH:MM:SS)
    created_at DATETIME,                  -- DateTime (sana + vaqt)
    notes TEXT,                           -- Long Text
    binary_data VARBINARY(50)             -- Binary data (Fayllar, rasmlar)
);

INSERT INTO data_types_demo 
(name, age, salary, is_active, birth_date, login_time, created_at, notes, binary_data) 
VALUES 
('Alice', 25, 50000.75, 1, '1998-07-12', '08:30:00', GETDATE(), 'First record', 0x41),
('Bob', 30, 75000.50, 0, '1993-05-22', '09:15:30', GETDATE(), 'Second record', 0x42),
('Charlie', 40, 100000.99, 1, '1984-11-02', '12:45:15', GETDATE(), 'Third record', 0x43);

SELECT * FROM data_types_demo;

-- task-3
--3. Inserting and Retrieving an Image
--Create a photos table with an id column and a varbinary(max) column.
--Insert an image into the table using OPENROWSET.
--Write a Python script to retrieve the image and save it as a file.

DROP TABLE IF EXISTS photos; -- Agar jadval mavjud bo‘lsa, o‘chirib tashlaymiz

CREATE TABLE photos (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Unikal ID
    image_data VARBINARY(MAX)          -- Rasmni saqlash uchun
);

INSERT INTO photos (image_data)
SELECT BulkColumn FROM OPENROWSET(BULK 'C:\Users\User\Desktop\sql\sqlhomeworks\lesson-2\homework\python.img', SINGLE_BLOB) AS img;

SELECT * FROM photos;

-- task-4
--4. Computed Columns
--Create a student table with a computed column total_tuition as classes * tuition_per_class.
--Insert 3 sample rows.
--Retrieve all data and check if the computed column works correctly.

DROP TABLE IF EXISTS students;  -- Agar jadval mavjud bo‘lsa, uni o‘chirib tashlaymiz

CREATE TABLE students (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Avtomatik ID
    name VARCHAR(100) NOT NULL,         -- Talabaning ismi
    classes INT NOT NULL,               -- Darslar soni
    tuition_per_class DECIMAL(10,2) NOT NULL, -- Har bitta dars uchun to‘lov miqdori
    total_tuition AS (classes * tuition_per_class) PERSISTED -- Computed Column
);

INSERT INTO students (name, classes, tuition_per_class)
VALUES 
    ('john', 5, 150.00),
    ('dina', 3, 200.50),
    ('doe', 7, 175.75);

SELECT * FROM students;

-- task-5
--5. CSV to SQL Server
--Download or create a CSV file with at least 5 rows of worker data (id, name).
--Use BULK INSERT to import the CSV file into the worker table.
--Verify the imported data.

DROP TABLE IF EXISTS worker;

CREATE TABLE worker (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

BULK INSERT worker
FROM 'C:\Users\User\Desktop\sql\sqlhomeworks\lesson-2\homework\task5.csv'
WITH (
    FORMAT = 'CSV',          -- CSV format
    FIRSTROW = 2,            -- Birinchi qator sarlavha (header) bo‘lgani uchun 2-qatordan boshlaymiz
    FIELDTERMINATOR = ',',   -- Virgullardan ajratilgan
    ROWTERMINATOR = '\n',    -- Har bir qator yangi satr bilan tugaydi
    TABLOCK
);

SELECT * FROM worker;





