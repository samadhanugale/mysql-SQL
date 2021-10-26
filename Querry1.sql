-- Switching/Selecting Database
USE mydb;

-- Fetching columns 
SELECT EMPNO,ename,job FROM emp;
SELECT * FROM emp;
SELECT empno,sal AS oldsal, (SAL*1.05) AS newsal FROM emp; -- Creating new column with operation 
SELECT 200*1.05 AS RESULT; -- Creating new column with operation or value

SELECT empno,sal FROM emp ORDER BY empno,sal DESC; -- Soeting ascending or descending

SELECT empno,sal FROM emp WHERE sal < 2000 ORDER BY empno,sal;

SELECT empno,sal FROM emp WHERE sal < 2000  ORDER BY empno,sal;

SELECT * FROM emp WHERE sal BETWEEN 1000 AND 3000 ORDER BY sal;

SELECT * FROM emp WHERE job IN ('CLERK','MANAGER') ORDER BY sal;

SELECT * FROM emp WHERE ename LIKE '_AR%' OR ename LIKE 'B%'; -- Finding String with letters

SELECT * FROM emp WHERE ename LIKE '%D';

SELECT * FROM emp LIMIT 3;

SELECT * FROM emp WHERE job IN ('CLERK','MANAGER') ORDER BY sal LIMIT 3; -- Adding limit to records to show

SELECT * FROM emp WHERE job IN ('CLERK','MANAGER') ORDER BY sal LIMIT 2,3; -- Adding limit to records to show with offset

SELECT * FROM emp where comm IS NOT NULL OR mgr IS NULL;

SELECT DISTINCT job FROM emp; -- Unique records fetch

SELECT DISTINCT mgr FROM emp;

SELECT ename,job,sal AS oldsal, (SAL*0.90) AS newsal FROM emp WHERE job IN ('MANAGER'); -- SECOND Last

SELECT * FROM emp WHERE job IN ('CLERK','PRESIDENT') ORDER BY sal DESC; -- First

SELECT ename,sal FROM emp WHERE ename LIKE '__R%' AND job IN ('SALESMAN'); -- Last

SELECT * FROM emp WHERE job IN ('MANAGER') ORDER BY empno DESC;

SELECT * FROM emp WHERE mgr IS NULL;	

SELECT ename,empno,sal FROM emp WHERE sal BETWEEN 2000 AND 6000 AND mgr IN ('7839') ORDER BY sal DESC;

SELECT ename employee_name FROM emp; -- Here as is optional

SELECT ename 'employe ename' FROM emp;
SELECT ename FROM emp;

SELECT MAX(sal) AS MAXSAL,MIN(sal) AS MINSAL FROM emp;
-- Highest Salary employee Details
SELECT * FROM emp WHERE sal = (SELECT MAX(sal) AS MAXSAL FROM emp) ; -- Querry inside Querry -> SubQuerry
-- Second highest Salary
SELECT * 
	FROM emp 
		WHERE sal = (SELECT MAX(sal) AS MAXSAL FROM emp
			WHERE sal < (SELECT MAX(sal) AS MAXSAL FROM emp)) ;
            
DESCRIBE emp;
DESCRIBE dept;
SELECT * FROM emp;
SELECT * FROM dept;

SELECT empno,ename,job,loc,sal,dname FROM emp INNER JOIN dept ON emp.deptno = dept.deptno;
SELECT empno,dname FROM emp INNER JOIN dept WHERE emp.deptno = dept.deptno;
SELECT empno,ename,job,loc,sal,dname FROM emp INNER JOIN dept USING (deptno);

SELECT COUNT(*) FROM (SELECT E.* ,dept.dname FROM emp E LEFT JOIN dept USING (deptno)) X; -- Counting

SELECT emp.*,dname FROM emp LEFT JOIN dept USING (deptno);

SELECT emp.*,dname FROM emp RIGHT JOIN dept USING (deptno);

SELECT COUNT(*) FROM emp; -- Count
SELECT emp.*,dname FROM emp RIGHT JOIN dept USING (deptno);

INSERT INTO EMP VALUES(111,'sam','CLERK',null,null,2000,null,30);
SELECT COUNT(*) FROM emp;
SELECT emp.*,dname FROM emp RIGHT JOIN dept USING (deptno);

SELECT emp.*,dept.* FROM emp RIGHT JOIN dept USING (deptno) WHERE emp.deptno IS NULL;

