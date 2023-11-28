-- use FUH_COMPANY
--1. Cho biết ai đang quản lý phòng ban có tên: Phòng Nghiên cứu và phát triển.
--mã số,họ tên nhân viên, mã số phòng ban, tên phòng ban
select e.empSSN, e.empName, e.depNum, d.depName
from tblDepartment d INNER JOIN tblEmployee e 
ON d.mgrSSN = e.empSSN
WHERE d.depName = N'Phòng nghiên cứu và phát triển';

--2. Cho phòng ban có tên: Phòng Nghiên cứu và phát triển hiện đang quản lý dự án nào.
--mã số dự án, tên dự án, tên phòng ban quản lý
select p.proNum, p.proName, d.depName
from tblDepartment d, tblProject p
where d.depNum = p.depNum and d.depName like N'Phòng Nghiên cứu và phát triển' -- 0 result

--3. Cho biết dự án có tên ProjectB hiện đang được quản lý bởi phòng ban nào.
--mã số dự án, tên dự án, tên phòng ban quản lý
select p.proNum, p.proName, d.depName
from tblDepartment d, tblProject p
where d.depNum = p.depNum and p.proName like 'ProjectB'

--4. Cho biết những nhân viên nào đang bị giám sát bởi nhân viên có tên Mai Duy An.
--mã số nhân viên, họ tên nhân viên
select empSSN, empName from tblEmployee
where supervisorSSN in (select empSSN from tblEmployee where empName like 'Mai Duy An')


--5. Cho biết ai hiện đang giám sát những nhân viên có tên Mai Duy An.
--mã số nhân viên, họ tên nhân viên giám sát.
select empSSN, empName from tblEmployee
where empSSN in (select supervisorSSN from tblEmployee
					where empName like 'Mai Duy An')

--6. Cho biết dự án có tên ProjectA hiện đang làm việc ở đâu.
--mã số, tên vị trí làm việc.
select l.locNum, l.locName from tblProject p, tblLocation l
where p.locNum = l.locNum
and p.proName like 'ProjectA'

--7. Cho biết vị trí làm việc có tên Tp. HCM hiện đang là chỗ làm việc của những dự án nào. 
--mã số, tên dự án
select p.proNum, p.proName from tblProject p, tblLocation l
where p.locNum = l.locNum
and l.locName like 'Tp. HCM' --not found

select p.proNum, p.proName from tblProject p, tblLocation l
where p.locNum = l.locNum
and l.locName like N'TP Hồ Chí Minh'

--8. Cho biết những người phụ thuộc trên 18 tuổi.
--tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào.
select d.depName, d.depBirthdate, e.empName from tblDependent d, tblEmployee e
where d.empSSN = e.empSSN 
and YEAR(GETDATE())-YEAR(d.depBirthdate) > 18

--9. Cho biết những người phụ thuộc là nam giới.
--tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào
select d.depName, d.depBirthdate, e.empName
from tblDependent d, tblEmployee e
where d.empSSN = e.empSSN 
and d.depSex='M'

--10. Cho biết những nơi làm việc của phòng ban có tên : Phòng Nghiên cứu và phát triển.
--mã phòng ban, tên phòng ban, tên nơi làm việc.
select d.depNum, d.depName, l.locName
from tblDepartment d, tblLocation l, tblDepLocation dl
where d.depNum = dl.depNum and l.locNum = dl.locNum
and d.depName like N'Phòng Nghiên cứu và phát triển'

--11. Cho biết các dự án làm việc tại Tp. HCM.
--mã dự án, tên dự án, tên phòng ban chịu trách nhiệm dự án.
select p.proNum, p.proName, d.depName
from tblProject p, tblLocation l, tblDepartment d
where p.locNum = l.locNum and p.depNum = d.depNum
and l.locName like 'Tp. HCM' --not found

select p.proNum, p.proName, d.depName
from tblProject p, tblLocation l, tblDepartment d
where p.locNum = l.locNum and p.depNum = d.depNum
and l.locName like N'TP Hồ Chí Minh' --1 result


--12. Cho biết những người phụ thuộc là nữ giới, 
--của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển.
--tên nhân viên, tên người phụ thuộc, mối liên hệ giữa người phụ thuộc với nhân viên
select e.empName, d.depName, d.depRelationship
from tblDependent d, tblEmployee e, tblDepartment p
where d.empSSN = e.empSSN and e.depNum = p.depNum
and d.depSex='F'
and p.depName like N'Phòng Nghiên cứu và phát triển'

--13. Cho biết những người phụ thuộc trên 18 tuổi, 
--của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển.
--tên nhân viên, tên người phụ thuộc, mối liên hệ giữa người phụ thuộc với nhân viên

SELECT e.empName, d.depName, d.depRelationship
FROM tblDependent d
JOIN tblEmployee e ON d.empSSN = e.empSSN
JOIN tblDepartment p ON e.depNum = p.depNum
WHERE DATEDIFF(YEAR, d.depBirthdate, GETDATE()) > 18
  AND p.depName LIKE N'Phòng Nghiên cứu và phát triển'


--14. Cho biết số lượng người phụ thuộc theo giới tính.
--giới tính, số lượng người phụ thuộc
select depSex, count(*) as count from tblDependent
group by depSex

--15. Cho biết số lượng người phụ thuộc theo mối liên hệ với nhân viên.
--mối liên hệ, số lượng người phụ thuộc
select depRelationship, count(*) as count
from tblDependent
group by depRelationship

