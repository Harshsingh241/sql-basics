CREATE DATABASE CPW;
-- DROP DATABASE CPW;
USE cpw;
CREATE TABLE teacher(
id int primary key,
name varchar(20) NOT NULL,
age int,
constraint check (age>=18));
INSERT INTO std
-- (column1,column2)
values 
(1,"harsh",31),
(2,"ravi",60);
SELECT * FROM student
where age>19
order by id DESC;
SELECT id,name FROM student
LIMIT 1;
SHOW DATABASES;
SHOW TABLES;
-- NOT NULL , UNIQUE,CHECK,DEFAULT,constraints
-- primary and foreign keys
-- and,or,between 1 and 15,in (1,2,3,4,5,6),not

SELECT count(id),max(age),avg(age),sum(id),min(age)FROM student;
-- select age,max(followers) from
-- student
-- group by age
-- having max(followers)>200; 
select age from student 
group by age
HAVING age>20;
-- select,from,where,group by,having,order by;
UPDATE student
SET followers=200
where age=19;
SET SQL_SAFE_UPDATES=0;
DELETE FROM student
WHERE age<21;
select * from std;
SET SQL_SAFE_UPDATES=1;
-- TO CHANGE SCHEMA OF TABLE WE USE ALTER 
ALTER TABLE student
ADD COLUMN rollno int default 1;
ALTER TABLE student
DROP COLUMN age;
ALTER TABLE student
RENAME to std;
ALTER TABLE std
CHANGE COLUMN id identity varchar(10) NOT NULL;
ALTER TABLE std
MODIFY rollno float unique;
-- truncate to delete tables data
truncate table std;
-- drop table std;



CREATE DATABASE IF NOT EXISTS COLLEGE;
use college;
CREATE TABLE teacher(
id int ,
name varchar(30) NOT NULL ,
subject varchar(30) UNIQUE,
salary float DEFAULT 45000,
primary key(id));
INSERT INTO teacher 
(id,name,subject,salary)
VALUES
(1,"kapil","physics",250000),
(2,"anno","pfps ",200000),
(3,"bhagat","bee",DEFAULT),
(4,"neha","eae",150000),
(5,"akhilesh","maths",225000);
SELECT * FROM teacher 
WHERE salary>150000 ;
SELECT * FROM teacher ;
ALTER TABLE teacher
CHANGE COLUMN salary ctc int ;
SET SQL_SAFE_UPDATES=0;
UPDATE teacher
SET ctc=ctc*1.25
where ctc<200000;
ALTER TABLE teacher
ADD column city varchar(20) DEFAULT "gurgaon";
ALTER TABLE teacher
DROP COLUMN ctc;

 
 use college;
CREATE TABLE student(
rollno int primary key,
name varchar(30),
city varchar(20),
cgpa float); 
INSERT INTO student
VALUES
(47,"nitin","agra",8.5),
(48,"nitin","ghazipur",9.0),
(100,"madhav","bihar",10),
(44,"nishant","mathura",8.4),
(20,"arjun","pryagraj",8);
select*from student
where cgpa>=9;
select DISTINCT city from student;
select city ,max(cgpa) from student
group by city;
select avg(cgpa) from student;
ALTER TABLE student
ADD COLUMN GRADE varchar(30);
select * from student;
SET SQL_SAFE_UPDATES=0;
UPDATE student
SET GRADE="0"
WHERE CGPA>=9;
UPDATE student
SET GRADE="A"
WHERE CGPA>=8.5 AND CGPA<9  ;
UPDATE student
SET GRADE="B"
WHERE CGPA>=8 AND CGPA<8.5;

