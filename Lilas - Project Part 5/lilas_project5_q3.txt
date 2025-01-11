-- Project Part 5

-- Question 3


CONNECT sys/sys as sysdba

CREATE USER lilas_L5Q3 IDENTIFIED BY lilas;

GRANT connect, resource TO lilas_L5Q3;
CONNECT lilas_L5Q3/lilas;

SPOOL c:\bdd\lilas_L5Q3.txt


CREATE TABLE course(courseid NUMBER CONSTRAINT course_courseid_PK PRIMARY KEY, coursename VARCHAR2(100) CONSTRAINT course_coursename_NN NOT NULL, credits NUMBER);

CREATE TABLE term(termid NUMBER CONSTRAINT term_termid_PK PRIMARY KEY, description VARCHAR2(100) CONSTRAINT term_description_NN NOT NULL, status VARCHAR2(10) CONSTRAINT term_status_CC CHECK (status IN ('OPEN', 'CLOSED')));

CREATE TABLE location(locid NUMBER CONSTRAINT location_locid_PK PRIMARY KEY, building NUMBER CONSTRAINT location_building_NN NOT NULL, room NUMBER CONSTRAINT location_room_UK UNIQUE);

CREATE TABLE student(studid NUMBER CONSTRAINT student_studid_PK PRIMARY KEY, sname VARCHAR2 (100) CONSTRAINT student_sname_NN NOT NULL, birthdate DATE);

CREATE TABLE course_section(csectionid NUMBER CONSTRAINT cs_csectionid_PK PRIMARY KEY, maxcapacity NUMBER CONSTRAINT cs_maxcapacity_NN NOT NULL, courseid NUMBER, termid NUMBER, locid NUMBER, CONSTRAINT cs_courseid_FK FOREIGN KEY (courseid) REFERENCES course(courseid), CONSTRAINT cs_termid_FK FOREIGN KEY (termid) REFERENCES term(termid), CONSTRAINT cs_locid_FK FOREIGN KEY (locid) REFERENCES location(locid));

CREATE TABLE enrollment(studid NUMBER, csectionid NUMBER, grade NUMBER, CONSTRAINT enrollment_studid_scid_PK PRIMARY KEY (studid, csectionid), CONSTRAINT enrollment_csid_FK FOREIGN KEY (csectionid) REFERENCES course_section(csectionid), CONSTRAINT enrollment_studid_FK FOREIGN KEY (studid) REFERENCES student(studid));

-- We need the following data to be inserted in the database :
-- a. A new course using the following values:
-- Course Name : Database
-- Credits: 3
-- Id: 1

INSERT INTO course
VALUES (1, 'Database', 3);

-- b. Two new course_section using the following values:
-- course_id : 1
-- c_section_id : 14, 15
-- term_id : 1
-- LOC_ID : 1
-- Maximum capacity: 10

-- In part b , if you can not insert data , explain why and give a solution.

-- FKs (locid and termid) violation, we just need to insert corresponding values (PKs, NOT NULL values, etc.) 
-- in TERM table and LOCATION table

INSERT INTO term (termid, description, status)
VALUES (1, 'First_semester', 'OPEN');
INSERT INTO location (locid, building, room)
VALUES (1, 2020, 1);

INSERT INTO course_section (csectionid, maxcapacity, courseid, termid, locid)
VALUES (14, 10, 1, 1, 1);
INSERT INTO course_section (csectionid, maxcapacity, courseid, termid, locid)
VALUES (15, 10, 1, 1, 1);

-- c. You are student number 1. You will be enrolled in both courses sections just inserted in 
-- part b, and have not yet received a note (GRADE = NULL) . 
-- Write the SQL statement for this event.

INSERT INTO student (studid, sname, birthdate)
VALUES (1, 'Lilas','1999-12-31');
INSERT INTO enrollment (studid, csectionid, grade)
VALUES (1, 14, null);
INSERT INTO enrollment (studid, csectionid, grade)
VALUES (1, 15, null);

-- d. Change the maximum capacity of section 15 to 25.

UPDATE course_section
SET maxcapacity = 25
WHERE csectionid = 15;

SPOOL OFF