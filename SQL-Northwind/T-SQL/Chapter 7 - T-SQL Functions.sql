--Chapter 7: Functions

--Q1 - Scalar Function
CREATE FUNCTION get_ln (@emp_id INT)
RETURNS varchar(20)
AS 
	BEGIN
		DECLARE @ln varchar(20)
		SELECT @ln = LastName
		FROM Employees
		wHERE EmployeeID = @emp_id
		RETURN @ln			
	END
GO

SELECT dbo.get_ln(3)
Go

--Q2 - Scalar Function
CREATE FUNCTION get_prod(@prod_id INT)
RETURNS varchar(20)
AS 
	BEGIN
		DECLARE @prod_name varchar(20)

		SELECT  @prod_name = ProductName
		FROM Products
		WHERE @prod_id = ProductID

		RETURN @prod_name			
	END
GO

SELECT dbo.get_prod(3)
Go


--Q3 - Scalar Function

CREATE FUNCTION get_email(@emp_id INT)
RETURNS varchar(25)
AS 
	BEGIN
		DECLARE @email varchar(25), @fn varchar(20), @ln varchar(20)
		SELECT @fn = FirstName,@ln = LastName
		FROM Employees
		WHERE @emp_id = EmployeeID
		SET @email = @fn + @ln+ '@gmail.com'
		RETURN @email
	END
GO

SELECT dbo.get_email(3)
Go

--Q4 - Scalar Function
CREATE FUNCTION get_phone(@cust_id varchar(15))
RETURNS varchar(15)
AS 
	BEGIN
		DECLARE
			@phone_num nvarchar(24)
			SELECT @phone_num = Phone
			FROM Customers
			WHERE CustomerID = @cust_id

			SET @phone_num = REPLACE(@phone_num, '(','')
			SET @phone_num = REPLACE(@phone_num,')', '')
			SET @phone_num = REPLACE(@phone_num, '-', '')
			SET @phone_num = REPLACE(@phone_num, '','')
		RETURN @phone_num	
	END
GO

SELECT dbo.get_phone('AROUT')
Go

--Q5 - Scalar Function
CREATE FUNCTION prod_exsist(@prod_id INT)
RETURNS BIT
AS 
	BEGIN
		DECLARE @res BIT	
		SELECT @prod_id = ProductID
		FROM Products
		WHERE EXISTS(SELECT ProductID FROM Products WHERE ProductID = @prod_id)
		
		IF EXISTS(SELECT ProductID FROM Products WHERE ProductID = @prod_id)
			SET @res = 1
		ELSE 
			SET @res = 0
		RETURN @res		
	END
GO

SELECT dbo.prod_exsist(111)
GO

--Another Solution
CREATE FUNCTION dbo.check_product_fun(@p_productid int)
RETURNS bit
AS
BEGIN
	DECLARE
	@v_check int,
	@v_result int
	
	SELECT @v_check = ProductID
	FROM Products
	WHERE ProductID = @p_productid
	IF @v_check IS NULL
		SET @v_result = 0
	ELSE
		SET @v_result = 1
	RETURN @v_result
END
GO

select dbo.check_product_fun(111)
GO

--part b: procedure

CREATE PROCEDURE update_price 
(@prod_id INT)
AS 
BEGIN
	IF dbo.check_product_fun(@prod_id) = 1
		BEGIN
		UPDATE Products
		SET UnitPrice = UnitPrice + 1
		WHERE ProductID = @prod_id
		END
	ELSE
		PRINT 'No such product.'
	
END
GO

EXEC update_price 1
GO


--Q6

CREATE FUNCTION dbo.break_text
(@p_name varchar(25))
RETURNS varchar(300)
AS
BEGIN
DECLARE
	@v_partname varchar(300),
	@v_name_length int,
	@v_counter int
	SET @v_partname = ''
	SET	@v_name_length = LEN(@p_name)
	SET @v_counter = 1
	WHILE @v_counter <= @v_name_length
		BEGIN
			--CHAR(13) is for droping a line in the printing
			SET @v_partname = @v_partname + SUBSTRING(@p_name , 1 , @v_counter) + CHAR(13)
			SET @v_counter = @v_counter + 1
		END
	RETURN @v_partname
