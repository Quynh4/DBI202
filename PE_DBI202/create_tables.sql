create database newdb

use newdb

CREATE TABLE Departments(
	DeptID VARCHAR(15) PRIMARY KEY,
	[Name] NVARCHAR(50),
)

CREATE TABLE Offices(
	OfficeNumber INT PRIMARY KEY,
	[Address] NVARCHAR(30),
	Phone VARCHAR(15),
	DeptID VARCHAR(15) REFERENCES Departments(DeptID)
)

CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY,
  FullName NVARCHAR(50),
  OfficeNumber INT REFERENCES Offices(OfficeNumber) --WorkIn
);



CREATE TABLE WorkFor(
	 [From] Date,
	 Salary float,
	 [To] Date,
	 EmployeeID INT REFERENCES Employees(EmployeeID),
	 DeptID VARCHAR(15) REFERENCES Departments(DeptID),
	 PRIMARY KEY ([From], EmployeeID, DeptID)
)
