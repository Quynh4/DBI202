
WITH t AS (SELECT od.ProductID,p.ProductName, COUNT(od.OrderID) AS'NumberOfOrders' 
FROM dbo.OrderDetails od,dbo.Product p WHERE od.ProductID = p.ID 
GROUP BY od.ProductID,p.ProductName)
SELECT * FROM t WHERE t.NumberOfOrders = (SELECT MIN(t.NumberOfOrders) FROM t)

-- Or
WITH t AS (SELECT od.ProductID,p.ProductName, COUNT(od.OrderID) AS'NumberOfOrders' 
FROM dbo.OrderDetails od inner join dbo.Product p on od.ProductID =p.ID 
GROUP BY od.ProductID,p.ProductName)
SELECT * FROM t WHERE t.NumberOfOrders = (SELECT MIN(t.NumberOfOrders) FROM t) 

-- Or
   
 SELECT top 1 with ties  od.ProductID,p.ProductName, 
 COUNT(od.OrderID) AS'NumberOfOrders' 
FROM dbo.OrderDetails od inner join dbo.Product p on od.ProductID =p.ID 
GROUP BY od.ProductID,p.ProductName order by NumberOfOrders
 
