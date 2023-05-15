--Chapter 4
--Part A

--Q1
SELECT MIN(LastName)
FROM Employees

--Q2
SELECT AVG(UnitPrice)
FROM Products

--Q3
SELECT MAX(LastName)
FROM Employees

--Q4
SELECT COUNT(*)
FROM Employees

--Q5
SELECT COUNT(DISTINCT Country)
FROM Customers

--Q6
SELECT COUNT(Fax)
FROM Customers

--Q7
SELECT COUNT(*)
FROM Customers
WHERE Fax IS NULL

--Q8
SELECT MAX(UnitPrice) 'MAX', MIN(UnitPrice) 'MIN',AVG(UnitPrice) 'AVG'
FROM Products

--Q9
SELECT MAX(BirthDate) 'MAX', MIN(BirthDate) 'MIN'
FROM Employees

--Q10
SELECT COUNT(*) 'Orders', COUNT(DISTINCT CustomerID) 'Customers'
FROM Orders

--Part B
--Q11
SELECT Country, COUNT(CustomerID) CountCust
FROM Customers
GROUP BY Country
ORDER BY CountCust DESC

--Q12
SELECT CategoryID, MAX(UnitPrice) 'MAX', MIN(UnitPrice) 'MIN',AVG(UnitPrice) 'AVG'
FROM Products
GROUP BY CategoryID

--Q13
SELECT Country ,COUNT(DISTINCT City)
FROM Customers
GROUP BY Country

--Q14
SELECT CategoryID, MAX(UnitPrice) 'MAX'
FROM Products
GROUP BY CategoryID

--Q15
SELECT CategoryID, MAX(UnitPrice) 'MAX', MIN(UnitPrice) 'MIN',AVG(UnitPrice) 'AVG'
FROM Products
WHERE CategoryID = 3
GROUP BY CategoryID

--Q16
--A
SELECT CategoryID, COUNT(ProductID)
FROM Products
GROUP BY CategoryID

--B
SELECT CategoryID, COUNT(ProductID) CountP
FROM Products
WHERE UnitsInStock >= 120
GROUP BY CategoryID

--C
SELECT CategoryID, COUNT(ProductID) CountP
FROM Products
GROUP BY CategoryID
HAVING COUNT(ProductID) > 10

--Q17
SELECT Country,City, COUNT(CustomerId)
FROM Customers
WHERE City = 'London'
Group by City, Country

SELECT Country,City, COUNT(CustomerId)
FROM Customers
Group by City, Country
HAVING City = 'London'

--Q18
SELECT CategoryID, AVG(UnitsOnOrder) U_AVG
FROM Products
GROUP BY CategoryID
HAVING AVG(UnitsOnOrder) > 5

--Q19
--A
SELECT CustomerID, COUNT(OrderID) CountOrders, ISNULL(ShipRegion, 'Unknown') Region
FROM Orders
WHERE ShipRegion IS NULL
GROUP BY CustomerID, ISNULL(ShipRegion, 'Unknown')

--B
SELECT CustomerID, COUNT(OrderID) CountOrders, ISNULL(ShipRegion, 'Unknown') Region
FROM Orders
WHERE ShipRegion IS NULL
GROUP BY CustomerID, ISNULL(ShipRegion, 'Unknown')
HAVING COUNT(OrderID) > 10

--Q20
SELECT Region, City, COUNT(CustomerId) COUNT_CUSTOMER
FROM Customers
WHERE (City like '%M%' OR City like'%L%') AND Region IS NOT NULL
GROUP BY Region, City
HAVING COUNT(CustomerId) >=2