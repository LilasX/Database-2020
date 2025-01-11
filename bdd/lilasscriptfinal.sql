-- Final Exam

-- Question 2

-- DEPARTMENT -----< EMPLOYEE -----< JOB_ASSIGNED >----- JOB

-- DEPARTMENT(DepartmentID, DepartmentName)
-- EMPLOYEE(EmployeeID, EmployeeName, BirthDate, Salary, DepartmentID)
-- JOB_ASSIGNED(EmployeeID, JobID, Date_job_assigned)
-- JOB(JobID, Job_Description, Skill_Required) 

-- Write the SQL command to:
-- Create a user called your_name_FINAL
CREATE USER lilas_FINAL_Q1 IDENTIFIED BY lilas;

-- Provide needed privileges
GRANT connect, resource TO lilas_FINAL_Q1;

-- Connect to the user just created to:
CONNECT lilas_FINAL_Q1/lilas;

-- a) Create a SPOOL file called you_name_FINAL
SPOOL c:\bdd\Lilas_FINAL.txt

-- b) Create all the tables using NUMBER for Id, VARCHAR2 for name, and DATE for date. (6 marks)

CREATE TABLE DEPARTMENT(DepartmentID NUMBER, DepartmentName VARCHAR2(100));
CREATE TABLE EMPLOYEE(EmployeeID NUMBER, EmployeeName VARCHAR2(100), BirthDate DATE, Salary NUMBER, DepartmentID NUMBER);
CREATE TABLE JOB_ASSIGNED(EmployeeID NUMBER, JobID NUMBER, Date_job_assigned DATE);
CREATE TABLE JOB(JobID NUMBER, Job_Description VARCHAR2(100), Skill_Required VARCHAR2(100));

-- c) Add all the PK and FK to each table. (4 marks)
ALTER TABLE DEPARTMENT
ADD CONSTRAINT DEPARTMENT_DepartmentID_PK PRIMARY KEY (DepartmentID);
ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMPLOYEE_EmployeeID_PK PRIMARY KEY (EmployeeID);
ALTER TABLE JOB_ASSIGNED
ADD CONSTRAINT JOB_A_EmpID_JobID_PK PRIMARY KEY (EmployeeID, JobID);
ALTER TABLE JOB
ADD CONSTRAINT JOB_JobID_PK PRIMARY KEY (JobID);

ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMPLOYEE_DepartmentID_FK FOREIGN KEY (DepartmentID)
REFERENCES DEPARTMENT(DepartmentID);
ALTER TABLE JOB_ASSIGNED
ADD CONSTRAINT JOB_A_EmployeeID_FK FOREIGN KEY (EmployeeID)
REFERENCES EMPLOYEE(EmployeeID);
ALTER TABLE JOB_ASSIGNED
ADD CONSTRAINT JOB_A_JobID_FK FOREIGN KEY (JobID)
REFERENCES JOB(JobID);

-- d) Add constraint NOT NULL to DepartmentName, and EmployeeName. (2 marks)
ALTER TABLE DEPARTMENT
MODIFY (DepartmentName VARCHAR2(100) CONSTRAINT DEPARTMENT_DepName_NN NOT NULL);
ALTER TABLE EMPLOYEE
MODIFY (EmployeeName VARCHAR2(100) CONSTRAINT EMPLOYEE_EmpName_NN NOT NULL);

-- e) Add column GENDER of datatype CHAR (1) to table Employee and 
-- constraint CHECK to accept the following value : M,F,m, or f. (4 marks)
ALTER TABLE EMPLOYEE
ADD (gender CHAR(1));
ALTER TABLE EMPLOYEE
MODIFY (gender CHAR(1) CONSTRAINT EMPLOYEE_gender_CC CHECK (gender IN ('M', 'F', 'm', 'f')));

-- f) Add to table EMPLOYEE a constraint CHECK to make sure the SALARY is a positive number. (2 marks)
ALTER TABLE EMPLOYEE
MODIFY (Salary NUMBER CONSTRAINT EMPLOYEE_salary_CC CHECK (Salary >=0));

-- g) Add constraint UNIQUE to column DepartmentName of table Department. (2 marks) 
ALTER TABLE DEPARTMENT
MODIFY (DepartmentName VARCHAR2(100) CONSTRAINT DEPARTMENT_DepName_UK UNIQUE);

SPOOL OFF

connect sys/sys as sysdba;

CREATE USER lilas_FINAL_q2 IDENTIFIED BY lilas;

-- Provide needed privileges
GRANT connect, resource TO lilas_FINAL_q2;

-- Connect to the user just created to:
CONNECT lilas_FINAL_q2/lilas;

SPOOL c:\bdd\lilas_FINAL_Q2.txt

-- Question 3

