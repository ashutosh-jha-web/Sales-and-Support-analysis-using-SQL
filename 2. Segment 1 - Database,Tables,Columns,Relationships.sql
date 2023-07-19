-- Q1. Identify the tables in the database and their respective columns
-- Ans. There are 3 Tables in the database:
SHOW COLUMNS FROM agents; -- it Identify all respective columns from agents table. 
SHOW COLUMNS FROM customer; -- it Identify all respective columns from customers table.
SHOW COLUMNS FROM orders; -- it Identify all respective columns from orders table.

use chinook;
-- Q2. Determine the number of records in each table within the schema.
-- Ans. 
	select count(*) from agents; -- Table Agents contains 12 records.
	select count(*) from customer; -- Table Customer contains 25 records.
	select count(*) from orders; -- Table Orders contains 36 records.

-- Q3. Identify and handle any missing or inconsistent values in the dataset.
-- Ans. 
	-- 1) For table agents
	SELECT * FROM agents
	 WHERE AGENT_CODE IS NULL OR
	 AGENT_NAME  IS NULL OR
	 WORKING_AREA IS NULL OR
	 COMMISSION IS NULL OR 
	 PHONE_NO IS NULL OR 
	 COUNTRY IS NULL;
   
	-- 2) For table customer
	SELECT * FROM customer
	 WHERE CUST_CODE IS NULL OR
	 CUST_NAME IS NULL OR
	 CUST_CITY IS NULL OR
	 WORKING_AREA IS NULL OR
	 CUST_COUNTRY IS NULL OR
	 GRADE IS NULL OR
	 OPENING_AMT IS NULL OR 
	 RECEIVE_AMT IS NULL OR 
	 PAYMENT_AMT IS NULL OR 
	 OUTSTANDING_AMT IS NULL OR 
	 PHONE_NO IS NULL OR 
	 AGENT_CODE IS NULL;

	-- 3) For table orders
	SELECT * FROM orders
	 WHERE ORD_NUM IS NULL OR
	 ORD_AMOUNT IS NULL OR
	 ADVANCE_AMOUNT IS NULL OR
	 ORD_DATE IS NULL OR
	 AGENT_CODE IS NULL OR
	 ORD_DESCRIPTION IS NULL;
     
     
-- Q4. Analyse the data types of the columns in each table to ensure they are appropriate for the stored data.
-- Data types of columns:

-- 1. In the agents table:
	SELECT COLUMN_NAME,
 DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
 WHERE TABLE_NAME = 'agents';
-- 2.In the customer table:
SELECT COLUMN_NAME,
 DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
 WHERE TABLE_NAME = 'customer';
-- 3. In the orders table:
	SELECT COLUMN_NAME,
 DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
 WHERE TABLE_NAME = 'orders';
    
-- Q5. Identify any duplicate records within the tables and develop a strategy for handling them.
-- Duplicates record in agent tables
	SELECT * FROM agents
 GROUP BY AGENT_CODE
 HAVING COUNT(AGENT_CODE) > 1;

    -- we can see there are no duplicate value in any columns
    
-- Duplicates record in customer tables
	SELECT * FROM customer
 GROUP BY CUST_CODE
 HAVING COUNT(CUST_CODE) > 1;
 
    -- we can see there are no duplicate value in any columns
    
-- Duplicates record in orders tables
	SELECT * FROM orders
 GROUP BY ORD_NUM
 HAVING COUNT(ORD_NUM) > 1;
    -- we can see there are no duplicate value in any columns