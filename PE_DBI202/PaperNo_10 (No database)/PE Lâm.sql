--1

CREATE TABLE Customers (
	SSN VARCHAR(20) PRIMARY KEY,
	[Name] NVARCHAR(50),
	[Address] NVARCHAR(255)
)
CREATE TABLE Loans(
	LoanNumber VARCHAR(20) PRIMARY KEY,
	Amount FLOAT,
	[Date] DATE,
	Branch NVARCHAR(100),
	SSN VARCHAR(20) FOREIGN KEY REFERENCES dbo.Customers(SSN)
)
CREATE TABLE Payments(
	PaymentNo VARCHAR(30) PRIMARY KEY,
	Amount FLOAT,
	[Date] DATE,
	LoanNumber VARCHAR(20) FOREIGN KEY REFERENCES dbo.Loans(LoanNumber)
)
--2
SELECT * FROM dbo.stores
--3
SELECT customer_id, first_name, last_name, city, state  FROM dbo.customers
WHERE city = 'Bellmore' OR city = 'New York'
order by city desc
--4
select a.product_id, a.product_name,a.list_price, a.brand_name, a.category_name, b.store_id, b.quantity
from products as a inner join stocks as b on a.product_id=b.product_id
where b.store_id = 1 and b.quantity >25
order by a.category_name asc, a.list_price desc
--5
SELECT a.staff_id, a.first_name, a.last_name, COUNT(b.order_id) as 'NumberOfOrders'
FROM dbo.staffs AS a LEFT JOIN dbo.orders AS b ON b.staff_id = a.staff_id
AND YEAR(b.order_date) = 2016
GROUP BY a.staff_id, a.first_name, a.last_name
ORDER BY 'NumberOfOrders' DESC
--6
SELECT a.product_id, a.product_name, a.model_year, b.store_id, b.quantity FROM dbo.products AS a 
INNER JOIN dbo.stocks AS b ON b.product_id = a.product_id
AND b.quantity =(
	SELECT MIN(x.num) FROM (SELECT quantity AS num  FROM dbo.stocks 
	GROUP BY store_id, quantity)x 
)
go
--8
CREATE PROC proc2
@store_name VARCHAR(255), @numberOfOrder INT OUTPUT
AS
BEGIN
    SELECT @numberOfOrder = COUNT(a.order_id) FROM dbo.orders AS a JOIN dbo.stores AS b ON b.store_id = a.store_id
	WHERE @store_name = b.store_name
	GROUP BY a.store_id
END

go
--9

CREATE TRIGGER trigger_update_orderItems ON dbo.order_items
AFTER UPDATE
AS 
BEGIN
    SELECT a.order_id,a.item_id, a.product_id, (a.list_price* a.quantity*(1-a.discount))'OldAmount' ,
	(b.list_price* b.quantity*(1-b.discount))'NewAmount'  
	FROM Deleted AS a JOIN Inserted AS b ON b.order_id = a.order_id
END
--10
INSERT INTO dbo.staffs
    (
        staff_id,
        first_name,
        last_name,
        email,
        active,
        store_id,
        manager_id
    )
VALUES
    (
        19,  -- staff_id - int
        'White', -- first_name - varchar(50)
        'Mary', -- last_name - varchar(50)
        'white.mary@bikes.shop', -- email - varchar(255)
        1,  -- active - tinyint
        3,  -- store_id - int
        7   -- manager_id - int
    )

