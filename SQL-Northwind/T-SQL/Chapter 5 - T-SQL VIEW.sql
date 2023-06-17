--Chapter 5: VIEW

--Q1
CREATE VIEW Prod_View
AS
SELECT ProductName, UnitPrice,UnitsInStock, UnitsOnOrder
FROM Products
WHERE UnitsInStock >= 10
GO 

SELECT *
FROM Prod_View
GO

--Q2
CREATE VIEW OrderCustDetails_View
AS
SELECT C.CompanyName, COUNT(O.OrderID) as OrderNum
FROM Customers C JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName
GO 

SELECT *
FROM OrderCustDetails_View
GO

--Q3
SELECT TOP 10 *
FROM OrderCustDetails_View
ORDER BY OrderNum DESC
GO

--Q4
CREATE VIEW Prod_Stock_View
AS
SELECT ProductID, ProductName, UnitPrice, UnitsInStock - UnitsOnOrder as UpdStock
FROM Products
WHERE UnitPrice >= 20
GO

SELECT *
FROM Prod_Stock_View
GO

--Q5
--a
UPDATE Prod_Stock_View
SET ProductName = 'Sushi'
WHERE ProductiD = 17
GO

--b
UPDATE Prod_Stock_View
SET UnitPrice = 19.5
WHERE ProductiD = 17
GO

--C
SELECT *
FROM Prod_Stock_View
WHERE ProductiD = 17
GO
--No, Becouse UnitPrice is 19.5 now on Products and its not bigger than 20 (condition)

--d
UPDATE Prod_Stock_View
SET UpdStock = 19
WHERE ProductID = 1

--ERROR 'Update or insert of view or function 'Prod_Stock_View' failed because it contains a derived or constant field.'