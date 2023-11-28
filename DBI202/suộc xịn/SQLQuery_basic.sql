-- select all from one table
select * from Products

select * from Customers

-- all những khách hàng không mua trong tháng 6
select distinct Orders.CustomerID, Customers.Name
from Orders join Customers
on Orders.CustomerID = Customers.CustomerID
having Orders.CustomerID not in (
	select distinct CustomerID
	from Orders
	where month(Orders.Date) = 6
) and not date is null

-- find ProductCode, Name of each product
select ProductCode, Name
from Products

-- find Address of each customer
select Address
from Customers

-- chọn các dữ liệu riêng biệt
select distinct address 
from Customers

-- phép chiếu mở rộng: extended projection
-- tìm CustomerID, CustomerName của từng khách hàng
select CustomerID, Name as CustomerName
from Customers

select CustomerID, CustomerName = Name
from Customers

-- tìm productCode, Name, StockQuantity, Price, Amount của từng sản phẩm
select ProductCode, Name, StockQuantity, Price, Amount = StockQuantity*Price
from Products

-- tìm productCode, Name, PriceVND của từng sản phẩm
-- Price trong bảng product là theo USD, tỉ giá 23000VND = 1 USD
select ProductCode, Name, PriceVND = 23000*Price
from Products

-- Hiển thị thông tin của từng dòng chi tiết hoá đơn bao gồm 
-- OrderID, ProductCode, Quantity, SellPrice, AmountUSD/VND
select OrderID, ProductCode, Quantity, SellPrice, AmountUSD = Quantity*SellPrice,
AmountVND = Quantity*SellPrice*23000
from OrderItems

-- Chỉ muốn hiển thị những dòng đầu tiên trong bảng
select top 3 *  -- hiển thị 3 dòng đầu tiên của bảng customers
from Customers 

-- Chỉ muốn hiển thị số phần trăm dòng đầu tiên trong danh sách
select top 50 percent *
from Customers

-- lấy phầm trăm của 1 số lượng dòng lẻ -> làm tròn số hàng:
select top 50 percent * 
from Products

-- chọn các dòng thoả mãn điều kiện bằng where 
-- chọn các khách hàng ở Bình Chánh
select * 
from Customers
where Address = N'Bình Chánh'

-- tìm CustomerID và Name của các khách hàng ở Tân Bình hoặc Bình Chánh
select CustomerID, Name
from Customers
where Address = N'Bình Chánh' or Address = N'Tân Bình'

-- tìm productcode, ProductName, PriceVND của các sản phẩm có 150000<=PriceVND<=400000
select ProductCode, Name as ProductName , PriceVND = Price * 23000
from Products
where Price >= 150000/23000 and Price <= 400000/23000 

-- tìm orderID, productCode, sellprice, quantity, Amount của các sản phẩm có amount < 500 hoặc > 2000
select OrderID, ProductCode, Quantity, SellPrice, Amount = Quantity*SellPrice
from OrderItems
where Quantity*SellPrice < 500 or Quantity*SellPrice > 2000

-- tìm tên của người dùng mà không có email
select Name 
from Customers
where Email is null

-- tìm productcode, productName, CategoryID của sản phẩm không thuộc loại 1, 3
select ProductCode, Name as ProductName, CategoryID 
from Products
where CategoryID <> 1 and CategoryID <> 3

-- tìm hoá đơn trong tháng 5 và tháng 6 năm 2000 của khách hàng C01
select * 
from Orders
where (Date >= '2000-05-01' and Date <=  '2000-06-30') and CustomerID = 'C01' 

-- hoặc dùng hàm lấy năm, tháng
select * 
from Orders
where Month(Date) in (5,6) and Year(Date) = 2000 and CustomerID = 'C01'

-- so sánh xâu ký tự: >=, <=, =, <>
-- Name : Phuong

-- So sánh xâu ký tự với định dạng: s like p, s not like p
-- s là thuộc tính kiểu xâu ký tự
-- p là định dạng
select * 
from Customers
where Name like '%p%' 

-- định dạng p:
-- %: thay cho 1 chuỗi có >= 0 kí tự
-- _: thay cho 1 kí tự bất kỳ
-- []: một ký tự trong số các ký tự 'a', 'A', 'b', 'B', 'c', 'C'
-- [a-z]: một ký tự là chữ cái
-- [0-9]: một ký tự là số
-- [^abc]: một ký tự bất kỳ khác a,b,c
-- [^0-9]: 1 ký tự không phải là số 

