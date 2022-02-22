-- Create database as mydb
-- patil.sachin@neosoftmail.com
CREATE DATABASE mydb;
USE mydb;

-- create table customers Fields: id,name,age,city,salary Note: id is Primary key
CREATE TABLE IF NOT EXISTS customers(
	id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT,
    city VARCHAR(255),
    salary INT
);

-- Insert below records in your table
INSERT INTO customers(id,name,age,city,salary) VALUES
(1,'pranav',25,'pune',25000),
(2,'prayas',25,'mumbai',28000),
(3,'sayali',23,'delhi',18000),
(4,'mayuri',25,'mumbai',28000),
(5,'ajinkya',23,'indore',32000),
(6,'anika',24,'indore',28000),
(7,'manish',26,'bhopal',28000);

-- display all
SELECT * FROM customers;

-- Display id,name and age of customers have salary > 25000
SELECT id,name,age FROM customers where salary>25000;


--  Display id,name and salary of customer name is 'sayali'.
SELECT id,name,age FROM customers where name = 'sayali';

--  Display id,name and salary of customers have sal > 28000 and age < 26
SELECT id,name,age FROM customers where salary>28000 AND age < 26;

--  Display id,name and salary of customers have sal > 28000 and age > 26
SELECT id,name,age FROM customers where salary>28000 AND age > 26;


-- Display id,name and city of customers in ascending order of salary
SELECT * FROM customers ORDER BY salary ASC;

-- Display id,name and salary of customers in descending order of city
SELECT * FROM customers ORDER BY city DESC;


-- Display city of customers where city start with letter 'p'
SELECT city FROM customers WHERE city LIKE 'p%';

-- Display city of customers where city include letters 'nd'
SELECT name,age FROM customers WHERE city LIKE '%nd%';

-- Display name,age of customers where city have second letter 'u'.
SELECT name,age FROM customers WHERE city LIKE '_u%';

-- Display name,age,city of customers where city ends with letter 'e'
SELECT city FROM customers WHERE city LIKE '%u';

-- Display name,age,city of customers where city have 4 characters and ends with 'e'
SELECT name,age,city FROM customers WHERE city LIKE '___e';

--  Display top 2 cities as per salary desc
SELECT city FROM customers ORDER BY salary DESC LIMIT 2;

-- Display top 2 cities as per name and salary desc
SELECT city FROM customers ORDER BY name AND salary DESC LIMIT 2;

-- Display top 2 cities as per name desc
SELECT city FROM customers ORDER BY name DESC LIMIT 2;

-- Display city wise avg(sal).
SELECT AVG(salary) AS avg_sal,city FROM customers GROUP BY city;

-- Display city wise avg(sal) in ascending order
SELECT AVG(salary) AS avg_sal,city FROM customers GROUP BY city ORDER BY avg_sal ASC;

-- Display city have maximum avg(sal)
SELECT AVG(salary) AS avg_sal,city FROM customers GROUP BY city ORDER BY avg_sal DESC LIMIT 1;

--  Display city have sum(sal) > 50000 
SELECT city,sum(salary) as salary FROM customers GROUP BY city HAVING salary > 50000;


--  Display city have avg(sal) in between 24999 and 29999 and customers salary > 25000.
SELECT city, AVG(salary) AS avg_sal FROM customers WHERE salary > 25000 GROUP BY city HAVING avg_sal > 24999 AND avg_sal < 29999;

--  Display a customer have max salary without using limit. (use subquery)
SELECT * FROM customers WHERE salary = (SELECT MAX(salary) FROM customers);

-- Display a customer have second max salary without using limit. (use subquery)
SELECT * FROM customers where salary = (SELECT MAX(salary) FROM customers WHERE Salary NOT IN (SELECT Max(Salary) FROM customers));

-- Update salary of each with 5% increment to their salary
UPDATE customers SET salary = salary*1.05;

-- Delete records where salary < 25000. 
DELETE FROM customers WHERE salary < 25000;

-- Count people who are below age 25
SELECT COUNT(*) AS below_25 FROM customers WHERE age < 25;

-- Refer or create emp and dept table: Note: deptno is a Primary key in emp and Foreign key in Dept As below

