create table Managers ( bonus money )

create table Projects (
ProjectID int primary key,
name nvarchar(200)
)

create table Employees (
EmpID int primary key,
name nvarchar(200),
salary money
)

create table Manages (
ProjectID int references Projects(ProjectID),
primary key (ProjectID)
)

create table Works (
hours int,
ProjectID int references Projects(ProjectID),
EmpID int references Employees(EmpID),
primary key (ProjectID, EmpID)
)