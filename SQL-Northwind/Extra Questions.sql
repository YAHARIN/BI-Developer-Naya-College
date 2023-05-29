--EXTRA SQL QUESTIONS
--Q1
SELECT ProductID as PID, ProductName as PN, CategoryID as CID, UnitPrice + 100 as UP 
FROM Products
ORDER BY UnitPrice DESC

--Q2

SELECT SupplierID, CompanyName, ISNULL(Region, 'UNKNOWN') as Region
FROM Suppliers

--Q3
SELECT c.CategoryName, c.CategoryID, COUNT(p.categoryID) as CountP 
FROM Products as p JOIN Categories as c
ON P.CategoryID = c.CategoryID
GROUP BY c.CategoryName, c.CategoryID
ORDER BY CountP

--Q4
SELECT UPPER(p.ProductName), UPPER(c.CategoryName), UPPER(s.CompanyName)
FROM Products as p INNER JOIN Categories as c
ON p.CategoryID = c.CategoryID
INNER JOIN Suppliers as s
ON s.SupplierID = p.SupplierID
WHERE p.ProductName like 'c%' AND LEN(c.CategoryName) > 10 

--Q5
SELECT o.CustomerID, COUNT(o.CustomerID)
FROM Orders as O INNER JOIN Customers as c
ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) > 1996 
GROUP BY o.CustomerID
HAVING COUNT(o.CustomerID) > 8

--Q6
CREATE TABLE Employee_Test (
					EmployeelD INT PRIMARY KEY,
					Name NVARCHAR(50),
					ManagerlD INT)

INSERT INTO Employee_Test
VALUES  (1,'Mike', 3),
		(2, 'David', 3),
		(3, 'Roger',NULL),
		(4, 'Marry',2),
		(5,'Joseph',2),
		(7,'Ben',2)

SELECT * FROM Employee_Test

SELECT E.EmployeelD, E.ManagerlD
FROM Employee_Test as E INNER JOIN Employee_Test as ET
ON E.ManagerlD = ET.ManagerlD
--What if I didnt want any duplicates? 

SELECT E.Name, ISNULL(ET.Name, 'Top Manager') as ManagerName
FROM Employee_Test E LEFT JOIN Employee_Test ET
ON E.ManagerlD = ET.ManagerlD

--Q7
SELECT E.EmployeeID, E.FirstName + ' ' + E.LastName as 'Full Name', COUNT(O.EmployeeID) as OrdersCount
FROM Employees as E INNER JOIN Orders as O
ON E.EmployeeID = O.EmployeeID
GROUP BY E.EmployeeID, E.FirstName + ' ' + E.LastName
HAVING COUNT(O.EmployeeID) > 100

--Q8
SELECT E.FirstName, E.LastName, RIGHT(YEAR(E.HireDate), 2) as 'Year'
FROM Employees as E

--Q9
CREATE TABLE orders_96 (
		order_id INT,
		Customerid NVARCHAR (100)
)

INSERT INTO orders_96 (order_id, Customerid)
SELECT OrderID, CustomerID
FROM Orders
WHERE OrderDate LIKE '%1996%'

UPDATE orders_96
SET CustomerID = NULL

SELECT * FROM orders_96

--Q10
SELECT LOWER(T.TerritoryDescription), LOWER(R.RegionDescription)
FROM Territories as T JOIN Region as R
ON T.RegionID = R.RegionID

--Q11
CREATE TABLE tabl (
		ID INT NOT NULL,
		Num INT NOT NULL
)

INSERT tabl (ID)
VALUES (1)

--Cannot insert the value NULL into column 'Num', table 'NORTHWND.dbo.tabl'; column does not allow nulls. INSERT fails.

--Q12
SELECT CustomerID, COUNT(OrderID)
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 10

--Q13

SELECT EmployeeID, BirthDate, DATEADD(YY, DATEDIFF(YY, Birthdate, GETDATE()), Birthdate) AS 'Birthdate this year',
		CASE
			WHEN DATEDIFF(dd, DATEADD(YY, DATEDIFF(YY, Birthdate, GETDATE()), Birthdate), GETDATE()) > 0 THEN 'No need for cake'
			WHEN DATEDIFF(dd, DATEADD(YY, DATEDIFF(YY, Birthdate, GETDATE()), Birthdate), GETDATE()) < 0 THEN 'Remember to buy cake'
		END
FROM Employees

--Q14

SELECT TOP 5 OD.ProductID, P.ProductName, COUNT(O.OrderID) AS 'Number of orders', CAST(SUM(OD.UnitPrice*OD.Quantity*(I-OD.Discount)) AS 'Total Sales'
FROM [Order Details] OD INNER JOIN Orders O ON OD.OrderID = O.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID
INNER JOIN [dbo].[Categories] C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Dairy Products'
GROUP BY OD.ProductID, P.ProductName
ORDER BY 4 DESC

--Q15

SELECT Country, COUNT(C.CustomerID) AS 'Number of customers', COUNT(O.OrderID) AS
'Number of orders',
MAX(O.OrderDate) AS 'Latest order date',
ROUND(MAX(OD.UnitPrice*OD.Quantity*(1-OD.Discount)),O) AS 'Largest single order'
FROM Customers C LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
LEFT JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY Country
HAVING Country IN ('Belgium', 'France', 'Portugal', 'Spain')

--16
SELECT E.EmployeeID , E.FirstName+' '+E.LastName, DATENAME(DW, ShippedDate) AS 'Day of Week', COUNT(O.OrderID) AS 'Number of orders',
ROUND(CAST(COUNT(O.OrderID)*100 as float)/(SELECT CAST(COUNT(*) AS float) FROM Orders WHERE DATENAME(DW, ShippedDate) ='Friday'),2) AS '% of total'
FROM Orders O LEFT JOIN Employees E ON E.EmployeeID = O.EmployeeID 
WHERE DATENAME(DW, ShippedDate) = 'Friday'
GROUP BY E.EmployeeID , E.FirstName+' '+E.LastName, DATENAME(DW, ShippedDate)
ORDER BY 4 DESC