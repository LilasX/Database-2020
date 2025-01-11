-- Project Part 3

-- Question 1

-- 1. Using SQL*Plus
-- Open Run SQL Command Line

-- 2. Connect to user sys (sys/sys as sysdba)
CONNECT sys/sys as sysdba

-- 3. Create a user called your_name_L3Q1 ( or C##your_name if you have ORACLE 12c)
CREATE USER lilas_L3Q1 IDENTIFIED BY lilas;

-- 4. Connect to the user just created to:
--To connect you need to provide privileges
GRANT connect, resource TO lilas_L3Q1;
CONNECT lilas_L3Q1/lilas;

-- a) Create a SPOOL file called your_name_L3Q1
SPOOL c:\bdd\lilas_L3Q1.txt

-- b) Create all the tables of the following final design using 
-- data type NUMBER for ID , varchar2 for text , and DATE for dates

-- CUSTOMER(CustID, CustName, Phone)
-- ORDERS(OID, Odate,CustID)
-- PRODUCT(ProductID, Description, Price)
-- ORDER_LINE(ProductID, OID, Quantity)

CREATE TABLE customer (custid NUMBER, custname VARCHAR2(100), phone NUMBER);
CREATE TABLE orders (oid NUMBER, odate DATE, custid NUMBER);
CREATE TABLE product (productid NUMBER, description VARCHAR2(100), price NUMBER);
CREATE TABLE order_line (productid NUMBER, oid NUMBER, quantity NUMBER);

-- c) Display the name and structure of all the tables belonged to user your_name_L3Q1.

-- Display the name of all tables
SELECT table_name FROM user_tables;

-- Display the structure of all tables
DESC customer
DESC orders
DESC product
DESC order_line

-- Save SPOOL file
SPOOL OFF