-- We would like the same result of question 2.
-- Create a user called your_name_FINAL_q2
-- Connect to the user just created to create all tables and constraints of question 2 AT THE SAME TIME. 

CREATE TABLE DEPARTMENT(DepartmentID NUMBER CONSTRAINT DEPARTMENT_DepartmentID_PK PRIMARY KEY, DepartmentName VARCHAR2(100) CONSTRAINT DEPARTMENT_DepName_NN NOT NULL CONSTRAINT DEPARTMENT_DepName_UK UNIQUE);

CREATE TABLE EMPLOYEE(EmployeeID NUMBER CONSTRAINT EMPLOYEE_EmployeeID_PK PRIMARY KEY, EmployeeName VARCHAR2(100) CONSTRAINT EMPLOYEE_EmpName_NN NOT NULL, BirthDate DATE, Salary NUMBER CONSTRAINT EMPLOYEE_salary_CC CHECK (Salary >=0), DepartmentID NUMBER, CONSTRAINT EMPLOYEE_DepartmentID_FK FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID), gender CHAR(1) CONSTRAINT EMPLOYEE_gender_CC CHECK (gender IN ('M', 'F', 'm', 'f')));

CREATE TABLE JOB(JobID NUMBER CONSTRAINT JOB_JobID_PK PRIMARY KEY, Job_Description VARCHAR2(100), Skill_Required VARCHAR2(100));

CREATE TABLE JOB_ASSIGNED(EmployeeID NUMBER, JobID NUMBER, Date_job_assigned DATE, CONSTRAINT JOB_A_EmpID_JobID_PK PRIMARY KEY (EmployeeID, JobID), CONSTRAINT JOB_A_EmployeeID_FK FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID), CONSTRAINT JOB_A_JobID_FK FOREIGN KEY (JobID) REFERENCES JOB(JobID));

SPOOL OFF

connect sys/sys as sysdba;
SPOOL c:\bdd\lilas_FINAL__Q4567.txt

Start c:\bdd\Clearwater.sql
-- Question 4

-- Use script 3clearwater(nora02), Working with table inventory, display item description,
-- sum of quantity on hand, minimum price, maximum price of each item having the sum of
-- quantity on hand less than 200 of all the inventories with size S or does not have any size at all. 

SELECT DISTINCT inventory.item_id, item_desc, SUM(inv_qoh), MIN(inv_price), MAX(inv_price) 
FROM inventory, item
WHERE inv_size IN ('S', NULL)
GROUP BY inventory.item_id, item_desc
HAVING SUM(inv_qoh) < 200;

Start c:\bdd\Software.sql
-- Question 5

-- Use script 3software(nora04), create a SQL command to list the first and last name of
-- every consultant who has ever worked on a project with consultant Paul Courtlandt. 

SELECT DISTINCT c_first, c_last
FROM consultant, project_consultant
WHERE consultant.c_id = project_consultant.c_id
AND NOT c_first = 'Paul'
AND NOT c_last = 'Courtlandt'
AND project_consultant.p_id IN ( 
(SELECT DISTINCT project_consultant.p_id
FROM consultant, project_consultant
WHERE project_consultant.c_id = consultant.c_id 
AND c_first = 'Paul'
AND c_last = 'Courtlandt'));

-- Question 6

-- Use script 3software (nora04), create a SQL command to display the first and last name
-- of all consultants who have worked on the same projects for client Supreme Data Corporation, display also the last -- name of the manager of those projects. 

SELECT DISTINCT c_first, c_last
FROM consultant, project, project_consultant, client
WHERE project_consultant.c_id = consultant.c_id 
AND project_consultant.p_id = project.p_id 
AND client_name = 'Morningstar Bank';

-- Managers
SELECT DISTINCT c_last
FROM consultant, project, project_consultant, client
WHERE project_consultant.c_id = consultant.c_id 
AND project_consultant.p_id = project.p_id 
AND project.client_id = client.client_id
AND client_name = 'Morningstar Bank';

Start c:\bdd\Clearwater.sql
-- Question 7

-- Use script 3clearwater(nora02), create a view named shipment_detail_view that contains
-- ITEM_DESC, INV_SIZE, COLOR, SL_QUANTITY, and SHIP_DATE_EXPECTED fields for all
-- shipments received during the months of August 2006. Make sure that the users can not modify
-- the data in such a way that the data from this view would be disappeared from the view. 


CREATE OR REPLACE VIEW shipment_detail_view AS
SELECT DISTINCT item_desc, inv_size, color, sl_quantity, ship_date_expected
FROM item, inventory, shipment_line, shipment
WHERE item.item_id = inventory.item_id
AND shipment_line.inv_id = inventory.inv_id
AND shipment.ship_id = shipment_line.ship_id
AND sl_date_received >= '2006-08-01'
AND sl_date_received < '2006-09-01'
WITH READ ONLY;



SPOOL OFF