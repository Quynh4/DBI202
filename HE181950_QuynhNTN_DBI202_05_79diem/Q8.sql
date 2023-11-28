create proc P1
@category_ID int, @numberOfCars int output
as
begin
	select @numberOfCars = count(*) from Cars where Category_ID = @category_ID
end
