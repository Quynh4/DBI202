--CREATE DATABASE lab4
--USE lab4
CREATE TABLE tblLocation(
	locNum int Primary key not null,
	locName nvarchar(50)
)
CREATE TABLE tblDepartment(
	depNum int Primary key not null,
	[depName] nvarchar(50),
	[mgrSSN] decimal(18,0),
	mgrAssDate datetime
)
CREATE TABLE tblProject(
	proNum int primary key  not null,
	proName nvarchar(50),
	locNum int references tblLocation(locNum),
	depNum int references tblDepartment(depNum)
)