USE PE_DBI202_FA2023

------------Câu hỏi về bảng Category:
--Có bao nhiêu danh mục (categories) trong bảng?
SELECT COUNT(*) FROM Category;

--Liệt kê tất cả các danh mục và mô tả của chúng.
SELECT Label, Description FROM Category;

--Tìm danh mục có ID là [ID].
SELECT * FROM Category WHERE ID = [ID];

--Tìm danh mục có nhãn (label) là [Label].
SELECT * FROM Category WHERE Label = '[Label]';

------------Câu hỏi về bảng Cars:
--Có bao nhiêu xe (cars) trong bảng?
SELECT COUNT(*) FROM Cars;

--Liệt kê thông tin chi tiết về tất cả các xe.
SELECT * FROM Cars;

--Tìm xe có ID là [ID].
SELECT * FROM Cars WHERE ID = [ID];

--Tìm xe thuộc danh mục (category) có ID là [Category_ID].
SELECT * FROM Cars WHERE Category_ID = [Category_ID];

--Tìm các xe màu [Color]. -- Question 2: Retrieve all cars with the color "Red" from the "Cars" table.
SELECT * FROM Cars WHERE Color = 'Red';

--Tìm các xe của hãng (brand) [Brand].
SELECT * FROM Cars WHERE Brand = '[Brand]';

--Tìm các xe mô hình (model) [Model] màu [Color].
SELECT * FROM Cars WHERE Model = '[Model]' AND Color = '[Color]';

--Câu hỏi về bảng Customers:
--Có bao nhiêu khách hàng (customers) trong bảng?
SELECT COUNT(*) FROM Customers;

--Liệt kê thông tin chi tiết về tất cả khách hàng.
SELECT * FROM Customers;

--Tìm khách hàng có ID là [ID].
SELECT * FROM Customers WHERE ID = [ID];

--Tìm khách hàng có tên là [First_Name] [Last_Name].
SELECT * FROM Customers WHERE First_Name = '[First_Name]' AND Last_Name = '[Last_Name]';

--Tìm khách hàng có địa chỉ email là [Email].
SELECT * FROM Customers WHERE Email = '[Email]';

--Tìm khách hàng ở [City], [State], [Country].
SELECT * FROM Customers WHERE City = '[City]' AND State = '[State]' AND Country = '[Country]';

--Câu hỏi về bảng Location:
--Có bao nhiêu địa điểm (locations) trong bảng?
SELECT COUNT(*) FROM Location;

--Liệt kê thông tin chi tiết về tất cả các địa điểm.
SELECT * FROM Location;

--Tìm địa điểm có ID là [ID].
SELECT * FROM Location WHERE ID = [ID];

--Tìm địa điểm ở [Street], [City], [State], [Country].
SELECT * FROM Location WHERE Street = '[Street]' AND City = '[City]' AND State = '[State]' AND Country = '[Country]';

--Câu hỏi về bảng Location_Phone_Number:
--Có bao nhiêu số điện thoại (phone numbers) trong bảng?
SELECT COUNT(*) FROM Location_Phone_Number;

--Liệt kê tất cả các số điện thoại và thông tin chi tiết về địa điểm liên kết với từng số điện thoại.
SELECT LPN.Phone_Number, LPN.Is_MainPhone, L.* 
FROM Location_Phone_Number LPN
JOIN Location L ON LPN.Location_ID = L.ID;

--Tìm số điện thoại có ID là [ID].
SELECT * FROM Location_Phone_Number WHERE ID = [ID];

--Tìm số điện thoại chính của địa điểm có ID là [Location_ID].
SELECT * FROM Location_Phone_Number WHERE Location_ID = [Location_ID] AND Is_MainPhone = 1;

--Câu hỏi về bảng Rentals:
--Có bao nhiêu đơn đặt xe (rentals) trong bảng?
SELECT COUNT(*) FROM Rentals;

--Liệt kê thông tin chi tiết về tất cả các đơn đặt xe.
SELECT * FROM Rentals;

