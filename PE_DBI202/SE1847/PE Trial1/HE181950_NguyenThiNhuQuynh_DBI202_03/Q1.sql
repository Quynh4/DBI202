CREATE TABLE Students (
  StudentID int PRIMARY KEY,
  Name nvarchar(50),
  Gender char(1),
  Address nvarchar(200)
);

CREATE TABLE Teachers (
  TeacherID int PRIMARY KEY,
  Name nvarchar(50),
  Gender char(1),
  Address nvarchar(200)
);

CREATE TABLE Classes (
  ClassID int PRIMARY KEY,
  Semester char(10),
  Year int,
  NoCredits int,
  CourseID char(6),
  GroupID char(6)
);

CREATE TABLE Attend (
  Date date,
  Slot int,
  StudentID int,
  ClassID int,
  Attend bit,
  PRIMARY KEY (Date, Slot),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

CREATE TABLE Teach (
  TeacherID int,
  ClassID int,
  FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID),
  FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);
