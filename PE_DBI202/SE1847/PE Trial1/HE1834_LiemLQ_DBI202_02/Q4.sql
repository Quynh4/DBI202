
WITH t AS(SELECT od.OrderID, o.OrderDate,SUM(od.Quantity*od.SalePrice*(1-od.Discount))
AS 'TotalAmount' FROM dbo.OrderDetails od, dbo.Orders o WHERE od.OrderID =o.ID 
GROUP BY od.OrderID,o.OrderDate)
SELECT * FROM t WHERE t.TotalAmount>8000 ORDER BY t.TotalAmount DESC

-- OR 
WITH t AS(SELECT od.OrderID, o.OrderDate,SUM(od.Quantity*od.SalePrice*(1-od.Discount))
AS 'TotalAmount' FROM dbo.OrderDetails od inner join  dbo.Orders o on od.OrderID =o.ID 
GROUP BY od.OrderID,o.OrderDate)
SELECT * FROM t WHERE t.TotalAmount>8000 ORDER BY t.TotalAmount DESC

-- OR
SELECT od.OrderID, o.OrderDate,SUM(od.Quantity*od.SalePrice*(1-od.Discount)     )
AS 'TotalAmount' FROM dbo.OrderDetails od inner join  dbo.Orders o on od.OrderID =o.ID 
GROUP BY od.OrderID,o.OrderDate having SUM(od.Quantity*od.SalePrice*(1-od.Discount) )>8000  
ORDER BY TotalAmount DESC






 

  



   
