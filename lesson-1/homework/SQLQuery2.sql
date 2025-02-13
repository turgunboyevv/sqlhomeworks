--task-1

CREATE TABLE student (
    id INT,  -- Hozircha NOT NULL yo‘q
    name VARCHAR(255),  
    age INT  
);
ALTER TABLE student
ALTER COLUMN id INT NOT NULL;


--task-2

CREATE TABLE product (
    product_id INT UNIQUE,
    product_name VARCHAR(255),
    price DECIMAL(10,2)
);

SELECT name 
FROM sys.key_constraints 
WHERE parent_object_id = OBJECT_ID('product') AND type = 'UQ';

ALTER TABLE product  
DROP CONSTRAINT [UQ__product__47027DF41637C584];  -- Olingan nomni qo‘yish kerak

ALTER TABLE product  
ADD CONSTRAINT UQ_product UNIQUE (product_id, product_name);
select * from product;

--task-3

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    order_date DATE
);

SELECT name 
FROM sys.key_constraints 
WHERE parent_object_id = OBJECT_ID('orders') AND type = 'PK';

INSERT INTO orders (order_id, customer_name, order_date) VALUES (1, 'Ali', '2025-02-13');
INSERT INTO orders (order_id, customer_name, order_date) VALUES (1, 'Hasan', '2025-02-14');
INSERT INTO orders (order_id, customer_name, order_date) VALUES (NULL, 'Bobur', '2025-02-15');

ALTER TABLE orders  
DROP CONSTRAINT [PK__orders__4659622978C41F8D];

ALTER TABLE orders  
ADD CONSTRAINT PK_orders PRIMARY KEY (order_id);

select * from orders;

--task-4

CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255)
);

CREATE TABLE item (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(255),
    category_id INT,
    CONSTRAINT FK_item_category FOREIGN KEY (category_id) REFERENCES category(category_id)
);

SELECT name 
FROM sys.foreign_keys 
WHERE parent_object_id = OBJECT_ID('item');

ALTER TABLE item  
DROP CONSTRAINT [FK_item_category];

ALTER TABLE item  
ADD CONSTRAINT FK_item_category FOREIGN KEY (category_id) REFERENCES category(category_id);

--task-5

CREATE TABLE account (
    account_id INT PRIMARY KEY,
    balance DECIMAL(10,2) CHECK (balance >= 0),
    account_type VARCHAR(50) CHECK (account_type IN ('Saving', 'Checking'))
);

SELECT name 
FROM sys.check_constraints 
WHERE parent_object_id = OBJECT_ID('account');

ALTER TABLE account  
DROP CONSTRAINT CK_balance;

ALTER TABLE account  
DROP CONSTRAINT CK_account_type;

ALTER TABLE account  
ADD CONSTRAINT CK_balance CHECK (balance >= 0);

ALTER TABLE account  
ADD CONSTRAINT CK_account_type CHECK (account_type IN ('Saving', 'Checking'));

select * from account;

--task-6

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100) DEFAULT 'Unknown'
);

SELECT name 
FROM sys.default_constraints 
WHERE parent_object_id = OBJECT_ID('customer');

ALTER TABLE customer  
DROP CONSTRAINT DF__customer__city__3E723F9C;

ALTER TABLE customer  
ADD CONSTRAINT DF_city DEFAULT 'Unknown' FOR city;

select * from customer;


--task-7

CREATE TABLE invoice (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    amount DECIMAL(10,2)
);

INSERT INTO invoice (amount) VALUES (100.50);
INSERT INTO invoice (amount) VALUES (200.75);
INSERT INTO invoice (amount) VALUES (50.25);
INSERT INTO invoice (amount) VALUES (175.00);
INSERT INTO invoice (amount) VALUES (300.00);

SET IDENTITY_INSERT invoice ON;

INSERT INTO invoice (invoice_id, amount) VALUES (100, 500.00);

SET IDENTITY_INSERT invoice OFF;

