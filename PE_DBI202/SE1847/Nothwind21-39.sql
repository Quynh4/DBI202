----Exercise 21
--determine the revenues for all products from 1/7/1996 to 5/7/1996
--as following (Revenue = Quantity * Unitprice)
--The output must be order by category id and then product id.
with d as(
select a.OrderID, a.ProductID, a.UnitPrice, a.Quantity, o.OrderDate,  a.Quantity * a.UnitPrice AS Revenue
from [Order Details] a
JOIN Orders o ON o.OrderID = a.OrderID
WHERE o.OrderDate BETWEEN '1996-07-01' AND '1996-07-05'
)
SELECT
  p.CategoryID, c.CategoryName, p.ProductID, p.ProductName,
  DAY(o.OrderDate) as 'day', MONTH(o.OrderDate) as 'month', YEAR(o.OrderDate) as 'year', 
  sum(d.Revenue) as Revenue
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN d ON d.ProductID = p.ProductID
JOIN Orders o ON o.OrderID = d.OrderID
group by p.CategoryID, c.CategoryName, p.ProductID, p.ProductName, o.OrderDate
ORDER BY p.CategoryID, p.ProductID



----Exercise 22
----display information about 7-days late orders and their employees 
--(an order is called late if it is shipped after required date)
select e.EmployeeID, e.LastName, e.FirstName, o.OrderID, o.OrderDate, o.RequiredDate, o.ShippedDate
from Orders o
join Employees e on o.EmployeeID = e.EmployeeID
where DATEDIFF(day, o.RequiredDate, o.ShippedDate) >7
order by e.EmployeeID

----Exercise 23
----display the names and telephone numbers of all employees and all
--customers satisfy the condition: all customers have names start with ‘W’.

select CompanyName, Phone
from  Customers c
where CompanyName like 'W%'
union all
select e.LastName +' ' + e.FirstName , e.HomePhone
from Employees e

----Exercise 24
----display information about the customer that placed the
--order with Id equal to 10643
select c.CustomerID, c.CompanyName, c.ContactName, c.ContactTitle
from orders o
join Customers c
on o.CustomerID = c.CustomerID
where o.orderid=10643

----Exercise 25
----display the product ids, product names and total units
--ordered of all products that satisfy: the total units ordered must be greater
--than or equal to 1200 units.
select p.ProductID, p.ProductName, sum(d.Quantity) as 'Total Ordered'
from [Order Details] d
join Products p on d.ProductID = p.ProductID
group by p.ProductID, p.ProductName
having sum(d.Quantity) >=1200
order by [Total Ordered]


--Exercise 26
--display the product ids, product names, supplier id, 
--category id and total units ordered of all products that satisfy: 
--the total units ordered must be greater than or equal to 1400 units.
select p.ProductID, p.ProductName, p.SupplierID, p.CategoryID,
sum(d.Quantity) as 'Total ordered'
from [Order Details] d
join Products p on d.ProductID = p.ProductID
group by p.ProductID, p.ProductName, p.SupplierID, p.CategoryID
having sum(d.Quantity) >= 1400
order by [Total Ordered] desc



--Exercise 27
--display the categories that have maximum total product
SELECT c.CategoryID, c.CategoryName, COUNT(*) AS 'Total products'
FROM Categories c JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
HAVING COUNT(*) = 
	(SELECT top 1 COUNT(*)
	FROM Categories c JOIN Products p ON c.CategoryID = p.CategoryID
	GROUP BY c.CategoryID
	order by COUNT(*) desc)

--Exercise 28
--display the categories that have minimum total product

SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) AS 'Total products'
FROM Categories c left outer JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
HAVING COUNT(*) <= all 
	(SELECT top 1 COUNT(*)
	FROM Categories c left JOIN Products p ON c.CategoryID = p.CategoryID
	GROUP BY c.CategoryID
	order by COUNT(*))
--Exercise 29
--display the total record in Customer and Employees tables:
-- cach 1
WITH c AS (
  SELECT COUNT(*) AS count1
  FROM Customers
),
e AS (
  SELECT COUNT(*) AS count2
  FROM Employees
)
SELECT (SELECT count1 FROM c) + (SELECT count2 FROM e) AS 'Total records';

-- cach 2
SELECT SUM(count) AS 'Total records'
FROM (
  SELECT COUNT(*) AS count
  FROM Customers
  UNION ALL
  SELECT COUNT(*) AS count
  FROM Employees
) AS counts;


