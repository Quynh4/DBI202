-- 1
-- khong lam vi qua luoi

-- 2
select * from SubCategory where CategoryID = 3

-- 3
select c.ID, c.CustomerName, c.City, c.[State] from Customer c, Orders o
where c.ID = o.CustomerID
and OrderDate between '2017-12-05' and '2017-12-10' and year(o.ShipDate) = 2017 and month(o.ShipDate) = 12 and day(o.ShipDate) - day(o.OrderDate) < 3
order by [State] asc, City desc

-- 4
select s.ID as 'SubCategoryID', s.SubCategoryName, a.Count as 'NumberOfProducts' from SubCategory s, 
(select SubCategoryID, count(SubCategoryID)as 'Count' from Product
group by SubCategoryID) as a
where s.ID = a.SubCategoryID
and a.Count > 100
order by NumberOfProducts desc

-- 5
select b.ProductID, p.ProductName, b.Quantity from Product p, (select OrderID, ProductID, sum(Quantity) as 'Quantity' from OrderDetails
group by OrderID, ProductID) as b
where p.ID = b.ProductID
and b.Quantity = (
select max(a.Quantity) from (select OrderID, ProductID, sum(Quantity) as 'Quantity' from OrderDetails
group by OrderID, ProductID) as a)

--6
select CustomerID, CustomerName, count(CustomerID) as 'NumberOfOrders' from Orders o, Customer c
where CustomerID = c.ID
group by CustomerID, CustomerName
having count(CustomerID) = (
select max(a.NumberOfOrders) from (
select CustomerID, count(CustomerID) as 'NumberOfOrders' from Orders
group by CustomerID) as a)

-- 7
select * from (select top 5 p.SubCategoryID, count(p.SubCategoryID) as 'NumberOfProducts' from Product p, SubCategory s
where p.SubCategoryID = s.ID
group by p.SubCategoryID
order by NumberOfProducts desc) as a
union all
select * from (select top 5 p.SubCategoryID, count(p.SubCategoryID) as 'NumberOfProducts' from Product p, SubCategory s
where p.SubCategoryID = s.ID
group by p.SubCategoryID
order by NumberOfProducts asc) as b
order by NumberOfProducts desc

-- 8
create proc TotalAmount
(
@OrderID nvarchar(255),
@TotalAmount float output
)
as
begin
set @TotalAmount = (
select sum(d.Quantity * d.SalePrice * (1-d.Discount)) from Orders o, OrderDetails d
where o.ID = @OrderID and o.ID = d.OrderID
)
end

-- 9
create trigger InsertSubCategory on SubCategory
for insert
as
begin
select i.SubCategoryName, c.CategoryName from inserted i, Category c
where i.CategoryID = c.ID
end

-- 10
insert into Category(CategoryName) values ('Sports')
insert into SubCategory(SubCategoryName, CategoryID) values 
('Tennis', (select ID from Category where CategoryName = 'Sports')),
('Football', (select ID from Category where CategoryName = 'Sports'))