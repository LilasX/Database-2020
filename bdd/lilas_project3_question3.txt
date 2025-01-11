-- Project Part 3

-- Question 3

-- 5. Using SQL*Plus
-- Open Run SQL Command Line

-- 6. Connect to user sys (sys/sys as sysdba)
CONNECT sys/sys as sysdba

-- 7. Create a user called your_name_L3Q3
CREATE USER lilas_L3Q3 IDENTIFIED BY lilas;

-- 8. Connect to the user just created to:
--To connect you need to provide privileges
GRANT connect, resource TO lilas_L3Q3;
CONNECT lilas_L3Q3/lilas;

-- a) Create a SPOOL file called your_name_L3Q3
SPOOL c:\bdd\lilas_L3Q3.txt

-- b) Create all the tables of the final design of QUESTION 2 using 
-- data type NUMBER for ID , varchar2 for text , and DATE for dates.

-- CourseSection3 (Section-ID, CourseNo, FID)
-- Course3 (CourseNo, CourseName)
-- FACULTY(FID, FName, Salary)
-- Student2 (Student-ID, StudentName)
-- Grade2 (Section-ID, Student-ID, GRADE)

CREATE TABLE coursesection3 (section_id NUMBER, courseno NUMBER, fid NUMBER);
CREATE TABLE course3 (courseno NUMBER, coursename VARCHAR2(100));
CREATE TABLE faculty (fid NUMBER, fname VARCHAR2(100), salary NUMBER);
CREATE TABLE student2 (student_id NUMBER, studentname VARCHAR2(100));
CREATE TABLE grade2 (section_id NUMBER, student_id NUMBER, GRADE VARCHAR2(3));
-- GRADE could also be in NUMBER type

-- c) Display the name and structure of all the tables belonged to user your_name_L3Q3.

-- Display the name of all tables
SELECT table_name FROM user_tables;

-- Display the structure of all tables
DESC coursesection3
DESC course3
DESC faculty
DESC student2
DESC grade2

-- Save SPOOL file
SPOOL OFF

