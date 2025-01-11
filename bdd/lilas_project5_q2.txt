-- Project Part 5

-- Question 2

-- Can you create all the tables, primary keys, foreign keys ... 
-- of question 1 ALL at the same time? If yes, create a user with your_name_L5Q2 to do so.

CONNECT sys/sys as sysdba

CREATE USER lilas_L5Q2 IDENTIFIED BY lilas;

GRANT connect, resource TO lilas_L5Q2;
CONNECT lilas_L5Q2/lilas;

SPOOL c:\bdd\lilas_L5Q2.txt

CREATE TABLE course(courseid NUMBER CONSTRAINT course_courseid_PK PRIMARY KEY, coursename VARCHAR2(100) CONSTRAINT course_coursename_NN NOT NULL, credits NUMBER);

CREATE TABLE term(termid NUMBER CONSTRAINT term_termid_PK PRIMARY KEY, description VARCHAR2(100) CONSTRAINT term_description_NN NOT NULL, status VARCHAR2(10) CONSTRAINT term_status_CC CHECK (status IN ('OPEN', 'CLOSED')));

CREATE TABLE location(locid NUMBER CONSTRAINT location_locid_PK PRIMARY KEY, building NUMBER CONSTRAINT location_building_NN NOT NULL, room NUMBER CONSTRAINT location_room_UK UNIQUE);

CREATE TABLE student(studid NUMBER CONSTRAINT student_studid_PK PRIMARY KEY, sname VARCHAR2 (100) CONSTRAINT student_sname_NN NOT NULL, birthdate DATE);

CREATE TABLE course_section(csectionid NUMBER CONSTRAINT cs_csectionid_PK PRIMARY KEY, maxcapacity NUMBER CONSTRAINT cs_maxcapacity_NN NOT NULL, courseid NUMBER, termid NUMBER, locid NUMBER, CONSTRAINT cs_courseid_FK FOREIGN KEY (courseid) REFERENCES course(courseid), CONSTRAINT cs_termid_FK FOREIGN KEY (termid) REFERENCES term(termid), CONSTRAINT cs_locid_FK FOREIGN KEY (locid) REFERENCES location(locid));

CREATE TABLE enrollment(studid NUMBER, csectionid NUMBER, grade NUMBER, CONSTRAINT enrollment_studid_scid_PK PRIMARY KEY (studid, csectionid), CONSTRAINT enrollment_csid_FK FOREIGN KEY (csectionid) REFERENCES course_section(csectionid), CONSTRAINT enrollment_studid_FK FOREIGN KEY (studid) REFERENCES student(studid));


SPOOL OFF