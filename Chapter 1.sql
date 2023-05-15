--Chapter 1

--Q1
SELECT *
FROM [dbo].[Orders]

--Q2
SELECT EmployeeID, OrderID
FROM [dbo].[Orders]

--Q3
SELECT ProductID as ID, ProductName as PrName, CategoryID as PrCategory
FROM [dbo].Products

--Q4
SELECT EmployeeID as ID, LastName as EmpLName, FirstName as EmpFName
FROM dbo.Employees

--Q5
SELECT CustomerID, (City +', '+ Address) as "Full Address"
FROM dbo.Customers

--Q6
SELECT (FirstName + ' ' + LastName) as "Full Name", BirthDate as "Birth Date", ReportsTo as Manager
FROM dbo.Employees

--Q7 
SELECT DISTINCT City
FROM dbo.Employees

SELECT DISTINCT Country
FROM dbo.Employees

SELECT DISTINCT Title
FROM dbo.Employees

--Q8
SELECT DISTINCT City
FROM dbo.Customers

SELECT DISTINCT Country
FROM dbo.Customers

SELECT DISTINCT City, Country
FROM dbo.Customers

--Q9
SELECT ProductName, UnitPrice, (UnitPrice + 5) as "+5"
FROM dbo.Products

--Q10
SELECT FirstName, BirthDate, BirthDate + 8 as "Circumcision Date"
FROM dbo.Employees

--Q11
SELECT ProductID, ProductName, UnitPrice, (UnitPrice + UnitPrice * 0.18) as "+18%", UnitsInStock, UnitsOnOrder, (UnitsInStock-UnitsOnOrder) as "Left in Stock"
FROM dbo.Products

--Q12
SELECT ProductID, ProductName, UnitPrice * (UnitsInStock-UnitsOnOrder) as "Left in Stock Cost"
FROM dbo.Products


