-- Quiz 10/08/2020

-- The following design is normalized to 3NF

-- CONSULTANT(CID, Cname)
-- CONSULTANT_SKILL(CID, SKILLID, certification)
-- SKILL(SKILLID, description)


-- note: attribute in upper case is primary key


-- 1. Using SQL*Plus
-- Open Run SQL Command Line

-- 2. Connect to user sys (sys/sys as sysdba)
CONNECT sys/sys as sysdba


-- 3. Create a user called your_name_quiz
CREATE USER lilas_quiz IDENTIFIED BY lilas;

-- 4. Connect to the user just created to:
-- To connect you need to provide privileges
GRANT connect, resource TO lilas_quiz;
CONNECT lilas_quiz/lilas;

-- i) Create a SPOOL file called your_name_quiz.
SPOOL c:\bdd\lilas_quiz.txt

-- j) Create all the tables of the design ABOVE using 
-- data type NUMBER for ID , varchar2 for text.

CREATE TABLE consultant (cid NUMBER, cname VARCHAR2(100));
CREATE TABLE consultant_skill (cid NUMBER, skillid NUMBER, certification VARCHAR2(5));
CREATE TABLE skill (skillid NUMBER, description VARCHAR2(100));

-- k) Create appropriate Primary Key for each table
ALTER TABLE consultant
ADD CONSTRAINT consultant_cid_PK PRIMARY KEY (cid);
ALTER TABLE consultant_skill
ADD CONSTRAINT cskill_cid_skillid_PK PRIMARY KEY (cid,skillid);
ALTER TABLE skill
ADD CONSTRAINT skill_skillid_PK PRIMARY KEY (skillid);

--l) Using the E.R.D below to create appropriate Foreign Key 
-- for each table if needed.


-- CONSULTANT  ---< CONSULTANT_SKILL >--- SKILL

ALTER TABLE consultant_skill
ADD CONSTRAINT consultant_skill_cid_FK FOREIGN KEY (cid)
REFERENCES consultant(cid);
ALTER TABLE consultant_skill
ADD CONSTRAINT consultant_skill_skillid_FK FOREIGN KEY (skillid)
REFERENCES skill(skillid);


-- m)Make sure that columns cname, Description MUST ALWAYS has a value in it.
ALTER TABLE consultant
MODIFY (cname VARCHAR2(100) CONSTRAINT consultant_cname_NN NOT NULL);
ALTER TABLE skill
MODIFY (description VARCHAR2(100) CONSTRAINT skill_description_NN NOT NULL);

-- n) Make sure that only 'Y' or 'N' can be inserted in column certification
ALTER TABLE consultant_skill
MODIFY (certification VARCHAR(5) CONSTRAINT cskill_certification_CC CHECK (certification = 'Y' || 'N'));

SPOOL OFF