select * from Customers
where Name like '%a%' -- tìm các Name có chứa kí tự 'a' hoặc 'A'

select * 
from Customers
where Name like '_a%'

-- Tìm các khách hàng họ Lê
select * 
from Customers
where Name like N'Lê %'

-- các khách hàng có tên bắt đầu bằng T hoặc L
select * 
from Customers
where Name like '[TL]%'

-- tìm các sản phầm là màn hình LCD
select * 
from Products
where Name like '%LCD Monitor%'

-- tìm khách hàng có số điện thoại bắt đầu bằng 08 hoặc 09
select *
from Customers 
where Phone like '0[89]%'

-- tìm các khách hàng có số điện thoại hợp lệ
select * 
from Customers
where Phone not like '%[^0-9]%'

--sắp xếp kết quả:
-- sắp xếp tăng dần theo Name:
select * from Customers
order by Name ASC

-- sắp xếp hoá đơn giảm dần theo Date:
select * 
from Orders
order by Date DESC

-- sắp xếp theo nhiều thuộc tính
select * from Orders
order by CustomerID ASC, Date DESC

-- sắp xếp tăng dần theo CusID, với những dòng có CusID bằng nhau thì sắp xếp giảm dần theo Date

-- Hiển thị ProductCode, Name, Price, Amount (Price * StockQuantity)
-- của từng sản phẩm có amount >100000, sắp xếp giảm dần theo Amount
select ProductCode, Name, Price, Amount = Price*StockQuantity
from Products
where Price*StockQuantity > 10000
order by Amount DESC

-- Hiển thị CusID, OrderID, year, month, của các hoá đơn khách hàng 
-- C01 hoặc C02, sắp xếp giảm dần theo thời gian
select CustomerID, OrderID, Year = year(Date), Month = month(date)
from Orders
where CustomerID like 'C0[1-2]'
order by Year DESC, Month DESC

-- Tìm 1 sản phẩm có price nhỏ nhất
select top(1) *
from Products
order by Price

-- Phép nhân: A x B: nối từng dòng của bảng A với từng dòng của bảng B

-- nhân products với categories không điều kiện
select * 
from Products, Categories

-- phép join nhân 2 bảng, chọn ra các dòng thoả mãn điều kiện join
-- để điều kiện join trong where

select * 
from Products, Categories
where Products.CategoryID = Categories.ID
order by Categories.ID

-- join nhiều bảng : A,B,C,...
-- Hiển thị OrderID, Date, CustomerID, CustomerName tương ứng với từng hoá đơn

select Orders.OrderID, Orders.Date, Orders.CustomerID, Customers.Name as CustomerName 
from Orders, Customers
where Orders.CustomerID = Customers.CustomerID

-- Hiển thị OrderID, Date, ProductCode, Quantity, SellPrice, Amount của từng dòng 
-- chi tiết hoá đơn của các hoá đơn trong tháng 5 2020

select OrderItems.OrderID, Orders.Date, OrderItems.ProductCode, OrderItems.Quantity,
OrderItems.SellPrice, Amount = OrderItems.Quantity*OrderItems.SellPrice
from OrderItems, Orders
where month(Orders.Date) = 5 and YEAR(Orders.Date) = 2000

--Hiển thị ProductCOde, Name, CategoryName của các sản phầm bán được trong 5/2020

select distinct Products.ProductCode, Products.Name, Categories.Name
from Categories, Products, OrderItems, Orders 
where (month(Orders.Date) = 5 and YEAR(Orders.Date) = 2000)
and Categories.ID = Products.CategoryID 
and Products.ProductCode = OrderItems.ProductCode
and OrderItems.OrderID = Orders.OrderID

-- Hiển thị CustomerID, CustomerName, OrderID, Date, ProductCode, ProductName, Quantity,
-- SellPrice, Amount của các hoá đơn trong 5-6/2000 của khách hàng Nguyễn Thị Bé

select Customers.CustomerID, Customers.Name as CustomerName, Orders.OrderID, Orders.Date,
Products.ProductCode, OrderItems.Quantity, OrderItems.SellPrice, 
Amount = OrderItems.Quantity*OrderItems.SellPrice
from Products, OrderItems, Orders, Customers
where Customers.Name = N'Nguyễn Thị Bé' 
and Month(Orders.Date) in (5,6) and Year(Orders.Date) = 2000
and Customers.CustomerID = Orders.CustomerID
and Products.ProductCode = OrderItems.ProductCode
and OrderItems.OrderID = Orders.OrderID


