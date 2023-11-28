drop database if exists Orders
go
create database Orders
go
use Orders
go
create table Customers(
	CustomerID nvarchar(5) primary key,
	Name nvarchar(30) not null,
	Address nvarchar(50),
	Phone nvarchar(10) check (Phone not like '%[^0-9]%' and len(Phone)>=8 and len(Phone)<=10),
	Email nvarchar(50)
);

create table Categories(
	ID int primary key,
	Name nvarchar(50)
);

create table Products(
	ProductCode nvarchar(5) primary key,
	Name nvarchar(30) not null,
	Price float check (Price>0),
	StockQuantity int check (StockQuantity >=0),
	CategoryID int references Categories(ID)
);

create table Orders(
	OrderID nvarchar(10) primary key,
	Date Date check (Date<=getDate()),
	CustomerID nvarchar(5),
	Amount float,
	constraint fk_Cus foreign key(CustomerID) references Customers(CustomerID)
);

create table OrderItems(
	OrderID nvarchar(10) references Orders(OrderID),
	ProductCode nvarchar(5) references Products(ProductCode),
	Quantity int check (Quantity > 0),
	Discount float,
	SellPrice float,
	primary key(OrderID,ProductCode)
);

insert into Categories(ID, Name)
values (1,'Stationery'),
(2,'Flash drive'),
(3, 'Computer hardware')

insert into Products(ProductCode,Name,Price,StockQuantity,CategoryID)
values ('P01', 'Paper A4 EPSON',10,5000,1),
('P02','Keyboard', 15, 500,3),
('P03','Mouse', 12, 800,3),
('P04', '17'' LCD Monitor', 119, 800,3),
('P05','21'' LCD Monitor', 219, 100,3),
('P06', 'USB 8G' ,45, 150,2),
('P07','USB 16G',60, 500,2)

insert into Customers(CustomerID,Name,Address,Phone,Email)
values ('C01',N'Nguyễn Thị Bé',N'Tân Bình','08457895','bnt@yahoo.com'),
('C02',N'Lê Hoàng Nam',N'Bình Chánh','09878987','namlehoang@abc.com.vn'),
('C03',N'Trần Thị Chiêu',N'Tân Bình','08457895',null),
('C04',N'Mai Thị Quế Anh',N'Bình Chánh',null,null),
('C05',N'Lê Văn Sáng',N'Quận 10',null,'sanglv@hcm.vnn.vn'),
('C06',N'Trần Hoàng Khải',N'Tân Bình','08457897',null)

insert into Orders(OrderID,Date,CustomerID)
values ('Or001','05/12/2000','C01'),
('Or002','05/25/2000','C02'),
( 'Or003', '05/25/2000', 'C01'),
( 'Or004', '05/25/2000', 'C04'), 
('Or005', '05/26/2000', 'C04'),
( 'Or006', '02/06/2000', 'C03'),
( 'Or007', '06/22/2000', 'C04'),
( 'Or008', '06/25/2000', 'C03'),
( 'Or009', '08/15/2000', 'C04'),
( 'Or010', '09/30/2000', 'C01'),
( 'Or011', '12/27/2000', 'C06'),
( 'Or012', '12/27/2000', 'C01')

insert into OrderItems(OrderID,ProductCode,Quantity,SellPrice)
values ('Or001','P01',5,12),
('Or001','P05',10,300),
('Or002','P03',4,13),
('Or003','P02',20,16),
('Or004','P03',3,13),
('Or004','P04',10,120),
('Or005','P05',10,309),
('Or005','P06',15,46.6),
('Or005','P07',20,70),
('Or006','P04',10,120),
('Or007','P04',20,125),
('Or008','P01',2,11.5),
('Or008','P02',20,16),
('Or009','P02',25,17),
('Or010','P01',25,11.5),
('Or011','P01',20,12),
('Or011','P02',20,17),
('Or012','P01',20,12),
('Or012','P02',10,16.5),
('Or012','P03',1,13.5)

use master