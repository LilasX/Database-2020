-- Project Part 10

connect sys/sys as sysdba;

SPOOL c:\bdd\lilas_L10.txt

Start c:\bdd\Northwoods.sql

-- Question 1

-- Using the database northwoods, create a SQL command to list the building
-- code and room number of all locations that have the same capacity as CR 103.

SELECT bldg_code, room
FROM location
WHERE capacity = 
(SELECT capacity
FROM location
WHERE bldg_code = 'CR' 
AND room = '103');


-- Question 2

-- Using the database northwoods, create a SQL command to display the
-- s_last, s_first, course_name, term_desc, and GRADE value for every student
-- ever taught by faculty member Kim Cox.

SELECT DISTINCT s_last, s_first, course_name, term_desc, GRADE
FROM student, course, term, enrollment, course_section
WHERE enrollment.c_sec_id = course_section.c_sec_id
AND course_section.term_id = term.term_id
AND student.f_id = course_section.f_id
AND course.course_id = course_section.course_id 
AND student.f_id = 
(SELECT DISTINCT f_id
FROM faculty
WHERE f_first = 'Kim'
AND f_last = 'Cox');

connect sys/sys as sysdba;

Start c:\bdd\Software.sql

--Question 3

-- Using the database software expert, create a SQL command to list the first
-- and last name of every consultant who has ever worked on a project with consultant Mark Myers.

SELECT DISTINCT c_first, c_last
FROM consultant, project_consultant
WHERE consultant.c_id = project_consultant.c_id
AND project_consultant.p_id IN ( 
(SELECT DISTINCT project_consultant.p_id
FROM consultant, project_consultant
WHERE project_consultant.c_id = consultant.c_id 
AND c_first = 'Mark'
AND c_last = 'Myers'));

-- Question 4

-- Using the database software expert, create a SQL command to display the
-- name of each project that consultant Mark Myers has ever worked on, and the
-- first and last name of the consultant who was the manager of the project.

SELECT DISTINCT project_name, c_first, c_last, mgr_id 
FROM consultant, project, project_consultant
WHERE consultant.c_id = project.mgr_id
AND project.p_id = project_consultant.p_id
AND project_name IN(
(SELECT DISTINCT project_name
FROM project, project_consultant, consultant
WHERE project_consultant.p_id = project.p_id 
AND project_consultant.c_id = consultant.c_id 
AND c_first = 'Mark'
AND c_last = 'Myers'));


-- Question 5

-- Using the database software expert, create a SQL command to display the
-- first and last name of all consultants who have worked on the same projects for Morningstar Bank.

SELECT c_first, c_last
FROM consultant, project, project_consultant
WHERE project_consultant.c_id = consultant.c_id 
AND project_consultant.p_id = project.p_id 
AND project_name =
(SELECT DISTINCT project_name
FROM project, client
WHERE client.client_id = project.client_id
AND client_name = 'Morningstar Bank');

connect sys/sys as sysdba;

Start c:\bdd\Clearwater.sql


-- Question 6

-- Using the database clearwater, create a SQL command to list 
-- the inventory ID, item description, item size, color , and shipment quantity for every item that
-- was received on the same date as inventory item 12 in shipment ID 4. 
-- Do not display the information of inventory item 12 in the output.

SELECT inventory.inv_id, item_desc, inv_size, color, sl_quantity
FROM inventory, item, shipment_line
WHERE shipment_line.inv_id = inventory.inv_id
AND inventory.item_id = item.item_id
AND sl_date_received = 
(SELECT sl_date_received
FROM shipment_line, inventory
WHERE shipment_line.inv_id = inventory.inv_id
AND ship_id = 4
AND inventory.inv_id = 12)
AND NOT (inventory.inv_id = 12);


SPOOL OFF