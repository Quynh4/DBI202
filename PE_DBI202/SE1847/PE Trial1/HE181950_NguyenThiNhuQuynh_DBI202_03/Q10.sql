INSERT INTO Category (CategoryName)
VALUES ('Sports');

DECLARE @CategoryID INT;
SET @CategoryID = SCOPE_IDENTITY();

INSERT INTO SubCategory (SubCategoryName, CategoryID)
VALUES ('Tennis', @CategoryID);

INSERT INTO SubCategory (SubCategoryName, CategoryID)
VALUES ('Football', @CategoryID);
