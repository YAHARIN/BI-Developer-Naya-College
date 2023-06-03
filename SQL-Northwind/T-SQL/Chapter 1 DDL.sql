--Chapter 1 DDL

--Q1
--CREATE DATABASE MyfirstDB

CREATE TABLE Categories (
	Category_id INT IDENTITY CONSTRAINT category_id_pk PRIMARY KEY,
	Category_name Varchar(25) CONSTRAINT category_name_uq UNIQUE
)

CREATE TABLE Books (
	Book_id INT IDENTITY CONSTRAINT book_id_pk PRIMARY KEY,
	Book_name Varchar(25) CONSTRAINT book_name_uq UNIQUE,
	Book_writer Varchar(25) CONSTRAINT book_writer_nn NOT NULL,
	Book_price INT CONSTRAINT Book_price_ck CHECK(Book_price BETWEEN 0 AND 5000),
	Book_location Varchar(25) CONSTRAINT Book_location_ck CHECK(Book_location IN ('A','B','C') ),
	Book_publish_date DATE DEFAULT getdate(),
	Category_id INT CONSTRAINT category_id_fk REFERENCES Categories(Category_id)
)

INSERT INTO Categories 
VALUES ('BI'), ('DBA')

SELECT * FROM Categories

INSERT INTO Books
VALUES ('Naya', 'Yair', 100, 'A', GETDATE(), 1), 
	   ('NewNaya', 'Aviel', 200, 'B',Getdate(), 2),
	   ('Something', 'Gery', 500, 'C',Getdate(), 1),
	   ('Bdas', 'Amir', 1000, 'A',Getdate(), 2),
	   ('vsfd', 'Yoav', 2000, 'B', Getdate(), 2)

SELECT * FROM Books

--Q2

CREATE TABLE Courses (
	Course_id INT IDENTITY CONSTRAINT course_id_pk PRIMARY KEY,
	Course_name Varchar(25) CONSTRAINT course_name_uq UNIQUE
)

CREATE TABLE Students (
	Student_id INT IDENTITY CONSTRAINT student_id_pk PRIMARY KEY,
	First_name Varchar(25) CONSTRAINT first_name_nn NOT NULL,
	Last_name Varchar(25) CONSTRAINT last_name_nn NOT NULL,
	Phone_number Varchar(25) CONSTRAINT phone_number_uq UNIQUE,
	Email Varchar(25) CONSTRAINT email_ck CHECK(Email LIKE '%@%'),
	Year_of_study Varchar(25) CONSTRAINT year_ck CHECK(Year_of_study IN ('1','2','3')),
	Class_id INT CONSTRAINT class_id_fk REFERENCES Courses(Course_id)

)

INSERT INTO Courses
VALUES ('DA'), ('DP')

SELECT * FROM Courses

INSERT INTO Students
VALUES
	('Amir', 'Vitman','054-3264332','amir@gmaiI.com', 3, 2),
	('Yossi', 'Aviel', '054-3264432', 'yossi@gmail.com', 1, 1),
	('Shay', 'Gery','054-3274332','shay@gmail.com',2, 2),
	('Liron', 'Amir','054-3964332','liron@gmail.com',1, 1),
	('Gabi', 'Yoav','054-3123332', 'gabi@gmail.com', 3, 2)

SELECT * FROM Students


--Q3


CREATE TABLE Locations (
	Loc_id INT IDENTITY CONSTRAINT loc_id_pk PRIMARY KEY,
	Area_name Varchar(25) CONSTRAINT Area_name_ck CHECK(Area_name IN ('North','Center','South')), 
	City Varchar(25),
	Zip_code INT CONSTRAINT zip_code_ck CHECK(LEN(Zip_code) = 5)
	)

CREATE TABLE Departments (
	Dep_id INT IDENTITY CONSTRAINT dep_id_pk PRIMARY KEY,
	Dep_name Varchar(25),
	Location_id INT CONSTRAINT location_id_fk REFERENCES Locations(loc_id)
	)

CREATE TABLE Employees (
	Emp_id INT IDENTITY CONSTRAINT emp_id_pk PRIMARY KEY,
	Emp_name Varchar(25),
	Emp_lname Varchar(25),
	Emp_email AS (LEFT(Emp_name, 1) + LEFT(Emp_lname, 2) + 'gmail.com'),
	Emp_job Varchar(25) CONSTRAINT emp_job_ck CHECK(Emp_job IN ('Cashier', 'Manager', 'Delivery')),
	Emp_birthdate DATE CONSTRAINT emp_birthdate_nn NOT NULL,
	Emp_age AS datediff(yyyy, emp_birthdate , getdate()),
	Emp_sal_per_hour INT CONSTRAINT emp_sal_per_hour_ck CHECK(Emp_sal_per_hour BETWEEN 25 AND 70),
	Emp_total_hours INT CONSTRAINT emp_total_hours_ck CHECK(Emp_total_hours < 200),
	Emp_salary AS Emp_sal_per_hour * Emp_total_hours,
	Emp_hiredate DATE, 
	Emp_cellephoe Varchar(11) CONSTRAINT emp_cellephoe_ck CHECK(Emp_cellephoe LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9]'), 
	Emp_cell_company AS 
	(CASE
		when Emp_cellephoe like '052%' then 'Cellcom'
		when Emp_cellephoe like '050%' then 'Pelephone'
		else 'Other Company'
	END),
	Dep_id int CONSTRAINT dep_id_fk REFERENCES Departments(Dep_id)
	)


INSERT INTO dbo.Locations
VALUES  ('Center', 'Tel Aviv', 32456),
		('South', 'Beer-Sheva', 32165),
		('North', 'Haifa', 21543)


INSERT INTO dbo.Departments
VALUES  ('HR', 2),
		('Sales', 1)

INSERT INTO dbo.Employees
VALUES
	('Amir','vitman', 'Cashier', '1982-02-16', 30, 120, '2002-02- 16', '050-3214332', 2),
	('Yossi', 'Aviel', 'Cashier', '1985-06-14', 50, 130, '2000-04-17', '050-3264132', 2),
	('Shay','Gery', 'Delivery', '1990-08-11', 25, 170, '2010-01-22', '052-3274332', 1),
	('Liron', 'Amir', 'Manager', '1981-05-23', 70, 100, '1999-12-10', '050-3964332', 2),
	('Gabi', 'Yoav', 'Delivery', '1987-07-29', 25, 180, '2012-01-04', '054-3123332', 1)


SELECT * FROM dbo.Departments
SELECT * FROM dbo.Locations
SELECT * FROM dbo.Employees