-- cú pháp khác để join (inner join)
/*
select *
from A inner join B on điều_kiện_join

select *
from A inner join B on điều_kiện_join A và B
inner join C on điều_kiện_thêm_C
*/

select * 
from Customers inner join Orders
on Customers.CustomerID = Orders.CustomerID

select *
from Customers inner join Orders
on Customers.CustomerID = Orders.CustomerID
inner join OrderItems on Orders.OrderID = OrderItems.OrderID

-- customerid, name của những khách hàng mua 'mouse' trong 5-6/2000

select distinct Customers.CustomerID, Customers.Name
from Customers inner join Orders
on Orders.CustomerID = Customers.CustomerID
inner join OrderItems on OrderItems.OrderID = OrderItems.OrderID
inner join Products on Products.ProductCode = OrderItems.ProductCode
and Products.Name = 'Mouse'

-- 2 productcode, productname, categoryname của sản phẩm đã từng được mua bởi
-- Nguyễn thị bé hoặc Mai thị Quế Anh

select distinct Products.ProductCode, Products.Name as ProductName, Categories.Name as CategoryName
from Categories inner join Products
on Categories.ID = Products.CategoryID
inner join OrderItems on Products.ProductCode = OrderItems.ProductCode
inner join Orders on Orders.OrderID = OrderItems.OrderID
inner join Customers on Orders.CustomerID = Customers.CustomerID 
and Customers.Name in (N'Nguyễn Thị Bé', N'Mai Thị Quế Anh')

-- 3 productcode, productname, categoryname của 
-- 1 sản phầm được mua nhiều nhất tháng 5/2000

select top 1 Products.ProductCode, Products.Name as ProductName, Categories.Name as CategoryName
from Categories inner join Products
on Categories.ID = Products.CategoryID
inner join OrderItems on Products.ProductCode = OrderItems.ProductCode
inner join Orders on Orders.OrderID = OrderItems.OrderID
and month(Orders.Date) = 5 and year(Orders.Date) = 2000
order by OrderItems.Quantity DESC

-- outer join: cho phép giữ lại những record, những phần tử không thoả mãn điều kiện join
-- có left outer join và right outer join 

select * 
from Customers right join Orders 
on Customers.CustomerID = Orders.CustomerID

--1 thông tin của khách hàng chưa từng mua hàng

select * 
from Customers left join Orders
on Customers.CustomerID = Orders.CustomerID
where Customers.Name is Null

-- Tìm CustomerID, Name của khách hàng không mua hàng trong tháng 5/2000
select distinct Customers.CustomerID, Name
from Customers left join Orders
on Customers.CustomerID = Orders.CustomerID
and Month(Orders.Date) = 5 and Year(Orders.Date) = 2000
where Orders.OrderID is null

-- Tìm productcode, productname, categoryname của sản phẩm không bán được trong 6/2000
select distinct Products.ProductCode, Products.Name as ProductName,
Categories.Name as CategoryName
from Orders join OrderItems on  Orders.OrderID = OrderItems.OrderID
and Month(Orders.Date) = 6 and Year(Orders.Date) = 2000
right join Products on Products.ProductCode = OrderItems.ProductCode
join Categories on Categories.ID = Products.CategoryID
where Orders.OrderID is null

-- tìm productcode, productname, categoryname của sản phẩm chưa bao giờ được mua
-- bởi Nguyễn Thị bé
select distinct Products.ProductCode, Products.Name as ProductName, Categories.Name as CategoryName
from Customers join Orders on Customers.CustomerID = Orders.CustomerID
and Customers.Name = N'Nguyễn Thị Bé'
join OrderItems on OrderItems.OrderID = Orders.OrderID
right join Products on Products.ProductCode = OrderItems.ProductCode
join Categories on Categories.ID = Products.CategoryID
where Orders.OrderID is null

-- tạo bảng EmployeeID để lấy ví dụ cho self-join
create table Employee(
	EmployeeID int primary key,
	Name nvarchar(50),
	ManagerID int references Employee(EmployeeID)
)


insert into Employee
values(101, 'A', null),
(102, 'B', 101),
(124, 'C', 101),
(149, 'D', 101),
(201, 'E', 200),
(200, 'F', 200),
(206, 'G', 200)

-- Hiển thị Employee_ID, ManagerName của từng nhân viên
select emp.EmployeeID, emp.Name, manager.Name as ManagerName
from Employee emp left outer join Employee manager
on emp.ManagerID = manager.EmployeeID

