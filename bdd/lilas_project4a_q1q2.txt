-- Project Part 4a

-- Question 1

--The following design is normalized to 3NF

-- LOCATION(Location-ID, Building-Name)
-- DEPARTMENT(DeptID, DeptName, Location-ID)
-- EMPLOYEE(EmpID, Ename,Salary,DeptID)
-- JOB(JobID, Description)
-- EMP_JOB(EmpID, JobID, Date_job_assigned)

-- 1. Using SQL*Plus
-- Open Run SQL Command Line

-- 2. Connect to user sys (sys/sys as sysdba)
CONNECT sys/sys as sysdba

-- 3. Create a user called your_name_L4Q1
CREATE USER lilas_L4Q1 IDENTIFIED BY lilas;

-- 4. Connect to the user just created to:
-- To connect you need to provide privileges
GRANT connect, resource TO lilas_L4Q1;
CONNECT lilas_L4Q1/lilas;

-- a) Create a SPOOL file called your_name_L4Q1
SPOOL c:\bdd\lilas_L4Q1.txt

-- b) Create all the tables of the following final design using 
-- data type NUMBER for ID , varchar2 for text , and DATE for dates

CREATE TABLE location (location_id NUMBER, building_name VARCHAR2(100));
CREATE TABLE department (deptid NUMBER, deptname VARCHAR2(100), location_id NUMBER);
CREATE TABLE employees (empid NUMBER, ename VARCHAR2(100), salary NUMBER, deptid NUMBER);
CREATE TABLE job (jobid NUMBER, description VARCHAR2(100));
CREATE TABLE emp_job (empid NUMBER, jobid NUMBER, date_job_assigned DATE);

-- c) Create appropriate Primary Key for each table (you have to add the keys AFTER table is created )
ALTER TABLE location
ADD CONSTRAINT location_location_id_PK PRIMARY KEY (location_id);
ALTER TABLE department
ADD CONSTRAINT department_deptid_PK PRIMARY KEY (deptid);
ALTER TABLE employees
ADD CONSTRAINT employees_empid_PK PRIMARY KEY (empid);
ALTER TABLE job
ADD CONSTRAINT job_jobid_PK PRIMARY KEY (jobid);
ALTER TABLE emp_job
ADD CONSTRAINT emp_job_empid_jobid_PK PRIMARY KEY (empid, jobid);

-- d) Using the E.R.D below to create appropriate Foreign Key for each table if needed. 
-- (you have to add the keys AFTER tables are created )

-- LOCATION -----< DEPARTMENT -----< EMPLOYEES -----< EMP_JOB >----- JOB

ALTER TABLE department
ADD CONSTRAINT department_location_id_FK FOREIGN KEY (location_id)
REFERENCES location(location_id);
ALTER TABLE employees
ADD CONSTRAINT employees_deptid_FK FOREIGN KEY (deptid)
REFERENCES department(deptid);
ALTER TABLE emp_job
ADD CONSTRAINT emp_job_empid_FK FOREIGN KEY (empid)
REFERENCES employees(empid);
ALTER TABLE emp_job
ADD CONSTRAINT emp_job_jobid_FK FOREIGN KEY (jobid)
REFERENCES job(jobid);

-- e) Display the name and structure of all the tables belonged to user your_name_L4Q1.

-- Display the name of all tables
SELECT table_name FROM user_tables;

-- Display the structure of all tables
DESC location
DESC department 
DESC employees 
DESC job 
DESC emp_job

-- f) Display the name and type of all constraints of user your_name_L4Q1.
SELECT constraint_name, constraint_type, table_name FROM user_constraints;

-- Question 2

-- For the design of question 1, make the following modification:

-- 1. Add table REGION with column RegID, RegionName (please use appropriate datatype)
-- REGION(RegID, RegionName)
CREATE TABLE region (regid NUMBER, regionname VARCHAR2(100));

-- 2. Add column hiredate to table employee
ALTER TABLE employees
ADD (hiredate DATE);

-- 3. Add column skill_required to table job
ALTER TABLE job
ADD (skill_required VARCHAR2(100));

-- 4. Remove column salary from table employee.
ALTER TABLE employees
DROP COLUMN salary;

-- 5. Add Foreign key RegID to table LOCATION (please add needed column, constraint, …)
-- LOCATION(Location-ID, Building-Name, RegID)
-- REGION(RegID, RegionName)
ALTER TABLE region
ADD CONSTRAINT region_regid_PK PRIMARY KEY (regid);
ALTER TABLE location
ADD (regid NUMBER);
ALTER TABLE location
ADD CONSTRAINT location_regid_FK FOREIGN KEY (regid)
REFERENCES region(regid);

-- Verification
SELECT table_name FROM user_tables;

DESC location
DESC department 
DESC employees 
DESC job 
DESC emp_job
DESC region

SELECT constraint_name, constraint_type, table_name FROM user_constraints;


-- Save SPOOL file
SPOOL OFF