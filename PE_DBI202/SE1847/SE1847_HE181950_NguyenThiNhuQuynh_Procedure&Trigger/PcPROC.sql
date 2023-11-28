--Take a price as argument and return the model number 
--of the PC whose price is closest.
CREATE FUNCTION FindClosestPCModel(@price DECIMAL) RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @model VARCHAR(255);

    SELECT TOP 1 @model = model
    FROM PC
    ORDER BY ABS(price - @price);

    RETURN @model;
END



CREATE FUNCTION GetPriceByMakerAndModel(@maker VARCHAR(255), @model VARCHAR(255)) RETURNS DECIMAL
AS
BEGIN
    DECLARE @price DECIMAL;

    SELECT @price = CASE
        WHEN EXISTS (SELECT 1 FROM PC WHERE maker = @maker AND model = @model) THEN (SELECT price FROM PC WHERE maker = @maker AND model = @model)
        WHEN EXISTS (SELECT 1 FROM Laptop WHERE maker = @maker AND model = @model) THEN (SELECT price FROM Laptop WHERE maker = @maker AND model = @model)
        WHEN EXISTS (SELECT 1 FROM Printer WHERE maker = @maker AND model = @model) THEN (SELECT price FROM Printer WHERE maker = @maker AND model = @model)
        ELSE NULL
    END;

    RETURN @price;
END

--Take model, speed, ram, hard-disk size, and price information as arguments,
--and insert this information into the relation PC. However, if there is already a PC 
--with that model number (tell by assuming that violation of a key constraint on insertion will 
--raise an exception, then keep adding 1 to the model number until you find a model number 
--that is not already a PC model number

CREATE PROCEDURE InsertPCWithUniqueModel(
    @model VARCHAR(255),
    @speed INT,
    @ram INT,
    @hd INT,
    @price DECIMAL
)
AS
BEGIN
    DECLARE @newModel VARCHAR(255) = @model;
    DECLARE @counter INT = 1;

    -- While the model already exists, keep incrementing the model number
    WHILE (SELECT COUNT(*) FROM PC WHERE model = @newModel) > 0
    BEGIN
        SET @newModel = @model + CAST(@counter AS VARCHAR(10)); 
        SET @counter = @counter + 1; 
    END

    -- Insert the new PC information with the unique model number
    INSERT INTO PC (model, speed, ram, hd, price)
    VALUES (@newModel, @speed, @ram, @hd, @price);
END

