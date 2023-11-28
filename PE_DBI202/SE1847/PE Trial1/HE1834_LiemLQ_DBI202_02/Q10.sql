
insert into SubCategory(SubCategoryName,CategoryID) values
('Tennis',(select ID from Category where CategoryName='Sports'))

select * From SubCategory