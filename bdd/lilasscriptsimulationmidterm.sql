-- Simulation Midterm

-- Question2
-- The design below is already normalized to 3NF

-- CUSTOMER -----< ORDERS -----< ORDER_LINE >----- PRODUCT

-- CUSTOMER(CustID, CustName)
-- ORDERS(OID, Odate, Payment, CustD)
-- Order_line(ProductID, OID, Quantity)
-- PRODUCT(ProductID, Description, Price)

-- Create a user called your_name_TEST
CREATE USER lilas_test IDENTIFIED BY lilas;

-- Provide needed privileges
GRANT connect, resource TO lilas_test;

-- Connect to the user just created to:
CONNECT lilas_test/lilas;

-- a) Create a SPOOL file called you_name_TEST
SPOOL c:\bdd\lilas_test.txt

-- b) Create all the tables using NUMBER for Id, VARCHAR2 for name, and DATE for date.

CREATE TABLE customer (custid NUMBER, custname VARCHAR2(100));
CREATE TABLE orders (oid NUMBER, odate DATE, payment NUMBER, custid NUMBER);
CREATE TABLE order_line (productid NUMBER, oid NUMBER, quantity NUMBER);
CREATE TABLE product (productid NUMBER, description VARCHAR2(100), price NUMBER);

-- c) Add all the PK and FK to each table.
ALTER TABLE customer
ADD CONSTRAINT customer_custid_PK PRIMARY KEY (custid);
ALTER TABLE orders
ADD CONSTRAINT orders_oid_PK PRIMARY KEY (oid);
ALTER TABLE order_line
ADD CONSTRAINT orderl_oid_pid_PK PRIMARY KEY (oid, productid);
ALTER TABLE product
ADD CONSTRAINT product_pid_PK PRIMARY KEY (productid);

ALTER TABLE orders
ADD CONSTRAINT orders_custid_FK FOREIGN KEY (custid)
REFERENCES customer(custid);
ALTER TABLE order_line
ADD CONSTRAINT orderl_oid_FK FOREIGN KEY (oid)
REFERENCES orders(oid);
ALTER TABLE order_line
ADD CONSTRAINT orderl_productid_FK FOREIGN KEY (productid)
REFERENCES product(productid);

-- d) Add constraint NOT NULL to CustName, and Description.
ALTER TABLE customer
MODIFY (custname VARCHAR2(100) CONSTRAINT customer_custname_NN NOT NULL);
ALTER TABLE product
MODIFY (description VARCHAR2(100) CONSTRAINT product_description_NN NOT NULL);

-- e) Add column GENDER of datatype CHAR (1) to table Customer 
-- and constraint CHECK to accept the following value : M,F,m, or f.
ALTER TABLE customer
ADD (gender CHAR(1));
ALTER TABLE customer
MODIFY (gender CHAR(1) CONSTRAINT customer_gender_CC CHECK (gender IN ('M', 'F', 'm', 'f')));

-- f) Add to table PRODUCT a constraint CHECK to make sure the PRICE is a positive number.
ALTER TABLE product
MODIFY (price NUMBER CONSTRAINT product_price_CC CHECK (price >=0));

-- g) Add constraint UNIQUE to column Payment of table Orders
ALTER TABLE orders
MODIFY (payment NUMBER CONSTRAINT orders_payment_UK UNIQUE);

-- Question 3
-- Write the command SQL to insert at least one row of data into each table of
-- question 2 (Each column MUST have a value, you can use sysdate as order date).

INSERT INTO customer (custid, custname)
VALUES (1, 'Lilas');

INSERT INTO orders (oid, odate, payment, custid)
VALUES (1, sysdate, 100, 1);

INSERT INTO product (productid, description, price)
VALUES (1, 'MIDI', 120);

INSERT INTO order_line (productid, oid, quantity)
VALUES (1, 1, 1);

-- Question 4
-- We need to generate all PK, FK values automatically. 
-- For each table of question 3, create a sequence to generate the number for the PK value. 
-- Use the sequences just created, insert another row in each table. 
-- (hint: START the sequence with a number GREATER than the number already exist in the table)

CREATE SEQUENCE oidpk_seq START WITH 2;
CREATE SEQUENCE custidpk_seq START WITH 2;
CREATE SEQUENCE pidpk_seq START WITH 2;

INSERT INTO customer (custid, custname)
VALUES (custidpk_seq.NEXTVAL, 'Iris');

INSERT INTO orders (oid, odate, payment, custid)
VALUES (oidpk_seq.NEXTVAL, sysdate, 101, custidpk_seq.CURRVAL);

INSERT INTO product (productid, description, price)
VALUES (pidpk_seq.NEXTVAL, 'Drawing_Tablet', 130);

INSERT INTO order_line (productid, oid, quantity)
VALUES (pidpk_seq.CURRVAL, oidpk_seq.CURRVAL, 1);

-- Question 5
-- Using database of question 3, write a query statement to 
-- display Customer name, order date, Payment, description, price, and quantity ordered 
-- of all orders of customer number 1.

SELECT custname, odate, payment, description, price, quantity 
FROM customer, orders, product, order_line
WHERE customer.custid = orders.custid
AND orders.oid = order_line.oid
AND product.productid = order_line.productid
AND customer.custid = 1;

SPOOL OFF