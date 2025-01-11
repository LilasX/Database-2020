-- Project Part 7

-- Question 1 :  SOFTWARE EXPERT APPLICATION

connect sys/sys as sysdba;

SPOOL c:\bdd\lilas_L7.txt

-- Create a user called nora04 with connect, resource, and CREATE VIEW privileges.
CREATE USER nora04 IDENTIFIED BY nora04;
GRANT connect , resource TO nora04;
GRANT create view TO nora04;

-- Connect to the new user just created and run the script 7software.
connect nora04/nora04;
Start c:\bdd\Software.sql

-- Create a view just to DISPLAY the name of the project and the name of the consultant who work for that project. 
CREATE OR REPLACE VIEW project_view AS
SELECT project_name, c_first, c_last
FROM project, consultant, project_consultant
WHERE project_consultant.c_id = consultant.c_id
AND project.p_id = project_consultant.p_id;

-- Question 2 : NORTHWOODS UNIVERSITY APPLICATION

connect sys/sys as sysdba;

-- Create a user called nora03 with connect, resource, and CREATE VIEW privileges.
CREATE USER nora03 IDENTIFIED BY nora03;
GRANT connect , resource TO nora03;
GRANT create view TO nora03;

-- Connect to the new user just created and run the script 7northwoods
connect nora03/nora03;
Start c:\bdd\Northwoods.sql

-- Create a view called student_faculty_1 with column s_last, s_first, s_dob of all student advised by
-- faculty number 1 or faculty number 2. 
-- Make sure that the student will ALWAYS advised by either faculty number 1 or faculty number 2. 
CREATE OR REPLACE VIEW student_faculty_1 AS
SELECT DISTINCT s_last, s_first, s_dob
FROM student, faculty
WHERE student.f_id = faculty.f_id
AND student.f_id = 1
OR student.f_id = 2
WITH CHECK OPTION;

connect sys/sys as sysdba;

-- Question 3 : CLEARWATER TRAIDER APPLICATION

-- Create a user called nora02 with connect, resource, and CREATE VIEW privileges.
CREATE USER nora02 IDENTIFIED BY nora02;
GRANT connect , resource TO nora02;
GRANT create view TO nora02;

-- Connect to the new user just created and run the script 7clearwater
connect nora02/nora02;
Start c:\bdd\Clearwater.sql

-- Create the Entity Relationship Diagram for Clearwater traider application.
-- CUSTOMER -----< ORDERS >----- ORDER_SOURCE
-- CATEGORY -----< ITEM -----< INVENTORY >----- COLOR
-- SHIPMENT -----< SHIPMENT_LINE >----- INVENTORY -----< ORDER_LINE >----- ORDERS

-- We have not created the table Order_line_archive yet.
-- The following is the logical design of table Order_line_archive:
-- ORDER_LINE_ARCHIVE(old-o-id, old-inv-id, old-ol-quantity)

-- Can you create a view base on table order_line_archive even if the table have not been created ?
-- Yes, it's possible, though it will have compilation errors. The view created will be a valid one after the missing -- table creation.

-- INCOMPLETE

-- If yes, create a view called OLD_ORDER_DETAIL with columns old-o-id, old-inv-id, old-ol-quantity, order date, -- method of payment, item description, customer last, and first name.
CREATE OR REPLACE FORCE VIEW old_order_detail AS
SELECT DISTINCT old_o_id, old_inv_id, old_ol_quantity, o_date, o_methpmt, item_desc, c_last, c_first
FROM orders, customer, item, order_line, order_line_archive, inventory
WHERE orders.o_id = order_line.o_id
AND customer.c_id = orders.c_id
AND item.item_id = inventory.item_id
AND inventory.inv_id = order_line.old_inv_id
AND order_line.o_id = order_line_archive.old_o_id;


SPOOL OFF