--Tìm đơn đặt xe có số đặt chỗ (reservation number) là [Reservation_Number].
SELECT * FROM Rentals WHERE Reservation_Number = [Reservation_Number];

--Tìm đơn đặt xe của khách hàng có ID là [Customer_ID].
SELECT * FROM Rentals WHERE Customer_ID = [Customer_ID];

--Tìm đơn đặt xe có ngày nhận xe là [Pick_up_date].
SELECT * FROM Rentals WHERE Pick_up_date = '[Pick_up_date]';

--Tìm đơn đặt xe có ngày trả xe là [Return_date].
SELECT * FROM Rentals WHERE Return_date = '[Return_date]';

--Tìm đơn đặt xe có xe có ID là [CarID].
SELECT * FROM Rentals WHERE CarID = [CarID];

--Tìm đơn đặt xe có điểm nhận xe là địa điểm có ID là [Pick_up_location].
SELECT * FROM Rentals WHERE Pick_up_location = [Pick_up_location];

--Tìm đơn đặt xe có điểm trả xe là địa điểm có ID là [Return_location].
SELECT * FROM Rentals WHERE Return_location = [Return_location];

---- hiển thị số ngày mà 1 khách hàng thuê xe
select r.*, days = datediff(day,Pick_up_date, Return_date)  from Rentals r




--tổng số lượng khách hàng đã thuê mỗi mô hình xe (model) theo danh mục (category):
SELECT c.Model, cat.Label, COUNT(*) AS TotalRentals
FROM Rentals r
JOIN Cars c ON r.CarID = c.ID
JOIN Category cat ON c.Category_ID = cat.ID
GROUP BY c.Model, cat.Label;

-- tổng số tiền thu được từ việc cho thuê xe theo từng tháng:
with t as (SELECT MONTH(r.Pick_up_date) AS RentalMonth, YEAR(r.Pick_up_date) AS RentalYear, r.Amount
FROM Rentals r)
select RentalMonth, RentalYear, sum(Amount) as TotalRevenue from t 
group by RentalMonth, RentalYear
ORDER BY RentalYear, RentalMonth


--Find the total number of rentals made by each customer.
SELECT Customers.ID, Customers.First_Name, Customers.Last_Name, COUNT(Rentals.Reservation_Number) AS TotalRentals
FROM Customers
LEFT JOIN Rentals ON Customers.ID = Rentals.Customer_ID
GROUP BY Customers.ID, Customers.First_Name, Customers.Last_Name;

--khách hàng có số lượng đặt xe nhiều nhất
--cach 1
with t as (SELECT Customers.ID, Customers.First_Name, Customers.Last_Name, count(Rentals.Reservation_Number) as NumberOfOrder 
FROM     Customers INNER JOIN
                  Rentals ON Customers.ID = Rentals.Customer_ID
group by Customers.ID, Customers.First_Name, Customers.Last_Name)
select * from t where NumberOfOrder >= all (select NumberOfOrder from t)
--cach 2
SELECT top 1 c.First_Name, c.Last_Name, COUNT(*) AS TotalBookings
FROM Customers c
JOIN Rentals r ON c.ID = r.Customer_ID
GROUP BY c.First_Name, c.Last_Name
ORDER BY TotalBookings DESC

-- tổng số lượng khách hàng trong từng quốc gia:
SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

--Retrieve the details of cars rented by customers from a specific country.
SELECT Rentals.Reservation_Number, Customers.First_Name, Customers.Last_Name, Cars.Brand, Cars.Model
FROM Rentals
JOIN Customers ON Rentals.Customer_ID = Customers.ID
JOIN Cars ON Rentals.CarID = Cars.ID
WHERE Customers.Country = 'YourCountry';

--Calculate the total revenue generated by each car brand.
SELECT Cars.Brand, SUM(Rentals.Amount) AS TotalRevenue
FROM Cars
JOIN Rentals ON Cars.ID = Rentals.CarID
GROUP BY Cars.Brand;