-- Hợp (union), giao (intersect), trừ(except)
-- các bảng phải có cùng tập thuộc tính
-- select -> truy vấn ra bảng A
-- union/union all/ intersect/ except
-- select ... -> truy vấn ra bảng B có cùng tập thuộc tính

select CustomerID
from Customers
intersect
select distinct CustomerID
from Orders

-- Hiển thị CustomerID của khách hàng mua hàng trong tháng 5/2000
-- nhưng không mua trong tháng 6/2000

select distinct CustomerID
from Orders
where month(Orders.Date) = 5 and YEAR(Orders.Date) = 2000
except
select distinct CustomerID
from Orders
where month(Orders.Date) = 6 and YEAR(Orders.Date) = 2000



-- Hiển thị productcode, productname, categoryname của sản phẩm mua bởi cả
-- Nguyễn Thị Bé và Mai Thị Quế Anh
select distinct Products.ProductCode, Products.Name as ProductName, Categories.Name as CategoryName
from Categories inner join Products
on Categories.ID = Products.CategoryID
inner join OrderItems on Products.ProductCode = OrderItems.ProductCode
inner join Orders on Orders.OrderID = OrderItems.OrderID
inner join Customers on Orders.CustomerID = Customers.CustomerID 
and Customers.Name = N'Nguyễn Thị Bé' 
intersect
select distinct Products.ProductCode, Products.Name as ProductName, Categories.Name as CategoryName
from Categories inner join Products
on Categories.ID = Products.CategoryID
inner join OrderItems on Products.ProductCode = OrderItems.ProductCode
inner join Orders on Orders.OrderID = OrderItems.OrderID
inner join Customers on Orders.CustomerID = Customers.CustomerID 
and Customers.Name = N'Mai Thị Quế Anh'

-- Tìm ProductCode, Name của tất cả sản phẩm có giá cao nhất
select *
from Products
except
select *
from Products P1 join Products P2 on P1.Price > P2.Price

-- Tìm customer ID, Name của các khách hàng chưa từng mua các sản phẩm mà
-- "Mai thị quế anh" mua
select CustomerID, Name
from Customers
except
select c2.CustomerID, c2.Name
from Customers c1 join Orders o1 on c1. CustomerID = o1.CustomerID
and c1.Name = 'Lê Hoàng Nam'
join OrderItems oi1 on oi1.OrderID = o1.OrderID
join OrderItems oi2 on oi1.ProductCode = oi2.ProductCode
join Orders o2 on o2.OrderID = oi2.OrderID
join Customers c2 on c2.CustomerID = o2.CustomerID

-- Tìm các khách hàng có địa chỉ giống khách hàng 'Nguyễn Thị Bé'
select *
from Customers
where Address = (select Address
				from Customers
				where Name = N'Nguyễn Thị Bé')

-- Tìm ProductCode, Name, CategoryName của sản phẩm có price >= Price của mouse và 
-- <= Price của Keyboard
select Products.ProductCode, Products.Name, Categories.Name as CategoryName
from Products join Categories on Products.CategoryID = Categories.ID
where Products.Price >= (select Price 
from Products where Name = 'Mouse')
and Products.Price <= (select Price 
from Products where Name = 'Keyboard')

-- Tìm ProductCode, Name, CategoryName của sản phẩm có StockQuantity lớn hơn
-- StockQuantity của cả Mouse và Keyboard

select Products.ProductCode, Products.Name, Categories.Name as CategoryName
from Products join Categories on Products.CategoryID = Categories.ID
where Products.StockQuantity > (
select top 1 StockQuantity 
from Products where Name in ('Mouse', 'Keyboard')
order by StockQuantity DESC) 

-- dùng all để biểu thị lớn hơn toàn bộ 1 tập giá trị nào đó 
select Products.ProductCode, Products.Name, Categories.Name as CategoryName
from Products join Categories on Products.CategoryID = Categories.ID
where Products.StockQuantity > all(
select StockQuantity 
from Products where Name in ('Mouse', 'Keyboard')) 

-- Tìm ProductCode, Name, CategoryName của các sản phẩm có price lớn
-- hơn price của mouse hoặc keyboard
select Products.ProductCode, Products.Name, Categories.Name as CategoryName
from Products join Categories on Products.CategoryID = Categories.ID
where Products.Price > any (select Price 
from Products where Name in ('Mouse', 'Keyboard'))

-- any: so ánh với any là so sánh với bất kỳ giá trị nào trong tập thoả mãn

