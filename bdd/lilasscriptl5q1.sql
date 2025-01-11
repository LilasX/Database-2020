-- Project Part 5

-- Question 1

-- The following design is normalized to 3NF

-- COURSE(CourseID, CourseName, Credits)
-- TERM(TermID, Description)
-- LOCATION(LocID, Building, Room)
-- STUDENT(StudID, SName,Birthdate)
-- ENROLLMENT(StudID, CSectionID,GRADE)
-- COURSE_SECTION(CSectionID, MaxCapacity, CourseID,TermID, LocID)

-- 1. Using SQL*Plus
-- Open Run SQL Command Line

-- 2. Connect to user sys (sys/sys as sysdba)
CONNECT sys/sys as sysdba

-- 3. Create a user called your_name_L5Q1
CREATE USER lilas_L5Q1 IDENTIFIED BY lilas;

-- 4. Connect to the user just created to:
-- To connect you need to provide privileges
GRANT connect, resource TO lilas_L5Q1;
CONNECT lilas_L5Q1/lilas;

-- a) Create a SPOOL file called your_name_L5Q1.
SPOOL c:\bdd\lilas_L5Q1.txt

-- b) Create all the tables of the following final design using 
-- data type NUMBER for ID , VARCHAR2 for text , and DATE for dates.

CREATE TABLE course(courseid NUMBER, coursename VARCHAR2(100), credits NUMBER);
CREATE TABLE term(termid NUMBER, description VARCHAR2(100));
CREATE TABLE location(locid NUMBER, building NUMBER, room NUMBER);
CREATE TABLE student(studid NUMBER, sname VARCHAR2 (100) , birthdate DATE);
CREATE TABLE enrollment(studid NUMBER, csectionid NUMBER, grade NUMBER);
CREATE TABLE course_section(csectionid NUMBER, maxcapacity NUMBER, courseid NUMBER, termid NUMBER, locid NUMBER);

-- c) Create appropriate Primary Key for each table
ALTER TABLE course
ADD CONSTRAINT course_courseid_PK PRIMARY KEY (courseid);
ALTER TABLE term
ADD CONSTRAINT term_termid_PK PRIMARY KEY (termid);
ALTER TABLE location
ADD CONSTRAINT location_locid_PK PRIMARY KEY (locid);
ALTER TABLE student
ADD CONSTRAINT student_studid_PK PRIMARY KEY (studid);
ALTER TABLE enrollment
ADD CONSTRAINT enrollment_studid_scid_PK PRIMARY KEY (studid, csectionid);
ALTER TABLE course_section
ADD CONSTRAINT cs_csectionid_PK PRIMARY KEY (csectionid);

-- d) Using the E.R.D below to create appropriate Foreign Key for each table if needed.

-- COURSE -----< COURSE_SECTION -----< ENROLLMENT >----- STUDENT
-- TERM -----< COURSE_SECTION >----- LOCATION

ALTER TABLE course_section
ADD CONSTRAINT cs_courseid_FK FOREIGN KEY (courseid)
REFERENCES course(courseid);
ALTER TABLE course_section
ADD CONSTRAINT cs_termid_FK FOREIGN KEY (termid)
REFERENCES term(termid);
ALTER TABLE course_section
ADD CONSTRAINT cs_locid_FK FOREIGN KEY (locid)
REFERENCES location(locid);
ALTER TABLE enrollment
ADD CONSTRAINT enrollment_csid_FK FOREIGN KEY (csectionid)
REFERENCES course_section(csectionid);
ALTER TABLE enrollment
ADD CONSTRAINT enrollment_studid_FK FOREIGN KEY (studid)
REFERENCES student(studid);

-- e) Make sure that CourseName, SName, Building, MaxCapacity, 
-- and Description ALWAYS has a value in it.
ALTER TABLE course
MODIFY (coursename VARCHAR2(100) CONSTRAINT course_coursename_NN NOT NULL);
ALTER TABLE student
MODIFY (sname VARCHAR2(100) CONSTRAINT student_sname_NN NOT NULL);
ALTER TABLE location
MODIFY (building NUMBER CONSTRAINT location_building_NN NOT NULL);
ALTER TABLE course_section
MODIFY (maxcapacity NUMBER CONSTRAINT cs_maxcapacity_NN NOT NULL);
ALTER TABLE term
MODIFY (description VARCHAR2(100) CONSTRAINT term_description_NN NOT NULL);

-- f) Add column STATUS of datatype VARCHAR2(10) to table TERM and
-- constraint CHECK to accept only this two values: OPEN or CLOSED.
ALTER TABLE term
ADD (status VARCHAR2(10));
ALTER TABLE term
MODIFY (status VARCHAR2(10) CONSTRAINT term_status_CC CHECK (status IN ('OPEN', 'CLOSED')));

-- g) Add a UNIQUE constraint to column room of table LOCATION.
ALTER TABLE location
MODIFY (room NUMBER CONSTRAINT location_room_UK UNIQUE);


SPOOL OFF