 
create trigger InsertSubCategory
on Subcategory for insert
as
begin
select i.SubCategoryName, c.CategoryName from inserted i, Category c
where i.CategoryID=c.ID
end