-- Create the stored procedure
drop PROCEDURE GetStudentsByScholarship

CREATE PROCEDURE GetStudentsByScholarship
    @schoGranted float
AS
BEGIN
    SELECT s.*, sch.schoGranted
    FROM Student s
	join Student_Scholarship ss on s.studentID = ss.StudentID
    join Scholarship sch ON ss.schoName = sch.schoName
    WHERE sch.schoGranted > @schoGranted;
END

--exec GetStudentsByScholarship @schoGranted = 5000