use FUH_COMPANY
--1. Listing all employees whose salary exceed at 50000
SELECT * FROM tblEmployee WHERE empSalary> 50000 
SELECT * FROM tblEmployee WHERE empSalary> 100000 

--2. Listing name and salary of all employees whose income exceed 50000
SELECT empName, empSalary FROM tblEmployee WHERE empSalary> 50000

--3. Listing full name and salary of all employees whose income exceed 50000
SELECT empName AS 'Họ và tên', empSalary AS 'Lương' FROM tblEmployee WHERE empSalary> 50000

--4. List all under 40 year-old female or under 50 year-old male employees
SELECT empName AS 'Họ và tên',empSex AS 'Giới tính', YEAR (GETDATE())-YEAR (empBirthdate) AS 'Tuổi'
FROM tblEmployee
WHERE (empSEX='F' AND YEAR (GETDATE())-YEAR (empBirthdate) <40)
OR (empSEX='M' AND YEAR (GETDATE())-YEAR (empBirthdate) <50)

SELECT empName AS 'Họ và tên',empSex AS 'Giới tính', YEAR (GETDATE())-YEAR (empBirthdate) AS 'Tuổi'
FROM tblEmployee
WHERE (empSEX='F' AND YEAR (GETDATE())-YEAR (empBirthdate) >50)
OR (empSEX='M' AND YEAR (GETDATE())-YEAR (empBirthdate) <50)

SELECT empName AS 'Họ và tên',empSex AS 'Giới tính', YEAR (GETDATE())-YEAR (empBirthdate) AS 'Tuổi'
FROM tblEmployee
WHERE (empSEX='F' AND YEAR (GETDATE())-YEAR (empBirthdate) >50)
OR (empSEX='M' AND YEAR (GETDATE())-YEAR (empBirthdate) >50)


--6. Listing all employee by department number ascreasingly, then by salary descreasingly
SELECT * FROM tblEmployee ORDER BY depNum ASC, empSalary DESC

--7. List all employees who work on ‘Phòng Phần mềm trong nước’ department
SELECT * FROM tblEmployee E, tblDepartment D 
WHERE e.depNum=d.depNum AND d.depName LIKE N'Phòng phần mềm trong nước'

SELECT * FROM tblEmployee E, tblDepartment D 
WHERE e.depNum=d.depNum AND d.depName LIKE N'Phòng phần mềm%'

--8. Find all cities in which our company is
SELECT distinct l.locname
FROM tblLocation l, tblDepLocation d WHERE l.locNum=d.locNum

--9. Find all those project numbers which have more than two members
SELECT distinct w1.proNum as 'Project Number' 
FROM tblWorksOn w1, tblWorksOn w2 
WHERE w1.proNum=w2.proNum AND w1.empSSN <> w2.empSSN

--10.1. Find all those employees whose name is begun by ‘H’ or salary exceed 80000
SELECT * FROM tblEmployee WHERE empName LIKE 'H%'
UNION
SELECT * FROM tblEmployee WHERE empSalary > 80000

SELECT * FROM tblEmployee WHERE empName LIKE 'H%' or empSalary > 80000

--10.2. Find all those normal employees, that is who do not supervise any other employees
SELECT empSSN FROM tblEmployee 
EXCEPT
SELECT supervisorSSN FROM tblEmployee

SELECT * FROM tblEmployee

SELECT empSSN FROM tblEmployee where supervisorSSN is not null

--10.3. Find all employees who work on projectB and projectC
SELECT empSSN
FROM tblWorksOn w, tblProject p
WHERE w.proNum=p.proNum AND p.proName='ProjectB'
INTERSECT
SELECT empSSN
FROM tblWorksOn w, tblProject p
WHERE w.proNum=p.proNum AND
p.proName='ProjectC'



--11. Find the employees of Phòng Phần mềm trong nước department
SELECT *
FROM tblEmployee 
WHERE depNum = (SELECT depNum
				FROM tblDepartment
				WHERE depName=N'Phòng Phần mềm trong nước')

SELECT *
FROM tblEmployee 
WHERE depNum = any(SELECT depNum
				FROM tblDepartment
				WHERE depName=N'Phòng Phần mềm trong nước')

SELECT *
FROM tblEmployee 
WHERE depNum in (SELECT depNum
				FROM tblDepartment
				WHERE depName=N'Phòng Phần mềm trong nước')

--12. Find the dependents of all employees of department number 1
SELECT *
FROM tblDependent
WHERE empSSN IN (SELECT empSSN
					FROM tblEmployee
					WHERE depNum=1)

--13. Find all those projects have the same location with projectA
SELECT * FROM tblProject p
WHERE locNum = (SELECT p.locNum FROM tblProject p WHERE p.proName=N'ProjectA')
   
--15.2. Find departments and employees who work in those departments, respectively
SELECT * 
FROM tblDepartment d JOIN tblEmployee e 
ON d.depNum = e.depNum

--17.1. For each location, listing the projects that are processed in it
SELECT l.locNum,l.locName, p.proNum, p.proName
FROM tblLocation l LEFT OUTER JOIN tblProject p ON l.locNum = p.locNum

--17.2. For each department, listing the projects that it controls
SELECT d.depName, p.proName
FROM tblDepartment d left OUTER JOIN tblProject p ON d.depNum = p.depNum

select * from tblProject

--17.3. List all location in which the projects are processed.
SELECT DISTINCT l.locNum, l.locName
FROM tblLocation l JOIN tblProject p ON l.locNum=p.locNum

--18.1. Find average salary of all employees
SELECT AVG(empSalary) AS Average_Of_Salary
FROM tblEmployee

--18.2. Find number of employees
SELECT COUNT(*) AS Count_Of_Employees
FROM tblEmployee


--19.1 Group employees by department number
SELECT *
FROM tblEmployee
ORDER BY depNum desc

SELECT *
FROM tblEmployee
ORDER BY depNum

SELECT *
FROM tblEmployee
ORDER BY empName

--19.2List number of employees for each department number
SELECT depNum, COUNT(*) AS Num_Of_Employees
FROM tblEmployee
GROUP BY depNum
ORDER BY count(*) ASC


--20.Compute the number of employees for each project
SELECT proNum,COUNT(*) AS Num_Of_Employees
FROM tblWorksOn
GROUP BY proNum


--21.Print the number of employees for each those department, whose average salary exceeds 80000
SELECT depNum, AVG(empSalary) AS Average_Of_Salary
FROM tblEmployee
GROUP BY depNum
HAVING AVG(empSalary) > 80000l
