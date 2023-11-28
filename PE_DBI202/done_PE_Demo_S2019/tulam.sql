use PE_Demo_S2019
--2
select * from Customer
where City = 'Arlington' and Segment='Consumer'

--3
select c.* from Customer c
join Orders o on c.ID = o.CustomerID
where c.CustomerName like 'B%'
and year(o.OrderDate)=2017 and month(o.OrderDate)=12
order by c.Segment desc, c.CustomerName

--4
with t as (SELECT SubCategory.ID as SubCategoryID, SubCategory.SubCategoryName, count(Product.ID) AS NumeberOfProducts 
FROM     SubCategory LEFT JOIN
                  Product ON SubCategory.ID = Product.SubCategoryID
GROUP BY SubCategory.ID , SubCategory.SubCategoryName)
select * from t where NumeberOfProducts > 100
order by NumeberOfProducts desc


--5
SELECT x.ProductID, p.ProductName, x.Quantity
FROM Product p
JOIN (SELECT ProductID, Quantity FROM OrderDetails) AS x
ON x.ProductID = p.ID
WHERE x.Quantity = (SELECT MAX(Quantity) FROM OrderDetails);

--6
with t as(SELECT Orders.CustomerID , Customer.CustomerName, count(Orders.ID) as NumberOfOrders
FROM     Customer  left JOIN
                  Orders ON Customer.ID = Orders.CustomerID
group by Orders.CustomerID , Customer.CustomerName)
select * from t where NumberOfOrders = (select max(NumberOfOrders) from t)

--8
create proc CountProduct 
@OrderID nvarchar(255), @NbProducts int out 
as
begin
	select @NbProducts = count(ProductID) from OrderDetails
	where OrderID = @OrderID
	group by OrderID
end

declare @t int
exec CountProduct'CA-2014-100391', @t output 
print @t

--9
create trigger InsertProduct 
on Product
for insert
as
begin
	SELECT inserted.ProductName, SubCategory.SubCategoryName
	FROM   inserted INNER JOIN  SubCategory ON inserted.SubCategoryID = SubCategory.ID
end

insert into Product(ProductName, UnitPrice, SubCategoryID)
values ('Craft paper', 0.5, 3)

--10
