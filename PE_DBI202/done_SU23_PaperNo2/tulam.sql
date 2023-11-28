use PE_DBI202_SU23
--2
select * from departments
where location_id > 2400
--6 --huhu khong ra
select top 10 first_name, last_name from employees
where manager_id is not null
order by first_name 

--7 --thua ra cai DE =))
select c.country_id, c.country_name,  count(e.employee_id) as 'number of employees'
from countries c
left join locations l on c.country_id = l.country_id
join departments d on d.location_id = l.location_id
join employees e on d.department_id = e.department_id
group by c.country_id, c.country_name
order by [number of employees] desc
  
select * from departments
select * from employees

--8
--drop TRIGGER Salary_Min_Max


CREATE TRIGGER Salary_Min_Max
ON employees
FOR UPDATE
AS
BEGIN
    DECLARE @max_salary FLOAT, @min_salary FLOAT, @new_salary FLOAT;
    SELECT @max_salary = MAX(salary), @min_salary = MIN(salary) FROM deleted;
    SET @new_salary = (SELECT salary FROM inserted);
    IF (@new_salary > @max_salary OR @new_salary < @min_salary)
		ROLLBACK TRANSACTION;
END;

update employees
set salary=37000
where employee_id=102
select * from employees
--9
CREATE FUNCTION Get_ManagerID
(
    @emp_id INT
)
RETURNS INT
AS
BEGIN
    DECLARE @manager_id INT;

    SELECT @manager_id = manager_id
    FROM employees
    WHERE employee_id = @emp_id;

    RETURN @manager_id;
END;

declare @id int=101
select @id as EmployeeId,
	dbo.Get_ManagerID(@id) as ManagerID

--10
DELETE FROM dependents
WHERE employee_id IN (
    SELECT employee_id
    FROM employees
    WHERE first_name = 'Alexander'
);