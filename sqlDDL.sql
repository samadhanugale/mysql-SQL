SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS MYDB2;
SHOW CREATE DATABASE mydb_TEST;

USE MYDB2;
SHOW TABLES; -- Show existing tabeles
DROP DATABASE IF EXISTS MYDB_TEST; 

-- Creating tables with rows
CREATE TABLE IF NOT EXISTS tasks(
	task_id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
    start_date DATE,
    due_date DATE,
    status TINYINT NOT NULL,
    priority TINYINT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS test	(
	test_id int,
    test_name VARCHAR(255),
    test_score int,
    test_status TINYINT,
    test_description TEXT,
    test_date DATE
);

-- Rename
RENAME TABLE TEST_NEW To TEST ;

DESCRIBE tasks;
DESCRIBE test;

-- Add Column
ALTER TABLE TEST ADD test_grade VARCHAR(2);
ALTER TABLE TEST ADD test_grade1 VARCHAR(2) FIRST; -- Adding Column at first
ALTER TABLE TEST ADD test_grade2 VARCHAR(2) AFTER test_name; -- Adding column after specific column

ALTER TABLE TEST 
	ADD test_grade4 VARCHAR(2),
	ADD test_grade5 VARCHAR(2) NOT NULL;
    
-- Modify column
ALTER TABLE test
	MODIFY test_grade2 VARCHAR(10) NOT NULL,
    MODIFY test_grade TINYINT NOT NULL;
    
ALTER TABLE test
	MODIFY test_grade VARCHAR(10) NOT NULL;
    
-- Change Column
ALTER TABLE test 
	CHANGE COLUMN TEST_GRADE1 test_grade int(2) NOT NULL;

SELECT * FROM test;
SELECT * FROM tasks;

-- Drop Column
Alter Table test 
	DROP COLUMN TEST_GRADE2,
    DROP COLUMN TEST_GRADE4,
    DROP COLUMN TEST_GRADE5;
    
DROP Table test; -- Drop Whole table

-- Drop And create table again using truncate
TRUNCATE TABLE test;

----------------------------------------------

-- Constraints Primary key, - Uniquely identify key
-- Foreign key, - Coumn use to link to another table
-- Unique , 
-- NOT NULL,
-- DEFAULT,
-- CHECK

CREATE TABLE users (
	user_id int AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    user_pass VARCHAR(15) NOT NULL,
    user_email VARCHAR(30) NOT NULL UNIQUE,
    user_phone VARCHAR(15) NOT NULL UNIQUE,
    user_credit DEC(5,2) DEFAULT 0.1,
    user_withdraw DEC(5,2) NOT NULL CHECK(user_withdraw > 0)
    
);

DROP TABLE users;

DESCRIBE users;

INSERT INTO users (user_id,user_name,user_pass,user_email,user_phone,user_withdraw) 
	VALUES(1,'Jonas','Jonas@123','Jonas12@gmail.com','+91-9552505659',0.1);
    
INSERT INTO users (user_name,user_pass,user_email,user_phone,user_withdraw) 
	VALUES('Hannah','Hannah@123','Hannah@gmail.com','+91-9552505658',0.1);
    
ALTER TABLE USERS auto_increment = 101;

INSERT INTO users (user_name,user_pass,user_email,user_phone,user_credit,user_withdraw) 
	VALUES('Sherk','sherk@123','sherk@gmail.com','+91-9552505657',10,0.1);
    
INSERT INTO users (user_name,user_pass,user_email,user_phone,user_withdraw) 
	VALUES('Bartosh','Bartosh@123','Bartosh@gmail.com','+91-9552505656',0.1);
    
INSERT INTO users (user_id,user_name,user_pass,user_email,user_phone,user_withdraw) 
	VALUES(2,'Adam','Adam@123','Adam@gmail.com','+91-9552505655',0.1);
    
UPDATE users SET user_email = "Sherk@gmail.com" WHERE user_name = 'Sherk';

SET SQL_SAFE_UPDATES = 0;
SELECT * FROM users;

CREATE  TABLE users_address(
	id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

DESCRIBE users_address;
select * FROM users_address;
SELECT * FROM users;

INSERT INTO users_address(user_id,city,country) VALUES(1,"Rome","Italy");
INSERT INTO users_address(user_id,city,country) VALUES(101,"Tokyo","Japan");

CREATE TABLE devices(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO devices(name) VALUES('Repeater 1'),('Repeater 2');
INSERT INTO devices(id,name) VALUES(3,'Printer1') ;
INSERT INTO devices(name) VALUES('Printer')
ON DUPLICATE KEY UPDATE name  = 'Printer';

INSERT INTO devices(id,name) VALUES(4,'Printer')
ON DUPLICATE KEY UPDATE name  = 'New Printer';

SELECT * FROM devices;
SELECT * FROM users;
SELECT * FROM users_address;

DELETE FROM users WHERE user_id = 102;

DELETE mydb2.users, mydb2.users_address FROM users INNER JOIN users_address ON (users.user_id = users_address.user_id ) WHERE id = 1;
DELETE user_id FROM users JOIN users_address 
ON users.user_id = users_address.user_id WHERE id = 1;