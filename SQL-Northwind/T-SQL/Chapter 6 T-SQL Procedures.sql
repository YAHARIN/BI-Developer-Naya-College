--Procedures

--Q1

CREATE PROCEDURE My_First_SP
AS
BEGIN
	SELECT c.CategoryName, p.ProductName
	FROM Products p inner join Categories c
	on c.CategoryID = p.CategoryID
END
GO

EXEC My_First_SP
GO

--Q2

CREATE PROCEDURE emp_orders_pro
@emp_num INT
AS 
BEGIN
	SELECT O.EmployeeID, OD.OrderID
	FROM Orders as O INNER JOIN [Order Details] as OD
	ON O.OrderID = OD.OrderID
	WHERE O.EmployeeID = @emp_num
END
GO

EXEC emp_orders_pro 1
GO

--Q3
CREATE PROCEDURE cat_prods_pro
@cat_num INT
AS 
BEGIN
	SELECT P.CategoryID, P.ProductName
	FROM Products as P
	WHERE P.CategoryID = @cat_num
END
GO

EXEC cat_prods_pro 1
GO

--Q4
CREATE PROCEDURE birth_emp_SP
@emp_date DATE 
AS 
BEGIN
	SELECT EmployeeID, FirstName, LastName, BirthDate
	FROM Employees
	WHERE BirthDate > @emp_date
END
GO

EXEC birth_emp_SP '1960-01-01'
GO

--Q5
CREATE PROCEDURE pro_amount_SP
@sup_num INT
AS 
BEGIN
	DECLARE @amount INT

	SELECT @amount = COUNT(*)
	FROM Products
	WHERE SupplierID = @sup_num

	IF @amount > 20
		PRINT '> 20'
	ELSE
		PRINT '< 20'
	
END
GO

EXEC pro_amount_SP 1
GO

--Q6
CREATE PROCEDURE avg_cat_SP
@pro_num INT
AS 
BEGIN
	DECLARE @cat_id INT,@unitprice INT, @avg INT
	
	SELECT @cat_id = CategoryID	, @unitprice = UnitPrice
	FROM Products
	WHERE ProductID = @pro_num

	SELECT @avg = AVG(UnitPrice)
	FROM Products
	WHERE @cat_id = CategoryID

	IF @unitprice > @avg
		PRINT 'unitprice > avg'
	ELSE
		PRINT 'unitprice < avg'	
END
GO

EXEC avg_cat_SP 1
GO

--Q7

CREATE PROCEDURE order_amount_SP
@emp_num INT
AS 
BEGIN
	SELECT EmployeeID, COUNT(OrderID) as 'NumOfOrders'
	FROM Orders
	WHERE EmployeeID = @emp_num
	GROUP BY EmployeeID

END
GO

EXEC order_amount_SP 1
GO

--Another sulotion? 
CREATE PROCEDURE order_amount__SP
@emp_num INT
AS 
BEGIN
	DECLARE @amount INT
	SELECT @amount = COUNT(OrderID)
	FROM Orders
	WHERE EmployeeID = @emp_num

	SELECT @amount
END
GO

EXEC order_amount_SP 1
GO

--Q8
CREATE PROCEDURE order_amount_print_SP
@emp_num INT
AS 
BEGIN
	DECLARE @amount INT
	SELECT @emp_num = EmployeeID, @amount = COUNT(OrderID)
	FROM Orders
	WHERE EmployeeID = @emp_num
	GROUP BY EmployeeID

	PRINT @emp_num + ' ' + @amount
END
GO

EXEC order_amount_print_SP 1
GO

--Q9
CREATE PROCEDURE order_amount_if_SP
@emp_num INT
AS 
BEGIN
	DECLARE @amount INT
	SELECT @emp_num = EmployeeID, @amount = COUNT(OrderID)
	FROM Orders
	WHERE EmployeeID = @emp_num
	GROUP BY EmployeeID

	PRINT @emp_num + ' ' + @amount
	
	IF @amount > 40
		PRINT ' > 40 '
END
GO

EXEC order_amount_if_SP 5
GO

--Q10
CREATE PROCEDURE order_amount_star_SP
@emp_num INT
AS 
BEGIN
	DECLARE @amount INT, @counter INT, @v_star varchar(10) = ''
	SELECT @emp_num = EmployeeID, @amount = COUNT(OrderID)
	FROM Orders
	WHERE EmployeeID = @emp_num
	GROUP BY EmployeeID
	
	SET @counter = @amount / 10

	WHILE @counter > 0
		BEGIN
			SET @v_star = @v_star + '*' 
			SET @counter = @counter - 1
		END
		PRINT @v_star	
END
GO

EXEC order_amount_star_SP 5
GO

