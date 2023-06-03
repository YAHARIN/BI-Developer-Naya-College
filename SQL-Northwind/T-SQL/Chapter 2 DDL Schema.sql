--Chapter 2 DDL Schema

--Q1
CREATE SCHEMA PetStore
GO

--Q2 

CREATE TABLE PetStore.Owner (
	OwnerID INT IDENTITY(1,1) PRIMARY KEY,
	OwnerName nvarchar(30) NOT NULL,
	HairColor nvarchar(10) NULL
)
GO

--Q3
INSERT PetStore.Owner(OwnerName,HairColor) VALUES('Lee', 'Black')

--Q4
ALTER TABLE PetStore.Owner 
ADD PreferredName nvarchar(30) NULL


--Q5
SELECT * FROM PetStore.Owner

--Q6
DROP TABLE PetStore.Owner
