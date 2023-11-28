WITH HighestPrices AS (
  SELECT TOP 5 ID, ProductName, UnitPrice, SubCategoryID
  FROM Product
  ORDER BY UnitPrice DESC
),
LowestPrices AS (
  SELECT TOP 5 ID, ProductName, UnitPrice, SubCategoryID
  FROM Product
  ORDER BY UnitPrice ASC
)
SELECT ID, ProductName, UnitPrice, SubCategoryID
FROM HighestPrices
UNION ALL
SELECT ID, ProductName, UnitPrice, SubCategoryID
FROM LowestPrices
ORDER BY UnitPrice DESC;