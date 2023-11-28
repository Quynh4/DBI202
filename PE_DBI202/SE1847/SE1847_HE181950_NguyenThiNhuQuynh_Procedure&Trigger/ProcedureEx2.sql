--List all information of employees (code, name, entered date, supervisor’s id, supervisor’s name)
--that were employed from s to f. S and f are date value that were been input parameters.
CREATE PROCEDURE SP_1 (@s DATE, @f DATE)
AS
BEGIN
    SELECT E.code, E.name, E.entered_date, E.supervisor_id, S.name AS supervisor_name
    FROM Employees AS E
    LEFT JOIN Employees AS S ON E.supervisor_id = S.code
    WHERE E.entered_date BETWEEN @s AND @f;
END

--List all employees (code, name, salary) whose salary more than the average salary 
--of the department that they work in
CREATE PROCEDURE SP_2
AS
BEGIN
    SELECT E.code, E.name, E.salary
    FROM Employees AS E
    WHERE E.salary > (
	SELECT AVG(salary) 
	FROM Employees 
	WHERE department_id = E.department_id
	);
END

--List N employees that have the highest salary. N is the input parameter.
CREATE PROCEDURE SP_3 (@N INT)
AS
BEGIN
    SELECT TOP (@N) code, name, salary
    FROM Employees
    ORDER BY salary DESC;
END


--Increase 10% for salary of all employees in the city A. A is the input parameter.
CREATE PROCEDURE SP_3 (@A nvarchar(255))
AS
BEGIN
	UPDATE Employees
	SET salary = salary *1,1
	WHERE city = @A
END

--Delete all no personnel departments. 
CREATE PROCEDURE SP_5
AS
BEGIN
    DELETE FROM Departments
    WHERE department_id NOT IN (
	SELECT DISTINCT department_id 
	FROM Employees);
END
