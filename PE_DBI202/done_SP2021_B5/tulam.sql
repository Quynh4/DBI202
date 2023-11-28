use [PE_DBI202_Sp2021_B5]
--2
select * from Employees
where Salary > 9000

--3
SELECT Jobs.JobID, Jobs.JobTitle, Jobs.min_salary
FROM  Jobs
where JobTitle like '%Manager%' and min_salary>5000
order by min_salary desc, JobTitle

--4
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Salary, Departments.DepartmentName, Locations.StateProvince, Locations.CountryID
FROM     Employees INNER JOIN
                  Departments ON Employees.DepartmentID = Departments.DepartmentID INNER JOIN
                  Locations ON Departments.LocationID = Locations.LocationID
where Salary >3000
and StateProvince = 'Washington'
and CountryID = 'US'

--5
SELECT Locations.LocationID, Locations.StreetAddress, Locations.City, Locations.StateProvince, Locations.CountryID, count(Departments.DepartmentID) as NumberOfDepartments
FROM     Departments RIGHT JOIN
                  Locations ON Departments.LocationID = Locations.LocationID
group by Locations.LocationID, Locations.StreetAddress, Locations.City, Locations.StateProvince, Locations.CountryID
order by NumberOfDepartments desc, LocationID asc

--6
with t as(SELECT Jobs.JobID, Jobs.JobTitle, count(Employees.EmployeeID) as NumberOfEmployees
FROM     Jobs INNER JOIN
                  Employees ON Jobs.JobID = Employees.JobID
group by Jobs.JobID, Jobs.JobTitle)
select * from t where NumberOfEmployees = (select max(NumberOfEmployees) from t)

--7

with manager as (select ManagerID, count(EmployeeID) as NumberofSubordinates
from Employees
group by ManagerID)
select e.EmployeeID, e.FirstName, e.LastName, e.Salary, e.DepartmentID, d.DepartmentName, sum(isnull(m.NumberofSubordinates,0)) as NumberofSubordinates
from Employees e
left join manager m on e.EmployeeID = m.ManagerID
join Departments d on e.DepartmentID = d.DepartmentID
group by e.EmployeeID, e.FirstName, e.LastName, e.Salary, e.DepartmentID, d.DepartmentName
having sum(isnull(m.NumberofSubordinates,0)) >1
or e.Salary>10000
order by NumberofSubordinates desc, LastName

--8
create proc pr1
@countryId varchar(10), @numberOfDeprtments int out
as
begin
	SELECT  @numberOfDeprtments = count(Departments.DepartmentID)
	FROM     Departments right JOIN
					  Locations ON Departments.LocationID = Locations.LocationID
	where countryId = @countryId	
end

declare @x int
exec pr1 'US', @x output
select @x as NumberOfDepartments

--9
drop trigger Tr1
create trigger Tr1
on Employees
for insert
as
begin
	SELECT i.EmployeeID, i.FirstName, i.LastName, Departments.DepartmentID, Departments.DepartmentName
	FROM     Departments right JOIN
					  inserted i ON Departments.DepartmentID = i.DepartmentID	 
end

insert into Employees (EmployeeID, FirstName, LastName, Email, JobID, DepartmentID)
values (1007, 'Alain', 'Boucher', 'alain.boucher@gmail.com', 'SH_CLERK', 50), 
(1008, 'Muriel', 'Visani', 'muriel.visani@gmail.com', 'SA_REP', null)

delete from Employees where EmployeeID = 1003

--10
--not work
delete from Departments
where DepartmentID not in 
(select distinct DepartmentID from Employees)


--work
DELETE FROM Departments
WHERE NOT EXISTS (SELECT * FROM Employees WHERE Employees.DepartmentID = Departments.DepartmentID)
