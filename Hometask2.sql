CREATE table Employees (
    id int,
    name varchar(25),
    age int,
    country varchar(40),
    salary int 
);
INSERT into Employees(id,name,age,country,salary) VALUES
(1,'RUSLAN',21,'UZBEKSTAN',1000),
(2,'RUSTAM',20,'UZBEKSTAN',900),
(3,'SUHROB',19,'UZBEKSTAN',1200),
(1,'BERNARD',21,'PORTUGAL',3400),
(5,'ALEX',26,'GERMANY',4400),
(6,'TOM',23,'USA',5200);

SELECT *FROM Employees 
WHERE age = (SELECT MIN(age) FROM Employees);

SELECT *FROM Employees 
WHERE salary = (SELECT MAX(salary) FROM Employees);

SELECT COUNT(*) AS USER_COUNT FROM Employees;

SELECT AVG(age) AS AVERAGE_AGE FROM Employees;

SELECT SUM(salary) AS AVERAGE_SALARY FROM Employees;