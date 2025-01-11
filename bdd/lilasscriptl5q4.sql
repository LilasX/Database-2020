-- Project 5

-- Question 4

-- We would like to automatically generate all the values of the PK, FK . 
-- Could you do that?
-- If so, Please Re - do question 3 with the values of all the KEYS Auto- generated

CONNECT sys/sys as sysdba

CREATE USER lilas_L5Q4 IDENTIFIED BY lilas;

GRANT connect, resource TO lilas_L5Q4;
CONNECT lilas_L5Q4/lilas;

SPOOL c:\bdd\lilas_L5Q4.txt


CREATE TABLE course(courseid NUMBER CONSTRAINT course_courseid_PK PRIMARY KEY, coursename VARCHAR2(100) CONSTRAINT course_coursename_NN NOT NULL, credits NUMBER);

CREATE TABLE term(termid NUMBER CONSTRAINT term_termid_PK PRIMARY KEY, description VARCHAR2(100) CONSTRAINT term_description_NN NOT NULL, status VARCHAR2(10) CONSTRAINT term_status_CC CHECK (status IN ('OPEN', 'CLOSED')));

CREATE TABLE location(locid NUMBER CONSTRAINT location_locid_PK PRIMARY KEY, building NUMBER CONSTRAINT location_building_NN NOT NULL, room NUMBER CONSTRAINT location_room_UK UNIQUE);

CREATE TABLE student(studid NUMBER CONSTRAINT student_studid_PK PRIMARY KEY, sname VARCHAR2 (100) CONSTRAINT student_sname_NN NOT NULL, birthdate DATE);

CREATE TABLE course_section(csectionid NUMBER CONSTRAINT cs_csectionid_PK PRIMARY KEY, maxcapacity NUMBER CONSTRAINT cs_maxcapacity_NN NOT NULL, courseid NUMBER, termid NUMBER, locid NUMBER, CONSTRAINT cs_courseid_FK FOREIGN KEY (courseid) REFERENCES course(courseid), CONSTRAINT cs_termid_FK FOREIGN KEY (termid) REFERENCES term(termid), CONSTRAINT cs_locid_FK FOREIGN KEY (locid) REFERENCES location(locid));

CREATE TABLE enrollment(studid NUMBER, csectionid NUMBER, grade NUMBER, CONSTRAINT enrollment_studid_scid_PK PRIMARY KEY (studid, csectionid), CONSTRAINT enrollment_csid_FK FOREIGN KEY (csectionid) REFERENCES course_section(csectionid), CONSTRAINT enrollment_studid_FK FOREIGN KEY (studid) REFERENCES student(studid));

CREATE SEQUENCE cpk_seq;

INSERT INTO course
VALUES (cpk_seq.NEXTVAL, 'Database', 3);

CREATE SEQUENCE tpk_seq;
CREATE SEQUENCE lpk_seq;
CREATE SEQUENCE cspk_seq START WITH 14;

INSERT INTO term (termid, description, status)
VALUES (tpk_seq.NEXTVAL, 'First_semester', 'OPEN');
INSERT INTO location (locid, building, room)
VALUES (lpk_seq.NEXTVAL, 2020, 1);

INSERT INTO course_section (csectionid, maxcapacity, courseid, termid, locid)
VALUES (cspk_seq.NEXTVAL, 10, cpk_seq.CURRVAL, tpk_seq.CURRVAL, lpk_seq.CURRVAL);
INSERT INTO course_section (csectionid, maxcapacity, courseid, termid, locid)
VALUES (cspk_seq.NEXTVAL, 10, cpk_seq.CURRVAL, tpk_seq.CURRVAL, lpk_seq.CURRVAL);

CREATE SEQUENCE spk_seq;
DROP SEQUENCE cspk_seq;
CREATE SEQUENCE cspk_seq START WITH 14;

INSERT INTO student (studid, sname, birthdate)
VALUES (spk_seq.NEXTVAL, 'Lilas','1999-12-31');
INSERT INTO enrollment (studid, csectionid, grade)
VALUES (spk_seq.CURRVAL, cspk_seq.NEXTVAL, null);
INSERT INTO enrollment (studid, csectionid, grade)
VALUES (spk_seq.CURRVAL, cspk_seq.NEXTVAL, null);

UPDATE course_section
SET maxcapacity = 25
WHERE csectionid = 15;

SPOOL OFF