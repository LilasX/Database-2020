SPOOL c:\bdd\practicetable.txt

-- 1. Connect to user sys
connect sys/sys as sysdba;

-- 2. Create user practice_s14
CREATE USER practice_s14 IDENTIFIED BY 123;

-- To remove user to remove errors to rerun script without errors (CASCADE to remove everything with the user)
DROP USER practice_s14 CASCADE;
CREATE USER practice_s14 IDENTIFIED BY 123;

-- 3. Grant needed privileges
GRANT connect, resource TO practice_s14;

-- 4. Connect to new user
CONNECT practice_s14/123;

-- 5. Create table of the following designs using appropriate datatype

--VIDEO(vid, title, rating)
CREATE TABLE video(vid NUMBER, title VARCHAR2(100), rating VARCHAR2(50));

--RENTAL (vid, mid, date_rented, date_returned)
CREATE TABLE rental(vid NUMBER, mid NUMBER, date_rented DATE, date_returned DATE);

-- 6. To display all tables belonged to the current user
SELECT table_name FROM user_tables;

-- 7. Display the definition of all tables 
DESC video
DESCRIBE rental

-- See the details on when the script was executed
SELECT TO_CHAR (sysdate, 'DD MM YYYY Day Month Year HH:MI:SS') FROM dual;

SPOOL OFF