--16. Cho biết số lượng người phụ thuộc theo mỗi phòng ban.
--mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT p.depNum, p.depName, COUNT(d.empSSN) AS count
FROM tblDepartment p
LEFT JOIN tblEmployee e ON e.depNum = p.depNum
LEFT JOIN tblDependent d ON d.empSSN = e.empSSN
GROUP BY p.depNum, p.depName

--17. Cho biết phòng ban nào có số lượng người phụ thuộc là ít nhất.
--mã phòng ban, tên phòng ban, số lượng người phụ thuộc

-- cach 1: 1 result (chi lay 1 ket qua)
SELECT TOP 1 p.depNum, p.depName, COUNT(d.depName) AS count
FROM tblDepartment p
LEFT JOIN tblEmployee e ON e.depNum = p.depNum
LEFT JOIN tblDependent d ON d.empSSN = e.empSSN
GROUP BY p.depNum, p.depName
ORDER BY COUNT(d.depName) ASC 

-- cach 2: 1 result
SELECT p.depNum, p.depName, COUNT(d.depName) AS count
FROM tblDepartment p
LEFT JOIN tblEmployee e ON e.depNum = p.depNum
LEFT JOIN tblDependent d ON d.empSSN = e.empSSN
GROUP BY p.depNum, p.depName
HAVING COUNT(d.depName) = (
  SELECT min(count)
  FROM (
    SELECT COUNT(d.depName) AS count
    FROM tblDepartment p
    LEFT JOIN tblEmployee e ON e.depNum = p.depNum
    LEFT JOIN tblDependent d ON d.empSSN = e.empSSN
    GROUP BY p.depNum, p.depName
  ) AS counts
)

--18. Cho biết phòng ban nào có số lượng người phụ thuộc là nhiều nhất.
--mã phòng ban, tên phòng ban, số lượng người phụ thuộc

-- cach 1: 1 result (chi lay 1 ket qua)
SELECT TOP 1 p.depNum, p.depName, COUNT(d.depName) AS count
FROM tblDepartment p
LEFT JOIN tblEmployee e ON e.depNum = p.depNum
LEFT JOIN tblDependent d ON d.empSSN = e.empSSN
GROUP BY p.depNum, p.depName
ORDER BY COUNT(d.depName) desc 

--cach 2: 2 results
SELECT p.depNum, p.depName, COUNT(d.depName) AS count
FROM tblDepartment p
LEFT JOIN tblEmployee e ON e.depNum = p.depNum
LEFT JOIN tblDependent d ON d.empSSN = e.empSSN
GROUP BY p.depNum, p.depName
HAVING COUNT(d.depName) = (
  SELECT max(count)
  FROM (
    SELECT COUNT(d.depName) AS count
    FROM tblDepartment p
    LEFT JOIN tblEmployee e ON e.depNum = p.depNum
    LEFT JOIN tblDependent d ON d.empSSN = e.empSSN
    GROUP BY p.depNum, p.depName
  ) AS counts
)


--19. Cho biết tổng số giờ tham gia dự án của mỗi nhân viên.
--mã nhân viên, tên nhân viên, tên phòng ban của nhân viên

SELECT e.empSSN, e.empName, d.depName,SUM(COALESCE(w.workHours, 0)) AS totalHours
FROM tblEmployee e 
LEFT OUTER JOIN tblWorksOn w ON w.empSSN = e.empSSN
JOIN tblDepartment d ON e.depNum = d.depNum
GROUP BY e.empSSN, e.empName, d.depName;

--20. Cho biết tổng số giờ làm dự án của mỗi phòng ban.
--mã phòng ban, tên phòng ban, tổng số giờ
-- select * from tblDepartment
-- select * from tblEmployee
-- select * from tblWorksOn

SELECT d.depNum, d.depName, SUM(COALESCE(w.workHours,0)) AS totalHours
FROM tblDepartment d
LEFT JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY d.depNum, d.depName


--21. Cho biết nhân viên nào có số giờ tham gia dự án là ít nhất.
--mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án

SELECT e.empSSN, e.empName, SUM(w.workHours) AS totalHours
FROM tblEmployee e
JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName
HAVING SUM(w.workHours) = (
    SELECT MIN(totalHours)
    FROM (
        SELECT SUM(workHours) AS totalHours
        FROM tblWorksOn
        GROUP BY empSSN
    ) AS subquery
)

--22. Cho biết nhân viên nào có số giờ tham gia dự án là nhiều nhất.
-- mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án

SELECT e.empSSN, e.empName, SUM(w.workHours) AS totalHours
FROM tblEmployee e
JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName
HAVING SUM(w.workHours) = (
    SELECT max(totalHours)
    FROM (
        SELECT SUM(workHours) AS totalHours
        FROM tblWorksOn
        GROUP BY empSSN
    ) AS subquery
)

--23. Cho biết những nhân viên nào lần đầu tiên tham gia dự án.
--mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT e.empSSN, e.empName, d.depName
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName, d.depName
HAVING COUNT(DISTINCT w.proNum) = 1

--24. Cho biết những nhân viên nào lần thứ hai tham gia dự án.
--mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT e.empSSN, e.empName, d.depName
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName, d.depName
HAVING COUNT(DISTINCT w.proNum) = 2

--25. Cho biết những nhân viên nào tham gia tối thiểu hai dự án.
--mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT e.empSSN, e.empName, d.depName
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName, d.depName
HAVING COUNT(DISTINCT w.proNum) >= 2
