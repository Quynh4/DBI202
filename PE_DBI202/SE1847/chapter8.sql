--Declare a variable
DECLARE @empName NVARCHAR(20), @empSSN AS DECIMAL, @empSalary DECIMAL=1000
--asign a value using set
DECLARE @empName NVARCHAR(20)
SET @empName=N'Mai Duy An'

SELECT *
FROM tblEmployee
WHERE empName= @empName

--asign a value using select
DECLARE @empSalary DECIMAL=1000
SELECT @empSalary=2000

--Assign a value into a variable using SQL command : SELECT or UPDATE
SELECT @empName = empName, @empSalary = empSalary
FROM tblEmployee
WHERE empName = N'Mai Duy An';

UPDATE	tblEmployee
SET	@empName=empName, @empSalary=empSalary
WHERE	empName=N'Mai Duy An'

--Display value of a variable : using PRINT or SELECT
DECLARE @empName NVARCHAR(20)='Q'
PRINT 	@empName

--Display value of a variable : using SELECT
DECLARE @empSalary DECIMAL=1000
SELECT 	@empSalary

--Converts an expression from one data type to a different data type : using CAST or CONVERT function
DECLARE @empName NVARCHAR(20), @empSalary DECIMAL
SET @empName=N'Mai Duy An'
SET @empSalary=1000
PRINT @empName + '''s salary is ' + CAST(@empSalary AS VARCHAR)
PRINT @empName + '''s salary is ' + CONVERT(VARCHAR, @empSalary)

--IF ... ELSE Statement
DECLARE @workHours DECIMAL, @bonus DECIMAL
SELECT	@workHours=SUM(workHours)
FROM	tblWorksOn
WHERE	empSSN=30121050027
GROUP BY empSSN

IF (@workHours > 300)
	SET @bonus=1000
ELSE
	SET @bonus=500
PRINT @bonus


--Case when 1
DECLARE	@depNum DECIMAL=1, @str NVARCHAR(30)
SET @str=
	CASE @depNum 
		WHEN 1 THEN N'Phòng ban số 1'
		WHEN 2 THEN N'Phòng ban số 2'
		ELSE N'Mã phòng ban khác 1, 2'
	END 
PRINT @depNum
PRINT @str

--Case when null
DECLARE	@depNum DECIMAL, @str NVARCHAR(30)
SET @str=
	CASE @depNum 
		WHEN 1 THEN N'Phòng ban số 1'
		WHEN 2 THEN N'Phòng ban số 2'
		ELSE N'Mã phòng ban khác 1, 2'
	END 
PRINT @depNum
PRINT @str

--WomanDay
declare @bonus decimal
select @bonus=
	case empSex
		when 'F' then 500
		when 'M' then 0
	end
from tblEmployee
where empSSN=30121050004
print @bonus


--while
DECLARE @factorial INT, @n INT
SET @n=5
SET @factorial=1
WHILE (@n > 1)
	BEGIN
		SET @factorial = @factorial*@n
		SET @n = @n - 1
	END
PRINT @factorial

--handling error
BEGIN TRANSACTION
	INSERT INTO tblDepartment(depNum,depName)
	VALUES(6, N'Phòng Kế Toán');

	INSERT INTO tblDepartment(depNum,depName)
	VALUES(6, N'Phòng Kế Toán');

	IF @@ERROR<>0
		BEGIN
			ROLLBACK TRANSACTION
			PRINT @@ERROR
		END
COMMIT TRANSACTION

--try catch
BEGIN TRANSACTION	--begin transaction

BEGIN TRY
	--oparations
	INSERT INTO tblDepartment(depNum,depName)
	VALUES(6, N'Phòng Kế Toán');

	INSERT INTO tblDepartment(depNum,depName)
	VALUES(6, N'Phòng Kế Toán');
	COMMIT TRANSACTION	--commit the transaction
END TRY	

BEGIN CATCH
	ROLLBACK TRANSACTION	--rollback transaction
	PRINT ERROR_NUMBER()
	PRINT ERROR_MESSAGE()
