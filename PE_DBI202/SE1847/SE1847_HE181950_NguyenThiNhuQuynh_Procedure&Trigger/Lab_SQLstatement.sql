-- Create the Departments table
CREATE TABLE Departments (
    DeptID VARCHAR(4) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    NoOfStudents INT
);

-- Create the Students table
CREATE TABLE Students (
    StudentID VARCHAR(4) PRIMARY KEY,
    LastName NVARCHAR(30),
    FirstName NVARCHAR(40),
    Sex VARCHAR(1) CHECK (Sex IN ('F', 'M')),
    DateOfBirth DATE,
    PlaceOfBirth NVARCHAR(30),
    DeptID VARCHAR(4),
    Scholarship FLOAT,
    AverageScore NUMERIC(4, 2),
    FOREIGN KEY (DeptID) REFERENCES Departments (DeptID)
);

-- Create the Courses table
CREATE TABLE Courses (
    CourseID VARCHAR(4) PRIMARY KEY,
    Name NVARCHAR(35),
    Credits TINYINT
);

-- Create the Results table
CREATE TABLE Results (
    StudentID VARCHAR(4),
    CourseID VARCHAR(4),
    Year INT,
    Semester INT,
    Mark FLOAT,
    Grade VARCHAR(1),
    PRIMARY KEY (StudentID, CourseID, Year, Semester),
    FOREIGN KEY (StudentID) REFERENCES Students (StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses (CourseID)
);
-- Insert data into the Departments table
INSERT INTO Departments (DeptID, Name, NoOfStudents)
VALUES
    ('IS', 'Information Systems', NULL),
    ('NC', 'Network and Communication', NULL),
    ('SE', 'Software Engineering', NULL),
    ('CE', 'Computer Engineering', NULL),
    ('CS', 'Computer Science', NULL);

-- Insert data into the Students table
INSERT INTO Students (StudentID, LastName, FirstName, Sex, DateOfBirth, PlaceOfBirth, DeptID, Scholarship, AverageScore)
VALUES
    ('S001', N'Lê', N'Kim Lan', 'F', '1990-02-23', N'Hà Nội', 'IS', 130000, NULL),
    ('S002', N'Trần', N'Minh Chánh', 'M', '1992-12-24', N'Bình Định', 'NC', 150000, NULL),
    ('S003', N'Lê', N'An Tuyết', 'F', '1991-02-21', N'Hải Phòng', 'IS', 170000, NULL),
    ('S004', N'Trần', N'Anh Tuấn', 'M', '1993-12-20', N'TpHCM', 'NC', 80000, NULL),
    ('S005', N'Trần', N'Thị Mai', 'F', '1991-08-12', N'TpHCM', 'SE', 0, NULL),
    ('S006', N'Lê', N'Thị ', 'F', '1991-01-02', N'An Giang', 'IS', 0, NULL),
    ('S007', N'Nguyễn', N'Kim Thư', 'F', '1990-02-02', N'Hà Nội', 'SE', 180000, NULL),
    ('S008', N'Lê', N'Văn Long', 'M', '1992-12-08', N'TpHCM', 'IS', 190000, NULL);

-- Insert data into the Courses table
INSERT INTO Courses (CourseID, Name, Credits)
VALUES
    ('DS01', 'Database Systems', 3),
    ('AI01', 'Artificial Intelligence', 3),
    ('CN01', 'Computer Network', 3),
    ('CG01', 'Computer Graphics', 4),
    ('DSA1', 'Data Structures and Algorithms', 4);

-- Insert data into the Results table
INSERT INTO Results (StudentID, CourseID, Year, Semester, Mark, Grade)
VALUES
    ('S001', 'DS01', 2017, 1, 3, NULL),
    ('S001', 'DS01', 2017, 2, 6, NULL),
    ('S001', 'AI01', 2017, 1, 4.5, NULL),
    ('S001', 'AI01', 2017, 2, 6, NULL),
    ('S001', 'CN01', 2017, 3, 5, NULL),
    ('S002', 'DS01', 2016, 1, 4.5, NULL),
    ('S002', 'DS01', 2017, 1, 7, NULL),
    ('S002', 'CN01', 2016, 3, 10, NULL),
    ('S002', 'DSA1', 2016, 3, 9, NULL),
    ('S003', 'DS01', 2017, 1, 2, NULL),
    ('S003', 'DS01', 2017, 3, 5, NULL),
    ('S003', 'CN01', 2017, 2, 2.5, NULL),
    ('S003', 'CN01', 2017, 3, 4, NULL),
    ('S004', 'DS01', 2017, 3, 4.5, NULL),
    ('S004', 'DSA1', 2018, 1, 10, NULL),
    ('S005', 'DS01', 2017, 2, 7, NULL),
    ('S005', 'CN01', 2017, 2, 2.5, NULL),
    ('S005', 'CN01', 2018, 1, 5, NULL),
    ('S006', 'AI01', 2018, 1, 6, NULL),
    ('S006', 'CN01', 2018, 2, 10, NULL);

--Update NoOfStudents of each department in 
--Departments table where NoOfStudents is the total number of
--students of each departments. Note that for department that has no student, 
--the NoOfStudents should be 0.

UPDATE Departments
SET NoOfStudents = (
    SELECT COUNT(s.StudentID)
    FROM Students s
    WHERE s.DeptID = Departments.DeptID
);
SELECT * FROM Departments

--Update AverageScore for each student so that for each course, we take only his/her highest Mark and 
--the AverageScore of the student is calculated as the average mark of all the courses that the student joins.

UPDATE Students
SET AverageScore = (
    SELECT AVG(MaxMark)
    FROM (
        SELECT StudentID, CourseID, MAX(Mark) AS MaxMark
        FROM Results
        GROUP BY StudentID, CourseID
    ) AS MaxMarks
    WHERE MaxMarks.StudentID = Students.StudentID
);

--Update Grade in table Results so that:
--•	Grade = ‘Passed’ if 5<= Mark <= 10
--•	Grade = ‘Failed’ if 0<= Mark < 5

UPDATE Results
SET Grade = CASE
    WHEN Mark >= 5 AND Mark <= 10 THEN 'P'
    WHEN Mark >= 0 AND Mark < 5 THEN 'F'
END;

--List (StudentID, Fullname, DateOfBirth, PlaceOfBirth, DeptID, Scholarship) of  all students 
--having Scholarship not greater than 160000, in descending order of Scholarship.
SELECT 
    StudentID,
    CONCAT(FirstName, ' ', LastName) AS Fullname,
    DateOfBirth,
    PlaceOfBirth,
    DeptID,
    Scholarship
FROM Students
WHERE Scholarship <= 160000
ORDER BY Scholarship DESC;

--List (DeptID, DepartmentName, StudentID, LastName, FirstName) of all 
--departments (KHOA) so that we see also departments which have no students.

SELECT 
	D.DeptID, D.Name, S.StudentID, S.LastName, S.FirstName
FROM Departments D
LEFT JOIN Students S ON S.DeptID = D.DeptID
ORDER BY D.DeptID

--List (StudentID, LastName, FirstName, NumberOfCourses) of all students, 
--show the results in ascending order of NumberOfCourses where NumberOfCourses 
--is the total number of courses studied by each student.

SELECT 
	S.StudentID, S.LastName, S.FirstName, COUNT(R.CourseID) AS NumberOfCourses
FROM Students S
LEFT JOIN Results R ON R.StudentID = S.StudentID
GROUP BY S.StudentID, S.LastName, S.FirstName
ORDER BY NumberOfCourses

--List (DeptID, DepartmentName, NumberOfFemaleStudents, 
--NumberOfMaleStudents) of all departments.
select 
    D.DeptID,
    D.Name,
    COUNT(CASE WHEN S.Sex = 'F' THEN 1 END) AS NumberOfFemaleStudents,
    COUNT(CASE WHEN S.Sex = 'M' THEN 1 END) AS NumberOfMaleStudents
FROM Departments D
LEFT JOIN Students S ON D.DeptID = S.DeptID
GROUP BY D.DeptID, D.Name
ORDER BY D.DeptID;

--the list of students which are not in the department ‘Information Systems’ 
--but having Mark of Database Systems greater than at least one student of 
--department ‘Information Systems’.
SELECT S.StudentID, S.LastName, S.FirstName
FROM Students S
JOIN Results R ON S.StudentID = R.StudentID
JOIN Departments D ON S.DeptID = D.DeptID
WHERE D.Name <> 'Information Systems'
  AND R.CourseID = 'DS01'
  AND R.Mark > ANY (
    SELECT R2.Mark
    FROM Students S2
    JOIN Results R2 ON S2.StudentID = R2.StudentID
    JOIN Departments D2 ON S2.DeptID = D2.DeptID
    WHERE D2.Name = 'Information Systems'
      AND R2.CourseID = 'DS01'
  );

--List (CourseID, CourseName, BestStudentFullName) where BestStudentFullName is
--the name of the student who has the highest mark for this course.
SELECT
    c.CourseID,
    c.Name,
    CONCAT(s.FirstName, ' ', s.LastName) AS BestStudentFullName
from Courses c
     JOIN Results m ON c.CourseID = m.CourseID
     JOIN Students s ON m.StudentID = s.StudentID
WHERE
    m.Mark = (
        SELECT MAX(Mark)
        FROM Results
        WHERE CourseID = c.CourseID
    );