--Q11
CREATE PROCEDURE output_SP
@prod_num INT, @prod_name varchar(25) OUTPUT

AS 
BEGIN
	SELECT @prod_name = ProductName
	FROM Products
	WHERE @prod_num = ProductID
	
END
GO

DECLARE @ans varchar(25)
EXEC output_SP 2, @ans OUTPUT
PRINT @ans
GO

--Q12
CREATE PROCEDURE emp_birth_output_SP
@emp_num INT, @emp_name varchar(40) OUTPUT, @emp_birth DATE OUTPUT
AS 
BEGIN
	SELECT @emp_name = FirstName + ' ' + LastName, @emp_birth = BirthDate
	FROM Employees
	WHERE @emp_num = EmployeeID
END
GO

DECLARE @ans_name varchar(20), @ans_date DATE
EXEC emp_birth_output_SP 5,@ans_name OUTPUT,  @ans_date OUTPUT

PRINT @ans_name + ' ' +  CAST(@ans_date as varchar)
GO

--Q13 + Q14
CREATE PROCEDURE prod_det_details 
@prod_num INT, @prod_name varchar(20) OUTPUT, @cat varchar(20)OUTPUT

AS 
BEGIN

	SELECT @prod_name = P.ProductName, @cat = C.CategoryName
	FROM Products as P INNER JOIN Categories as C
	ON P.CategoryID = C.CategoryID
	WHERE @prod_num = P.ProductID
	
END
GO
DECLARE @productname varchar(20)
DECLARE @categoryname varchar(20)

EXEC prod_det_details 6, @productname OUTPUT, @categoryname OUTPUT

PRINT 'Product name is: ' + @productname
PRINT 'Category name is: ' + @categoryname

GO

--Q15
CREATE PROCEDURE top_price_SP 
AS 
BEGIN
	SELECT TOP 10 ProductID,ProductName, UnitPrice
	FROM Products
	ORDER BY UnitPrice DESC 
END
GO
 
EXEC top_price_SP 
GO

--Q16
CREATE PROCEDURE top_price_n_SP @top_n INT 
AS 
BEGIN
	SELECT TOP(@top_n) ProductID,ProductName, UnitPrice
	FROM Products
	ORDER BY UnitPrice DESC 
END
GO
 
EXEC top_price_n_SP 5 
GO

--Q17
CREATE PROCEDURE emp_det_SP
@emp_num INT

AS 
BEGIN
	DECLARE @ln varchar(25), @bd DATE, @city varchar(20)

	SELECT @ln = LastName,@bd =  BirthDate, @city = City
	FROM Employees
	WHERE @emp_num = EmployeeID
	IF @ln LIKE '%a%'
		PRINT @ln + ' ' + CAST(@bd as varchar(20)) + ' ' + @city
	ELSE
		PRINT 'Employee Number: ' + CAST(@emp_num as varchar(10)) + ', Has No Letter A'	
END
GO

EXEC emp_det_SP 4
GO

EXEC emp_det_SP 7
GO

--Q18
CREATE PROCEDURE cust_det_SP
@cust_id NCHAR(5)

AS 
BEGIN
	SELECT CompanyName, Country, Address
	FROM Customers
	WHERE @cust_id = CustomerID
END
GO

EXEC cust_det_SP 'ALFKI'
GO

--Q19
CREATE PROCEDURE cust_det_up_SP
@cust_id NCHAR(5)

AS 
BEGIN
	DECLARE @cn varchar(20), @country varchar(20), @addr varchar(20)
	SELECT @cn = CompanyName, @country = Country, @addr = Address
	FROM Customers
	WHERE @cust_id = CustomerID
	IF @country = 'MEXICO'
		PRINT 'Client ' + @cust_id + ' IS MEXICAN'
	ELSE IF @country= 'GERMANY'
		PRINT 'Client ' + @cust_id + ' IS GERMAN'

	ELSE
		PRINT @cust_id + ' '+ @country + ' ' + @addr
END
GO

EXEC cust_det_up_SP 'ALFKI'
GO
EXEC cust_det_up_SP 'ANTON'
GO
EXEC cust_det_up_SP 'BERGS'
GO

--Q20
CREATE PROCEDURE all_orders_SP
@cust_code varchar(20) 

AS 
BEGIN
	DECLARE @count_orders INT
	SELECT @count_orders = COUNT(OrderID)
	FROM Orders
	WHERE @cust_code = CustomerID
	IF @count_orders > 10
		PRINT '>10'
	ELSE
		SELECT *
		FROM Orders
		WHERE @cust_code = CustomerID
END
GO

EXEC all_orders_SP 'ALFKI'
GO

EXEC all_orders_SP 'BERGS'
GO