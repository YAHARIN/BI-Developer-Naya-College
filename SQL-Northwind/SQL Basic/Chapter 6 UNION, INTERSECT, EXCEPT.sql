--Chapter 6
--Q1
SELECT City, 'C' as Category
FROM Customers
UNION
SELECT City, 'S' as Category
FROM Suppliers
ORDER BY City

--Q2
SELECT City, 'C' as Category
FROM Customers
UNION ALL
SELECT City, 'S' as Category
FROM Suppliers
ORDER BY Category, City

--Q3
SELECT City, 'C' as Category
FROM Customers
WHERE Country = 'Germany'
UNION
SELECT City, 'S' as Category
FROM Suppliers
WHERE Country = 'USA'
ORDER BY City

--Q4
SELECT CustomerID
FROM Customers
EXCEPT 
SELECT CustomerID
FROM Orders

--Q5
SELECT CustomerID
FROM Customers
INTERSECT 
SELECT CustomerID
FROM Orders

--Q6
SELECT ProductID
FROM Products
EXCEPT
SELECT ProductID
FROM [Order Details] OD
INNER JOIN Orders O 
ON OD.OrderID = O.OrderID
WHERE YEAR(OrderDate) = 1996

