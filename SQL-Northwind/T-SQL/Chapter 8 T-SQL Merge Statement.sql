--Chapter 8: Merge Statement

--Q1
CREATE TABLE [dbo].[products_30_source](
	[productID] [int] NULL,
	[productName] [nvarchar](40) NOT NULL,
	[unitPrice] [money] NULL,
	[categoryID] [int] NULL,
	[supplierID] [int] NULL
)


CREATE TABLE [dbo].[products_40_destination](
	[productID] [int] NULL,
	[productName] [nvarchar](40) NOT NULL,
	[unitPrice] [money] NULL,
	[categoryID] [int] NULL,
	[supplierID] [int] NULL
)


insert into products_30_source
SELECT productID, productName , unitPrice, categoryID , supplierID
FROM Northwnd.dbo.products
WHERE unitPrice > 30

insert into products_40_destination
SELECT productID, productName , unitPrice, categoryID , supplierID
FROM Northwnd.dbo.products
WHERE unitPrice > 40

--Q2 - Update no merge
UPDATE products_30_source
SET productName = productName + '_source'
WHERE unitPrice > 50

SELECT * FROM products_30_source

--Q3 - Merge
MERGE  products_40_destination as target 
USING products_30_source as source
ON (source.productName = target.productName)
WHEN MATCHED 
	THEN UPDATE  
	SET target.productName = source.productName, target.unitPrice = source.unitPrice
WHEN NOT MATCHED
	THEN INSERT (productID, productName , unitPrice, categoryID , supplierID)
	VALUES (source.productID, source.productName , source.unitPrice, source.categoryID , source.supplierID);


select * from products_30_source
select * from products_40_destination

--Q4 

CREATE TABLE merge_log 
(
	dml_action varchar(55),
	dml_date datetime,
	productID INT,
	ProductName varchar(55),
	unitPrice INT, 
	categoryID INT,
	supplierID INT
)

--Q5
MERGE  products_40_destination as target 
USING products_30_source as source
ON (source.productName = target.productName)
WHEN MATCHED 
	THEN UPDATE  
	SET target.productName = source.productName, target.unitPrice = source.unitPrice
WHEN NOT MATCHED
	THEN INSERT (productID, productName , unitPrice, categoryID , supplierID)
	VALUES (source.productID, source.productName , source.unitPrice, source.categoryID , source.supplierID)
OUTPUT $ACTION, GETDATE(), INSERTED.productID,INSERTED.ProductName, INSERTED.unitPrice,INSERTED.categoryID, INSERTED.supplierID 
INTO merge_log;

