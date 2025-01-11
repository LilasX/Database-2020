-- To connect to dba account
CONNECT sys/sys as sysdba

-- To create a SPOOL file
SPOOL c:\bdd\s17.txt

-- To display the current connection
SHOW user

-- To display current time
SELECT TO_CHAR(sysdate, 'DD MM YYYY Day Month Year HH:MI:SS Am') FROM dual;

-- To remove a user
DROP USER sept17_user CASCADE;

-- To create a new user called sept17_user with password 1234
CREATE USER sept17_user IDENTIFIED BY 1234;

-- To provide privileges to the user created
GRANT connect, resource TO sept17_user;

-- To display the name of all users
SELECT username FROM dba_users;

-- To change a user's password
ALTER USER sept17_user IDENTIFIED BY 123;

-- To unlock a user's account (you need to be an user with privileges dba)
CONNECT sys/sys as sysdba
ALTER USER sept17_user ACCOUNT UNLOCK;

-- To connect to a normal user
CONNECT sept17_user/123;

-- To show current user
SHOW user

-- To create table VIDEO using appropriate datatype and the logical model below
-- VIDEO (vid, title, rating)
CREATE TABLE video (vid NUMBER, title VARCHAR2(80), rating VARCHAR2(50));

-- To display the name of all tables belonging to the current user
SELECT table_name FROM user_tables;

-- To display the structure (definition) of a table 
-- DESCRIBE or DESC
DESCRIBE Video


-- To save SPOOL file
SPOOL OFF