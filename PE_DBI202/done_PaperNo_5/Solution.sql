-- 1
-- khong lam vi qua luoi

-- 2
select * from Locations where CountryID in ('US', 'CA')

-- 3
select EmployeeID, FirstName, LastName, Salary, Commission_pct, HireDate from Employees
where (Salary between 4000 and 10000) and Commission_pct > 0 and (FirstName like '%E%' or FirstName like '%e%')
order by HireDate desc

-- 4
select e.EmployeeID, e.FirstName, e.LastName, e.HireDate, e.JobID, j.JobTitle, e.DepartmentID, d.DepartmentName from Employees e, Departments d, Jobs j
where e.JobID = j.JobID and e.DepartmentID = d.DepartmentID
and j.JobTitle = 'Stock Clerk' and year(e.HireDate) = 2005

-- 5
select j.JobID, j.JobTitle, count(e.JobID) as 'NumberOfEmployees' from Employees e, Jobs j
where e.JobID = j.JobID
group by j.JobID, j.JobTitle
order by NumberOfEmployees desc

-- 6
select * from Countries where not CountryID in
(select distinct c.CountryID from Departments d, Locations l, Countries c
where d.LocationID = l.LocationID and l.CountryID = c.CountryID)

-- 7


/* if you want to use ORDER BY in a query and keep it as a table, you must use TOP, OFFSET or FETCH in that query */
select * from (select e.EmployeeID, e.FirstName, e.LastName, e.DepartmentID, d.DepartmentName, a.NumberOfSubordinates from Employees e, Departments d, (select ManagerID, count(ManagerID) as 'NumberOfSubordinates' from Employees
where ManagerID is not null
group by ManagerID) as a
where e.DepartmentID = d.DepartmentID and e.EmployeeID = a.ManagerID
order by NumberOfSubordinates desc
offset 0 rows) as b
union all
select e.EmployeeID, e.FirstName, e.LastName, e.DepartmentID, d.DepartmentName, 0 as 'NumberOfSubordinates' from Employees e, Departments d
where e.DepartmentID = d.DepartmentID and d.DepartmentName = 'IT'
and EmployeeID not in (select e.EmployeeID from Employees e, Departments d, (select ManagerID, count(ManagerID) as 'NumberOfSubordinates' from Employees
where ManagerID is not null
group by ManagerID) as a
where e.DepartmentID = d.DepartmentID and e.EmployeeID = a.ManagerID)

-- 8
create proc proc2
(
@fromDate date,
@toDate date,
@numberOfEmployees int output
)
as
begin
select count(*) from Employees where HireDate between @fromDate and @toDate
end

-- 9
create trigger Tr2 on Departments
for update
as
begin
select i.DepartmentID, d.DepartmentName, e.ManagerID as 'OldManagerID', i.ManagerID as 'NewManagerID' from inserted i, deleted e, Departments d
where i.DepartmentID = d.DepartmentID and e.DepartmentID = d.DepartmentID
end

update Departments
set ManagerID = 100
where DepartmentID in (110, 80)

-- 10
delete from Locations where not CountryID in
(select distinct c.CountryID from Departments d, Locations l, Countries c
where d.LocationID = l.LocationID and l.CountryID = c.CountryID)