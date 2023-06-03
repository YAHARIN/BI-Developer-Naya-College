--Chapter 3
--Part 1

--Q1
SELECT EmployeeID, LOWER(FirstName), UPPER(LastName)
FROM Employees
WHERE EmployeeID BETWEEN 2 AND 5

--Q2
SELECT FirstName, LastName, lower(LEFT(FirstName,1) + SUBSTRING(LastName,0,4) + '@naya-tech.co.il') as Email
FROM Employees

--Q3
SELECT CompanyName, LEN(CompanyName) as 'Length'
FROM Customers
WHERE LEN(CompanyName) > 7

--Q4
SELECT FirstName,LastName, REPLACE(HomePhone,'555','$$$') as 'New Home Phone'
FROM Employees
WHERE HomePhone like '%555%'

SELECT FirstName,LastName, REPLACE(HomePhone,'71','$$') as 'New Home Phone'
FROM Employees
WHERE HomePhone like '(71)%'

--Q5
SELECT CustomerID, LEFT(CompanyName,4) as 'New Company Name'
FROM Customers
WHERE CompanyName like 'a%'

--Q6
SELECT LastName, REVERSE(LastName) as 'Reverse LN'
FROM Employees
WHERE ReportsTo IS NOT NULL

--Q7
SELECT ProductID, UPPER(ProductName) as Product
FROM Products
WHERE ProductID NOT BETWEEN 10 AND 30 
ORDER BY ProductName  

--Q8
SELECT CompanyName, CHARINDEX('s', CompanyName, 7) AS 'Location 7', CHARINDEX('s', CompanyName, 1) AS 'Location 1'
FROM Customers
WHERE CompanyName like '%s%' AND CHARINDEX('s', CompanyName, 7) <> CHARINDEX('s', CompanyName, 1) 

--Q9
SELECT FirstName + ' ' + LastName as EName, FirstName + LEFT(LastName, 1) as 'User Name'
FROM Employees
WHERE FirstName like 'a%' OR LastName like '%g'

--Q10
SELECT REPLACE(QuantityPerUnit, '-', '=')
FROM Products
WHERE QuantityPerUnit like '%-%'

--Part B
--Q11
SELECT ProductName, UnitPrice, UnitPrice + UnitPrice*0.18 as 'UP 18%', ROUND(UnitPrice + UnitPrice*0.187, 2) as 'UP 18.7% 2', FLOOR(UnitPrice + UnitPrice*0.187) as 'FLOOR 18.7%', ROUND(UnitPrice + UnitPrice*0.187, 0) as 'UP 18.7%'
FROM Products
WHERE UnitPrice IS NOT NULL 
ORDER BY UnitPrice

--Part C
--Q12
SELECT GETDATE()

--Q13
SELECT FirstName, MONTH(HireDate) as 'Month', YEAR(HireDate) as 'Year'
FROM Employees

--Q14
SELECT FirstName, HireDate, HireDate - 10 as '-10 DAYS', DATEADD(month, 1, HireDate) as '+1 MONTH', DATEDIFF(day, HireDate, GETDATE()) as 'DIFF'
FROM Employees

--Q15
SELECT FirstName, HireDate, DATEADD(YEAR, DATEDIFF(YEAR, HireDate, GETDATE()), HireDate) as 'Evaluation Date'
FROM Employees

--Q16

SELECT FirstName, BirthDate, DATEDIFF(YEAR, BirthDate, GETDATE()) as Age
FROM Employees
WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) >= 50

--Q17
SELECT FirstName, BirthDate
FROM Employees
WHERE MONTH(BirthDate) = MONTH(GetDate()) AND DAY(BirthDate) = MONTH(GetDate()) 

--Q18
SELECT FirstName
FROM Employees
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) = 5 AND MONTH(HireDate) = MONTH(GetDate()) AND DAY(HireDate) = MONTH(GetDate())

