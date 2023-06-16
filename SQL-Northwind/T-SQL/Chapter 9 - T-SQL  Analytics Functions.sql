--Chapter 9: Analytics Functions/Window Functions

--Q1
SELECT ROW_NUMBER() OVER(ORDER BY UnitPrice) as 'Row Number', ProductName, UnitPrice
FROM Products

--Q2
SELECT  CategoryID, ROW_NUMBER() OVER(PARTITION BY CategoryID ORDER BY UnitPrice) as 'Row Number', ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 18

--Q3
SELECT  CategoryID, ROW_NUMBER() OVER(PARTITION BY CategoryID ORDER BY UnitPrice) as 'Row Number', ProductName, UnitPrice,
		RANK() OVER(PARTITION BY CategoryID ORDER BY UnitPrice) as rnk,
		DENSE_RANK() OVER(PARTITION BY CategoryID ORDER BY UnitPrice) as dense_rnk
FROM Products
WHERE UnitPrice > 18

--Q4
SELECT ProductName, UnitPrice,
		NTILE(5) OVER(ORDER BY UnitPrice) as '5',
		NTILE(10) OVER(ORDER BY UnitPrice) as '10',
		NTILE(20) OVER(ORDER BY UnitPrice) as '20'
FROM Products

--Q5
SELECT C.CategoryName, PP.ProductName,P.UnitPrice
FROM (
	SELECT ProductID, UnitPrice, CategoryID, RANK() OVER(PARTITION BY CategoryID ORDER BY UnitPrice DESC) as rnk
	FROM Products
) as P INNER JOIN Categories as C ON P.CategoryID = C.CategoryID
INNER JOIN Products PP ON P.ProductID = PP.ProductID
WHERE P.rnk = 1

--Q6
SELECT ProductName, UnitPrice
, LEAD(ProductName, 1 ,'The most Expensive Product') OVER(ORDER BY UnitPrice ASC) AS NextProductName
FROM Products
ORDER BY UnitPrice DESC

--Q7

SELECT ProductName, CategoryID
, LEAD(ProductName, 1,'The Expensive Product in Category -'+CAST(CategoryID AS VARCHAR(1)))
OVER(PARTITION BY CategoryID ORDER BY UnitPrice
ASC) AS NextProductName
FROM Products
ORDER BY CategoryID Asc, UnitPrice DESC