CREATE DATABASE EMIT;
USE EMIT;
CREATE TABLE employee(
id int primary key,
firstname varchar(30),
lastname varchar(30),
department varchar(20),
salary int,
HIREDATE DATE);
INSERT INTO employee
VALUES
(101,"ALICE","JOHNSON","IT",6500,'2020-03-15'),
(102,"MARK","RIVERA","HR",4800,'2019-07-22'),
(103,"SOPHIA","LEE","FINANCE",7200,'2021-01-10'),
(104,"DANIEL","KIM","IT",5800,'2018-11-05'),
(105,"EMMA","BROWN","MARKETING",5300,'2022-04-18'),
(106,"LIAM","PATEL","FINANCE",6900,'2020-09-29'),
(107,"OLIVIA","GARCIA","HR",4600,'2017-06-30'),
(108,"NOAH","THOMPSON","IT",7500,'2023-02-12'),
(109,"AVA","MARTINEZ","MARKETING",5100,'2019-12-02'),
(110,"ETHAN","DAVIS","FINANCE",8000,'2016-05-14');
SELECT * FROM employee;
SELECT firstname,lastname,salary FROM employee;
SELECT * FROM employee
WHERE department="IT";
SELECT * FROM employee
WHERE SALARY>6000;
SELECT * FROM employee
WHERE SALARY>6000;
SELECT * FROM employee
ORDER BY HIREDATE DESC;
SELECT department FROM EMPLOYEE
group by department;    
SELECT DISTINCT DEPARTMENT FROM EMPLOYEE;
SELECT * from employee
where salary  between 4000 AND 7000;
SELECT department,AVG(salary) FROM EMPLOYEE
group by department;    
SELECT department,count(id) FROM EMPLOYEE
group by department
HAVING COUNT(ID)>=3;
truncate table employee;  
SELECT * from employee
where firstname LIKE "A%";



-- atomicity,consistency,isolation,durabiilty
SET SQL_SAFE_UPDATES=0;
SELECT @@autocommit;
CREATE DATABASE PRIME;
USE PRIME;
CREATE TABLE accounts(
id INT PRIMARY KEY AUTO_INCREMENT,
name varchar(30),
balance decimal(10,2)
);
INSERT INTO accounts
(name,balance)
VALUES
("ADAM",500.50),
("BOB",300.50),
("CHARLIE",1000.50);
SELECT * FROM accounts;
SET autocommit=0;
START TRANSACTION;
UPDATE accounts SET balance=balance-50 WHERE ID=1;
UPDATE accounts SET balance=balance+50 WHERE ID=2;
rollback;
-- TRUNCATE TABLE accounts;
START TRANSACTION;
UPDATE accounts SET balance=balance+1000 WHERE ID=1;
savepoint after_topup;
UPDATE accounts SET balance=balance+10 WHERE ID=1;
rollback to after_topup;
commit;

-- JOINS 
USE emit;
CREATE TABLE customers(
ID int primary key AUTO_INCREMENT,
name varchar(20),
city varchar(20));
INSERT INTO customers
(name,city)
values
("Alice","Mumbai"),
("Bob","Delhi"),
("Charlie","Banglore"),
("David","Mumbai");
SELECT * from customers;
SELECT * from orders;
CREATE TABLE orders(
order_ID int primary key,
ID int,
amount int);
INSERT INTO orders          
values
(101,1,500),
(102,1,900),
(103,2,300),
(104,5,700);
SELECT c.id,o.order_id,c.name
FROM customers c
INNER JOIN ORDERS o
ON c.id=o.id;
SELECT *
FROM customers c 
LEFT JOIN ORDERS o
ON c.id=o.id
UNION
SELECT *
FROM customers c 
RIGHT JOIN ORDERS o
ON c.id=o.id;
SELECT *
FROM customers c 
JOIN customers o
ON c.id=o.id;
SELECT *
FROM customers c 
LEFT JOIN ORDERS o
ON c.id=o.id
WHERE o.id is NULL;
SELECT *
FROM customers c 
RIGHT JOIN ORDERS o
ON c.id=o.id
WHERE c.id is NULL;



USE emit;
select * FROM orders
where amount>(
SELECT avg(amount)
FROM orders);
SELECT NAME,(
SELECT count(*)
FROM ORDERS O
WHERE O.ID=C.ID
) as order_count
FROM CUSTOMERS C;
SELECT 
    SUMMARY.ID,
    SUMMARY.AVG_AMOUNT
FROM 
(
    SELECT 
        ID,
        AVG(AMOUNT) AS AVG_AMOUNT
    FROM ORDERS
    GROUP BY ID
) AS SUMMARY;
CREATE VIEW view1 as
select id,name from customers;
SELECT * FROM view1;
DROP VIEW view1;
CREATE INDEX IDX_1 ON customers(id);
SHOW INDEX FROM customers;
SELECT * FROM customers
where id=1;
DROP INDEX IDX_1 ON customers;
CREATE INDEX IDX_1 ON customers(id,name);
DELIMITER $$
CREATE PROCEDURE alum(in a int)
BEGIN
select * from customers
where ID=a;
END $$
DELIMITER ;
CALL alum(2);
DROP PROCEDURE IF EXISTS alum;



