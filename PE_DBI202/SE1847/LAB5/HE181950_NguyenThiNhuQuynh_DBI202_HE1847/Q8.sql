with t as(
SELECT Student.*, Scholarship.schoGranted
FROM     Student INNER JOIN
                  Student_Scholarship ON Student.studentID = Student_Scholarship.StudentID 
				 INNER JOIN
                  Scholarship ON Student_Scholarship.schoName = Scholarship.schoName
)
select * from t
where schoGranted >= all (select schoGranted from t)
--where schoGranted = (select max(schoGranted) from Scholarship)