SELECT * FROM invoice;

--task-8

CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL CHECK (LEN(title) > 0),
    price DECIMAL(10,2) CHECK (price > 0),
    genre NVARCHAR(100) DEFAULT 'Unknown'
);

INSERT INTO books (title, price, genre) VALUES ('The Great Gatsby', 15.99, 'Classic');
INSERT INTO books (title, price) VALUES ('Harry Potter', 20.50); 
INSERT INTO books (title, price, genre) VALUES ('The Hobbit', 12.75, 'Fantasy');

INSERT INTO books (title, price, genre) VALUES ('', 10.00, 'Mystery');

INSERT INTO books (title, price, genre) VALUES ('Inferno', 0, 'Thriller');

ALTER TABLE books DROP CONSTRAINT [DF__books__genre];
ALTER TABLE books DROP CONSTRAINT [CK__books__price];
ALTER TABLE books DROP CONSTRAINT [CK__books__title];

ALTER TABLE books ADD CONSTRAINT chk_title CHECK (LEN(title) > 0);
ALTER TABLE books ADD CONSTRAINT chk_price CHECK (price > 0);
ALTER TABLE books ADD CONSTRAINT df_genre DEFAULT 'Unknown' FOR genre;

SELECT * FROM books;

--task-9

CREATE TABLE Book (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    author NVARCHAR(255) NOT NULL,
    published_year INT CHECK (published_year > 0)
);

CREATE TABLE Member (
    member_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) UNIQUE,
    phone_number NVARCHAR(20) UNIQUE
);

CREATE TABLE Loan (
    loan_id INT IDENTITY(1,1) PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL DEFAULT GETDATE(),
    return_date DATE NULL,
    CONSTRAINT fk_loan_book FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE,
    CONSTRAINT fk_loan_member FOREIGN KEY (member_id) REFERENCES Member(member_id) ON DELETE CASCADE
);

INSERT INTO Book (title, author, published_year) VALUES ('1984', 'George Orwell', 1949);
INSERT INTO Book (title, author, published_year) VALUES ('To Kill a Mockingbird', 'Harper Lee', 1960);

INSERT INTO Member (name, email, phone_number) VALUES ('Ali Valiyev', 'ali@gmail.com', '998901234567');


INSERT INTO Loan (book_id, member_id, loan_date) VALUES (1, 1, '2025-02-01');


UPDATE Loan SET return_date = GETDATE() WHERE loan_id = 1;

SELECT * FROM Loan;


-- tasks


CREATE TABLE Book (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    author NVARCHAR(255) NOT NULL,
    published_year INT CHECK (published_year > 0)
);


CREATE TABLE Member (
    member_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) UNIQUE,
    phone_number NVARCHAR(20) UNIQUE
);


CREATE TABLE Loan (
    loan_id INT IDENTITY(1,1) PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL DEFAULT GETDATE(),
    return_date DATE NULL,
    CONSTRAINT fk_loan_book FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE,
    CONSTRAINT fk_loan_member FOREIGN KEY (member_id) REFERENCES Member(member_id) ON DELETE CASCADE
);


INSERT INTO Book (title, author, published_year) VALUES 
('1984', 'George Orwell', 1949),
('To Kill a Mockingbird', 'Harper Lee', 1960),
('The Catcher in the Rye', 'J.D. Salinger', 1951);

INSERT INTO Member (name, email, phone_number) VALUES 
('Ali Valiyev', 'ali@gmail.com', '998901234567'),
('Madina Karimova', 'madina@gmail.com', '998907654321');

INSERT INTO Loan (book_id, member_id, loan_date) VALUES 
(1, 1, '2025-02-01'),
(2, 1, '2025-02-03'),
(2, 2, '2025-02-05'),
(3, 2, '2025-02-07');


UPDATE Loan SET return_date = GETDATE() WHERE loan_id = 1;

SELECT * FROM Loan;




