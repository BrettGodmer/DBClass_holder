-- File: companyDML-a1.sql 
-- SQL/DML (on the COMPANY database)
/*
--
IMPORTANT SPECIFICATIONS
--
(A)
-- Download the script file PA-06-companyDB.sql and use it to create your COMPANY database in sqlplus.
-- Dowlnoad the file companyDBinstance.pdf; it is provided for your convenience when checking the results of your queries.
--
(B)
--Implement the queries below by ***editing this file*** to include
your name and your SQL code in the indicated places.   
--
(C)
After you have written the SQL code in the appropriate places:
-- Run this file (from the command line in sqlplus). It will produce the spooled file companyDML-a1.txt.
-- Upload the spooled file (companyDML-a1.txt) to BB.*/
--
*/
SPOOL companyDML-a1.txt
SET ECHO ON
-- ---------------------------------------------------------------
-- 
-- Name: Brett Godmer
--
-- ------------------------------------------------------------
-- NULL AND SUBSTRINGS -------------------------------
--
/*(10A)
Find the ssn and last name of every employee who doesn't have a  supervisor, or their last name contains at least two occurences of the letter 'a'. Sort the results by ssn.
*/
SELECT Ssn, Lname
FROM Employee
WHERE Super_ssn IS NULL
OR Lname LIKE '[a][a]%'
ORDER BY Ssn DESC;
--
-- JOINING 3 TABLES ------------------------------
-- 
/*(11A)
For every employee who works more than 30 hours on any project: Find the ssn, lname, project number, project name, and numer of hours. Sort the results by ssn.
*/
SELECT e.ssn, e.Lname, wo.Pno, p.Pname, wo.Hours
FROM EMPLOYEE e, WORKS_ON wo, PROJECT p
WHERE e.Ssn = wo.Essn 
	AND wo.Pno = p.Pnumber 
	AND wo.Hours > 30
ORDER BY e.Ssn DESC;
--
-- JOINING 3 TABLES ---------------------------
--
/*(12A)
Write a query that consists of one block only.
For every employee who works on a project that is not controlled by the department they work for: Find the employee's lname, the department they works for, the project number that they work on, and the number of the department that controls that project. Sort the results by lname.
*/
SELECT e.Lname, e.Dno, wo.Pno, p.Dnum
FROM EMPLOYEE e, WORKS_ON wo, PROJECT p
WHERE e.Ssn = wo.Essn 
	AND wo.Pno = p.Pnumber 
	AND e.Dno != p.Dnum
GROUP BY e.Lname;
--
-- JOINING 4 TABLES -------------------------
--
/*(13A)
For every employee who works for more than 20 hours on any project that is located in the same location as their department: Find the ssn, lname, project number, project location, department number, and department location. Sort the results by lname
*/
SELECT Ssn, Lname, Pno, Plocation, Dnum, Dlocation
FROM EMPLOYEE e, WORKS_ON wo, PROJECT p, DEPT_LOCATIONS dl
WHERE e.Ssn = wo.Essn 
	AND wo.Pno = p.Pnumber 
	AND p.Dnum = dl.Dnumber 
	AND p.Hours > 20 
	AND dl.Dlocation = p.Plocation
GROUP BY e.Lname;
--
-- SELF JOIN -------------------------------------------
-- 
/*(14A)
Write a query that consists of one block only.
For every employee whose salary is less than 70% of his/her immediate supervisor's salary: Find that employee's ssn, lname, salary; and their supervisor's ssn, lname, and salary. Sort the results by ssn.  
*/
SELECT Ssn, Lname, Salary, Ssn, Lname, Salary
FROM EMPLOYEE e1, EMPLOYEE e2
WHERE e1.Super_ssn = e2.Ssn 
	AND e1.Salary = e2.Salary*0.7
ORDER BY e1.Ssn;
--
-- USING MORE THAN ONE RANGE VARIABLE ON ONE TABLE -------------------
--
/*(15A)
For projects located in Houston: Find pairs of last names such that the two employees in the pair work on the same project. Remove duplicates. Sort the result by the lname in the left column in the result. 
*/
SELECT DISTINCT e1.Lname, e2.Lname
FROM EMPLOYEE e1, EMPLOYEE e2, WORKS_ON wo
WHERE e1.Ssn = wo.Essn 
	AND e2.Ssn = wo.Essn
GROUP BY e1.Lname;
--
------------------------------------
--
SET ECHO OFF
SPOOL OFF


