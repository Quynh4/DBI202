SELECT c.ID, c.CustomerName, c.City, c.State
FROM Customer c
JOIN Orders o ON c.ID = o.CustomerID
WHERE o.OrderDate between '2017-12-5' and '2017-12-10'
and DATEDIFF(day, o.OrderDate, o.ShipDate) <3
ORDER BY c.State, c.City desc;
