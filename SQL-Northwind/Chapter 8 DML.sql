--Chapter 8 DML
CREATE TABLE my_employees
(	ID int PRIMARY KEY ,
	Name VARCHAR (50),
	Title VARCHAR(50),
	Deptid int,
	salary MONEY DEFAULT 3500 )

--Q1
INSERT INTO my_employees
VALUES (1, 'Aviv Cohen', 'Clerk', 10, 4000)

--Q2
INSERT INTO my_employees (ID,Name,Title,Deptid,salary)
VALUES (2, 'Miriam Levi', 'Sales Manager', 30, 3700)

--Q3
INSERT INTO my_employees (ID,Name,Title,Deptid,salary)
VALUES (3, 'Alon Romano', 'Operations Manager', 40, NULL)

--Q4
INSERT INTO my_employees (ID,Name,Deptid)
VALUES (4, 'Baruch Nave',10)


--Q5 YES Q6
SELECT * FROM my_employees

--Q7
UPDATE my_employees
SET salary = 4500
WHERE ID = 2

SELECT * FROM my_employees

--Q8
UPDATE my_employees
SET Name = 'Ori Ben', Deptid = 20
WHERE ID = 4

--Q9
DELETE my_employees
WHERE Name = 'Alon Romano'
