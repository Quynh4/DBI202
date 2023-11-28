CREATE TRIGGER TR1 ON Student
FOR INSERT
AS
BEGIN
	if (select year(getdate()) -year(inserted.studentDOB) from inserted)>15
		ROLLBACK
END
