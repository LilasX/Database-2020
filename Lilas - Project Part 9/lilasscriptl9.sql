-- Project Part 9

connect sys/sys as sysdba;

SPOOL c:\bdd\lilas_L9.txt

Start c:\bdd\scott_emp_dept.sql


-- Question 1

-- Using the database of scott, create a SQL command 
-- to find the largest and smallest salary of all employees.

SELECT MAX(sal), MIN(sal) FROM emp;

-- Question 2

-- Find the Sum, Max, Min salary of every department which have
-- the minimum salary GREATER than 1000 FOR ALL EMPLOYEE except PRESIDENT.

SELECT deptno, SUM(sal), MAX(sal), MIN(sal) FROM emp
WHERE job <> 'PRESIDENT'
GROUP BY deptno
HAVING MIN(sal) > 1000;


connect sys/sys as sysdba;

Start c:\bdd\Clearwater.sql


-- Question 3

-- Working with table inventory of database CLEARWATER, display 
-- the sum of quantity on hand, minimum price, maximum price of each item 
-- having the sum of quantity on hand greater than 200 of all the inventories with size L, M.

SELECT item_id, SUM(inv_qoh), MIN(inv_price), MAX(inv_price) FROM inventory
WHERE inv_size IN ('M', 'L')
GROUP BY item_id
HAVING SUM(inv_qoh) > 200;

-- Question 4

-- Working with table inventory of database CLEARWATER, display 
-- the sum of quantity on hand, minimum price, maximum price of each item 
-- having the sum of quantity on hand greater than 100 of all the inventories 
-- with size either equal S or have no size at all.

SELECT item_id, SUM(inv_qoh), MIN(inv_price), MAX(inv_price) FROM inventory
WHERE inv_size IN ('S', NULL)
GROUP BY item_id
HAVING SUM(inv_qoh) > 100;

-- Question 5

-- Modify question 4 to display also the ITEM DESCRIPTION between the MAX, and MIN price.

SELECT inventory.item_id, item.item_id, SUM(inv_qoh), MIN(inv_price), item_desc, MAX(inv_price) 
FROM inventory, item
WHERE inventory.item_id = item.item_id
AND inv_size IN ('S', NULL)
GROUP BY inventory.item_id, item.item_id, item_desc
HAVING SUM(inv_qoh) > 100;

connect sys/sys as sysdba;

Start c:\bdd\Northwoods.sql


-- Question 6

-- Using database NORTHWOODS, create SQL command to find 
-- the birthdate of the youngest and oldest student. 
-- Named the column “Youngest” and “Oldest” respectively.

SELECT MIN(s_dob) AS Youngest, MAX(s_dob) AS Oldest FROM student;

-- Question 7

-- Using database NORTHWOODS, For each CLASS, create SQL command
-- to find and display the birthdate of the youngest and oldest student.

SELECT s_class, MIN(s_dob) AS Youngest, MAX(s_dob) AS Oldest FROM student
GROUP BY s_class;

SPOOL OFF