use FUH_COMPANY
--Example 1 
--Create a view to list all employees who are in Department number 1
IF OBJECT_ID ('Employee_Dep1', 'V') IS NOT NULL drop view Employee_Dep1
GO
CREATE VIEW Employee_Dep1 AS SELECT * FROM tblemployee WHERE depnum=1
GO
--Example 2
--Find all employees who work in department 1
select * from tblEmployee te where te.depNum=1
select * from Employee_Dep1

--Find all dependents of the employees who work in department 1
SELECT * 
FROM Employee_Dep1 ed1, tblDependent d
WHERE ed1.empSSN=d.empSSN

SELECT * 
FROM (SELECT * 
FROM tblEmployee
WHERE depNum=1
) ed1, tblDependent d
WHERE ed1.empSSN=d.empSSN

--Example 3:
--Create view for all employees of Department number 1,
--including: SSN, Fullname, Age, Salary, Sex
if OBJECT_ID('Employee_Dep1', 'V') is not null drop view Employee_Dep1

create view Employee_Dep1 as
SELECT te.empSSN as 'Mã số nhân viên', te.empName as 'Họ và tên',
	YEAR (GETDATE())-YEAR (te.empBirthdate) AS 'Tuổi', 
	te.empSalary AS 'Luong', 
	CASE WHEN te.empSex ='F' THEN N'Nữ' ELSE N'Nam' END AS 'Giới tính'
FROM tblEmployee te WHERE te.depNum=1;

--Example 4:
--Create view from table Employee
--Do changes on Employee and review created view
--Do changes on created view and review Employee

--Update on table effects on view
IF OBJECT_ID('Employee_Dep1v2', 'V') IS NOT NULL
    DROP VIEW Employee_Dep1v2;
GO

CREATE VIEW Employee_Dep1v2 AS
SELECT te.empSSN, te.empName, te.empSalary, te.empSex
FROM tblemployee te
WHERE te.depnum = 1;
GO

INSERT INTO tblEmployee (empSSN, empName, empSalary, empSex, depNum)
VALUES (100000, N'Lê Văn Tám', 100000, 'M', 1);
GO

SELECT * FROM tblEmployee te WHERE te.depNum = 1;
GO

SELECT * FROM Employee_Dep1v2;
GO

--Update on view effects on table with unexpected result
IF OBJECT_ID('Employee_Dep1v2', 'V') IS NOT NULL
    DROP VIEW Employee_Dep1v2;
GO

CREATE VIEW Employee_Dep1v2 AS
SELECT te.empSSN, te.empName, te.empSalary, te.empSex
FROM tblemployee te
WHERE te.depnum = 1;
GO

INSERT INTO Employee_Dep1v2 (empSSN, empName, empSalary, empSex)
VALUES (100001, N'Lê Văn Bảy', 100000, 'M');
GO

SELECT * FROM tblEmployee te WHERE te.depNum = 1;
GO

SELECT * FROM Employee_Dep1v2;
GO
--Update on view raises error on table
IF OBJECT_ID('Employee_Dep1v3', 'V') IS NOT NULL
    DROP VIEW Employee_Dep1v3;
GO

CREATE VIEW Employee_Dep1v3 AS
SELECT te.empSSN AS 'Mã số nhân viên', te.empName AS 'Họ và tên',
       YEAR(GETDATE()) - YEAR(te.empBirthdate) AS 'Tuổi',
       te.empSalary AS 'Lương',
       CASE WHEN te.empSex = 'F' THEN N'Nữ' ELSE N'Nam' END AS 'Giới tính'
FROM tblEmployee te
WHERE te.depNum = 1;
GO

INSERT INTO Employee_Dep1v3 (empSSN, empName, empBirthdate, empSalary, empSex)
VALUES (100002, N'Lê Văn Chín', '1993-01-01', 90000, N'Nam');
GO