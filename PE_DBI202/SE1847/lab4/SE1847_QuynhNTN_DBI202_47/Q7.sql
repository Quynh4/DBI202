SELECT E.EmployeeID, E.FirstName, E.LastName, E.HireDate, J.JobID, J.JobTitle, D.DepartmentID, D.DepartmentName
FROM Employees E
INNER JOIN Jobs J ON E.JobID = J.JobID
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE YEAR(E.HireDate) = 2005
  AND J.JobTitle = 'Stock Clerk';