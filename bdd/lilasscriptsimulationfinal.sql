-- Simulation Final Part 2

-- Question 2
-- The design below is already normalized to 3NF 

-- SUPPLIER -----< VIDEO -----< RENTAL >----- MEMBER

-- SUPPLIER(SupplierID, SupplierName)
-- VIDEO(VideoID, Title, Rating, SupplierID)
-- RENTAL(VideoID, MemberID, DateRented)
-- MEMBER(MemberID, MemberName, Address, Age) 

-- Write the SQL command to:
-- Create a user called your_name_FINAL
CREATE USER lilas_FINAL IDENTIFIED BY lilas;

-- Provide needed privileges
GRANT connect, resource TO lilas_FINAL;

-- Connect to the user just created to:
CONNECT lilas_FINAL/lilas;

-- a) Create a SPOOL file called you_name_FINAL
SPOOL c:\bdd\lilas_FINAL.txt

-- b) Create all the tables using NUMBER for Id, VARCHAR2 for name, and DATE for date. (8 marks)

CREATE TABLE SUPPLIER(SupplierID NUMBER, SupplierName VARCHAR2(100));
CREATE TABLE VIDEO(VideoID NUMBER, Title VARCHAR2(100), Rating NUMBER, SupplierID NUMBER);
CREATE TABLE RENTAL(VideoID NUMBER, MemberID NUMBER, DateRented DATE);
CREATE TABLE MEMBER(MemberID NUMBER, MemberName VARCHAR2(100), Address VARCHAR2(100), Age NUMBER);

-- c) Add all the PK and FK to each table. (5 marks)
ALTER TABLE SUPPLIER
ADD CONSTRAINT SUPPLIER_supplierid_PK PRIMARY KEY (SupplierID);
ALTER TABLE VIDEO
ADD CONSTRAINT VIDEO_videoid_PK PRIMARY KEY (VideoID);
ALTER TABLE RENTAL
ADD CONSTRAINT RENTAL_vid_mid_PK PRIMARY KEY (VideoID, MemberID);
ALTER TABLE MEMBER
ADD CONSTRAINT MEMBER_memberid_PK PRIMARY KEY (MemberID);

ALTER TABLE VIDEO
ADD CONSTRAINT VIDEO_supplierid_FK FOREIGN KEY (SupplierID)
REFERENCES SUPPLIER(SupplierID);
ALTER TABLE RENTAL
ADD CONSTRAINT RENTAL_vid_FK FOREIGN KEY (VideoID)
REFERENCES VIDEO(VideoID);
ALTER TABLE RENTAL
ADD CONSTRAINT RENTAL_mid_FK FOREIGN KEY (MemberID)
REFERENCES MEMBER(MemberID);

-- d) Add constraint NOT NULL to SupplierName, and MemberName. (3 marks)
ALTER TABLE SUPPLIER
MODIFY (SupplierName VARCHAR2(100) CONSTRAINT SUPPLIER_sname_NN NOT NULL);
ALTER TABLE MEMBER
MODIFY (MemberName VARCHAR2(100) CONSTRAINT MEMBER_mname_NN NOT NULL);

-- e) Add column GENDER of datatype CHAR (1) to table Member and constraint
-- CHECK to accept the following value : M,F,m, or f. (3 marks)
ALTER TABLE MEMBER
ADD (gender CHAR(1));
ALTER TABLE MEMBER
MODIFY (gender CHAR(1) CONSTRAINT MEMBER_gender_CC CHECK (gender IN ('M', 'F', 'm', 'f')));

-- f) Add to table MEMBER a constraint CHECK to make sure the Age is a positive number. (3 marks)
ALTER TABLE MEMBER
MODIFY (Age NUMBER CONSTRAINT MEMBER_Age_CC CHECK (Age >=0));

-- g) Add constraint UNIQUE to column SupplierName of table Supplier. (3 marks)
ALTER TABLE SUPPLIER
MODIFY (SupplierName VARCHAR2(100) CONSTRAINT SUPPLIER_sname_UK UNIQUE);

SPOOL OFF

connect sys/sys as sysdba;

SPOOL c:\bdd\lilas_FINAL_Q3.txt

-- Question 3
-- We would like the same result of question 2. 

