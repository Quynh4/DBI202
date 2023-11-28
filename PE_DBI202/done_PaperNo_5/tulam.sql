use PE_DBI202_F2019
--7
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

--8
create proc proc2 
@fromDate Date, @toDate Date, @numberOfEmployees int output
as
begin
	select @numberOfEmployees = count(distinct EmployeeID) from  Employees
	where HireDate between @fromDate and @toDate
end

declare @x int
execute proc2 '2002-01-01', '2002-12-31', @x output
select @x as NumberOfEmployees


--9
create trigger Tr2 
on departments
after update
as
begin
	select i.DepartmentID, i.DepartmentName,
	d.ManagerID OldManagerID , i.ManagerID NewManagerID 
	from inserted i join deleted d
	on i.DepartmentID = d.DepartmentID
end

update Departments
set ManagerID = 100
where DepartmentID in (110, 80)


--10
