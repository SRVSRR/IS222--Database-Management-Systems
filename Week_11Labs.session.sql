Lab 9 - SQL Table Creation and Insert Statements
-- Lab 9 - SQL Table Creation and Insert Statements

-- @block
-- Create customer table
CREATE TABLE customer (
    CustomerCode VARCHAR(10) PRIMARY KEY,
    CustomerFirstName VARCHAR(50),
    CustomerLastName VARCHAR(50),
    CustomerAreaCode VARCHAR(10),
    CustomerPhone VARCHAR(15),
    CustomerBalance DECIMAL(10, 2)
);

-- Create customer2 table
CREATE TABLE customer2 (
    CustomerCode VARCHAR(10) PRIMARY KEY,
    CustomerFirstName VARCHAR(50),
    CustomerLastName VARCHAR(50),
    CustomerAreaCode VARCHAR(10),
    CustomerPhone VARCHAR(15),
    CustomerBalance DECIMAL(10, 2)
);

-- Create product table
CREATE TABLE product (
    ProductCode VARCHAR(10) PRIMARY KEY,
    ProductDescription VARCHAR(100),
    ProductPrice DECIMAL(10, 2)
);

-- Create invoice table
CREATE TABLE invoice (
    InvoiceNumber INT PRIMARY KEY,
    CustomerCode VARCHAR(10),
    InvoiceDate DATE,
    FOREIGN KEY (CustomerCode) REFERENCES customer(CustomerCode)
);

-- Create line table
CREATE TABLE line (
    InvoiceNumber INT,
    ProductCode VARCHAR(10),
    LineUnits INT,
    LinePrice DECIMAL(10, 2),
    FOREIGN KEY (InvoiceNumber) REFERENCES invoice(InvoiceNumber),
    FOREIGN KEY (ProductCode) REFERENCES product(ProductCode)
);


-- Insert into customer table
INSERT INTO customer (CustomerCode, CustomerFirstName, CustomerLastName, CustomerAreaCode, CustomerPhone, CustomerBalance)
VALUES 
('C001', 'John', 'Doe', 'AC01', '1234567', 150.00),
('C002', 'Jane', 'Smith', 'AC02', '7654321', 0.00),
('C003', 'Emily', 'Jones', 'AC03', '3456789', 80.00);

-- Insert into customer2 table
INSERT INTO customer2 (CustomerCode, CustomerFirstName, CustomerLastName, CustomerAreaCode, CustomerPhone, CustomerBalance)
VALUES 
('C004', 'Alice', 'Brown', 'AC04', '9876543', 200.00),
('C005', 'David', 'Clark', 'AC05', '1928374', 50.00);

-- Insert into product table
INSERT INTO product (ProductCode, ProductDescription, ProductPrice)
VALUES 
('P001', 'Laptop', 1200.00),
('P002', 'Mouse', 25.00),
('P003', 'Keyboard', 55.00),
('P004', 'Monitor', 150.00);

-- Insert into invoice table
INSERT INTO invoice (InvoiceNumber, CustomerCode, InvoiceDate)
VALUES 
(1001, 'C001', '2024-01-10'),
(1002, 'C002', '2024-02-15'),
(1003, 'C003', '2024-03-20'),
(1004, 'C001', '2024-04-25');

-- Insert into line table
INSERT INTO line (InvoiceNumber, ProductCode, LineUnits, LinePrice)
VALUES 
(1001, 'P001', 1, 1200.00),
(1001, 'P002', 2, 25.00),
(1002, 'P003', 1, 55.00),
(1003, 'P002', 3, 25.00),
(1004, 'P004', 2, 150.00),
(1004, 'P003', 1, 55.00);

-- @block
SELECT * FROM invoice;

-- @block
-- Date_Format Function
SELECT DATE_FORMAT(InvoiceDate, '%W, %D %M, %Y') AS NewDate FROM invoice;

-- @block
-- Diff Date Functions
SELECT DATE_FORMAT(InvoiceDate, '%d/%m/%Y') AS NewDate FROM invoice;
-- @block
SELECT InvoiceNumber, InvoiceDate, DateDiff(InvoiceDate, '2004-02-12') AS datedifference FROM invoice; 

-- @block
CREATE INDEX description_index ON product(ProductDescription);

-- @block
SHOW INDEX FROM product;

-- @block
CREATE VIEW Customer_View AS
SELECT CustomerCode AS CV_CustomerCode, CONCAT(CustomerFirstName, " ", CustomerLastName) AS CV_Name,CustomerAreaCode AS CV_AreaCode, CustomerPhone AS CV_Phone, CustomerBalance AS CV_Balance
FROM customer;

-- @block
SELECT * FROM Customer_View;

-- @block
CREATE VIEW invoice_totals_view AS
SELECT 
    InvoiceNumber, 
    SUM(LineUnits * LinePrice) AS TotalAmount
FROM line
GROUP BY InvoiceNumber;

-- @block
DROP VIEW invoice_totals_view;

-- @block
SELECT * FROM invoice_totals_view;

-- @block
SELECT
c.CustomerCode, 
i.InvoiceNumber, 
i.InvoiceDate,
p.ProductDescription,
l.LineUnits,
l.LinePrice
FROM invoice AS i, customer AS c, product AS p, line AS l
WHERE i.InvoiceNumber = l.InvoiceNumber AND l.ProductCode = p.ProductCode
ORDER BY
    c.CustomerCode ASC, 
    i.InvoiceNumber ASC, 
    p.ProductDescription ASC;

-- @block
