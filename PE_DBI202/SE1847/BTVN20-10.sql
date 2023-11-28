--Exercise 1
--Write a SELECT query to display Full name of all employees in lower-case
SELECT LOWER(CONCAT(LastName, ' ', FirstName)) AS [Full name], TitleOfCourtesy
FROM employees;

-- Exercise 2
--Write a SELECT query to display Full name of all employees in upper-case
SELECT UPPER(CONCAT(LastName, ' ', FirstName)) AS [Full name]
FROM employees;

--Exercise 3
--Write a SELECT query to display all employees that are from United States
select EmployeeID, LastName, FirstName, Title, City, Country from Employees
where Country='USA'

--Exercise 4
--Write a SELECT query to display all customers that are from UK
select CustomerID, CompanyName, ContactName, ContactTitle, Country from Customers
where Country='UK'

--Exercise 5
--Write a SELECT query to display all customers that are from Mexico
select CustomerID, CompanyName, Address, City, Country from Customers
where Country='Mexico'

--Exercise 6
--Write a SELECT query to display all customers that are from Sweden
select CustomerID, CompanyName, Phone, Address, City, Country from Customers
where Country='Sweden'

--Exercise 7
--In Products table, values of UnitsInStock tell you the total units in the inventory of every product. 
--Write a SELECT query to display 
--product id, product name, unit price of all products such that their total units in the
--inventory is between 5 and 10
SELECT ProductID, ProductName, UnitPrice, UnitsInStock
FROM Products
WHERE UnitsInStock BETWEEN 5 AND 10

--Exercise 8
--In Products table, the value of UnitsOnOrder tells you the total ordered units for every product. 
--Write a SELECT query to display product id, product name, unitprice, re-order level… of all products
--that have total ordered units between 60 and 100 
SELECT ProductID, ProductName, UnitPrice, ReorderLevel, UnitsOnOrder
FROM Products
WHERE UnitsOnOrder BETWEEN 60 AND 100

----Exercise 9
--Write a SELECT query to display total orders of every employee in 1996
select e.EmployeeID,e.LastName,e.FirstName,e.Title,YEAR(o.OrderDate) as year,COUNT(*) as TotalOrders
from Orders o
join Employees e on e.EmployeeID = o.EmployeeID
where year(o.OrderDate) = 1996
group by e.EmployeeID,e.LastName,e.FirstName,e.Title,YEAR(o.OrderDate)

--Exercise 10
--Write a SELECT query to display total orders of every employee in 1998 
select e.EmployeeID,e.LastName,e.FirstName,e.City,e.Country,COUNT(o.OrderDate) as TotalOrders
from Orders o
join Employees e on e.EmployeeID = o.EmployeeID
where year(o.OrderDate) = 1998
group by e.EmployeeID,e.LastName,e.FirstName,e.City,e.Country,YEAR(o.OrderDate)


--Exercise 11
--Write a SELECT query to display total orders of every employee from 1/1/1998 to 31/7/1998
select e.EmployeeID,e.LastName,e.FirstName,e.HireDate,COUNT(*) as TotalOrders
from Orders o
join Employees e on e.EmployeeID = o.EmployeeID
where o.OrderDate between '1998-01-01' and '1998-07-31'
group by e.EmployeeID,e.LastName,e.FirstName,e.HireDate

--Exercise 12
--Write a SELECT query to display total orders of every employee from 1/1/1997 to 30/6/1997
select e.EmployeeID,e.LastName,e.FirstName,e.HireDate,e.HomePhone,COUNT(*) as TotalOrders
from Orders o
join Employees e on e.EmployeeID = o.EmployeeID
where o.OrderDate between '1997-01-01' and '1997-06-30'
group by e.EmployeeID,e.LastName,e.FirstName,e.HireDate,e.HomePhone

--Exercise 13
--An order will be taxed 10% if its freight cost is larger than or equal to 100$.
--Otherwise, an order will be taxed 5% if its freight cost is smaller than 100$.
--Write a SELECT query to show the freight with taxes of orders placed
--between 1/8/1996 and 5/8/1996
select OrderID, day(o.OrderDate) as OrderDay, month(o.OrderDate) as OrderMonth, year(o.OrderDate) as OrderYear,Freight,
	case
		when Freight >= 100 then '10%'
		else '5%'
	end
as 'Tax',
	case
		when Freight >= 100 then CAST(Freight * 1.1 as float)
		else CAST(Freight * 1.05 as float)
	end 
