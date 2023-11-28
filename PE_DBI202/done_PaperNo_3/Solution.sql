-- 1
create table Hobbies
(
ho_id int primary key,
ho_name varchar(30),
)

create table Hobbies_Students
(
hs_ho_id int,
hs_st_id varchar(10)
)

alter table Student
add hometown varchar(200)

alter table Student
alter column studentAddress varchar(200)

-- 2
-- Từ chối làm

-- 3
create trigger atLeast15 on Student
for insert
as
begin
if (select year(getdate()) - year(studentDOB) from inserted) < 15
rollback transaction
end

-- 4
create proc checkScholarship
(
@scho int
)
as
begin
select st.studentFName, st.studentLName from Student st, Scholarship sc, Student_Scholarship ss
where st.studentID = ss.StudentID and ss.schoName = sc.schoName and sc.schoGranted > @scho
end

-- 5
select * from Student where year(GETDATE()) - year(studentDOB) > 20 and studentGender = 1

-- 6
select s.studentFName, s.studentLName, c.className from Student s, Student_Class sc, Class c
where s.studentID = sc.studentID and sc.classCode = c.classCode

--7
select st.studentFName, st.studentLName from Student st, Student_Scholarship ss, Scholarship sc
where st.studentID = ss.StudentID and ss.schoName = sc.schoName and sc.schoGranted = (select max(sc.schoGranted) from Student st, Student_Scholarship ss, Scholarship sc
where st.studentID = ss.StudentID and ss.schoName = sc.schoName)

-- 8
select a.schoName, sum(a.schoGranted) as 'TotalBudget' from (select sc.schoName, sc.schoGranted from Student st, Student_Scholarship ss, Scholarship sc
where st.studentID = ss.StudentID and ss.schoName = sc.schoName) as a
group by a.schoName

-- 9
select * from Student where 
studentID =
/* Highest average score */
(select b.studentID from
(select studentID, AVG(examScore) as 'Avg' from Exam
group by studentID
having AVG(examScore) = (select max(a.Avg) from 
(select studentID, AVG(examScore) as 'Avg' from Exam
group by studentID) as a)) as b)
or studentID =
/* Highest scholarship */
(select st.studentID from Student st, Student_Scholarship ss, Scholarship sc
where st.studentID = ss.StudentID and ss.schoName = sc.schoName and sc.schoGranted = (select max(sc.schoGranted) from Student st, Student_Scholarship ss, Scholarship sc
where st.studentID = ss.StudentID and ss.schoName = sc.schoName))