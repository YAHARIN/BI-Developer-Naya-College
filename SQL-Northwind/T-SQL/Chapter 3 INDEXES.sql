--Chapter 3 INDEXES

--Q1

--A
CREATE TABLE Customers (
	cust_id INT, 
	cust_name Varchar(25),
	cust_city Varchar(25)
)

--B
INSERT INTO dbo.customers
	VALUES (3, 'Moshe' , 'Tel Aviv')
INSERT INTO dbo.customers
	VALUES (8, 'Yossi' , 'Tel Aviv')
INSERT INTO dbo.customers
	VALUES (2, 'Roee', ' Jerusalem')
INSERT INTO dbo.customers
	VALUES (4, 'Avi' , 'Tel Aviv')
INSERT INTO dbo.customers
	VALUES (5, 'Ram' , 'Jerusalem')
INSERT INTO dbo.customers
	VALUES (6, 'Ronen', 'Tel Aviv')
INSERT INTO dbo.customers
	VALUES (7, 'Elad' , 'Jerusalem')
INSERT INTO dbo.customers
	VALUES (1, 'Shlomo' , 'Jerusalem')


--C
SELECT * FROM Customers
--This table is a Heap Table, Thats why cust_id column is not sorted. 

--D
CREATE UNIQUE NONCLUSTERED INDEX customers_id_ix
ON Customers(cust_id)

--E
--Becouse we used NONCLUSTERED INDEX 

--F
SELECT *
FROM Customers
WHERE cust_id = 4

DROP INDEX customers_id_ix ON customers
GO

CREATE UNIQUE NONCLUSTERED INDEX customers_id_ix_new
ON Customers(cust_id)
INCLUDE (cust_name, cust_city)
GO

SELECT cust_name ,cust_city
FROM dbo.customers
WHERE cust_id = 4
GO

--Q2
--A

DROP TABLE dbo.customers

CREATE TABLE dbo.customers
(	cust_id int CONSTRAINT cust_id_pk PRIMARY KEY,
	cust_name varchar(25),
	cust_city varchar(25),
	cust_phone varchar(3000)
)

--B
INSERT INTO dbo.customers VALUES (2,'Moshe' , 'Tel Aviv' , replicate ('*',3000))
INSERT INTO dbo.customers VALUES (1,'Yossi' , 'Tel Aviv' , replicate ('*', 3000)) 
INSERT INTO dbo.customers VALUES (4,'Roee' , 'Jerusalem' , replicate ('*',3000))
INSERT INTO dbo.customers VALUES (3,'Avi' , 'Tel Aviv' , replicate ('*',3000))
INSERT INTO dbo.customers VALUES (6,'Ram' , 'Jerusalem' ,replicate ('*',3000))
INSERT INTO dbo.customers VALUES (5, 'Ronen' , 'Tel Aviv' , replicate('*',3000))
INSERT INTO dbo.customers VALUES (8,'Elad' , 'Jerusalem' , replicate ('*', 3000))
INSERT INTO dbo.customers VALUES (7,'Shlomo', 'Jerusalem' , replicate ('*', 3000))

--C 
SELECT * FROM customers
--PRIMARY KEY creates an CLUSTERED INDEX

