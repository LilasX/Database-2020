-- Question 3

-- Can we create tables, primary key, foreign key AT THE SAME time?
-- If yes, please create a script file called part4a.sql containing all the command needed
-- to obtain the same result as question 1 and 2.

CONNECT sys/sys as sysdba

CREATE USER lilas_L4Q3 IDENTIFIED BY lilas;

GRANT connect, resource TO lilas_L4Q3;
CONNECT lilas_L4Q3/lilas;

SPOOL c:\bdd\lilas_part4a.txt

CREATE TABLE region (regid NUMBER CONSTRAINT region_regid_PK PRIMARY KEY, regionname VARCHAR2(100));

CREATE TABLE location (location_id NUMBER CONSTRAINT location_location_id_PK PRIMARY KEY, building_name VARCHAR2(100), regid NUMBER, CONSTRAINT location_regid_FK FOREIGN KEY (regid)
REFERENCES region(regid));

CREATE TABLE department (deptid NUMBER CONSTRAINT department_deptid_PK PRIMARY KEY, deptname VARCHAR2(100), location_id NUMBER, CONSTRAINT department_location_id_FK FOREIGN KEY (location_id) REFERENCES location(location_id));

CREATE TABLE employees (empid NUMBER CONSTRAINT employees_empid_PK PRIMARY KEY, ename VARCHAR2(100), hiredate DATE, deptid NUMBER, CONSTRAINT employees_deptid_FK FOREIGN KEY (deptid) REFERENCES department(deptid));

CREATE TABLE job (jobid NUMBER CONSTRAINT job_jobid_PK PRIMARY KEY, description VARCHAR2(100), skill_required VARCHAR2(100));

CREATE TABLE emp_job (empid NUMBER, jobid NUMBER, date_job_assigned DATE, CONSTRAINT emp_job_empid_jobid_PK PRIMARY KEY (empid, jobid), CONSTRAINT emp_job_empid_FK FOREIGN KEY (empid) REFERENCES employees(empid), CONSTRAINT emp_job_jobid_FK FOREIGN KEY (jobid) REFERENCES job(jobid));


SELECT table_name FROM user_tables;

DESC region
DESC location
DESC department 
DESC employees 
DESC job 
DESC emp_job

SELECT constraint_name, constraint_type, table_name FROM user_constraints;



SPOOL OFF