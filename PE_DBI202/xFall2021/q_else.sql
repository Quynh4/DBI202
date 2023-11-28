--q2
select * from location
where CostRate > 0

--q3
select * from ProductPriceHistory pph 
where Price < 100
and YEAR (pph.EndDate) = '2003'
order by pph.Price DESC

--q4
select p.ProductID, p.Name as ProductName, p.Color, ps.SubcategoryID, p.Name as SubCatergoryName, ps.Category, pch.StartDate, pch.EndDate, pch.Cost
from Product p
left join ProductSubcategory ps
on ps.SubcategoryID = p.SubcategoryID
left join ProductCostHistory pch
on pch.ProductID = p.ProductID
where p.Color = 'Black' 
and p.Name like 'HL%'

--q5
select l.LocationID, l.Name as LocationName, count(*) as NumberOfProducts 
from Location l, ProductInventory pi
where l.LocationID = pi.LocationID
group by l.LocationID, l.Name



