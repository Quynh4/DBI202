--q2
select * from ranking_criteria

--q3
select ranking_system_id, criteria_name from ranking_criteria rc

where ranking_system_id = 1 
or ranking_system_id = 2
order by rc.ranking_system_id, criteria_name ASC

--q4
select university_id, university_name, year, num_students, pct_international_students,country_id
from university_year uy, university u
where u.id = uy.university_id
and uy.year = 2016
and uy.pct_international_students > 30
order by u.university_name ASC

--q5
select rc.ranking_system_id, rs.system_name, rc.criteria_name as numberOfCriteria 
from ranking_system rs, ranking_criteria rc
where rs.id = rc.ranking_system_id
group by rs.id, rs.system_name
order by numberOfCriteria DESC

--q6
select u.id, u.university_name, uy.year, uy.student_staff_ratio
from university u, university_year uy
where u.id = uy.university_id
and year = 2015
and uy.student_staff_ratio = (select Min(student_staff_ratio) from university_year)

--q10





