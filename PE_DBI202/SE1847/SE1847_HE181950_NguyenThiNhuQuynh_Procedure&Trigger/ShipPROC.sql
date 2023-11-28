--1)	The firepower of a ship is roughly proportional to the number of guns times 
--the cube of the bore. Given a class as argument, return its firepower

CREATE PROCEDURE SP_1 (@class VARCHAR(255))
AS
BEGIN
    DECLARE @firepower FLOAT
    SELECT @firepower = SUM(numGuns * POWER(bore, 3))
    FROM Classes
    WHERE class = @class;
    SELECT @firepower AS Firepower;
END

--2)	Take as arguments a new class name, type, country, number of guns, bore, and displacement. 
--Add this information to Classes and also add the ship with the class name to Ships.

CREATE PROCEDURE SP_2
    @new_class VARCHAR(255),
    @type VARCHAR(255),
    @country VARCHAR(255),
    @numGuns INT,
    @bore FLOAT,
    @displacement INT
AS
BEGIN
    INSERT INTO Classes (class, type, country, numGuns, bore, displacement)
    VALUES (@new_class, @type, @country, @numGuns, @bore, @displacement);

    INSERT INTO Ships (name, class, launched)
    VALUES (@new_class, @new_class, NULL);
END

--Given a ship name, determine if the ship was in a battle with a date before the ship was launched. 
--If so, set the date of the battle and the date the ship was launched to NULL, and -1, respectively.
CREATE PROCEDURE SP_3 (@ship_name VARCHAR(255))
AS
BEGIN
    DECLARE @battle_date DATE;
    DECLARE @ship_launched DATE;

    SELECT @battle_date = B.date, @ship_launched = S.launched
    FROM Ships AS S
    JOIN Outcomes AS O ON S.name = O.ship
    JOIN Battles AS B ON O.battle = B.name
    WHERE S.name = @ship_name;

    IF @battle_date IS NOT NULL AND @ship_launched IS NOT NULL AND @battle_date < @ship_launched
    BEGIN
        UPDATE Ships
        SET launched = -1
        WHERE name = @ship_name;

        UPDATE Battles
        SET date = NULL
        WHERE name = @battle_date;
    END
END


--Given the name of a battle, produce the two countries whose ships were involved in the battle. 
--If there are more or fewer than two countries involved, produce NULL for both countries.

CREATE PROCEDURE SP_4 (@battle_name VARCHAR(255))
AS
BEGIN
    DECLARE @country1 VARCHAR(255);
    DECLARE @country2 VARCHAR(255);

    SELECT @country1 = NULL, @country2 = NULL; -- Initialize both countries to NULL

    DECLARE @count INT;
    SELECT @count = COUNT(DISTINCT C.country)
    FROM Outcomes AS O
    LEFT JOIN Ships AS S ON O.ship = S.name
    LEFT JOIN Classes AS C ON S.class = C.class
    WHERE O.battle = @battle_name;

    IF @count = 2
    BEGIN
        SELECT @country1 = MIN(C1.country), @country2 = MAX(C1.country)
        FROM Outcomes AS O
        LEFT JOIN Ships AS S ON O.ship = S.name
        LEFT JOIN Classes AS C ON S.class = C.class
        WHERE O.battle = @battle_name;
    END

    SELECT @country1 AS Country1, @country2 AS Country2;
END
