use PE_DBI202_F2021
--2
select * from ProductSubcategory
where Category='Accessories'
--3
select ProductID, Name, Color, Cost, Price from Product
where Cost<100 and SellEndDate is not null
order by Cost
--4
select p.ProductID, p.Name, p.Price,
m.Name as 'ModelName', 
s.Name as 'SubCategoryName'
from Product p
left join ProductModel m on m.ModelID = p.ModelID
left join ProductSubcategory s on s.SubcategoryID = p.SubcategoryID
where Price<100 and Color='Black'

--5
select s.SubcategoryID, s.Name as SubCategoryName,
s.Category,
count(distinct p.ProductID) as NumberOfProducts
from ProductSubcategory s
left join Product p on s.SubcategoryID = p.SubcategoryID
group by s.SubcategoryID, s.Name,s.Category
order by s.Category, 
count(distinct p.ProductID) desc

--6
with t as(
	select l.LocationID, l.Name as LocationName,
	count(distinct p.ProductID) as NumberOfProducts
	from ProductInventory p
	right join Location l on p.LocationID = l.LocationID
	group by l.LocationID, l.Name )
select LocationID, LocationName, NumberOfProducts
from t
where NumberOfProducts = (select MIN(NumberOfProducts) from t)

--7
WITH TempCount AS
(
	SELECT s.Category, s.Name AS SubCategoryName, COUNT(DISTINCT p.ProductID) AS NumberOfProducts FROM ProductSubcategory s
	JOIN Product p
	ON s.SubcategoryID = p.SubcategoryID
	GROUP BY s.Category, s.Name
)
,TempMax AS
(
	SELECT Category, MAX(NumberOfProducts) AS NumberOfProducts FROM TempCount
	GROUP BY Category
)

SELECT t.* FROM TempCount t
JOIN TempMax m
ON t.Category = m.Category AND t.NumberOfProducts = m.NumberOfProducts
ORDER BY NumberOfProducts DESC

--8
drop PROC proc_product_model
CREATE PROC proc_product_model
	@modelID INT,
	@numberOfProducts INT OUTPUT
AS
	BEGIN
		SELECT @numberOfProducts = COUNT(DISTINCT ProductID) FROM Product
		WHERE ModelID = @modelID
		RETURN
	END

--9
DROP TRIGGER tr_insert_Product 
CREATE TRIGGER tr_insert_Product
ON Product
AFTER INSERT
AS
BEGIN

	SELECT p.ProductID, p.Name AS ProductName, m.ModelID, m.Name AS ModelName FROM inserted p
	LEFT JOIN ProductModel m
	ON p.ModelID = m.ModelID
END


insert into Product(ProductID, Name, Cost, Price, ModelID, SellStartDate) 
values (1004, 'Product Test', 12.5, 15.5, 1, '2021-10-25')

--10
delete FROM ProductInventory 
WHERE ProductID IN 
	(
select ProductID from Product
where ModelID=33
	)


