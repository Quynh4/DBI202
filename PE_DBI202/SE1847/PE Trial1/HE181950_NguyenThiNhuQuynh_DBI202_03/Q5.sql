SELECT o.ProductID, p.ProductName, o.Quantity
FROM OrderDetails o join Product p
on o.ProductID = p.ID
WHERE Quantity = (
    SELECT MAX(Quantity)
    FROM OrderDetails
)