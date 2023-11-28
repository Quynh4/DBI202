CREATE TABLE Students(
StudentID INT PRIMARY KEY,
[Name] NVARCHAR(50),
[Address] NVARCHAR(200),
Gender CHAR(1)
)

CREATE TABLE Teachers(	
TeacherID INT PRIMARY KEY,		
Name NVARCHAR(50),
[Address] NVARCHAR(200),
Gender CHAR(1)
)

CREATE TABLE Classes(
GroupID CHAR(6),
courseID CHAR(6),
NoCredits INT,
Semester CHAR(10),
[year] INT,
classID INT PRIMARY KEY,
TeacherID INT references Teachers(TeacherID)
)

CREATE TABLE Attend(
[Date] DATE,
StudentID INT references Students(StudentID),
classID INT references Classes(ClassID),
Slot INT,
Attend bit
PRIMARY KEY(StudentID, ClassID, [Date],Slot)
)

 