SELECT deptno,COUNT(*) AS COUNTER FROM emp GROUP BY deptno;

SELECT deptno, COUNT(*) as EMPS, MAX(sal) AS MAXSAL, MIN(sal) AS MINSAL FROM emp GROUP BY 1;

SELECT deptno, COUNT(*) as EMPS FROM emp GROUP BY 1 HAVING  emps > 2;

SELECT deptno as EMPS FROM emp GROUP BY 1 HAVING   MAX(sal) > 3000; 


SELECT job, sal,COUNT(*) as EMPS FROM emp GROUP BY 1 HAVING  AVG(sal);

-- Display avg sal of each job 
SELECT job, sal,COUNT(*) as EMPS FROM emp GROUP BY 1 HAVING  AVG(sal);

-- Display max sal of each deptno where avg sal of that dept > 2000.
SELECT deptno,sal,COUNT(*) as EMPS FROM emp GROUP BY 2 HAVING  MAX(sal) > 2000;

-- Display max sal of each deptno where dept > 10 and max sal > 3000.
SELECT deptno,sal FROM emp GROUP BY job HAVING MAX(sal) > 3000 ;

-- Display max sal of each job for non managers.

SELECT CURDATE(); -- Date
SELECT CURTIME(); -- Time
SELECT NOW(); -- Server time
SELECT SYSDATE(); -- System time

SELECT DATE_ADD('2021-10-25',INTERVAL 30 DAY); -- Year month day
SELECT DATE_ADD('2021-10-25',INTERVAL 1 YEAR);
SELECT DATE_ADD('2021-08-12',INTERVAL 3 MONTH);
SELECT DATE_ADD(CURDATE(),INTERVAL 30 DAY);
SELECT DATE_ADD(CURTIME(),INTERVAL 3 HOUR);

SELECT DATEDIFF('2021-08-12',CURDATE());
SELECT DAYNAME(CURDATE()),DAYOFMONTH(CURRDATE()),DAYOFWEEK(CURDATE()),DAYOFYEAR(CURDATE());
SELECT MONTH(CURDATE()),MONTHNAME(CURDATE()),YEAR(CURDATE()),WEEKOFYEAR(CURDATE());
SELECT HOUR(CURDATE()),MINUTE(CURTIME());

SELECT DATE_FORMAT('2021-10-26 16:12:00 ','%W %M %Y');
SELECT DATE_FORMAT('2021-10-26 16:12:00 ','%H : %I : %S');
SELECT DATE_FORMAT('2021-10-26 16:12:00 ','%D %M %Y %a , %d %m %b  : %j th day');

-----------------------------
SELECT * FROM emp;
SELECT * FROM dept;

SELECT ename,sal,deptno,loc FROM emp INNER JOIN dept ON emp.deptno = dept.deptno;
SELECT empno,ename,job,loc,sal,dname FROM emp INNER JOIN dept ON emp.deptno = dept.deptno;

-- 1. Give 5% increment to most junior emps and display their emp details.
SELECT *, (sal*1.05) as NEWSAL FROM emp HAVING DATEDIFF(CURDATE(),hiredate) = (SELECT MIN(DATEDIFF(CURDATE(),hiredate)) FROM emp);


-- 2. Count the most junior emps of the table.
SELECT * FROM emp HAVING DATEDIFF(CURDATE(),hiredate) = (SELECT MIN(DATEDIFF(CURDATE(),hiredate)) FROM emp);


-- 3. Find out the empname, sal, deptno, dept location of most senior emp/emp's.
SELECT empno,ename,job,sal,loc,hiredate FROM emp INNER JOIN dept ON emp.deptno = dept.deptno HAVING DATEDIFF(CURDATE(),hiredate) = (SELECT MAX(DATEDIFF(CURDATE(),hiredate)) FROM emp);


----------------------------------------------------------
SELECT * FROM emp;
SELECT * FROM emp where empno = 7899;

UPDATE emp SET sal = 1600,comm = 500 where deptno IN(30,20);

UPDATE emp SET empno = 112 WHERE ename = "SAM";
SET SQL_SAFE_UPDATES = 0;

DELETE FROM emp WHERE EMPNO = 112;

INSERT INTO emp VALUES(7899,"MARTHA","CLERK",7902,"2021-08-12",10000,300,20);
REPLACE INTO emp VALUES(7899,"MARTHA","MANAGER",7902,"2021-08-12",10000,300,20);