END
GO

PRINT dbo.break_text('RAM')
GO
	
--Q7 - In Line TVF

CREATE FUNCTION get_cats(@cat_num INT)
RETURNS TABLE 
AS 
	RETURN (SELECT CategoryID, UnitsInStock
			FROM Products
			WHERE CategoryID = @cat_num) 			
GO

SELECT * 
FROM dbo.get_cats(2)
Go

--Q8 - In Line TVF
CREATE FUNCTION today_date_f(@date DATETIME)
RETURNS varchar(10) 
AS 
	BEGIN
		DECLARE @new_date varchar(10)
		SET @new_date =  CONVERT(varchar(10), @date, 103)	
		RETURN @new_date
	END
GO

--SELECT dbo.today_date_f(GETDATE())
--Go

--Function Check - a
SELECT FirstName, HireDate, dbo.today_date_f(HireDate)
FROM Employees
--Function Check - b
DECLARE @res varchar(10)
SET @res = dbo.today_date_f(GETDATE())
PRINT @res
GO


--Q9
CREATE FUNCTION user_name_f(@fn varchar(20), @ln varchar(20))
RETURNS varchar(20)
AS 
	BEGIN
		RETURN LOWER(@fn + LEFT(@ln, 1)) 		
	END
GO

--Function Check 
SELECT EmployeeID, dbo.user_name_f(FirstName, LastName)
FROM Employees
GO

--Q10

CREATE FUNCTION user_name_email(@user_name varchar(20))
RETURNS varchar(20)
AS 
	BEGIN
		RETURN @user_name + '@naya.com' 
	END
GO

--Function Check
SELECT EmployeeID, dbo.user_name_f(FirstName, LastName), dbo.user_name_email(dbo.user_name_f(FirstName, LastName)) as UserName, GETDATE() as CreationDate 
FROM Employees
GO

--Q11

--My solution - not exacly what was in the answers - do this exercise again

CREATE FUNCTION order_list(@prod_name varchar(40))
RETURNS INT
AS 
	BEGIN 
		DECLARE @orders INT 
		SELECT @orders = COUNT(DISTINCT O.CustomerID)
		FROM Orders as O INNER JOIN [Order Details] as OD
		ON O.OrderID = OD.OrderID
		WHERE OD.ProductID = (SELECT ProductID FROM Products WHERE @prod_name = ProductName)
		RETURN @orders		
	END
GO

SELECT ProductName, dbo.order_list(ProductName)
FROM Products
GO

--Q12
CREATE FUNCTION disc_f(@disc BIT)
RETURNS varchar(20)
AS 
	BEGIN
		DECLARE @cat varchar(20)
		IF @disc = 0
			SET @cat = 'Discontinued'
		ELSE
			SET @cat = 'Active'
		RETURN 	@cat	
	END
GO

SELECT *, dbo.disc_f(Discontinued) as Category
FROM Products
GO

--Q13
CREATE FUNCTION OrderInfo(@order_id INT)
RETURNS TABLE
AS 
	RETURN (SELECT O.OrderID, C.CompanyName, E.FirstName + ' ' + E.LastName as FullName, ROUND(SUM(OD.UnitPrice * OD.Quantity * (1-OD.Discount)),2) as OrderSum, CONVERT(varchar(20), O.OrderDate, 103) as OrderDate
			FROM Orders as O INNER JOIN Customers as C
			ON O.CustomerID = C.CustomerID
			INNER JOIN Employees as E
			ON O.EmployeeID = E.EmployeeID INNER JOIN [Order Details] as OD
			ON O.OrderID = OD.OrderID
			WHERE O.OrderID = @order_id
			GROUP BY O.OrderID, C.CompanyName, E.FirstName + ' ' + E.LastName, O.OrderDate
			)			
GO

SELECT *
FROM dbo.OrderInfo(10249)
GO