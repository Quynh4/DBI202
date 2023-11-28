
create table Courses 
(
CourseNo varchar(30) primary key,
[Name] nvarchar(255),
[Description] nvarchar(255),
Credits tinyint
)

create table Assessments
(
AssessmentCode varchar(30),
[Percent] float,
[Type] nvarchar(30),
CourseNo varchar(30) references Courses(CourseNo),
PRIMARY KEY (CourseNo,AssessmentCode)
)


create table Marks
(
StudentCode varchar(15),
mark float,
CourseNo varchar(30) references Courses(CourseNo),
AssessmentCode varchar(30),
PRIMARY KEY(CourseNo, StudentCode, AssessmentCode)
)
