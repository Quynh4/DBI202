with t as(
SELECT  Student.studentID, Student.studentFName, Student.studentLName, Student.studentGender, Scholarship.schoGranted,  (sum(Subject.numOfCredit * Exam.examScore)/sum(Subject.numOfCredit)) as avgScore
FROM     Exam INNER JOIN
                  Student ON Exam.studentID = Student.studentID INNER JOIN
                  Student_Class ON Student.studentID = Student_Class.studentID INNER JOIN
                  Student_Scholarship ON Student.studentID = Student_Scholarship.StudentID INNER JOIN
                  Scholarship ON Student_Scholarship.schoName = Scholarship.schoName INNER JOIN
				  Subject ON Subject.subjectCode = Exam.subjectCode
group by Student.studentID, Student.studentFName, Student.studentLName, Student.studentGender, Scholarship.schoGranted
)
select * from t
where schoGranted >= all (select schoGranted from t)
--schoGranted = (select max(schoGranted) from Scholarship)
or avgScore >=  all (select avgScore from t)