--Find the customers who have rented cars from multiple categories.
SELECT Customers.ID, Customers.First_Name, Customers.Last_Name
FROM Customers
JOIN Rentals ON Customers.ID = Rentals.Customer_ID
JOIN Cars ON Rentals.CarID = Cars.ID
JOIN Category ON Cars.Category_ID = Category.ID
GROUP BY Customers.ID, Customers.First_Name, Customers.Last_Name
HAVING COUNT(DISTINCT Category.ID) > 1;

--Identify the most popular car color in each city.
SELECT Location.City, Cars.Color, COUNT(Rentals.Reservation_Number) AS RentalCount
FROM Location
JOIN Rentals ON Location.ID = Rentals.Pick_up_location
JOIN Cars ON Rentals.CarID = Cars.ID
GROUP BY Location.City, Cars.Color
HAVING COUNT(Rentals.Reservation_Number) = (
    SELECT MAX(RentalCount)
    FROM (
        SELECT Location.City, Cars.Color, COUNT(Rentals.Reservation_Number) AS RentalCount
        FROM Location
        JOIN Rentals ON Location.ID = Rentals.Pick_up_location
        JOIN Cars ON Rentals.CarID = Cars.ID
        GROUP BY Location.City, Cars.Color
    ) AS Subquery
    WHERE Subquery.City = Location.City
);


--Question 3: Retrieve a list of customer names and their mobile phone numbers in "California" and sort them by their names.
select [Name] = First_Name + ' '+ Last_Name, Mobile_phone from Customers
WHERE Customers.State = 'California'
ORDER BY Customers.First_Name, Customers.Last_Name;


--Question 4: Display the rentals that occurred between January 1, 2023, and December 31, 2023.

select DATEDIFF(day, getdate(), '2023-11-02') -- ngay sau tru ngay truoc


select * from Rentals
where DATEDIFF(day, '2023-01-01',Pick_up_date) >=0 and  DATEDIFF(day, Return_date, '2023-12-31') >=0

--Question 5: Retrieve a list of all customers (Customers) and the number of rentals (Rentals) each customer has made, 
--along with the total amount (Amount) each customer has paid.
SELECT Customers.ID, Customers.First_Name, Customers.Last_Name, count(Rentals.Reservation_Number) as NumberOfRentals, sum(Rentals.Amount) as TotalAmount
FROM     Customers INNER JOIN
                  Rentals ON Customers.ID = Rentals.Customer_ID
group by Customers.ID, Customers.First_Name, Customers.Last_Name;


--Question 6: Retrieve information about cars with the minimum and maximum number of rentals.
with t as (
	SELECT CarID, count(Reservation_Number) as NumberOfRentals
	FROM     Rentals
	group by CarID
)
select * from t where NumberOfRentals = (select max(NumberOfRentals) from t)
union all
select * from t where NumberOfRentals = (select min(NumberOfRentals) from t)



--Question 7: Retrieve information about the customer (Customers) with the most rentals and the car (Cars) they have rented the most times.
with t as (select Customer_ID, count(*) as NumberOfRental from Rentals group by Customer_ID),
m as (select Customer_ID,  CarID, count(*) as NumberOfCarRen from Rentals group by Customer_ID, carID),
n as (select Customer_ID,  max(NumberOfCarRen) as MaxCarRen from m group by Customer_ID) --tim loai oto ma moi nguoi dung nhieu nhat

select t.Customer_ID, m.CarID, m.NumberOfCarRen
from t join n on t.Customer_ID = n.Customer_ID join m on t.Customer_ID = m.Customer_ID
where  t.NumberOfRental = (select max(NumberOfRental) from t)
and m.NumberOfCarRen = n.MaxCarRen


--liệt kê state có số nhân viên nhiều nhất trong 1 đất nước
with tmpCount as (select Country, State, count(ID) NumOfEmp from Customers group by Country, State),
tmpMax as (select Country, max(NumOfEmp) as MaxNum from tmpCount group by Country)
select tmpCount.* from tmpCount join tmpMax on tmpCount.Country = tmpMax.Country
and tmpCount.NumOfEmp = tmpMax.MaxNum


