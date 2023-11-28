use FUH_COMPANY

--26. Cho biết số lượng thành viên của mỗi dự án.
--mã dự án, tên dự án, số lượng thành viên

SELECT tblProject.proNum, tblProject.proName, count(tblWorksOn.empSSN) as NumberOfMembers
FROM     tblProject LEFT JOIN
                  tblWorksOn ON tblProject.proNum = tblWorksOn.proNum
group by tblProject.proNum, tblProject.proName


--27. Cho biết tổng số giờ làm của mỗi dự án.
--mã dự án, tên dự án, tổng số giờ làm
SELECT tblProject.proNum, tblProject.proName, sum(tblWorksOn.workHours) AS TotalWorkHours
FROM     tblWorksOn RIGHT JOIN tblProject ON tblWorksOn.proNum = tblProject.proNum
group by tblProject.proNum, tblProject.proName;


--28. Cho biết dự án nào có số lượng thành viên là ít nhất.
--mã dự án, tên dự án, số lượng thành viên
WITH t AS (
    SELECT tblProject.proNum, tblProject.proName, COUNT(tblWorksOn.empSSN) AS NumberOfMembers
    FROM tblProject
    LEFT JOIN tblWorksOn ON tblProject.proNum = tblWorksOn.proNum
    GROUP BY tblProject.proNum, tblProject.proName
)
SELECT *
FROM t
WHERE NumberOfMembers <= all (SELECT NumberOfMembers FROM t)

--29. Cho biết dự án nào có số lượng thành viên là nhiều nhất.
--mã dự án, tên dự án, số lượng thành viên
WITH t AS (
    SELECT tblProject.proNum, tblProject.proName, COUNT(tblWorksOn.empSSN) AS NumberOfMembers
    FROM tblProject
    LEFT JOIN tblWorksOn ON tblProject.proNum = tblWorksOn.proNum
    GROUP BY tblProject.proNum, tblProject.proName
)
SELECT *
FROM t
WHERE NumberOfMembers >= all (SELECT NumberOfMembers FROM t)

--30. Cho biết dự án nào có tổng số giờ làm là ít nhất.
--mã dự án, tên dự án, tổng số giờ làm
with t as (SELECT tblProject.proNum, tblProject.proName, sum(tblWorksOn.workHours) AS TotalWorkHours
FROM     tblWorksOn RIGHT JOIN tblProject ON tblWorksOn.proNum = tblProject.proNum
group by tblProject.proNum, tblProject.proName) 
select * from t where TotalWorkHours <= all (select TotalWorkHours from t)

--31. Cho biết dự án nào có tổng số giờ làm là nhiều nhất.
--mã dự án, tên dự án, tổng số giờ làm
with t as (SELECT tblProject.proNum, tblProject.proName, sum(tblWorksOn.workHours) AS TotalWorkHours
FROM     tblWorksOn RIGHT JOIN tblProject ON tblWorksOn.proNum = tblProject.proNum
group by tblProject.proNum, tblProject.proName) 
select * from t where TotalWorkHours >= all (select TotalWorkHours from t)


--32. Cho biết số lượng phòng ban làm việc theo mỗi nơi làm việc.
--tên nơi làm việc, số lượng phòng ban
SELECT tblLocation.locName, count(tblDepLocation.depNum) as NumberOfDep
FROM     tblLocation LEFT JOIN tblDepLocation ON tblLocation.locNum = tblDepLocation.locNum
group by tblLocation.locName


--33. Cho biết số lượng chỗ làm việc theo mỗi phòng ban.
--mã phòng ban, tên phòng ban, số lượng chỗ làm việc
SELECT tblDepartment.depNum, tblDepartment.depName, count(tblDepLocation.locNum) as NumberOfLoc
FROM     tblDepartment LEFT JOIN  tblDepLocation ON tblDepartment.depNum = tblDepLocation.depNum
group by tblDepartment.depNum, tblDepartment.depName;


--34. Cho biết phòng ban nào có nhiều chỗ làm việc nhất.
--mã phòng ban, tên phòng ban, số lượng chỗ làm việc
with t as (
SELECT tblDepartment.depNum, tblDepartment.depName, count(tblDepLocation.locNum) as NumberOfLoc
FROM     tblDepartment LEFT JOIN  tblDepLocation ON tblDepartment.depNum = tblDepLocation.depNum
group by tblDepartment.depNum, tblDepartment.depName
) select * from t where NumberOfLoc >= all (select NumberOfLoc from t)

--35. Cho biết phòng ban nào có it chỗ làm việc nhất.
--mã phòng ban, tên phòng ban, số lượng chỗ làm việc
with t as (
SELECT tblDepartment.depNum, tblDepartment.depName, count(tblDepLocation.locNum) as NumberOfLoc
FROM     tblDepartment LEFT JOIN  tblDepLocation ON tblDepartment.depNum = tblDepLocation.depNum
group by tblDepartment.depNum, tblDepartment.depName
) select * from t where NumberOfLoc <= all (select NumberOfLoc from t)

