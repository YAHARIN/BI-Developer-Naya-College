--Chapter 2

--Q1
SELECT FirstName, LastName
FROM Employees
WHERE EmployeeID = 3

--Q2
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE ProductID = 2

--Q3
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 20

--Q4
SELECT (FirstName +' '+LastName) as "Full Name", BirthDate as "Birth Date" 
FROM Employees
WHERE EmployeeID = 8

--Q5
SELECT (FirstName +' '+LastName) as "Full Name", BirthDate as "Birth Date" 
FROM Employees
WHERE City = 'London'

--Q6
SELECT *
FROM Products
WHERE UnitPrice < 50 OR UnitPrice > 100

--Q7
SELECT ProductName
FROM Products
WHERE UnitPrice BETWEEN 80 AND 100

--Q8
SELECT TOP 1 *
FROM Employees
ORDER BY LastName

--Q9
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 21.35 AND 43.9

--Q10
SELECT EmployeeID, LastName, City,BirthDate
FROM Employees
WHERE City = 'London' OR City='Tacoma'

SELECT EmployeeID, LastName, City,BirthDate
FROM Employees
WHERE City IN ('London', 'Tacoma')

--Q11
SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE EmployeeID IN (1,2,5)

--Q12
SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE EmployeeID NOT IN (4,5,7)

--Q13

SELECT *
FROM Employees
WHERE Region IS NULL

--Q14
SELECT OrderID, OrderDate, RequiredDate
FROM Orders
WHERE RequiredDate >= '1996-11-01'

--Q15
SELECT *
FROM Categories
WHERE CategoryName LIKE '%f%'

--Q16
SELECT CompanyName, Country
FROM Customers
WHERE CompanyName Like '%a'

--Q17
SELECT ProductName, CategoryID
FROM Products
WHERE ProductName LIKE '%a_'

--Q18
SELECT CustomerID, CompanyName, Country, Phone
FROM Customers
WHERE Country LIKE 'M%' OR Country LIKE 'F%' OR Country LIKE 'G%' AND Region IS NULL

SELECT CustomerID, CompanyName, Country, Phone
FROM Customers
WHERE Country LIKE '[M, F, G]%' AND Region IS NULL

--Q19
--Lowest
SELECT TOP 1 BirthDate
FROM Employees
ORDER BY BirthDate

--Highest
SELECT TOP 1 BirthDate
FROM Employees
ORDER BY BirthDate DESC 

--Q20
SELECT *
FROM Employees
WHERE LastName LIKE '%[K,D]%' OR BirthDate BETWEEN '1963-01-01' AND '1963-12-31'

--Q21
SELECT ProductName, UnitPrice, SupplierID
FROM Products
WHERE UnitPrice > 20 AND SupplierID IN (1,3)
ORDER BY ProductName

--Q22 
SELECT DISTINCT TerritoryDescription
FROM Territories
ORDER BY TerritoryDescription

--Q23
SELECT *
FROM Suppliers
WHERE HomePage IS NOT NULL AND HomePage LIKE '%MICROSOFT%'

--Q24
SELECT TOP 3 ProductName
FROM Products
ORDER BY UnitPrice DESC

--Q25
SELECT TOP 1 LastName
FROM Employees
ORDER BY LastName DESC

