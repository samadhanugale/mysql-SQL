USE mydb;

-- Create a Function
DELIMITER $$
CREATE FUNCTION SalLavel(salary DECIMAL(10,2))
	RETURNS VARCHAR(20)
    DETERMINISTIC
    BEGIN
		DECLARE sal_level VARCHAR(20);
        IF salary > 2000 THEN 
			SET sal_level = 'HIGH';
		ELSE
			SET sal_level = 'LOW';
		END IF;
        RETURN sal_level;
    END $$
DELIMITER ;
DROP  FUNCTION SalLavel;
SHOW FUNCTION STATUS WHERE db='mydb'; -- To show created functions

SELECT ename,sal,empno,SalLavel(sal) AS SALLEVEL FROM emp;
CALL getAllEmpAndDept;
ALTER TABLE sample AUTO_INCREMENT = 3;
SELECT * FROM mydb.profile;

use mydb;

CREATE TABLE student(stdid INT  AUTO_INCREMENT PRIMARY KEY,stdname VARCHAR(50),stdcourse VARCHAR(50),marks INT NOT NULL);

INSERT INTO student(stdname,stdcourse,marks) VALUES('Jane','Java',90),('Jonas','python',80),
			('Hannah','python',76),	
            ('Adam','python',93),
            ('John','python',76);
            
SELECT * FROM student;
DESCRIBE bank;
DROP TABLE mydb.profile;

DELETE  FROM profile;
USE mydb;
SELECT * FROM bank;

ALTER TABLE bank MODIFY COLUMN phno BIGINT;
INSERT INTO mydb.bank(name,address,phno,uname,pass,deposit) VALUES('Jonas','Tokyo',987654,'jonas123','Jonas@123',100);

CREATE TABLE IF NOT EXISTS mydb.bank(uid INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(50) NOT NULL, address VARCHAR(50) NOT NULL,phno INT NOT NULL, uname VARCHAR(20) NOT NULL,pass VARCHAR(20) NOT NULL, deposit INT);