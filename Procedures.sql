-- Create procedure to get all employees with dept details
USE mydb;
SELECT * FROM emp;
DELIMITER @@
DELIMITER $$ 
CREATE PROCEDURE getAllEmpAndDept()
BEGIN
	SELECT * FROM mydb.emp INNER JOIN mydb.dept  USING(deptno);
END$$
DELIMITER ; 
CALL getAllEmpAndDept;
CALL GetEmpDetails;

-- Parameterized Procedure
DELIMITER @@
DELIMITER $$ 
CREATE PROCEDURE getAllEmpAndDeptByNo(IN dno INT)
BEGIN
	SELECT * FROM mydb.emp INNER JOIN mydb.dept  USING(deptno) WHERE emp.deptno =dno ;
END$$
DELIMITER ; 

CALL getAllEmpAndDeptByNo(20);

DELIMITER @@
DELIMITER $$ 
CREATE PROCEDURE getEmpByJob(IN jb VARCHAR(20),OUT counter INT)
BEGIN
	
	SELECT COUNT(*)
    INTO counter
    FROM mydb.emp WHERE job = jb;
END$$
DELIMITER ; 

CALL getEmpByJob('MANAGER',@counter);

SELECT @counter AS counter;

SELECT COUNT(*) FROM mydb.emp WHERE job = 'MANAGER';
