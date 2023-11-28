use PE_DBI202_SU2023
--2
SELECT * FROM Courses WHERE credits > 3;
--3
select distinct a.id as AssessmentID, a.type,  a.name, a.[percent], c.title as CourseTitle
from Assessments a
join marks m on a.id = m.assessmentId
join Courses c on c.id = a.courseId
where c.title = 'Introduction to Databases'

--4
select distinct s.id as studentId, s.name as StudentName, s.department,
se.code as SemesterCode, se.year, c.title as CourseTitle
from  enroll e
join Students s on e.studentId = s.id
join semesters se on se.id = e.semesterId
join Courses c on c.id = e.courseId
where c.title = 'Operating Systems'
order by se.year, SemesterCode, s.id

--5
SELECT
  c.id AS CourseId
 ,c.code
 ,c.title
 ,COUNT(DISTINCT e1.studentId) AS NumberOfEnrolledStudents
FROM Courses c
LEFT JOIN (SELECT
    *
  FROM enroll e
  JOIN semesters s
    ON e.semesterId = s.id
  WHERE s.year = 2019) AS e1
  ON c.id = e1.courseId
GROUP BY c.id
        ,c.code
        ,c.title;


--6
--cach 1
with t as (
select a.courseId, c.code, c.title, count(distinct a.[type]) as NumberOfAssessmentTypes, 
	count(a.id) as NumberOfAssessments
	from Courses c join Assessments a on c.id = a.courseId
	group by a.courseId, c.code, c.title)
select * from t
where NumberOfAssessments >= all (select NumberOfAssessments from t)


--cach 2 --khong nen dung vi no chi lay 1 kq
select top 1  a.courseId, c.code, c.title, count(distinct a.[type]) as NumberOfAssessmentTypes, 
	count(a.id) as NumberOfAssessments
	from Courses c join Assessments a on c.id = a.courseId
	group by a.courseId, c.code, c.title
order by NumberOfAssessments desc

--cach 3
SELECT Courses.id, Courses.code, Courses.title, Assessments.type, Assessments.id 
FROM     Courses INNER JOIN
                  Assessments ON Courses.id = Assessments.courseId

--7
with m as (select m.enrollId, sum(m.mark * a.[percent]) as avgm from marks m
join Assessments a on m.assessmentId = a.id
group by m.enrollId
)
select e.enrollId, e.courseId, c.title, e.studentId, s.name as StudentName,
e.semesterId, se.code as SemesterCode, m.avgm
from enroll e
join Courses c on e.courseId = c.id
join Students s on s.id = e.studentId
join semesters se on se.id = e.semesterId
join m on m.enrollId = e.enrollId
where title = 'Introduction to Databases'
order by studentId, semesterId desc

--8
drop PROCEDURE P2
CREATE PROCEDURE P2
    @studentId INT,
    @semesterCode VARCHAR(20),
    @numberOfCourses INT OUTPUT
AS
BEGIN
    SELECT @numberOfCourses = COUNT(*) 
    FROM enroll e join semesters s on e.semesterId = s.id
    WHERE studentId = @studentId
    AND s.code = @semesterCode;
END

declare @x int
exec P2 9, 'Sp2019', @x output
select @x as NumberOfCourses

--9

CREATE TRIGGER Tr1
ON enroll
FOR INSERT
AS
BEGIN
    INSERT INTO marks (enrollId, assessmentId)
    SELECT i.enrollId, a.id
    FROM inserted i
    INNER JOIN assessments a ON a.courseId = i.courseId;
END


insert into enroll(enrollId, studentId, courseId,semesterId)
values(600,9,11,4)

select * from marks

--10
insert into Students (id, name, birthdate, gender, department)
values (110, 'Mary Jane', '2001-5-12', 'Female', 
 (SELECT Code FROM Departments WHERE Name = 'Business Administration'))
