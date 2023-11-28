SELECT J.JobID, J.JobTitle, COUNT(E.EmployeeID) AS NumberOfEmployees
FROM Jobs J
LEFT JOIN Employees E ON J.JobID = E.JobID
GROUP BY J.JobID, J.JobTitle
ORDER BY NumberOfEmployees DESC;