as 'Freight with tax'
from Orders o
where OrderDate between '1996-08-01' and '1996-08-05'

--Exercise 14
--Write a SELECT query to display the full name, title of courtesy and sex for all employees such that:
-- If title of courtesy is ‘Mr.’ then sex is set to ‘Male’
-- If title of courtesy is ‘Ms.’ or ‘Mrs.’ then sex is set to ‘Female’

select LastName + ' ' + FirstName as 'FullName', TitleOfCourtesy,
	case
		when TitleOfCourtesy = 'Mr.' then 'Male'
		when TitleOfCourtesy in ('Mrs.','Ms.') then 'Female'
		else 'Unknow'
	end 
as 'Sex'
from Employees
group by LastName,FirstName,TitleOfCourtesy

--Exercise 15
--Write a SELECT query to display the fullname, title of courtesy and sex for all employees such that:
-- If title of courtesy is ‘Mr.’ or ‘Dr.’ then sex is set to ‘M’
-- If title of courtesy is ‘Ms.’ or ‘Mrs.’ then sex is set to ‘F’

select LastName + ' ' + FirstName as 'FullName',TitleOfCourtesy,
	case
		when TitleOfCourtesy in ('Mr.','Dr.') then 'M'
		when TitleOfCourtesy in ('Mrs.','Ms.') then 'F'
		else 'N/A'
	end 
as 'Sex'
from Employees
group by LastName,FirstName,TitleOfCourtesy
order by 
	case
		when TitleOfCourtesy in ('Mr.','Dr.') then 1
		when TitleOfCourtesy in ('Mrs.','Ms.') then 2
		else 3
	end

--Exercise 16
--Write a SELECT query to display the fullname, title of courtesy and sex for all employees such that:
-- If title of courtesy is ‘Mr.’ then sex is set to ‘Male’
-- If title of courtesy is ‘Ms.’ or ‘Mrs.’ then sex is set to ‘Female’
-- If title of courtesy is not ‘Mr.’ and not ‘Mrs.’ and not ‘Ms.’ then sex is set to‘Unknown’
select LastName + ' ' + FirstName as 'FullName',TitleOfCourtesy,
	case
		when TitleOfCourtesy = 'Mr.' then 'Male'
		when TitleOfCourtesy in ('Mrs.','Ms.') then 'Female'
		else 'Unknown'
	end 
as 'Sex'
from Employees
group by LastName,FirstName,TitleOfCourtesy
order by 
	case
		when TitleOfCourtesy = 'Mr.' then 1
		when TitleOfCourtesy in ('Mrs.','Ms.') then 2
		else 3
	end 

--Exercise 17
--Write a SELECT query to display the full name, title of courtesy and sex for all employees such that:
--If title of courtesy is ‘Mr.’ then sex is set to 1
--If title of courtesy is ‘Ms.’ or ‘Mrs.’ then sex is set to 0
--If title of courtesy is not ‘Mr.’ and not ‘Mrs.’ and not ‘Ms.’ then sex is set to
select LastName + ' ' + FirstName as 'FullName',TitleOfCourtesy,
	case
		when TitleOfCourtesy = 'Mr.' then 1
		when TitleOfCourtesy in ('Mrs.','Ms.') then 0
		else 2
	end
as 'Sex'
from Employees
group by LastName,FirstName,TitleOfCourtesy
order by
	case
		when TitleOfCourtesy = 'Mr.' then 1
		when TitleOfCourtesy in ('Mrs.','Ms.') then 2
		else 3
	end

--Exercise 18
--Write a SELECT query to display the full name, title of courtesy and sex for all employees such that:
-- If title of courtesy is ‘Mr.’ then sex is set to ‘M’
-- If title of courtesy is ‘Ms.’ or ‘Mrs.’ then sex is set to ‘F’
-- If title of courtesy is not ‘Mr.’ and not ‘Mrs.’ and not ‘Ms.’ then sex is set to ‘N/A’
select LastName + ' ' + FirstName as 'FullName',TitleOfCourtesy,
	case
		when TitleOfCourtesy = 'Mr.' then 'M'
		when TitleOfCourtesy in ('Mrs.','Ms.') then 'F'
		else 'N/A'
	end
as 'Sex'
from Employees
group by LastName,FirstName,TitleOfCourtesy
order by
	case
		when TitleOfCourtesy = 'Mr.' then 1
		when TitleOfCourtesy in ('Mrs.','Ms.') then 2
		else 3
	end