CREATE TABLE IF NOT EXISTS emp(
	empno INT PRIMARY KEY,
    ename VARCHAR(50) NOT NULL,
    job VARCHAR(50) NOT NULL,
    mgr INT,
    hireDate DATE,
    sal FLOAT,
    comm FLOAT,
    deptno INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Dept(
	deptNo INT PRIMARY KEY,
    dName VARCHAR(50),
    loc VARCHAR(255)
);
use mydb;
INSERT INTO emp VALUES
	(7369,'SMITH','CLERK',7902,'1980-12-17',800,NULL,20),
    (7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30),
    (7521,'WARD','SALESMAN',7698,'1981-02-22',1250,500,30),
    (7566,'JONES','MANAGER',7839,'1981-04-02',2975,NULL,20),
    (7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,1400,30),
    (7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,NULL,30),
    (7782,'CLARK','MANAGER',7839,'1981,06,09',2450,NULL,10),
    (7788,'SCOTT','ANALYST',7566,'1982-12-09',3000,NULL,20),
    (7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,NULL,10),
    (7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30),
    (7876,'ADAMS','CLERK',7788,'1983-01-12',1100,NULL,20),
    (7900,'JAMES','CLERK',7698,'1981-12-03',950,NULL,30),
    (7902,'FORD','ANALYST',7566,'1981-12-03',3000,NULL,20),
    (7934,'MILLIER','CLERK',7782,'1982-01-23',1300,NULL,10);
    
SELECT * FROM emp;
    
INSERT INTO dept VALUES
	(10,'ACCOUNTING','NEW YORK'),
    (20,'RESEARCH','BOSTON'),
    (30,'SALES','CHICAGO'),
    (40,'OPERATIONS','BOSTON');
    
SELECT * FROM dept;
-- Count the people who have maximum salary
SELECT COUNT(DISTINCT empno) AS 'max salary employees',empno,sal FROM emp WHERE sal = (SELECT MAX(sal) FROM emp);

--  Display people with their dept details having min salary.
Select deptno, count(*) as "Count People" 
  From emp
 Where (deptno,sal) IN
   (
    Select deptno, Min(sal)
      From emp
     Group by deptno
    )
 Group by deptno;
 
-- Display dept wise max salary.
SELECT deptno,MAX(sal) AS max_sal FROM emp GROUP BY deptno;

--  Display people having second highest salary.
SELECT * from emp 
WHERE sal IN (SELECT MAX(sal) 
FROM emp 
WHERE sal NOT IN (SELECT MAX(sal) 
FROM emp));

--  Count the people having second lowest salary.
SELECT COUNT(DISTINCT empno) FROM emp WHERE sal = (SELECT MIN(sal) FROM emp);

--  Count the people having second lowest salary.
SELECT COUNT(DISTINCT empno) AS second_heighest_sal FROM emp where sal = (SELECT MIN(sal) FROM emp WHERE Sal NOT IN (SELECT MIN(Sal) FROM emp));

--  Count the employees who have second highest salary.
SELECT COUNT(DISTINCT empno) FROM emp where sal = (SELECT MAX(sal) FROM emp WHERE sal NOT IN (SELECT Max(sal) FROM emp));

-- Give 10% increment to employees on their salary who have min salary
UPDATE emp SET sal = sal*1.1 WHERE sal = (SELECT MIN(sal) FROM emp);

--  Give 5% increment to employees on their salary who have salary < 3000.
UPDATE emp SET sal = sal*1.05 WHERE sal < 3000;

--  Display employee who have second lowest salary from location BOSTON
SELECT e.*,d.loc FROM emp e 
INNER JOIN dept d
USING (deptno)
WHERE d.loc = 'BOSTON'
ORDER BY sal LIMIT 1,1;

--  Give 5% increment to employees on their salary who have worked for min 1 year
UPDATE emp SET sal = sal*1.05 WHERE TIMESTAMPDIFF(YEAR,hiredate,SYSDATE())  > 1;

SELECT *, sal*1.05 AS upd FROM emp WHERE TIMESTAMPDIFF(YEAR,hiredate,SYSDATE()) > 40;

-- Identify most junior person from emp and add 1500 to his salary.
SELECT empno,ename,job,hiredate,sal+1500 AS salary,TIMESTAMPDIFF(YEAR,hiredate,SYSDATE()) AS experince FROM emp HAVING MAX(experince) ;

-- Identify most senior person from emp who have highest salary in seniors
SELECT *,TIMESTAMPDIFF(YEAR,hiredate,SYSDATE()) AS experince FROM emp WHERE sal IN (SELECT MAX(sal) FROM emp GROUP BY TIMESTAMPDIFF(YEAR,hiredate,SYSDATE())) HAVING experince = MAX(experince) ;

-- Identify most junior person from emp who have highest salary in seniors.
SELECT *,TIMESTAMPDIFF(YEAR,hiredate,SYSDATE()) AS experince FROM emp GROUP BY experince HAVING sal = MAX(sal) AND experince = MIN(experince);