END CATCH

--listing all projects procedure
IF OBJECT_ID ('psm_List_ALL_Of_Project', 'P') IS NOT NULL
DROP PROCEDURE psm_List_ALL_Of_Project;

GO

CREATE PROCEDURE psm_List_ALL_Of_Project
AS
	SELECT *
	FROM tblProject;
GO

EXEC psm_List_ALL_Of_Project;

--change name of project
IF OBJECT_ID ('psm_Change_Name_Of_Project', 'P') IS NOT NULL
DROP PROCEDURE psm_Change_Name_Of_Project;

GO

CREATE PROCEDURE psm_Change_Name_Of_Project
	@PNUMBER INT,
	@PNAME NVARCHAR(50)
AS
	UPDATE tblProject
	SET proName=@PNAME
	WHERE proNum=@PNUMBER
GO

EXEC psm_Change_Name_Of_Project 1, 'Project A';
select * from tblProject

--function must return & procedure not have to return
--function tim kiem nhan su
create function FnSelectEmployee(@empSSN decimal(18,0))
returns table
as
return
(
select * from tblEmployee
where empSSN=@empSSN or @empSSN=0
)

select * from FnSelectEmployee(30121050027)

--trigger
IF OBJECT_ID('Tr_Employee_Insert', 'TR') is not null
	drop trigger Tr_Employee_Insert
go
CREATE TRIGGER Tr_Employee_Insert ON tblEmployee
AFTER INSERT
AS
	RAISERROR('Insert trigger is awakened',16,1)
go

--raised after insert on tblEmployee table
CREATE TRIGGER Tr_Employee_Insert ON tblEmployee
AFTER INSERT
AS
	RAISERROR('Insert trigger is awakened',16,1)
	ROLLBACK TRANSACTION
go
--test 
INSERT INTO tblEmployee(empSSN, empName, empSalary, depNum)
VALUES (30121050345, N'Nguyễnn Văn Tý', 10000, 1;
--not found employee whose empSSN is 30121050345
SELECT * FROM tblEmployee WHERE empSSN=30121050345




--using Deleted and Inserted tables
IF OBJECT_ID('Tr_Employee_Insert', 'TR') is not null
	drop trigger Tr_Employee_Insert
go
CREATE TRIGGER Tr_Employee_Insert ON tblEmployee
AFTER INSERT
AS
	DECLARE @vEmpSSN DECIMAL, @vEmpName NVARCHAR(50)
	SELECT @vEmpSSN=empSSN FROM inserted
	SELECT @vEmpName=empName FROM inserted
	PRINT 'new tuple:'
	PRINT 'empSSN=' + CAST(@vEmpSSN AS nvarchar(11)) + ' empName=' + @vEmpName
go

--test
INSERT INTO tblEmployee(empSSN, empName, empSalary, depNum, supervisorSSN)
VALUES (30121050345, N'Nguyễn Văn Tý', 10000, 1, 30121050037);



--trigger that refuses all under-18-year-old employee’s insertion or update
CREATE TRIGGER Tr_Employee_Under18 ON tblEmployee
AFTER INSERT, UPDATE
AS
	DECLARE @empBirthdate DATETIME, @age INT
	SELECT @empBirthdate=empBirthdate 
	FROM inserted
	
	SET @age=YEAR(GETDATE()) - YEAR(@empBirthdate)
	IF (@age < 18)
	BEGIN
		RAISERROR('Employee is under 18 years old.We can not sign a contact with him/her.',16,1)
		ROLLBACK TRANSACTION
	END


--Another method: using EXISTS
CREATE TRIGGER Tr_Employee_Under18 ON tblEmployee
AFTER INSERT, UPDATE
AS
	IF EXISTS(SELECT * 
		FROM inserted 
		WHERE (YEAR(GETDATE())-YEAR(empBirthdate))<18
	)
	BEGIN
		RAISERROR('Employee is under 18 years old. We can not sign a contact with him/her.',16,1)
		ROLLBACK TRANSACTION
	END
go
