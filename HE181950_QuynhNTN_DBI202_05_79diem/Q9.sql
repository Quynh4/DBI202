create trigger Tr1
on Category
instead of delete
as
begin
	update Cars
	set Category_ID = null
	where Category_ID in (select ID from deleted)

	delete from Category where ID = (select ID from deleted)
end
