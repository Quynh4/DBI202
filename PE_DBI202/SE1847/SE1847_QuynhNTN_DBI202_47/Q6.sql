SELECT EmployeeID, FirstName, LastName, Salary, Commission_pct, HireDate
FROM Employees
WHERE Salary BETWEEN 4000 AND 10000
  AND Commission_pct > 0
  AND (FirstName LIKE '%E%' OR FirstName LIKE '%e%')
ORDER BY HireDate DESC;