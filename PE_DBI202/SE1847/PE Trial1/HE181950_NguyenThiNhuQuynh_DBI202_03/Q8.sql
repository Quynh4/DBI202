CREATE PROCEDURE TotalAmount
    @OrderID NVARCHAR(255),
    @TotalAmount FLOAT OUTPUT
AS
BEGIN
    SELECT @TotalAmount = SUM((SalePrice * Quantity) * (1 - Discount))
    FROM OrderDetails
    WHERE OrderID = @OrderID;
END