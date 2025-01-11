-- Project Part 6

-- Question 1 :
-- Use Reverse Engineering to create the E.R.D of the
-- Software Expert database (script 7 software)

-- CLIENT -----< PROJECT >----- CONSULTANT -----< CONSULTANT_SKILL >----- SKILL 
-- SKILL -----< PROJECT_SKILL >----- PROJECT -----< PROJECT_CONSULTANT >----- CONSULTANT
-- PROJECT -----< EVALUATION >----- CONSULTANT

SPOOL c:\bdd\lilas_L6.txt

-- Question 2:
-- Using database SOFTWARE EXPERT
-- 1. Create a user called your_name_L6 with all needed privileges
CREATE USER lilas_L6 IDENTIFIED BY lilas;
GRANT connect, resource TO lilas_L6;

-- 2. Connect to the new user and run script 7software
CONNECT lilas_L6/lilas;
Start c:\bdd\Software.sql

-- 3. Write SQL command to:
-- a) Find all the skill of consultant number 100
 SELECT * FROM consultant_skill WHERE c_id = 100; 

-- b) Find all the certified skill of consultant number 102
SELECT * FROM consultant_skill WHERE c_id = 102 AND certification = 'Y';

-- c) All the projects that consultant number 1 is currently working on.
SELECT * FROM project_consultant WHERE c_id = 1;

-- d) The skill description and the name of all consultants who are certified in that skill
SELECT skill_description, c_first, c_last, certification  FROM skill, consultant, consultant_skill 
WHERE skill.skill_id = consultant_skill.skill_id
AND consultant.c_id = consultant_skill.c_id
AND certification = 'Y';

-- e) The name of each project that consultant Mark Myers has ever worked.
SELECT project_name, c_first, c_last FROM project, project_consultant, consultant
WHERE project.p_id = project_consultant.p_id
AND project_consultant.c_id = consultant.c_id
AND c_first = 'Mark'
AND c_last = 'Myers';

-- f) The name of the project and the name of the consultant who was the manager of the project
SELECT project_name, c_first, c_last, mgr_id FROM consultant, project, project_consultant
WHERE consultant.c_id = project.mgr_id
AND project.p_id = project_consultant.p_id;

-- g) The name of the project and the name of the parentproject.
SELECT project_name FROM project;

-- h) The name of the project and the name of the parent project 
-- including the project that does not have a parent project.
SELECT project_name FROM project;

SPOOL OFF