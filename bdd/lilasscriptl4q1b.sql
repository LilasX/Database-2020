-- Project Part 4b

-- Question 1

-- The following design is normalized to 3NF

-- CUSTOMER(CustID, CustName, Phone)
-- ORDERS(OID, Odate,CustID)
-- PRODUCT(ProductID, Description, Price)
-- ORDER_LINE(ProductID, OID, Quantity)
-- SUPPLIER(Supplier-ID, Supplier-Name)

-- 1. Using SQL*Plus
-- Open Run SQL Command Line

-- 2. Connect to user sys (sys/sys as sysdba)
CONNECT sys/sys as sysdba

-- 3. Create a user called your_name_L4Q1b
CREATE USER lilas_L4Q1b IDENTIFIED BY lilas;

-- 4. Connect to the user just created to:
-- To connect you need to provide privileges
GRANT connect, resource TO lilas_L4Q1b;
CONNECT lilas_L4Q1b/lilas;

-- i) Create a SPOOL file called your_name_L4Q1b.
SPOOL c:\bdd\lilas_L4Q1b.txt

-- j) Create all the tables of the following final design using 
-- data type NUMBER for ID ,varchar2 for text , and DATE for dates.

CREATE TABLE customer (custid NUMBER, custname VARCHAR2(100), phone NUMBER);
CREATE TABLE orders (oid NUMBER, odate DATE, custid NUMBER);
CREATE TABLE product (productid NUMBER, description VARCHAR2(100), price NUMBER);
CREATE TABLE order_line (productid NUMBER, oid NUMBER, quantity NUMBER);
CREATE TABLE supplier (supplier_id NUMBER, supplier_name VARCHAR2(100));

-- k) Create appropriate Primary Key for each table
ALTER TABLE customer
ADD CONSTRAINT customer_custid_PK PRIMARY KEY (custid);
ALTER TABLE orders
ADD CONSTRAINT orders_oid_PK PRIMARY KEY (oid);
ALTER TABLE product
ADD CONSTRAINT product_productid_PK PRIMARY KEY (productid);
ALTER TABLE order_line
ADD CONSTRAINT order_line_productid_oid_PK PRIMARY KEY (productid, oid);
ALTER TABLE supplier
ADD CONSTRAINT supplier_supplier_id_PK PRIMARY KEY (supplier_id);

-- l) Using the E.R.D below to create appropriate Foreign Key for each table if needed.

-- CUSTOMER -----< ORDERS  -----< ORDER_LINE >----- PRODUCT >----- SUPPLIER

ALTER TABLE orders
ADD CONSTRAINT orders_custid_FK FOREIGN KEY (custid)
REFERENCES customer(custid);
ALTER TABLE order_line
ADD CONSTRAINT order_line_oid_FK FOREIGN KEY (oid)
REFERENCES orders(oid);
ALTER TABLE order_line
ADD CONSTRAINT order_line_productid_FK FOREIGN KEY (productid)
REFERENCES product(productid);

-- Missing Supplier-ID in Product table
ALTER TABLE product
ADD (supplier_id NUMBER);

ALTER TABLE product
ADD CONSTRAINT product_supplier_id_FK FOREIGN KEY (supplier_id)
REFERENCES supplier(supplier_id);

-- m)Make sure that columns Cust-Name, Description, and Supplier-Name ALWAYS has a value in it.
ALTER TABLE customer
MODIFY (custname VARCHAR2(100) CONSTRAINT customer_custname_NN NOT NULL);
ALTER TABLE product
MODIFY (description VARCHAR2(100) CONSTRAINT product_description_NN NOT NULL);
ALTER TABLE supplier
MODIFY (supplier_name VARCHAR2(100) CONSTRAINT supplier_supplier_name_NN NOT NULL);

-- n) Make sure that we can not insert a negative value in column PRICE 
ALTER TABLE product
MODIFY (price NUMBER CONSTRAINT product_price_CC CHECK (price >=0));

-- o) Display the name and structure of all the tables belonged to user your_name_L4Q1b.

-- Display the name of all tables
SELECT table_name FROM user_tables;

-- Display the structure of all tables
DESC customer
DESC orders
DESC product
DESC order_line
DESC supplier

-- p) Display the name and type of all constraints of user your_name_L4Q1b.
SELECT constraint_name, constraint_type, table_name FROM user_constraints;

SPOOL OFF