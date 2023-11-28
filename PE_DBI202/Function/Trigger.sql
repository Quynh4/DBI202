/* Trigger 1 */
create trigger trg_DatHang on DatHang after insert as
begin
update KhoHang
	set SoLuongTon = SoLuongTon - 
	(select inserted.SoLuongMua from inserted where MaHang=KhoHang.MaHang)
from KhoHang join inserted on inserted.MaHang=KhoHang.MaHang
end

/* Trigger 1 */
create trigger trg_dathang_insert
on DatHang
for insert
as
begin
	declare @mahang nvarchar(10)
	declare @soluongban int
	declare @soluongcon int
	select @mahang=mahang, @soluongban=SoLuongMua from inserted
	select @soluongcon=SoLuongTon from KhoHang where MaHang=@mahang
	case
		when @soluongcon >= @soluongban then
			update KhoHang set SoLuongTon=SoLuongTon-@soluongban where mahang=@mahang
		else
			rollback transaction
end

/* Trigger 1 */
CREATE TRIGGER Tg_Insert_Customer
ON Customers
FOR INSERT
AS
BEGIN
    -- Khai bao 1 bien co kieu INT
    DECLARE @rowNumber INT
    -- Gan gia tri cho bien @rowNumber
    SET @rowNumber = (SELECT COUNT(*) FROM inserted)
    -- Hien thi thong bao cua Trigger
    PRINT CAST(@rowNumber as VARCHAR(5)) + ' dong duoc chen thanh cong'
END

/* Trigger 1 */
CREATE TRIGGER Tg_Insert_Employees
ON Employees
AFTER INSERT
AS
BEGIN
    DECLARE @rowNumber INT
    SET @rowNumber = (SELECT COUNT(*) FROM inserted)
    IF @rowNumber > 0 
    BEGIN 
        ROLLBACK TRANSACTION
        PRINT 'Khong the them moi nhan vien'
    END
END

/* Trigger 1 */
CREATE TRIGGER Tg_Delete_Categories
ON Categories
FOR DELETE
as 
BEGIN
    DELETE FROM Products
    WHERE CategoryID IN (SELECT CategoryID FROM deleted)
END

/* Trigger 1 */
CREATE TRIGGER Tg_Update_Categories
on Categories
FOR UPDATE
AS
BEGIN
    IF(UPDATE(CategoryName) AND UPDATE([Description]))
    BEGIN
        PRINT 'Khong the sua doi du lieu cua CategoryName'
        ROLLBACK TRANSACTION
    END
END

/* Trigger 2 */
CREATE TRIGGER Cust_Delete_Only1 ON Customers FOR DELETE
AS
IF (SELECT COUNT(*) FROM Deleted) > 1
BEGIN
	RAISEERROR('You are not allowed to delete more than one customer at a time.', 16, 1)
	ROLLBACK TRANSACTION
END

/* Trigger 3 */
CREATE TRIGGER trg_DatHang ON tbl_DatHang AFTER INSERT AS 
BEGIN
    UPDATE tbl_KhoHang
    SET SoLuongTon = SoLuongTon - (
        SELECT SoLuongDat
        FROM inserted
        WHERE MaHang = tbl_KhoHang.MaHang
    )
    FROM tbl_KhoHang
    JOIN inserted ON tbl_KhoHang.MaHang = inserted.MaHang
END
GO

/* Trigger 4 */
CREATE TRIGGER trg_CapNhatDatHang on tbl_DatHang after update AS
BEGIN
   UPDATE tbl_KhoHang SET SoLuongTon = SoLuongTon -
       (SELECT SoLuongDat FROM inserted WHERE MaHang = tbl_KhoHang.MaHang) +
       (SELECT SoLuongDat FROM deleted WHERE MaHang = tbl_KhoHang.MaHang)
   FROM tbl_KhoHang 
   JOIN deleted ON tbl_KhoHang.MaHang = deleted.MaHang
end
GO

/* Trigger 5 */
create TRIGGER trg_HuyDatHang ON tbl_DatHang FOR DELETE AS 
BEGIN
    UPDATE tbl_KhoHang
    SET SoLuongTon = SoLuongTon + (SELECT SoLuongDat FROM deleted WHERE MaHang = tbl_KhoHang.MaHang)
    FROM tbl_KhoHang 
    JOIN deleted ON tbl_KhoHang.MaHang = deleted.MaHang
END