--Exercise 30
--Write a query to display information
--about employees who have minimum total orders
select e.EmployeeID, e.LastName, e.FirstName, count(o.OrderID) as 'total orders'
from Orders o
right join Employees e on o.EmployeeID = e.EmployeeID
group by e.EmployeeID, e.LastName, e.FirstName
having count(o.OrderID) <= all
	(select count(OrderID) from Orders group by EmployeeID)


--Exercise 31
--display information about employees who have maximum total orders
select e.EmployeeID, e.LastName, e.FirstName, count(o.OrderID) as 'Total_Orders'
from Orders o
right join Employees e on o.EmployeeID = e.EmployeeID
group by e.EmployeeID, e.LastName, e.FirstName
having count(o.OrderID) >= all
	(select count(OrderID) from Orders group by EmployeeID)

--Exercise 32
--In Products table, the value of UnitsInStock tells you the total unit in the
--inventory for every product. 
--display information about products that have maximum total unit in inventory
select ProductID, ProductName, SupplierID, CategoryID, UnitsInStock
from Products
where UnitsInStock >= all
(select UnitsInStock from Products)

--Exercise 33
--In Products table, the value of UnitsInStock tells you the total unit in the
--inventory for every product. display information about
--products that have minimum total unit in inventory
select ProductID, ProductName, SupplierID, CategoryID, UnitsInStock
from Products
where UnitsInStock <= all
(select UnitsInStock from Products)

--Exercise 34
--In Products table, the value of UnitsOnOrder tells you the total ordered unit
--for every product. display information about products that
--have maximum total ordered unit
select ProductID, ProductName, SupplierID, CategoryID, UnitsOnOrder
from Products
where UnitsOnOrder >= all
(select UnitsOnOrder from Products)

--Exercise 35
--In Products table, the value of ReOrderLevel tells you the re-order level for
--every product. display information about products that have maximum re-order level
select ProductID, ProductName, SupplierID, CategoryID, ReorderLevel
from Products
where ReorderLevel >= all
(select ReorderLevel from Products)

--Exercise 36
--display the information about employees who have maximum
--total delayed-orders

WITH EmployeeDelayedOrders AS (
    SELECT e.EmployeeID, e.LastName, e.FirstName, COUNT(o.OrderID) AS 'Delay Orders'
    FROM Employees e
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    WHERE o.[ShippedDate] > o.RequiredDate
    GROUP BY e.EmployeeID, e.LastName, e.FirstName
)
SELECT EmployeeID, LastName, FirstName, [Delay Orders]
FROM EmployeeDelayedOrders
WHERE [Delay Orders] = (SELECT MAX([Delay Orders]) FROM EmployeeDelayedOrders);


--Exercise 37
--display the information about employees who have at least one
--delayed-order and have minimum total delayed-orders


WITH EmployeeDelayedOrders AS (
    SELECT e.EmployeeID, e.LastName, e.FirstName, COUNT(o.OrderID) AS 'Delay Orders'
    FROM Employees e
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    WHERE o.[ShippedDate] > o.RequiredDate
    GROUP BY e.EmployeeID, e.LastName, e.FirstName
)
SELECT EmployeeID, LastName, FirstName, [Delay Orders]
FROM EmployeeDelayedOrders
WHERE [Delay Orders] <= all 
(SELECT [Delay Orders] 
FROM EmployeeDelayedOrders 
where [Delay Orders] <> 0);

--Exercise 38
--display product ids and product names of all products that
--have total ordered-units in three-highest level (top 3 to top 1)

with t as (select top 3 p.ProductID, p.ProductName, sum(d.Quantity) as 'Total Ordered'
from [Order Details] d
join Products p on d.ProductID = p.ProductID
group by p.ProductID, p.ProductName
order by [Total Ordered] desc)
select * from t
order by [Total Ordered] 

----Exercise 39
--display product ids and product names of all products that
--have total ordered-units in five-highest level (top 5 to top 1)

with t as (select top 5 p.ProductID, p.ProductName, sum(d.Quantity) as 'Total Ordered'
from [Order Details] d
join Products p on d.ProductID = p.ProductID
group by p.ProductID, p.ProductName
order by [Total Ordered] desc)
select * from t
order by [Total Ordered] 