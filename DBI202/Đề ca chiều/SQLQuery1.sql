--Q2 giá lớn hơn 0
select l.LocationID, l.Name, l.CostRate, l.Availability from Location l
where l.CostRate > 0
-- Q3 năm 2003 và giá < 100 sắp xếp giảm dần
select h.ProductID, h.Price as Price, h.StartDate, h.EndDate from ProductPriceHistory h
where year(h.EndDate) = 2003
and h.Price < 100 
order by h.Price desc
-- Q4
select p.ProductID, p.[Name], p.Color, s.SubcategoryID, s.Name, s.Category,  h.StartDate, h.EndDate, h.Cost as HistoryCost
from  Product p
left join ProductSubcategory s
on s.SubcategoryID = p.SubcategoryID
left join ProductCostHistory h
on h.ProductID = p.ProductID
where p.Color= 'Black' and p.Name like 'HL%'

-- Q5 count
select l.LocationID, l.Name as LocationName, COUNT(*) as NumberOfProducts
from Location l, ProductInventory i 
where i.LocationID = l.LocationID
group by l.LocationID, l.Name
order by NumberOfProducts asc

-- Q7: Write a query to display, for each product model having the name beginning with 'HL Mountain',
-- the information of the products which are stored in most locations. 
-- Display the information with the following attributes:
-- Modell D, ModelName, ProductID, ProductName, NumberOfLocations; 
-- where NumberOfLocations is the number of distinct locations where we found the corresponding product of the given model.
-- For example, among different products of the model 'HL Mountain Frame', 
-- two products which are stored in the most number of locations are product 747 and 748.

select pm.ModelID, pm. Name as ModelName, p.ProductID, p.Name as ProductName,
count (p.ProductID) as NumberOfLocations 
from ProductInventory pdi
left join Product p on pdi.ProductID = p.ProductID 
right join ProductModel pm on pm. ModelID = p. ModelID
where pm. Name like 'HL Mountain%'
group by pm.ModelID, pm. Name, p.ProductID, p.Name


-- Q8
drop proc proc_product_subcategory
create proc proc_product_subcategory @subcategoryID int, @NumberOfProduct int out
as
begin 
	set @NumberOfProduct = (select count(p.ProductID) 
	from ProductSubcategory ps, Product p 
	where p. SubcategoryID = ps. SubcategoryID and ps.SubcategoryID= @subcategoryID)
end

declare @x int
exec proc_product_subcategory 1, @x output
select @x as NumberOfProducts

-- Q9
drop trigger tr_delete_productInventory
create trigger tr_delete_productInventory 
on ProductInventory instead of delete
as
begin
	select d.ProductID, d.LocationID, l.Name as LocationName, d.Shelf, d.Bin, d.Quantity 
	from deleted d, Product p, Location l
	where d.ProductID = p.ProductID and l.LocationID= d. LocationID
end

delete from ProductInventory
where ProductID = 1 and LocationID = 1