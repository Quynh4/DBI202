-- Add a record into the Class table
INSERT INTO Class
VALUES ('Class04', 'Class Number 4');


-- Add two records into the Student table
INSERT INTO Student (StudentID, studentFName, studentLName, studentGender, studentDOB, studentAddresss)
VALUES ('ST11', 'Nhu','Quynh1',1,'2004-08-04','BN'),
('ST12', 'Nhu','Quynh2',1,'2004-08-05','BN')

--Student_Class
INSERT INTO Student_Class
VALUES ('ST11', 'Class04'),  ('ST12', 'Class04')

--Add Hobbies
insert into Hobbies values (1,'Hobby 1')
insert into Hobbies values (2,'Hobby 2')
insert into Hobbies values (3,'Hobby 3')
insert into Hobbies values (4,'Hobby 4')


--Add Student Hobbies
insert into Hobbies_Students
values (1, 'ST11'), (2,'ST11'),(3,'ST12'),(4,'ST13')
