	CREATE PROC TotalAmount (@OrderID NVARCHAR(255),@totalAMount FLOAT OUTPUT)
	AS
	BEGIN
	SET @totalAMount = (SELECT a.Amount from (SELECT od.OrderID,SUM(od.Quantity*od.SalePrice*(1-od.Discount)) 
	AS 'Amount'FROM dbo.OrderDetails od GROUP BY od.OrderID ) AS a WHERE a.OrderID = @OrderID )
	RETURN @totalAMount
	END


	--Xóa khi nộp bài
	go

	DECLARE @t FLOAT;
	EXEC dbo.TotalAmount N'CA-2014-100006', @t output
						 PRINT @t