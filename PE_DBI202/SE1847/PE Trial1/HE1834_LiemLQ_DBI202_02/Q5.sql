
SELECT od.ProductID,p.ProductName,od.Quantity FROM dbo.Product p, dbo.OrderDetails od 
WHERE od.ProductID=p.ID AND od.Quantity in (SELECT MAX(od.Quantity) 
FROM dbo.OrderDetails od) ORDER BY od.ProductID

-- Or
SELECT od.ProductID,p.ProductName,od.Quantity FROM dbo.Product p inner join dbo.OrderDetails od 
on od.ProductID=p.ID AND od.Quantity = (SELECT MAX(od.Quantity) 
FROM dbo.OrderDetails od) ORDER BY od.ProductID 
