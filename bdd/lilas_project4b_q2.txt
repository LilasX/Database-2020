-- Question 2

-- Can we create tables, primary key, foreign key AT THE SAME time?
-- If yes, please create a script file called part4B.sql contain all the command needed 
-- to obtain the same result as question 1.

CONNECT sys/sys as sysdba

CREATE USER lilas_L4Q2b IDENTIFIED BY lilas;

GRANT connect, resource TO lilas_L4Q2b;
CONNECT lilas_L4Q2b/lilas;

SPOOL c:\bdd\lilas_partB.txt

CREATE TABLE customer (custid NUMBER CONSTRAINT customer_custid_PK PRIMARY KEY, custname VARCHAR2(100) CONSTRAINT customer_custname_NN NOT NULL, phone NUMBER);

CREATE TABLE orders (oid NUMBER CONSTRAINT orders_oid_PK PRIMARY KEY, odate DATE, custid NUMBER, CONSTRAINT orders_custid_FK FOREIGN KEY (custid) REFERENCES customer(custid));

CREATE TABLE supplier (supplier_id NUMBER CONSTRAINT supplier_supplier_id_PK PRIMARY KEY, supplier_name VARCHAR2(100) CONSTRAINT supplier_supplier_name_NN NOT NULL);

CREATE TABLE product (productid NUMBER CONSTRAINT product_productid_PK PRIMARY KEY, description VARCHAR2(100) CONSTRAINT product_description_NN NOT NULL, price NUMBER CONSTRAINT product_price_CC CHECK (price >=0), supplier_id NUMBER, CONSTRAINT product_supplier_id_FK FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id));

CREATE TABLE order_line (productid NUMBER, oid NUMBER, quantity NUMBER, CONSTRAINT order_line_productid_oid_PK PRIMARY KEY (productid, oid), CONSTRAINT order_line_oid_FK FOREIGN KEY (oid) REFERENCES orders(oid), CONSTRAINT order_line_productid_FK FOREIGN KEY (productid)
REFERENCES product(productid));

SELECT table_name FROM user_tables;

DESC customer
DESC orders
DESC product
DESC order_line
DESC supplier

SELECT constraint_name, constraint_type, table_name FROM user_constraints;

SPOOL OFF
