--Chapter 4 T-SQL Programing

--Part A: Variables 

--Q1

DECLARE @var1 VARCHAR(20), @var2 VARCHAR(20)
SET @var1 = 'Hwllo'
SET @var2 = 'World'

--Q2
DECLARE @var3 VARCHAR(20), @var_date DATE
SET @var3 = 'The Current Date is: '
SET @var_date = GETDATE()

--Q3

DECLARE @emp_idd INT, @fn VARCHAR(20), @ln VARCHAR(20), @birth_date DATE

SELECT @emp_idd = EmployeeID, 
		@fn = FirstName,
		@ln = LastName,
		@birth_date = BirthDate
FROM Employees
WHERE EmployeeID = 5

PRINT @emp_idd 
PRINT @fn + ' ' + @ln
PRINT  @birth_date

--Q4
DECLARE @comp_name VARCHAR(25), @city_var VARCHAR(25)

SELECT @comp_name = CompanyName,@city_var = City
FROM Suppliers
WHERE SupplierID = 2

PRINT @comp_name
PRINT @city_var

--Q5

DECLARE @prod_name VARCHAR(25), @category_var VARCHAR(25)

SELECT @prod_name = ProductName, @category_var = P.CategoryID
FROM Products P JOIN Categories C
ON P.CategoryID = C.CategoryID
WHERE P.ProductID = 1

PRINT @prod_name
PRINT @category_var

--Q6
DECLARE @cust_code VARCHAR(25), @comp_name_var VARCHAR(25), @cust_city VARCHAR(25)

SET @cust_code = 'ANATR'

SELECT @comp_name_var = CompanyName, @cust_city = City
FROM Customers
WHERE @cust_code = CustomerID

PRINT @comp_name_var
PRINT @cust_city

--Q7
DECLARE @cat_var INT, @avg INT
SET @cat_var = 5

SELECT @avg = (UnitPrice)
FROM Products
WHERE CategoryID = @cat_var

PRINT @avg

--Q8

DECLARE @prod_id INT, @prod_name_v VARCHAR(25), @comp_v VARCHAR(25)

SET @prod_id = 2

SELECT @prod_name_v = ProductName, @comp_v = S.CompanyName
FROM Products P JOIN Suppliers S
ON P.SupplierID = S.SupplierID
WHERE P.ProductID = @prod_id

PRINT @prod_name_v
PRINT @comp_v

--Q9

DECLARE @cust_code_v VARCHAR(25), @orders_counter INT

SET @cust_code_v = 'BOLID'

SELECT @orders_counter = COUNT(*)
FROM Customers C JOIN Orders O
ON C.CustomerID = O.CustomerID
WHERE C.CustomerID = @cust_code_v

PRINT @orders_counter


--Part B: Temp Tables

CREATE TABLE #TempProducts
(
	ProductName NVARCHAR(40),
	UnitslnStock INT,
	UnitsOnOrder INT
)

DECLARE @cat_id INT = FLOOR(RAND()*(10)) 
INSERT INTO #TempProducts
SELECT ProductName, UnitsInStock, UnitsOnOrder
FROM Products
WHERE CategoryID = @cat_id

SELECT * 
FROM #TempProducts
GO

-- #TempProducts was deleted after session closed


--Part C: IF...ELSE

--Q1

DECLARE @prod_id INT = 3, @unit_price INT 
SELECT @prod_id = ProductID, @unit_price = UnitPrice
FROM Products
WHERE @prod_id = ProductID
IF @unit_price > 20
	PRINT '> 20'
ELSE IF @unit_price < 20
	PRINT '< 20'
ELSE 
	PRINT '= 20'
GO
--Q2

DECLARE @cat_id INT = 4, @unit_stock INT 
SELECT @unit_stock = SUM(UnitsInStock)
FROM Products
WHERE @cat_id = CategoryID
IF @unit_stock > 200
	PRINT '> 200'
ELSE IF @unit_stock < 200
	PRINT '< 200'
ELSE 
	PRINT '= 200'
GO
--Q3

DECLARE @cat_name varchar = '', @avg_up INT
SELECT @avg_up = AVG(UnitPrice)
FROM Products as P INNER JOIN Categories as C
ON P.CategoryID = C.CategoryID
WHERE @cat_name = C.CategoryName
IF @avg_up > 20
	PRINT '> 20'
ELSE IF @avg_up < 20
	PRINT '< 20'
ELSE 
	PRINT '= 20'
GO

--Q4
DECLARE @pro_id INT = 11, @unit_price INT
SELECT @unit_price = UnitPrice
FROM Products
WHERE @pro_id = ProductID
IF @unit_price > 50
	PRINT 'The price is above market value'
ELSE
	PRINT 'The price is below market value'
GO

--Q5
DECLARE @prod_name Varchar(20) = 'Chang', @prod_price INT 
SELECT @prod_price = UnitPrice
FROM Products
WHERE ProductName = @prod_name
IF @prod_price < 20
	SET @prod_price = @prod_price + @prod_price * 0.1
ELSE IF @prod_price >= 20 AND @prod_price < 40
	SET @prod_price = @prod_price + @prod_price * 0.2
ELSE IF @prod_price >= 40
	SET @prod_price = @prod_price + @prod_price * 0.5

PRINT @prod_price
GO

--In the answers it was done with PRINT command wraped in BEGIN ... END

--Part D: WHILE

--Q1
DECLARE @num INT = 1
WHILE @num <= 10
	BEGIN
		IF @num % 2 = 0
			BEGIN 
				PRINT 'even'
			END
		ELSE
			BEGIN 
				PRINT 'odd'
			END 
		SET @num = @num + 1
	END
GO

--Q2
DECLARE @num INT = 1
WHILE @num <= 7
	BEGIN
		PRINT CAST( @num as varchar(10))
		IF @num = 7
			BEGIN 
				PRINT '7 IS BAD LUCK'
			END
		SET @num = @num + 1
	END
GO

--Q3

DECLARE @num int
SET @num = 1
WHILE (@num <= 10)
	BEGIN
		PRINT @num
		SET @num = @num +1
		IF @num <7
			CONTINUE
		ELSE
			PRINT 'This number is greater than 7'
	END
GO

--Q4
Declare @lastname varchar(20) , @Empld int, @MaxEmplD int;
set @Empld = (select MIN(employeeId) from employees)
set @MaxEmplD = (select MAX(employeeId) from employees)
While @Empld <= @MaxEmplD
	Begin
		Select @lastname = lastname
		from Employees
		where EmployeeID = @Empld
		If @lastname like '%E%'
			Print @lastname
		Else
			Print @lastname+ ': ' + 'The Last Name Does Not Contain The Letter E' Set @Empld = @Empld + 1
	End;