-- Tìm ProductCode, Name của sản phẩm thuộc 'Stationery' hoặc 'Hardware'
select Products.ProductCode, Products.Name CategoryName
from Products join Categories on Products.CategoryID = Categories.ID
where Categories.Name = 'Stationery'
or Categories.Name = 'Computer hardware'

-- Tìm các khách hàng không mua hàng trong tháng 5/2000
select Customers.Name, Orders.Date
from Customers join Orders on Orders.CustomerID = Customers.CustomerID
where not Orders.Date in (select Date from Orders where YEAR(Date) = 2000 and MONTH(Date) = 5) 

-- Tìm tất cả sản phẩm có StockQuantity nhỏ nhất
select *
from Products
where StockQuantity <= all(select StockQuantity from Products)

-- exists, not exists
-- tìm các khách hàng có hoá đơn
select * from Customers
where exists (select*
	from Orders
	where Customers.CustomerID = Orders.OrderID)

-- Truy vấn trong from
select distinct CustomerID, Name
from(
select Customers.CustomerID, Name, OrderID, Date
from Customers join Orders
on Customers.CustomerID = Orders.CustomerID) t
where Month(Date) = 5 and Year(Date) = 2000

with t as(
select Customers.CustomerID, Name, OrderID, Date
from Customers join Orders
on Customers.CustomerID = Orders.CustomerID
)
select distinct CustomerID, Name
from t 
where Month(Date) = 5 and Year(Date) = 2000

-- Tìm customerID, name của khách hàng đã mua cả mouse, keyboard
with t as(
select distinct Customers.CustomerID, Customers.Name
from Customers join Orders on Customers.CustomerID = Orders.CustomerID
join OrderItems on Orders.OrderID = OrderItems.OrderID
join Products on Products.ProductCode = OrderItems.ProductCode
where Products.Name = 'Mouse'
),
s as(
select distinct Customers.CustomerID, Customers.Name
from Customers join Orders on Customers.CustomerID = Orders.CustomerID
join OrderItems on Orders.OrderID = OrderItems.OrderID
join Products on Products.ProductCode = OrderItems.ProductCode
where Products.Name = 'Keyboard'
)
select CustomerID, Name
from t intersect 
select CustomerID, Name
from s


go
-- Tìm ProductCode, Name, CtegoryName của sản phẩm bán được trong 5/2000 nhưng không
-- bán được trong 6/2000
with t as(
select distinct Products.ProductCode, Products.Name as ProductName, Categories.Name as CategoryName
from Categories inner join Products
on Categories.ID = Products.CategoryID
inner join OrderItems on Products.ProductCode = OrderItems.ProductCode
inner join Orders on Orders.OrderID = OrderItems.OrderID
and month(Orders.Date) = 5 and year(Orders.Date) = 2000
),
s as(
select distinct Products.ProductCode, Products.Name as ProductName, Categories.Name as CategoryName
from Categories inner join Products
on Categories.ID = Products.CategoryID
inner join OrderItems on Products.ProductCode = OrderItems.ProductCode
inner join Orders on Orders.OrderID = OrderItems.OrderID
and month(Orders.Date) = 6 and year(Orders.Date) = 2000
)
select *
from t
except
select *
from s

go

--Tìm CustomerID, Name của khách hàng chưa từng mua sản phẩm mà 'Lê Hoàng nam' đã mua
with t as(select distinct Customers.CustomerID, Customers.Name, OrderItems.ProductCode
from Customers join Orders on Customers.CustomerID = Orders.CustomerID
join OrderItems on Orders.OrderID = OrderItems.OrderID
)
select CustomerID, Name
from Customers
except
select CustomerID, Name from t
where ProductCode in (
	select ProductCode
	from t where Name  = N'Lê Hoàng Nam'
)

-- các hàm có sẵn trong SQL:
-- sum -> tính tổng
-- avg -> tính giá trị trung bình
-- min, max -> giá trị lớn nhất, nhỏ nhất

-- tìm price nhỏ/lớn nhất trong bảng Products
select min(Price) from Products

select min(Price) from Products

-- Tìm các sản phẩm có Quantity nhỏ nhất trong bảng Products
select * from Products 
where StockQuantity = (select min(StockQuantity) from Products)

-- Tìm hoá đơn cuối cùng của khách hàng C01
select *
from Orders 
where Orders.CustomerID = 'C01'
and Date = (select max(Date) from Orders)

