use PE_DBI202_SU23
--2 
select employee_id, first_name, last_name
from employees
where employee_id < 105
--7
SELECT countries.country_id, countries.country_name, count(employees.employee_id) as 'number of employees'
FROM     countries INNER JOIN
                  locations ON countries.country_id = locations.country_id INNER JOIN
                  departments ON locations.location_id = departments.location_id INNER JOIN
                  employees ON departments.department_id = employees.department_id
group by countries.country_id, countries.country_name 
having count(employees.employee_id)>2
order by [number of employees] desc
--8
DROP TRIGGER IF EXISTS Salary_Min_Max;
CREATE TRIGGER Salary_Min_Max
ON employees
AFTER UPDATE
AS
BEGIN
  UPDATE employees 
  SET salary = d.salary
  FROM DELETED d JOIN jobs j on d.job_id = j.job_id
  WHERE employees.employee_id = d.employee_id
  AND (employees.salary > j.max_salary OR employees.salary < j.min_salary)
END;
 


update employees
set salary=0
where employee_id=101


select salary from employees
where employee_id=101

--9
drop function Get_ManagerID
CREATE procedure Get_ManagerID
(
    @emp_id INT, @manager_id int output
)
AS
BEGIN
    SELECT @manager_id = manager_id
    FROM employees
    WHERE employee_id = @emp_id;
END;

declare @X int
declare @in int=101
exec Get_ManagerID @in, @X output
select @X as ManagerID

--10
DELETE FROM dependents
WHERE employee_id IN (
    SELECT employee_id
    FROM employees
    WHERE first_name = 'Karen'
);