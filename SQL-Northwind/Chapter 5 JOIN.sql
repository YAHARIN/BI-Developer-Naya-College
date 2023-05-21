--Chapter 5
--Q1
SELECT Products.ProductName, Categories.CategoryName
FROM Products INNER JOIN Categories 
ON  Products.CategoryID = Categories.CategoryID

--Q2, 6, 10
SELECT p.ProductName, s.CompanyName
from Products as p
join Suppliers as s
on p.SupplierID = s.SupplierID
WHERE s.SupplierID = 3


SELECT p.ProductName, c.Description, s.City
from Products as p
join Suppliers as s
on p.SupplierID = s.SupplierID
join Categories as c
on p.CategoryID = c.CategoryID
WHERE s.City = 'London' OR s.City = 'Tokyo'

--Q3
SELECT O.OrderID, C.CompanyName
FROM Orders as O INNER JOIN Customers as C 
ON O.CustomerID = C.CustomerID
WHERE C.CompanyName like 'a%' 

--Q4
SELECT R.RegionDescription, T.TerritoryDescription
FROM Region as R INNER JOIN Territories as T
ON R.RegionID = T.RegionID

--Q5
SELECT P.ProductName, C.CategoryName
FROM Products as P INNER JOIN Categories as C
ON P.CategoryID = C.CategoryID
WHERE P.UnitPrice > 50

--Q6 - UP

--Q7
SELECT P.ProductName, C.CategoryName, S.CompanyName
FROM Products as P INNER JOIN Categories as C
ON P.CategoryID = C.CategoryID
INNER JOIN Suppliers as S 
ON P.SupplierID = S.SupplierID

--Q8
SELECT C.CompanyName, O.OrderID
FROM Customers as C LEFT JOIN Orders as O
ON C.CustomerID = O.CustomerID

--Q9
SELECT p.ProductName, s.CompanyName
from Products as p
join Suppliers as s
on p.SupplierID = s.SupplierID
WHERE s.Country like 'a%'

--Q10 - UP

--Q11
SELECT O.OrderID, O.OrderDate, O.ShipAddress, C.CustomerID, C.CompanyName ,C.Phone
FROM Orders as O INNER JOIN Customers as C
ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = 1996 AND O.CustomerID Like '[AC]%'

--Q12

SELECT O.OrderID, O.OrderDate, O.ShipAddress, C.CustomerID, C.CompanyName ,C.Phone, E.FirstName, E.LastName
FROM Orders as O INNER JOIN Customers as C
ON O.CustomerID = C.CustomerID
INNER JOIN Employees as E 
ON E.EmployeeID = O.EmployeeID
WHERE YEAR(O.OrderDate) = 1996 AND O.CustomerID Like '[AC]%'
ORDER BY 2 DESC

--Q13
SELECT E.LastName, M.LastName
FROM Employees as E LEFT JOIN Employees M
ON E.ReportsTo = M.EmployeeID

--Q14
SELECT E.EmployeeID
FROM Employees as E INNER JOIN Employees as O
ON E.LastName = 'Suyama' AND E.BirthDate < O.BirthDate

SELECT E.EmployeeID
FROM Employees as E INNER JOIN Employees as O
ON E.BirthDate < O.BirthDate
WHERE E.LastName = 'Suyama' 

--Q15
SELECT C.CustomerID, AVG(O.Freight)
FROM Customers as C LEFT JOIN Orders as O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID

--Q16
SELECT TOP 1 C.CustomerID, SUM(O.Freight)
FROM Customers as C INNER JOIN Orders as O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID
ORDER BY 2 DESC

--Q17
SELECT O.OrderID, COUNT(OD.ProductID) 'Products Quantity'
FROM Orders as O LEFT JOIN [Order Details] as OD
ON O.OrderID = OD.OrderID
GROUP BY O.OrderID
ORDER BY 1

--Q18
SELECT P.ProductName, P.UnitPrice, C.CategoryName, S.CompanyName, S.SupplierID
FROM Products as P INNER JOIN Categories as C
ON P.CategoryID = C.CategoryID
INNER JOIN Suppliers as S 
ON P.SupplierID = S.SupplierID
WHERE S.SupplierID IN (2,16,29) 

--Q19

SELECT O.OrderID, S.CompanyName, C.CompanyName, P.ProductName, SUM(OD.UnitPrice * OD.Quantity * (1 - Discount)) Revenue
FROM Orders O
INNER JOIN Shippers S ON S.ShipperID = O.ShipVia
INNER JOIN Customers C ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
INNER JOIN Products P ON P.ProductID = OD.ProductID
WHERE (OD.UnitPrice * OD.Quantity * (1 - Discount)) > 50
GROUP BY O.OrderID, S.CompanyName, C.CompanyName, P.ProductName
ORDER BY O.OrderID

--Q20
SELECT P.ProductID, P.ProductName, P.ProductName, P.UnitPrice
FROM Products as P INNER JOIN Products as PC
ON P.UnitPrice > PC.UnitPrice
WHERE PC.ProductName = 'Chang'


