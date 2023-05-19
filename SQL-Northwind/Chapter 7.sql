--Chapter 7
--Q1

SELECT P.ProductName, P.UnitPrice
FROM Products as P
WHERE P.UnitPrice < (	SELECT UnitPrice 
						FROM Products
						WHERE ProductID = '8')

--Q2

SELECT P.ProductName, P.UnitPrice
FROM Products as P
WHERE P.UnitPrice > (	SELECT UnitPrice 
						FROM Products
						WHERE ProductName = 'Tofu')


--Q3

SELECT FirstName, HireDate
FROM Employees
WHERE HireDate > (	SELECT HireDate
					FROM Employees
					WHERE EmployeeID = '6')

--Q4

SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice >  (	SELECT AVG(UnitPrice) 
						FROM Products )

--Q5
SELECT *
FROM Employees
WHERE BirthDate > (	SELECT BirthDate
					FROM Employees
					WHERE LastName = 'Suyama')

--Q6
SELECT ProductName, UnitsInStock
FROM Products
WHERE UnitsInStock < (	SELECT MIN(UnitsInStock)
						FROM Products
						WHERE CategoryID = '5')

--Q7
SELECT *
FROM Products
WHERE CategoryID = (	SELECT CategoryID
						FROM Products
						WHERE ProductName = 'Chai')
AND ProductName <> 'Chai'

--Q8
SELECT ProductName, UnitPrice, CategoryID
FROM Products
WHERE UnitPrice IN (SELECT UnitPrice FROM Products WHERE CategoryID = 5)

--Q9
SELECT OrderID, OrderDate
FROM Orders
WHERE CustomerID IN (SELECT CustomerID
					FROM Customers
					WHERE Country IN ('Sweden', 'France', 'Germany'))
AND YEAR(OrderDate) = 1997

--Q10
SELECT ProductID, ProductName
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products WHERE UnitsInStock > 50) 

--Q11

SELECT *
FROM Products
WHERE CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName IN ('Condiments', 'Beverages'))
AND SupplierID IN (SELECT SupplierID FROM Suppliers WHERE Region IS NULL)

--Q12

SELECT CompanyName
FROM Suppliers
WHERE SupplierID IN (SELECT SupplierID FROM Products WHERE CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName = 'Beverages'))

--Q13
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT UnitPrice FROM Products WHERE ProductName = 'Chang')

--Q14

SELECT *
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products WHERE CategoryID = 2) AND UnitPrice > (SELECT MIN(UnitPrice) FROM Products WHERE CategoryID = 5)

--Q15
SELECT OrderID, OrderDate, ShippedDate, RequiredDate, ShipName, Freight
FROM Orders
WHERE ShipVia = (	SELECT ShipperID
					FROM Shippers
					WHERE CompanyName = 'Federal Shipping')
AND (Freight BETWEEN 25 AND 30)
AND DATEDIFF(DAY,OrderDate,ShippedDate) < 8
ORDER BY 5,6 