--Tìm các xe thuê có số ngày thuê lớn nhất.
SELECT Cars.ID, Cars.Description, Rentals.Pick_up_date, Rentals.Return_date, DATEDIFF(Rentals.Return_date, Rentals.Pick_up_date) AS RentalDuration
FROM Cars
JOIN Rentals ON Cars.ID = Rentals.CarID
WHERE DATEDIFF(Rentals.Return_date, Rentals.Pick_up_date) = (
    SELECT MAX(DATEDIFF(Return_date, Pick_up_date))
    FROM Rentals
);

--Tính tổng doanh thu từ khách hàng ở mỗi quốc gia và loại xe.
SELECT Customers.Country, Category.Label, SUM(Rentals.Amount) AS TotalRevenue
FROM Customers
JOIN Rentals ON Customers.ID = Rentals.Customer_ID
JOIN Cars ON Rentals.CarID = Cars.ID
JOIN Category ON Cars.Category_ID = Category.ID
GROUP BY Customers.Country, Category.Label;

--Tìm khách hàng có số lượng thuê xe liên tục dài nhất.

WITH ContinuousRentals AS (
    SELECT Rentals.Customer_ID, Rentals.Reservation_Number, ROW_NUMBER() OVER (PARTITION BY Rentals.Customer_ID ORDER BY Rentals.Pick_up_date) AS RowNumber
    FROM Rentals
    JOIN (
        SELECT Customer_ID, MAX(Pick_up_date) AS MaxPickupDate
        FROM Rentals
        GROUP BY Customer_ID
    ) AS Subquery ON Rentals.Customer_ID = Subquery.Customer_ID AND Rentals.Pick_up_date = Subquery.MaxPickupDate
)
SELECT Customers.ID, Customers.First_Name, Customers.Last_Name, COUNT(ContinuousRentals.Reservation_Number) AS ContinuousRentalCount
FROM ContinuousRentals
JOIN Customers ON ContinuousRentals.Customer_ID = Customers.ID
GROUP BY Customers.ID, Customers.First_Name, Customers.Last_Name) 
HAVING ContinuousRentalCount = (
    SELECT MAX(ContinuousRentalCount)
    FROM (
        SELECT Customers.ID, Customers.First_Name, Customers.Last_Name, COUNT(ContinuousRentals.Reservation_Number) AS ContinuousRentalCount
        FROM ContinuousRentals
        JOIN Customers ON ContinuousRentals.Customer_ID = Customers.ID
        GROUP BY Customers.ID, Customers.First_Name, Customers.Last_Name
    ) AS Subquery
);


--Xác định tỷ lệ khách hàng thuê xe theo mỗi danh mục.
SELECT Category.Label, COUNT(Rentals.Reservation_Number) AS RentalCount, COUNT(Rentals.Reservation_Number) / CAST((SELECT COUNT(*) FROM Rentals) AS float) * 100 AS RentalPercentage
FROM Category
LEFT JOIN Cars ON Category.ID = Cars.Category_ID
LEFT JOIN Rentals ON Cars.ID = Rentals.CarID
GROUP BY Category.Label;

--Tìm số lượng khách hàng có số lượng thuê xe nhiều nhất trong mỗi quốc gia.
SELECT Customers.Country, COUNT(Rentals.Reservation_Number) AS RentalCount
FROM Customers
JOIN Rentals ON Customers.ID = Rentals.Customer_ID
GROUP BY Customers.Country
HAVING RentalCount = (
    SELECT MAX(RentalCount)
    FROM (
        SELECT Customers.Country, COUNT(Rentals.Reservation_Number) AS RentalCount
        FROM Customers
        JOIN Rentals ON Customers.ID = Rentals.Customer_ID
        GROUP BY Customers.Country
    ) AS Subquery
    WHERE Subquery.Country = Customers.Country
);


