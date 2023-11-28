--When updating the price of a PC, check that there is 
--no lower-priced PC with the same speed

CREATE TRIGGER CheckPCPrice
ON PC
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN PC p ON i.model = p.model
        WHERE i.speed = p.speed AND i.price < p.price
    )
    BEGIN
        RAISERROR('Cannot update the price. Lower-priced PC with the same speed exists.', 16, 1)
        ROLLBACK;
    END
    ELSE
    BEGIN
        UPDATE PC
        SET speed = i.speed, price = i.price
        FROM PC p
        INNER JOIN inserted i ON p.model = i.model;
    END
END
--When inserting a new printer, check that the model number exists in Product
CREATE TRIGGER CheckPrinterModel
ON Printer
INSTEAD OF INSERT
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN Product p ON i.model = p.model
        WHERE p.model IS NOT NULL
    )
    BEGIN
        RAISERROR('Cannot insert a new printer. Model number does not exist in Product.', 16, 1)
        ROLLBACK;
    END
    ELSE
    BEGIN
        INSERT INTO Printer (model, color, type, price)
        SELECT model, color, type, price
        FROM inserted;
    END
END


--When making any modification to the Laptop relation, check that 
--the average price of laptops for each manufacturer is at least $1500

CREATE TRIGGER CheckLaptopPrice
ON Laptop
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (
        SELECT maker, AVG(price) AS AvgPrice
        FROM Laptop
        GROUP BY maker
        HAVING AVG(price) < 1500
    )
    BEGIN
        RAISEERROR('Cannot perform the modification. Average laptop price for a manufacturer is less than $1500.', 16, 1);
        ROLLBACK;
    END
END;

 --When updating the RAM or hard disk of any PC, check that the updated PC 
 --has at least 100 times as much hard disk as RAM
CREATE TRIGGER CheckPCUpgrade
ON PC
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.hd < (i.ram * 100)
    )
    BEGIN
        RAISERROR('Cannot update the PC. Hard disk must be at least 100 times the RAM.', 16, 1)
        ROLLBACK;
    END
    ELSE
    BEGIN
        UPDATE PC
        SET ram = i.ram, hd = i.hd
        FROM PC p
        INNER JOIN inserted i ON p.model = i.model;
    END
END;


--When inserting a new PC, make sure that the model number did not previously appear in any of PC:
CREATE TRIGGER CheckNewPCModel
ON PC
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN PC p ON i.model = p.model
    )
    BEGIN
        RAISERROR('Cannot insert a new PC. Model number already exists in PC.', 16, 1)
        ROLLBACK;
    END
    ELSE
    BEGIN
        INSERT INTO PC (model, speed, ram, hd, price)
        SELECT model, speed, ram, hd, price
        FROM inserted;
    END
END;