--36. Cho biết địa điểm nào có nhiều phòng ban làm việc nhất.
--tên nơi làm việc, số lượng phòng ban
with t as (SELECT tblLocation.locName, count(tblDepLocation.depNum) as NumberOfDep
FROM     tblLocation LEFT JOIN tblDepLocation ON tblLocation.locNum = tblDepLocation.locNum
group by tblLocation.locName)
select * from t where NumberOfDep >= all (select NumberOfDep from t)

--37. Cho biết địa điểm nào có ít phòng ban làm việc nhất.
--tên nơi làm việc, số lượng phòng ban
with t as (SELECT tblLocation.locName, count(tblDepLocation.depNum) as NumberOfDep
FROM     tblLocation LEFT JOIN tblDepLocation ON tblLocation.locNum = tblDepLocation.locNum
group by tblLocation.locName)
select * from t where NumberOfDep <= all (select NumberOfDep from t)

--38. Cho biết nhân viên nào có nhiều người phụ thuộc nhất.
--mã số, họ tên nhân viên, số lượng người phụ thuộc
with t as (SELECT tblEmployee.empSSN, tblEmployee.empName, count(tblDependent.empSSN)  as NumberOfDep
FROM     tblDependent RIGHT JOIN    tblEmployee ON tblDependent.empSSN = tblEmployee.empSSN
group by tblEmployee.empSSN, tblEmployee.empName)
select * from t where NumberOfDep >= all (select NumberOfDep from t)


--39. Cho biết nhân viên nào có ít người phụ thuộc nhất.
--mã số, họ tên nhân viên, số lượng người phụ thuộc
with t as (SELECT tblEmployee.empSSN, tblEmployee.empName, count(tblDependent.empSSN)  as NumberOfDep
FROM     tblDependent RIGHT JOIN    tblEmployee ON tblDependent.empSSN = tblEmployee.empSSN
group by tblEmployee.empSSN, tblEmployee.empName)
select * from t where NumberOfDep <= all (select NumberOfDep from t)

--40. Cho biết nhân viên nào không có người phụ thuộc.
--mã số nhân viên, họ tên nhân viên, tên phòng ban của nhân viên
with t as (SELECT tblEmployee.empSSN, tblEmployee.empName, count(tblDependent.empSSN)  as NumberOfDep
FROM     tblDependent RIGHT JOIN    tblEmployee ON tblDependent.empSSN = tblEmployee.empSSN
group by tblEmployee.empSSN, tblEmployee.empName)
select * from t where NumberOfDep =0

--41. Cho biết phòng ban nào không có người phụ thuộc.
--mã số phòng ban, tên phòng ban
with t as (SELECT tblDepartment.depName, tblDepartment.depNum, count(tblDependent.depName) as NumberOfDep
FROM     tblDependent RIGHT JOIN
                  tblEmployee ON tblDependent.empSSN = tblEmployee.empSSN RIGHT JOIN
                  tblDepartment ON tblEmployee.depNum = tblDepartment.depNum AND tblEmployee.empSSN = tblDepartment.mgrSSN
group by tblDepartment.depName, tblDepartment.depNum
) 
select * from t where NumberOfDep =0


--42. Cho biết những nhân viên nào chưa hề tham gia vào bất kỳ dự án nào.
--mã số, tên nhân viên, tên phòng ban của nhân viên
with t as(
SELECT tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName, count(tblWorksOn.proNum) as NumberOfPro
FROM     tblWorksOn RIGHT JOIN
                  tblEmployee ON tblWorksOn.empSSN = tblEmployee.empSSN JOIN
                  tblDepartment ON tblEmployee.depNum = tblDepartment.depNum 
group by  tblEmployee.empSSN, tblEmployee.empName, tblDepartment.depName
) select * from t where NumberOfPro =0


--43. Cho biết phòng ban không có nhân viên nào tham gia (bất kỳ) dự án.
--mã số phòng ban, tên phòng ban
with t as(
SELECT tblDepartment.depNum, tblDepartment.depName, count(tblWorksOn.proNum) as NumberOfPro
FROM     tblWorksOn RIGHT JOIN
                  tblEmployee ON tblWorksOn.empSSN = tblEmployee.empSSN JOIN
                  tblDepartment ON tblEmployee.depNum = tblDepartment.depNum 
group by   tblDepartment.depNum, tblDepartment.depName
) select * from t where NumberOfPro =0

--44. Cho biết phòng ban không có nhân viên nào tham gia vào dự án có tên là ProjectA. 
--mã số phòng ban, tên phòng ban

select d.depNum, d.depName from tblDepartment d
left join tblEmployee e on e.depNum = d.depNum
except
select d.depNum, d.depName from tblDepartment d
left join tblEmployee e on e.depNum = d.depNum
where e.empSSN is null or e.empSSN not in (
	SELECT empSSN
	FROM tblWorksOn w, tblProject p
	WHERE w.proNum=p.proNum AND p.proName='ProjectA')



