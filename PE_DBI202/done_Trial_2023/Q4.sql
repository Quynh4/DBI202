SELECT OrderID, OrderDate, TotalAmount
FROM (
    SELECT o.ID as OrderID, o.OrderDate, 
        SUM(OrderDetails.Quantity * OrderDetails.SalePrice * (1 - OrderDetails.Discount)) AS TotalAmount
    FROM Orders o
    JOIN OrderDetails ON o.ID = OrderDetails.OrderID
    GROUP BY o.ID, o.OrderDate
) AS subquery
WHERE TotalAmount > 8000
ORDER BY TotalAmount DESC;