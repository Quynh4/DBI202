USE [PE_DBI202_F2021]
--2
select * from [Location]
where CostRate >0

--3
select * from ProductPriceHistory
where year(EndDate) = 2003
and Price <100
order by Price desc

--4
select Product.ProductID, Product.[Name], Product.[Color], Product.SubcategoryID,ProductSubcategory.[Name] SubCategoryName, ProductCostHistory.StartDate, ProductCostHistory.EndDate, ProductCostHistory.Cost HistoryCost 
from 
Product
left join
ProductSubcategory
on Product.SubcategoryID = ProductSubcategory.SubcategoryID
left join
ProductCostHistory
on
Product.ProductID = ProductCostHistory.ProductID
where
Product.[Name] like 'HL%'
and color = 'Black'
order by
Product.ProductID

--5
SELECT Product.ProductID, Product.Name, sum(ProductInventory.Quantity) as TotalQuantity
FROM     Product INNER JOIN
                  ProductInventory ON Product.ProductID = ProductInventory.ProductID
group by Product.ProductID, Product.Name
having  sum(ProductInventory.Quantity) > 1700
order by TotalQuantity desc, [Name] 

--6
with t as(SELECT  ProductSubcategory.SubcategoryID, ProductSubcategory.Name SubcategoryName, ProductSubcategory.Category, count(distinct Product.ProductID) NumberOfProducts
FROM     ProductSubcategory INNER JOIN
                  Product ON ProductSubcategory.SubcategoryID = Product.SubcategoryID
group by ProductSubcategory.SubcategoryID, ProductSubcategory.Name, ProductSubcategory.Category
)
select * from t where NumberOfProducts <= all (select NumberOfProducts from t)

--7
-- model & max product of model
with tempCount as (
	select m.ModelID, m.Name ModelName, p.ProductID,  
	p.Name ProductName, count(p.ProductID) as NumberOfLocation
	from ProductModel m
	left join Product p on p.ModelID = m.ModelID
	left join ProductInventory on ProductInventory.ProductID = p.ProductID
	group by m.ModelID, m.Name, p.ProductID, p.Name
),
tempMax as (
select ModelID, max(NumberOfLocation) as maxnum from tempCount group by ModelID)

select t1.* from tempCount t1
join tempMax t2 on t1.ModelID = t2.ModelID and t1.NumberOfLocation = t2.MaxNum
where t1.ModelName like 'HL Mountain%' order by ModelID


--dap an cua dung
with temp as (
	select b.ModelID, b.Name as ModelName, t.ProductID, t.Name as ProductName, COUNT(t.LocationID) as NumberOfProducts
	from ProductModel b left join 
	(select a.*,d.LocationID from Product a 
	join ProductInventory c on a.ProductID = c.ProductID
	join Location d on d.LocationID = c.LocationID) as t 
	on b.ModelID = t.ModelID
	where b.Name like 'HL Mountain%'
	group by b.ModelID, b.Name, t.ProductID, t.Name
)
select * from temp t1
where not exists (
	select * from temp t2
	where t2.NumberOfProducts>t1.NumberOfProducts and t2.ModelID = t1.ModelID
)



--8
go
create proc proc_product_location 
@productId int, @numberOfLocation int output 
as
begin
	select @numberOfLocation = count( productId) from ProductInventory
	where productId = @productId
end

declare @x int
exec proc_product_location 1, @x output
select @x as NumberOfLocations

--9
go
create trigger tr_delete_productinventory_location 
on Productinventory
for delete
as
begin
	select * from deleted
end

delete from Productinventory
where ProductID = 1 and LocationID = 1

--10
select * from ProductInventory
UPDATE ProductInventory
SET quantity = 2000
WHERE  productid in (select productid from Product where modelid = 33)

