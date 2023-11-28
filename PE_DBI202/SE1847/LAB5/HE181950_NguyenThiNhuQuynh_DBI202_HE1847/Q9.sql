with t as(
SELECT Student.*, Scholarship.*

FROM     Student INNER JOIN
                  Student_Scholarship ON Student.studentID = Student_Scholarship.StudentID RIGHT JOIN
                  Scholarship ON Student_Scholarship.schoName = Scholarship.schoName
)
select schoName, sum(case when studentID is null then 0 else schoGranted end) as TotalBudget from t
group by schoName