--1 is male
select * from Student
where studentGender=1
and year(GETDATE()) - year(studentDOB) >20
