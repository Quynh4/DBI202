
SELECT c.ID, c.CustomerName,c.Segment,c.Country,c.City,c.State,c.PostalCode,c.Region 
FROM dbo.Customer c,dbo.Orders o 
WHERE o.CustomerID=c.ID and c.CustomerName LIKE 'B%' 
AND  o.OrderDate between '2017-12-01' and '2017-12-31'  
ORDER BY c.Segment DESC ,c.CustomerName ASC

-- OR
SELECT c.ID, c.CustomerName,c.Segment,c.Country,c.City,c.State,
c.PostalCode,c.Region 
FROM dbo.Customer c inner join dbo.Orders o 
on o.CustomerID=c.ID and c.CustomerName LIKE 'B%' 
AND  o.OrderDate between '2017-12-01' and '2017-12-31' 
ORDER BY c.Segment DESC ,c.CustomerName ASC

-- OR
SELECT c.* FROM dbo.Customer c inner join dbo.Orders o 
on o.CustomerID=c.ID and c.CustomerName LIKE 'B%' 
AND  o.OrderDate between '2017-12-01' and '2017-12-31' 
ORDER BY c.Segment DESC ,c.CustomerName ASC