--When a new class is inserted into Classes, also insert a ship with 
--the name of that class and a NULL launch date

CREATE TRIGGER T_1
ON Classes
AFTER INSERT
AS
BEGIN
    INSERT INTO Ships (name, class, launched)
    SELECT i.class, i.class, NULL
    FROM inserted AS i;
END

--When a new class is inserted with a displacement greater than 35,000 tons, 
--allow the insertion, but change the displacement to 35,000.

CREATE TRIGGER T_2
ON Classes
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO Classes (class, type, country, numGuns, bore, displacement)
    SELECT
        i.class, i.type, i.country, i.numGuns, i.bore,
        CASE WHEN i.displacement > 35000 THEN 35000 ELSE i.displacement END
    FROM inserted AS i;
END

--If a tuple is inserted into Outcomes, check that the ship and battle are listed in Ships and Battles, respectively
--, and if not, insert tuples into one or both of these relations, with NULL components where necessary.

CREATE TRIGGER T_3
ON Outcomes
AFTER INSERT
AS
BEGIN
    -- Insert into Ships if ship doesn't exist
    INSERT INTO Ships (name, class, launched)
    SELECT i.ship, NULL, NULL
    FROM inserted AS i
    WHERE NOT EXISTS (SELECT 1 FROM Ships WHERE name = i.ship);
    
    -- Insert into Battles if battle doesn't exist
    INSERT INTO Battles (name, date)
    SELECT i.battle, NULL
    FROM inserted AS i
    WHERE NOT EXISTS (SELECT 1 FROM Battles WHERE name = i.battle);
END

--When there is an insertion into Ships or an update of the class 
--attribute of Ships, check that no country has more than 20 ships.

CREATE TRIGGER T_4
ON Ships
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @country NVARCHAR(255);
    SELECT @country = country
    FROM Classes
    WHERE class = (SELECT class FROM inserted);

    IF @country IS NOT NULL
    BEGIN
        DECLARE @shipCount INT;
        SELECT @shipCount = COUNT(*)
        FROM Ships
        WHERE class IN (SELECT class FROM inserted)
        AND country = @country;

        IF @shipCount > 20
        BEGIN
            RAISERROR ('A country cannot have more than 20 ships of the same class.', 16, 1)
            ROLLBACK TRANSACTION;
        END
    END
END