-- set du lieu trong 1 cot
UPDATE tblProject
SET proName = 'ProjectA'
WHERE proName = 'Project A';

--45. Cho biết số lượng dự án được quản lý theo mỗi phòng ban.
--mã phòng ban, tên phòng ban, số lượng dự án
SELECT tblDepartment.depNum, tblDepartment.depName, count(tblProject.proNum) as NumberOfProject
FROM     tblDepartment LEFT JOIN 
                  tblProject ON tblDepartment.depNum = tblProject.depNum
group by tblDepartment.depNum, tblDepartment.depName;

--46. Cho biết phòng ban nào quản lý it dự án nhất.
--mã phòng ban, tên phòng ban,số lượng dự án
with t as 
(SELECT tblDepartment.depNum, tblDepartment.depName, count(tblProject.proNum) as NumberOfProject
FROM     tblDepartment LEFT JOIN 
                  tblProject ON tblDepartment.depNum = tblProject.depNum
group by tblDepartment.depNum, tblDepartment.depName)
select * from t where NumberOfProject <= all (select NumberOfProject from t)

--47. Cho biết phòng ban nào quản lý nhiều dự án nhất.
--mã phòng ban, tên phòng ban, số lượng dự án

with t as 
(SELECT tblDepartment.depNum, tblDepartment.depName, count(tblProject.proNum) as NumberOfProject
FROM     tblDepartment LEFT JOIN 
                  tblProject ON tblDepartment.depNum = tblProject.depNum
group by tblDepartment.depNum, tblDepartment.depName)
select * from t where NumberOfProject >= all (select NumberOfProject from t)

--48. Cho biết những phòng ban nào có nhiểu hơn 5 nhân viên đang quản lý dự án gì. 
--mã phòng ban, tên phòng ban, số lượng nhân viên của phòng ban, tên dự án quản lý
with t as (SELECT  tblDepartment.depNum, tblDepartment.depName, count(tblEmployee.empSSN) NumOfEmp
FROM     tblDepartment INNER JOIN tblEmployee ON tblDepartment.depNum = tblEmployee.depNum
group by tblDepartment.depNum, tblDepartment.depName
having count(tblEmployee.empSSN)>5
)
select t.depNum, depName, NumOfEmp, p.proName from t join tblProject p on p.depNum = t.depNum

--49. Cho biết những nhân viên thuộc phòng có tên là Phòng nghiên cứu, và không có người phụ thuộc.
--mã nhân viên,họ tên nhân viên
SELECT empSSN, empName
FROM tblEmployee 
WHERE depNum in (SELECT depNum
				FROM tblDepartment
				WHERE depName=N'Phòng Nghiên cứu và phát triển')
and empSSN not in (select distinct empSSN from tblDependent)


--50. Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này không có người phụ thuộc.
--mã nhân viên,họ tên nhân viên, tổng số giờ làm
WITH t AS (
    SELECT empSSN, empName
    FROM tblEmployee
    WHERE empSSN NOT IN (SELECT DISTINCT empSSN FROM tblDependent)
)
SELECT t.empSSN, t.empName, SUM(COALESCE(w.workHours, 0)) AS TotalWorkHours
FROM t
LEFT JOIN tblWorksOn w ON t.empSSN = w.empSSN
GROUP BY t.empSSN, t.empName;

--51. Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này có nhiều hơn 3 người phụ thuộc.
--mã nhân viên,họ tên nhân viên, số lượng người phụ thuộc, tổng số giờ làm
WITH t AS (
    SELECT tblEmployee.empSSN, tblEmployee.empName, COUNT(tblDependent.depName) AS NumOfDep
    FROM tblEmployee
    left JOIN tblDependent ON tblEmployee.empSSN = tblDependent.empSSN
    GROUP BY tblEmployee.empSSN, tblEmployee.empName
    HAVING COUNT(tblDependent.depName) >3
)

SELECT t.empSSN, t.empName, SUM(COALESCE(w.workHours, 0)) AS TotalWorkHours
FROM t
LEFT JOIN tblWorksOn w ON t.empSSN = w.empSSN
GROUP BY t.empSSN, t.empName;


--52. Cho biết tổng số giờ làm việc của các nhân viên hiện đang dưới quyền giám sát (bị quản lý bởi)
--của nhân viên Mai Duy An.mã nhân viên, họ tên nhân viên, tổng số giờ làm
WITH t AS (
    SELECT empSSN, empName
    FROM tblEmployee
    WHERE empSSN IN (select empSSN from tblEmployee
						where supervisorSSN = (select empSSN from tblEmployee where empName='Mai Duy An'))
)
SELECT t.empSSN, t.empName, SUM(COALESCE(w.workHours, 0)) AS TotalWorkHours
FROM t
LEFT JOIN tblWorksOn w ON t.empSSN = w.empSSN
GROUP BY t.empSSN, t.empName;

