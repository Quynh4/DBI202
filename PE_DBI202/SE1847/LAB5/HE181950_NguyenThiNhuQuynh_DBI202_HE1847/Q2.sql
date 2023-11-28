alter table Student add hometown varchar(270)

EXEC sp_rename 'Student.studentAddress', 'studentAddresss', 'COLUMN';

alter table Student
alter column studentAddresss  varchar(270)