-- Tìm tổng tiền mà khách hàng C01 đã bỏ ra để mua hàng trong tháng 5/2000
select sum(Quantity*SellPrice)
from Customers join Orders on Customers.CustomerID = Orders.CustomerID
join OrderItems on Orders.OrderID = OrderItems.OrderID
where Month(Orders.Date) = 5 and Year(Orders.Date) = 2000
and Customers.CustomerID = 'C01'

-- hàm count đếm số dòng thoả mãn điều kiện
select count(*)
from Customers

select count(CustomerID)
from Customers

-- đếm Address phân biệt trong customers
select count(distinct(Address))
from Customers

-- đếm các khách hàng có địa chỉ Email
select count(Email)
from Customers
where Email like '%'

-- đếm số lượng hoá đơn của khách hàng C01
select count(OrderID)
from Customers join Orders on Customers.CustomerID = Orders.CustomerID
where Customers.CustomerID = 'C01'

-- đếm số lượng hoá đơn và tổng tiền trong 5/2000
select count(distinct(Orders.OrderID)) as NumberOfOrder, sum(Quantity*SellPrice) as SumOfPay
from Customers join Orders on Customers.CustomerID = Orders.CustomerID
join OrderItems on OrderItems.OrderID = Orders.OrderID
where Customers.CustomerID = 'C01'
and month(Orders.Date) = 5 and year(Orders.Date) = 2000

-- group by : các dòng có cùng giá trị của các thuộc tính trong group by sẽ được coi 
-- là cùng 1 nhóm --> các hàm aggregate function sẽ tính cho từng nhóm
select CustomerID, count(*)
from Orders
group by CustomerID

-- Tìm CustomerId, CustomerName, NumberOfOrders của từng khách hàng 
select Customers.CustomerID, Customers.Name as CustomerName, count(OrderID) as NumberOfOrders
from Customers left join Orders on Orders.CustomerID = Customers.CustomerID
group by Customers.CustomerID, Customers.Name

-- Tìm CustomerID, CustomerName, NameOfOrders, TotalAmount mà từng khách hàng mua 
-- trong 5/2000
select Customers.CustomerID, Customers.Name as CustomerName,
count(distinct(Orders.OrderID)) as NumberOfOrder, 
isnull(sum(Quantity*SellPrice), 0) as TotalAmount
from OrderItems join Orders on OrderItems.OrderID = Orders.OrderID
and month(Orders.Date) = 5 and year(Orders.Date) = 2000
right join Customers on Customers.CustomerID = Orders.CustomerID
--where month(Orders.Date) = 5 and year(Orders.Date) = 2000
group by Customers.CustomerID, Customers.Name

-- Tìm ProductCode, ProductName, CategoryName, TotalQuantity, TotalAmount
-- đã bán được trong 5/2000 và 6/2000 của từng sản phẩm
select Products.ProductCode, Products.Name as ProductName,
Categories.Name as CategoryName, sum(Quantity) as TotalQuantity, 
isnull(sum(Quantity*SellPrice), 0) as TotalAmount
from Orders join OrderItems on Orders.OrderID = OrderItems.OrderID
and year(Orders.Date) = 2000 and month(Orders.Date) in (5,6)
right join Products on Products.ProductCode = OrderItems.ProductCode
join Categories on Categories.ID = Products.CategoryID
group by Products.Name, Products.ProductCode, Categories.Name

-- Tìm số lượng và tổng tiền mà từng khách hàng đã mua từng sản phẩm
-- CustomerID, CustomerName, ProductCode, ProductName, TotalQuantity, TotalAmount
go
with t as (select CustomerID, Customers.Name as CustomerName, 
ProductCode, Products.Name as ProductName
from Customers, Products),
s as
(select CustomerID, ProductCode, sum(Quantity) as TotalQuantity,
sum(Quantity*SellPrice) as TotalAmount
from Orders join OrderItems on  OrderItems.OrderID = Orders.OrderID
group by CustomerID, ProductCode)

select t.*, TotalQuantity, TotalAmount
from t left join s on t.CustomerID = s.CustomerID
and t.ProductCode = s.ProductCode

-- Tìm tổng tiền mà từng khách hàng đã bỏ ra để mua hàng
-- chỉ hiển thị những khách hàng có tổng tiền < 3000

with t as(
select Customers.CustomerID, Customers.Name, sum(SellPrice*Quantity) as TotalAmount
from Customers left join Orders on Customers.CustomerID = Orders.CustomerID
join OrderItems on OrderItems.OrderID = Orders.OrderID
group by Customers.CustomerID, Customers.Name
)
select t.*
from t
where TotalAmount > 3000