--Question 8: Create a stored procedure to calculate the total number of rentals for a specific car, with the input being the @ID of the car.
create proc PR1
@CarID int
as
begin
	SELECT CarID, count(Reservation_Number) as NumberOfRentals
	FROM     Rentals
	where CarID = @CarID
	group by CarID
end

--exec PR1 3

--Stored procedure to delete a customer and all related orders from the database:
CREATE PROCEDURE DeleteCustomer
    @CustomerID INT
AS
BEGIN
    BEGIN TRANSACTION;
    
    DELETE FROM Orders
    WHERE CustomerID = @CustomerID;
    
    DELETE FROM Customers
    WHERE CustomerID = @CustomerID;
    
    COMMIT;
END;

--Stored procedure to calculate the total revenue for a specific category
CREATE PROCEDURE CalculateCategoryRevenue
    @CategoryID INT,
    @TotalRevenue DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @TotalRevenue = SUM(Price)
    FROM Products
    WHERE CategoryID = @CategoryID;
END;

	
--Question 9: Create a trigger named 'car_up_trig' on the Car table to display the elements that have been changed after an update.
create trigger car_up_trig
on Cars
for update
as
begin
	select * from inserted
end


--Trigger để cập nhật số lượng xe trong mỗi danh mục sau khi thêm một cuộc thuê mới:
CREATE TRIGGER UpdateCategoryCount
AFTER INSERT ON Rentals
FOR EACH ROW
BEGIN
    UPDATE Category
    SET Category.Count = Category.Count + 1
    WHERE Category.ID = NEW.Category_ID;
END;

--Trigger để kiểm tra tính hợp lệ của ngày trả xe không được nhỏ hơn ngày thuê trong bảng Rentals:
CREATE TRIGGER CheckReturnDate
BEFORE INSERT ON Rentals
FOR EACH ROW
BEGIN
    IF NEW.Return_date < NEW.Pick_up_date THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Return date cannot be earlier than pick-up date.';
    END IF;
END;

--Trigger để xóa các bản ghi thuê xe liên quan khi xóa một khách hàng:
CREATE TRIGGER DeleteRelatedRentals
AFTER DELETE ON Customers
FOR EACH ROW
BEGIN
    DELETE FROM Rentals WHERE Rentals.Customer_ID = OLD.ID;
END;
--Trigger để kiểm tra tính hợp lệ của số điện thoại chính trong bảng Location_Phone_Number:
CREATE TRIGGER CheckMainPhoneNumber
BEFORE INSERT ON Location_Phone_Number
FOR EACH ROW
BEGIN
    IF NEW.Is_MainPhone = 1 THEN
        IF EXISTS (SELECT * FROM Location_Phone_Number WHERE Location_Phone_Number.Location_ID = NEW.Location_ID AND Location_Phone_Number.Is_MainPhone = 1) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'There is already a main phone number for this location.';
        END IF;
    END IF;
END;

--Trigger để tính tổng doanh thu của mỗi khách hàng sau khi thêm hoặc cập nhật một cuộc thuê:
CREATE TRIGGER CalculateCustomerRevenue
AFTER INSERT, UPDATE ON Rentals
FOR EACH ROW
BEGIN
    UPDATE Customers
    SET Customers.TotalRevenue = (
        SELECT COALESCE(SUM(Rentals.Amount), 0)
        FROM Rentals
        WHERE Rentals.Customer_ID = Customers.ID
    )
    WHERE Customers.ID = NEW.Customer_ID;
END;


--Question 10: Delete data from the "Cars" table with the condition 'economy.'
DELETE FROM Cars
where ID = (
select ID from Cars
join Category on Cars.Category_ID = Category.ID
where Category.Label = 'economy'
)






select * from Cars
select * from Category -- Label: luxury, compact, economy, convertible
select * from Customers
select * from Location
-- State: NY, NJ, CA, BC
-- Country: United States, Canada, Belgium
select * from Location_Phone_Number
select * from Rentals