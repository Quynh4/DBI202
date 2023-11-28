--The average salary of each department must be fewer than 50000.
CREATE TRIGGER Trigger_1
ON Employees
AFTER INSERT, UPDATE
AS
BEGIN
    IF (SELECT AVG(salary) 
	FROM Employees 
	WHERE department_id = (
		SELECT department_id 
		FROM INSERTED)) > 50000
    BEGIN
        ROLLBACK;
    END
END

--Ensure the head of each department has a salary greater than or 
--equal to all employees in that department

CREATE TRIGGER Trigger_2
ON Employees
AFTER INSERT, UPDATE
AS
BEGIN
    IF (SELECT MIN(salary) FROM Employees WHERE department_id = (SELECT department_id FROM INSERTED)) > (SELECT salary FROM INSERTED)
    BEGIN
        ROLLBACK;
    END
END

--Ensure the difference between average salary in HCM and HN is less than 10000
CREATE TRIGGER Trigger_3
ON Employees
AFTER INSERT, UPDATE
AS
BEGIN
    IF (ABS((SELECT AVG(salary) FROM Employees WHERE city = 'HCM') - (SELECT AVG(salary) FROM Employees WHERE city = 'HN')) > 10000)
    BEGIN
        ROLLBACK;
    END
END

--Ensure no group has more than five employees from the same family:
CREATE TRIGGER Trigger_4
ON Employees
AFTER INSERT
AS
BEGIN
    IF (SELECT COUNT(*) FROM Employees WHERE family_id = (SELECT family_id FROM INSERTED)) > 5
    BEGIN
        ROLLBACK;
    END
END

--Ensure the difference between the number of male and female employees is less than 10%
CREATE TRIGGER Trigger_5
ON Employees
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @TotalCount INT, @MaleCount INT, @FemaleCount INT, @Difference INT
    SELECT @TotalCount = COUNT(*), @MaleCount = COUNT(*) FROM Employees WHERE gender = 'Male'
    SET @FemaleCount = @TotalCount - @MaleCount
    SET @Difference = ABS(@MaleCount - @FemaleCount)
    IF (@Difference > (@TotalCount * 0.1))
    BEGIN
        ROLLBACK;
    END
END