-- the second way:
select Customers.CustomerID, Customers.Name,
isnull(sum(SellPrice*Quantity),0) as TotalAmount
from Customers left join Orders on Customers.CustomerID = Orders.CustomerID
join OrderItems on OrderItems.OrderID = Orders.OrderID
group by Customers.CustomerID, Customers.Name
having isnull(sum(SellPrice*Quantity),0) > 3000

-- tìm productcode, productName, totalQUantity, NumberOfOrders
-- của những sản phẩm bán được nhiều hơn 10 sản phẩm hoặc bán được ít nhất 2 hoá đơn 
-- trong tháng 5
-- xắp xếp kết quả giảm dần theo TotalQuantity và giảm dần theo NumberOfOrders
select Products.ProductCode, Products.Name as ProductName,
sum(Quantity) as TotalQuantity, count(OrderItems.OrderID) as NumberOfOrders
from Orders join OrderItems on OrderItems.OrderID = Orders.OrderID
and month(Orders.Date) = 5 and year(Orders.Date) = 2000
join Products on Products.ProductCode = OrderItems.ProductCode
group by Products.ProductCode, Products.Name
having sum(Quantity) > 10 or count(OrderItems.OrderID) > = 2
order by TotalQuantity DESC, NumberOfOrders DESC

-- stored procedure: không trả về giá trị thông qua tên hàm
-- function: hàm có trả về giá trị thông qua tên hàm bằng return 

/*
create procedure/proc tên_thủ_tục các_tham_số
as
begin
end
*/

--toạ thủ tục
go
create procedure proc0
as
begin
	select *
	from Customers join Orders
	on Customers.CustomerID = Orders.CustomerID
end
go

--gọi thủ tục
execute proc0
-------------------------------------------

go
create procedure proc2 @customerName nvarchar(50)
as
begin
	select Customers.CustomerID, Name, OrderID, Date
	from Customers join Orders
	on Customers.CustomerID = Orders.CustomerID
	and Name = @customerName
end
go

execute proc2 N'Nguyễn Thị Bé'
--------------------------------------------------
-- tạo thủ tục proc3 hiển thị ProductCode, ProductName của các sản phẩm được mua bởi
-- 1 khách hàng tronmg 1 tháng cụ thể với mã khách hàng, tháng và năm là 3 tham số
-- đầu vào của thủ tục
go--[dbo].[proc2]

create procedure proc3 @CustomerID nvarchar(5), @Date_month int, @Date_year int
as
begin
	select Products.ProductCode, Products.Name as ProductName
 	from Products join OrderItems on OrderItems.ProductCode = Products.ProductCode
	join Orders on Orders.OrderID = OrderItems.OrderID
	join Customers on Customers.CustomerID = Orders.CustomerID
	where month(Orders.Date) = @Date_month --ủa where cx đc hả
	and year(Orders.Date) = @Date_year
	and Customers.CustomerID = @CustomerID
end

execute proc3 'C01',5,2000

-- VD: Hiển thị sản phẩm được mua bởi C01 trong 5/2000
-- execute proc3 'C01', 5, 2000

--thủ tục có tham số đầu ra
-- thủ tục tính tổng 2 số nguyên
go 
create proc tinhTong @x int, @y int, @tong int output
as 
begin
	set @tong = @x + @y
end
execute tinhTong 10, 20, 0
select 0

go
---------------
declare @t int
exec tinhTong 10, 20, @t output
select @t
-------------------------


-- tạo thủ tục proc4 để tính tổng  tiền thu được qua việc bán 1 sản phẩm 
-- với mã sản phẩm là tham số đầu vào, tổng tiền là tham số đầu ra 
go 
create proc proc4 @productCode nvarchar(5), @totalAmount float output
as begin
	set @totalAmount = (
		select sum(Quantity * SellPrice)
		from OrderItems
		where ProductCode = @productCode
	)
end
---------------
declare @x float
exec proc4 'P02', @x output
select @x
---------------

-- tạo thủ tục proc5 để đếm số lượng hoá đơn và tổng tiền mà 1 khách hàng đã bỏ ra để
-- mua hàng trong 1 khoảng thời gian cụ thể 
-- với mã khách hàng, ngày bắt đầu và ngày kết thúc là tham số đầu vào 
-- số lượng hoá đơn và tổng tiền là tham số đầu ra 

