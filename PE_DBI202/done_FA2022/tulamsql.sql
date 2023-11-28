use PE_DBI202_F2022
--3 
select t.SupplierTransactionID, t.SupplierID, s.SupplierName,
t.TransactionDate, t.TransactionAmount
from SupplierTransactions t
join Suppliers s on t.SupplierID = s.SupplierID
where TransactionDate between '2013-2-1' and '2013-2-15'

--4
SELECT StockItems.StockItemID, StockItems.StockItemName, StockItems.SupplierID, Suppliers.SupplierName, 
StockItems.OuterPackageID, PackageTypes.PackageTypeName as OuterPackageTypeName, StockItems.UnitPrice
FROM     PackageTypes INNER JOIN
                  StockItems ON PackageTypes.PackageTypeID = StockItems.OuterPackageID 
				  INNER JOIN Suppliers ON StockItems.SupplierID = Suppliers.SupplierID
where StockItems.StockItemID >= 135
order by OuterPackageTypeName, StockItemName

--5
SELECT Suppliers.SupplierID, Suppliers.SupplierName, count(PurchaseOrders.PurchaseOrderID) as NumberOfPurchaseOrders
FROM     PurchaseOrders RIGHT JOIN  Suppliers ON PurchaseOrders.SupplierID = Suppliers.SupplierID
group by  Suppliers.SupplierID, Suppliers.SupplierName
order by NumberOfPurchaseOrders desc, SupplierName

--6
with t as(
SELECT PackageTypes.PackageTypeID, PackageTypes.PackageTypeName, count(StockItems.StockItemID) as NumberOfStockItems
FROM     StockItems JOIN
                  PackageTypes ON StockItems.OuterPackageID = PackageTypes.PackageTypeID AND StockItems.UnitPackageID = PackageTypes.PackageTypeID
group by PackageTypes.PackageTypeID, PackageTypes.PackageTypeName)
select * from t where NumberOfStockItems <= all (select NumberOfStockItems from t)

--7