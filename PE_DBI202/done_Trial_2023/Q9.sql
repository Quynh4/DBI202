CREATE TRIGGER InsertSubCategory
ON SubCategory
AFTER INSERT
AS
BEGIN
    SELECT i.SubCategoryName, c.CategoryName
    FROM inserted i
    INNER JOIN Category c ON i.CategoryID = c.ID;
END