go 
create proc proc5 @custID nvarchar(5), @beginDate date, @endDate date,
@numberofOrders int output, @totalAmount float output
as
begin
	set @numberofOrders = (select count(OrderID) from Orders
	where CustomerID = @custID and Date between @beginDate and @endDate
	)
	set @totalAmount = 
	(
		select sum(Quantity*SellPrice)
		from Orders join OrderItems on Orders.OrderID = OrderItems.OrderID
		and CustomerID = @custID
		and date between @beginDate and @endDate
	)
end
---------------
declare @order int, @total float
exec proc5 'C01','2000-04-25','2000-06-25', @order output, @total output
select @order, @total
-----------------------------------


-- trigger: thủ tục gắn với sự kiện
-- chỉ thực hiện khi sự kiện liên quan xảy ra
-- cú pháp:
/*
Create trigger Tên
On Tên-Bảng
for sự_kiện(insert/update/delete)
as
begin
end
*/

-- viết trigger gắn với lệnh insert vào bảng Customers
-- để hiển thị nội dung của bảng Customer sau khi insert

Go

Create trigger Tr1
On Customers
for insert
as
begin
	select * from Customers
end

--trigger chỉ được kích hoạt khi câu lệnh insert được thực hiện

insert into Customers(CustomerID, Name)
values ('C08', N'Nguyễn Văn A')

-- để gắn 1 sự kiện với trigger :
-- for insert (update/delete): TRONG khi insert thành công thì kích hoạt trigger
-- after insert (update/delete): SAU khi insert thành công thì kích hoạt trigger
-- instead of insert (update/delete): không thực hiện insert, thay vào đó chỉ thực hiện
-- lệnh trong trigger

-- viết trigger gắn với lệnh delete trong bảng Customers để hiển thị nội dung bảng 
-- Customers yêu cầu thực hiện instead of 
go
create trigger Tr01
on Customers
instead of delete
as 
begin
	select * from Customers
end

go 

delete from Customers 
where CustomerID = 'C07'

-- bên trong trigger có thể có 1 số bảng trung gian:
-- Nếu trigger gắn với lệnh insert -> bảng inserted -- có cấu trúc giống với bảng gắn với trigger 
-- chứa các dòng muốn thêm vào trong
-- lệnh insert trong trigger 
-- Nếu trigger gắn với lệnh delete -> bảng deleted -- chứa các dòng muốn xoá đi trong
-- lệnh delete trong trigger
-- Nếu trigger gắn với lệnh update 
--> 2 bảng như trên với bảng inserted chứa các dòng muốn thêm vào bảng gắn với trigger 
-- Bảng deleted chứa các dòng muốn xoá bỏ từ bảng gắn với trigger
go

create trigger Tr02
on Products
for insert
as 
begin 
	select * from inserted
end
go

insert into Products(ProductCode, Name)
values('P0','Product 1')

-- viết trigger gắn với lệnh insert vào bảng Orders để hiển thị CustomerID, CustomerName
-- OrderID, Date tương ứng với các hoá đơn vừa thêm vào
go
create trigger Tr03
on Orders
for insert
as 
begin 
	select Customers.CustomerID, Customers.Name as CustomerName, i.OrderID, i.Date
	from inserted i join Customers on i.CustomerID = Customers.CustomerID
end
go

insert into Orders(OrderID, Date, CustomerID)
values ('Or102', '2022-01-01', 'C01')

-- viết trigger gắn với lệnh delete khỏi bảng OrderItems để hiển thị OrderID,Date
-- ProductCode, ProductName, Quantity, SellPrice tương ứng với các dòng vừa xoá đi
go
create trigger Tr04
on OrderItems
for delete
as 
begin 
	select d.OrderID, Orders.Date, Products.ProductCode, Products.Name as ProductName,
	d.Quantity, d.SellPrice
	from deleted d join Products on Products.ProductCode = d.ProductCode
	join Orders on d.OrderID = Orders.OrderID
end
go

delete from OrderItems
where OrderID = 'Or002'

-- viết trigger gắn với lệnh update vào bảng Product để nếu update Price thì hiển thị
-- ProductCode, Name, OldPrice, NewPrice của các sản phẩm vừa update

go
create trigger Tr05
on Products
for update -- = delete rồi insert
as 
begin 
	if Update(Price)
	begin
		select d.ProductCode, d.Name as ProductName, 
		d.Price as OldPrice, i.Price as NewPrice
		from deleted d join inserted i on d.ProductCode = i.ProductCode
	end
end

update Products
set Price  = 1.2*Price 
where ProductCode in ('P06','P07')

-- cái bảng có những cột nào thì bảng kia cx có các cột y hệt như thế