-- Create a user called your_name_FINAL_Q3
CREATE USER lilas_FINAL_Q3 IDENTIFIED BY lilas;

-- Provide needed privileges
GRANT connect, resource TO lilas_FINAL_Q3;

-- Connect to the user just created to CREATE TABLEs and CONSTRAINTS of the question 2 at the SAME TIME!!!!! 
CONNECT lilas_FINAL_Q3/lilas;

CREATE TABLE SUPPLIER(SupplierID NUMBER CONSTRAINT SUPPLIER_supplierid_PK PRIMARY KEY, SupplierName VARCHAR2(100) CONSTRAINT SUPPLIER_sname_NN NOT NULL CONSTRAINT SUPPLIER_sname_UK UNIQUE);

CREATE TABLE MEMBER(MemberID NUMBER CONSTRAINT MEMBER_memberid_PK PRIMARY KEY, MemberName VARCHAR2(100) CONSTRAINT MEMBER_mname_NN NOT NULL, Address VARCHAR2(100), Age NUMBER CONSTRAINT MEMBER_Age_CC CHECK (Age >=0), gender CHAR(1) CONSTRAINT MEMBER_gender_CC CHECK (gender IN ('M', 'F', 'm', 'f')));

CREATE TABLE VIDEO(VideoID NUMBER CONSTRAINT VIDEO_videoid_PK PRIMARY KEY, Title VARCHAR2(100), Rating NUMBER, SupplierID NUMBER, CONSTRAINT VIDEO_supplierid_FK FOREIGN KEY (SupplierID)
REFERENCES SUPPLIER(SupplierID));

CREATE TABLE RENTAL(VideoID NUMBER, MemberID NUMBER, DateRented DATE, CONSTRAINT RENTAL_vid_mid_PK PRIMARY KEY (VideoID, MemberID), CONSTRAINT RENTAL_vid_FK FOREIGN KEY (VideoID) REFERENCES VIDEO(VideoID), CONSTRAINT RENTAL_mid_FK FOREIGN KEY (MemberID) REFERENCES MEMBER(MemberID));

SPOOL OFF

-- Question 4

connect sys/sys as sysdba;

SPOOL c:\bdd\lilas_FINAL_Q4567.txt

Start c:\bdd\Northwoods.sql

-- Use script 7northwoods, create a SQL command to list the last name and first
-- name of every student who has ever advised by the same advisor as Mobley Amanda. 

SELECT s_last, s_first
FROM   student
WHERE  f_id = 
(SELECT DISTINCT f_id
FROM student
WHERE s_last = 'Mobley'
AND s_first = 'Amanda');

-- Question 5
-- Use script 7northwoods, create a SQL command to list the last name and first
-- name of all faculty member who teach in building ‘BUS’ , but their office is not in the same building (??). 

SELECT f_last, f_first
FROM faculty, location
WHERE location.loc_id = faculty.loc_id
AND bldg_code = 'BUS';

-- Question 6
-- Use script 7northwoods, create a SQL command to display the first and last
-- name of all students who take the same course section located in the location which
-- have the same capacity as location CR 103. 

SELECT DISTINCT s_last, s_first
FROM COURSE_SECTION, LOCATION, student
WHERE student.f_id = COURSE_SECTION.f_id
AND LOCATION.loc_id = COURSE_SECTION.loc_id
AND capacity =
(SELECT DISTINCT capacity 
FROM location
WHERE bldg_code = 'CR'
AND room = '103');

-- Question 7
-- Use script 7northwoods, create a view named student_detail_view that
-- contains student last and first name, course name, building, room and grade of all
-- students of the term Summer 2006. Make sure that the users can not modify the
-- data in such a way that the data from this view would be disappeared from the view. 

CREATE OR REPLACE VIEW student_detail_view AS
SELECT s_last, s_first, course_name, bldg_code, room, grade
FROM student, course, location, ENROLLMENT, term, COURSE_SECTION
WHERE COURSE_SECTION.c_sec_id = ENROLLMENT.c_sec_id
AND student.s_id = ENROLLMENT.s_id
AND COURSE_SECTION.loc_id = location.loc_id
AND term.term_id = COURSE_SECTION.term_id
AND course.course_id = COURSE_SECTION.course_id
AND term_desc = 'Summer 2006'
WITH READ ONLY;


SPOOL OFF