--Q19
SELECT OrderDate, DATENAME(weekday,OrderDate), DATENAME(month,OrderDate), DATEPART(year, OrderDate)
FROM Orders
WHERE DATENAME(weekday,OrderDate) IN ('Sunday', 'Monday', 'Friday')

--Q20
SELECT OrderID, OrderDate, RequiredDate, DATEPART(Q, OrderDate) AS QDate
FROM Orders
WHERE DATEPART(Q, OrderDate) = 3

--Q21
SELECT OrderDate, ShippedDate, DATEDIFF(DAY, OrderDate, ShippedDate) as LATE
FROM Orders
WHERE DATEDIFF(DAY, OrderDate, ShippedDate) >= 15
ORDER BY LATE

--Part 4
--Q22
SELECT FirstName + ' ' + CAST(HireDate as varchar) as 'New Name', LastName +' ' +  CAST(Extension as varchar) as 'New Last Name'
FROM Employees

--Q23
SELECT LastName, UPPER(Country) + CAST(EmployeeID as varchar(3)) as 'C+N', CAST(HireDate as varchar(20)) + '  ' + CAST(BirthDate as varchar(20)) as 'New Dates'
FROM Employees
--WHERE SUBSTRING(LastName,1,1) = 'A' OR SUBSTRING(LastName,1,1) = 'D'
WHERE SUBSTRING(LastName,1,1) IN ('A','D')

--Q24
SELECT 'The Order Id: ' + CAST(OrderId as varchar) + ' Is From The Date: ' + CONVERT(CHAR,OrderDate, 103) as "Order & Date"
FROM Orders
WHERE OrderID BETWEEN 10249 AND 10431

--Q25
SELECT CustomerID, ContactName, Address, ISNULL(Phone, 'N/A') as Phone, ISNULL(Fax,'N/A') as Fax
FROM Customers
WHERE City = 'London' 

--Q26
SELECT FirstName + ' ' + LastName + ' ' + CONVERT(CHAR, HireDate, 104) as 'Employee Details', ISNULL(CAST(ReportsTo as varchar), 'No Manager') as 'Manager Check' 
FROM Employees
WHERE LEN(FirstName) < LEN(LastName)

--Part 5
--Q27
SELECT OrderID, RequiredDate, ShippedDate,
	CASE 
		WHEN DATEDIFF(day,ShippedDate, RequiredDate) > 0 THEN 'On Time'
		WHEN DATEDIFF(day,ShippedDate, RequiredDate) < 0 THEN 'Late'
		ELSE NULL
	END AS 'Staus'
FROM Orders

SELECT OrderID, RequiredDate, ShippedDate,
	CASE 
		WHEN DATEDIFF(day,ShippedDate, RequiredDate) > 0 THEN 'On Time'
		ELSE 'Late'
	END AS 'Staus'
FROM Orders

--Q28
--Part A
SELECT EmployeeID, FirstName + ' ' + LastName as 'Full Name', DATEDIFF(YEAR, BirthDate, GETDATE()) as Age,
	CASE
		WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) <= 65 THEN 'Adult'
		WHEN  DATEDIFF(YEAR, BirthDate, GETDATE())<= 75 THEN 'Old'
		ELSE 'Very Old'
	END AS 'Age Staus'
FROM Employees
--Part B
SELECT EmployeeID, FirstName + ' ' + LastName as 'Full Name', DATEDIFF(YEAR, BirthDate, GETDATE()) as Age,
	CASE
		WHEN  DATEDIFF(YEAR, BirthDate, GETDATE()) > 70 THEN 'Old'
		WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) > 50 THEN 'Adult'
		ELSE 'Very Old'
	END AS 'Age Staus'
FROM Employees

SELECT EmployeeID, FirstName + ' ' + LastName as 'Full Name', DATEDIFF(YEAR, BirthDate, GETDATE()) as Age,
	CASE
		WHEN  DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 50 AND 69 THEN 'Adult'
		WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 70 AND 79 THEN 'Old'
		ELSE 'Very Old'
	END AS 'Age Staus'
FROM Employees





