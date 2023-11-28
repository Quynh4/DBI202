CREATE VIEW View_FullName_Employee AS
SELECT CONCAT(FirstName, ' ', LastName) AS FullName, Salary
FROM Employees
WHERE Salary > 10000;