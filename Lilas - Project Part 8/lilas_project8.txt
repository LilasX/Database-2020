-- Project Part 8

connect sys/sys as sysdba;

Start c:\bdd\Northwoods.sql

SPOOL c:\bdd\lilas_L8.txt

-- Question 1

-- Use database 3northwoods, Retrieve the C_SEC_ID, SEC_NUM, C_SEC_DAY, and C_SEC_TIME 
-- for all course_sections that meet on Monday.
-- Format the time so the time values appear as times and not as dates.

SELECT c_sec_id, sec_num, c_sec_day, TO_CHAR(c_sec_time, 'HH:MI')
FROM course_section
WHERE c_sec_day = 'MWF';



-- Question 2

-- Retrieve the S_FIRST, S_LAST of all students who does not have a Middlename. 
-- Modify the query to display "N/A" in the middle name if the middle name is not presented.

SELECT s_first, s_last, NVL(s_mi, 'N/A')
FROM student
WHERE s_mi is NULL;

-- Question 3

-- Use database 3northwoods, Retrieve the C_SEC_ID, SEC_NUM, C_SEC_DAY,and C_SEC_TIME 
-- for all course_sections table. 
-- Convert the C_SEC_TIME field so that the time values appears as times, 
-- and use the LTRIM function to remove the leading zeros from the times value.
-- For example, value such as "08:00 AM" should appear as "8:00 AM".

SELECT c_sec_id, sec_num, c_sec_day, LTRIM(TO_CHAR(c_sec_time, 'HH:MI'),0)
FROM course_section;

-- Question 4

-- Modify the time_enrolled by adding 1 year to the existing time_enrolled, 
-- and increase the duration of all course sections by 30 Minutes.

SELECT time_enrolled + TO_YMINTERVAL('1-0'), 
c_sec_duration + TO_DSINTERVAL ('0 00:30:00') 
FROM student, course_section;

-- Question 5

-- Retrive all of the fields from the ENROLLMENT table in which 
-- the grade either has not yet been assigned or different than 'C'.

SELECT *
FROM enrollment
WHERE grade is NULL
OR NOT grade = 'C';

SPOOL OFF