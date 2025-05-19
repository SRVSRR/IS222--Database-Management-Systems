-- Week 12 Lab: Transactions
-- @block
-- Drop and Create customer3 Table
DROP TABLE IF EXISTS customer3;
CREATE TABLE customer3 (
Cus_code INT PRIMARY KEY,
Cus_Lname VARCHAR(50),
Cus_Fname VARCHAR(50),
Cus_Initial CHAR(1),
Cus_AreaCode CHAR(3),
Cus_Phone VARCHAR(12),
Cus_Balance DECIMAL(10,2)
);
-- @block
-- Insert Data into customer3
INSERT INTO customer3 VALUES
(777, 'Di Stefano', 'Alfredo', 'I', '617', '844-2173', 9.80),
(778, 'Puskas', 'Ferenc', 'K', '619', '844-2273', 45.40),
(779, 'Ramas', 'Alfred', 'A', '615', '844-2573', 0.00);

-- @block
-- View Data
SELECT * FROM customer3;

-- @block
-- Update Area Code for Cus_code 777
START TRANSACTION;
UPDATE customer3
SET Cus_AreaCode = '666'
WHERE Cus_code = 777;

-- @block
-- View Updated Data
SELECT * FROM customer3;

-- @block
-- Rollback the Change
ROLLBACK;
SELECT * FROM customer3;
-- Explanation:
-- After the rollback, the change to Cus_AreaCode is undone. The area code for Cus_code = 777 reverts back to '617'. Task 2: Multiple Statements in One Transaction

-- @block
-- Create customer4 Table
DROP TABLE IF EXISTS customer4;
CREATE TABLE customer4 AS SELECT * FROM customer3;
ALTER TABLE customer4 ADD PRIMARY KEY (Cus_code);

-- @block
-- Execute the following as one transaction
START TRANSACTION;
INSERT INTO customer4 VALUES (780, 'Cruyff', 'Johan', 'R', '616', '844-2179', 10.00);
UPDATE customer4
SET Cus_AreaCode = '666'
WHERE Cus_code = 777;
ROLLBACK;

-- @block
SELECT * FROM customer4;
-- Explanation:
-- Since the transaction was rolled back, no new data is added and no update is applied.

-- @block
-- Next Transaction - Commit and Rollback Together
START TRANSACTION;
INSERT INTO customer4 VALUES (999, 'Boone', 'Megan', 'S', '699', '844-2199', 0.00);
UPDATE customer4
SET Cus_AreaCode = '666'
WHERE Cus_code = 779;
COMMIT;
ROLLBACK;
-- @block
SELECT * FROM customer4;
-- Explanation: The COMMIT finalizes all changes before the ROLLBACK, so changes persist.

-- @block
SOURCE /path_to_file/Wk12_Lecture3_CreateTables.sql;
-- 2. Run Transaction Script and Record Results
-- a) Explanation of Final SQL Output
-- If rollback is used, data is not saved.
-- If committed, data persists.
-- b) Re-run Transaction Script
SELECT MAX(order_num) FROM orders;
-- c) What happens each time it's run?
-- If rollback is used, no data remains.
-- If commit is used, data accumulates.