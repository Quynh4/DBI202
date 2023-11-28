select * from
(SELECT e.EmployeeID, e.FirstName,  e.LastName, e.DepartmentID, d.DepartmentName,
    COUNT(sub.EmployeeID) AS NumberOfSubordinates
FROM Employees e
LEFT JOIN Employees sub ON e.EmployeeID = sub.ManagerID
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.EmployeeID in (select ManagerID from Employees)
OR d.DepartmentName = 'IT'
GROUP BY e.EmployeeID, e.FirstName,  e.LastName, e.DepartmentID, d.DepartmentName) as subquery
order by NumberOfSubordinates desc
