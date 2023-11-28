/* Proc 1 */
CREATE PROCEDURE SP_Insert_Categories
(
    -- Cac tham so kieu Input
    @CatName NVARCHAR(15) = 'Demo',
    @Desc NTEXT = 'Demo description'
)
AS
BEGIN
    INSERT INTO Categories(CategoryName, [Description]) 
    VALUES(@CatName, @Desc)
END

/* Proc 2 */
CREATE PROC SP_Total_Product_By_CatId
(
    @catId int -- Input parameter
)
as
BEGIN
SELECT c.CategoryID, COUNT(p.CategoryID) 
        FROM Categories c INNER JOIN Products p
        ON C.CategoryID = p.CategoryID
        GROUP BY c.CategoryID
        HAVING c.CategoryID = @catId
END