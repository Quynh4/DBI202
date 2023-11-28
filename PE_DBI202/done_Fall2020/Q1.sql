--q1
create table Customers (
CustomerID int primary key,
FullName nvarchar(100),
Address nvarchar(200)
)

create table Branches (
Adress nvarchar(200),
Name nvarchar(100),
BranchID int primary key
)

create table Vehicles (
Model nvarchar(50),
VehicleID int primary key,
year int,
Maker varchar(20),
RentalPrice float
)

create table Rent(
DropoffDate Date,
PickupDate Date,
BranchID int references Branches(BranchID),
VehicleID int references Vehicles(VehicleID),
CustomerID int references Customers(CustomerID)
primary key (PickupDate, BranchID, VehicleID, CustomerID)
)