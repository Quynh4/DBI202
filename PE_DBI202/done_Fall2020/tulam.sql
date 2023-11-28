use PE_DBI202_F2020

--3
select ranking_system_id, criteria_name from ranking_criteria
where ranking_system_id =1 or ranking_system_id=2
order by ranking_system_id, criteria_name

--4
SELECT university_year.university_id, university.university_name, university_year.year, university_year.num_students, university_year.pct_international_students, university.country_id
FROM     university_year INNER JOIN
                  university ON university_year.university_id = university.id
where pct_international_students >30 and year = 2016
order by  university_name

--5
 SELECT ranking_system.id as system_id, ranking_system.system_name, count(ranking_criteria.id) as numberOfCriteria
FROM     ranking_criteria INNER JOIN
                  ranking_system ON ranking_criteria.ranking_system_id = ranking_system.id
group by ranking_system.id, ranking_system.system_name
order by numberOfCriteria desc

--6
with t as (SELECT university_year.university_id, university.university_name, university_year.year, university_year.student_staff_ratio
FROM     university_year INNER JOIN
                  university ON university_year.university_id = university.id
)
select * from t where student_staff_ratio = (select min(student_staff_ratio) from t)
and year = 2015

--7
with t as (select score, count(university_id) as NumberOfScore
from university_ranking_year join ranking_criteria
on ranking_criteria.id = university_ranking_year.ranking_criteria_id
where year = 2016 and criteria_name = 'Teaching' group by score having count(university_id)>1)
SELECT university_ranking_year.university_id, university.university_name, ranking_criteria.ranking_system_id, ranking_criteria.criteria_name, university_ranking_year.year, university_ranking_year.score, t.NumberOfScore
FROM     ranking_criteria INNER JOIN
                  university_ranking_year ON ranking_criteria.id = university_ranking_year.ranking_criteria_id INNER JOIN
                  university ON university_ranking_year.university_id = university.id INNER JOIN
				  t on t.score = university_ranking_year.score
where ranking_criteria.criteria_name = 'Teaching'
and university_ranking_year.year = 2016
order by score desc, university_id;

--9
drop proc proc_university_year
create proc proc_university_year 
 @year int, @pct_international_students int, @nbUniversity int output
as
begin
		select @nbUniversity = count(university_id) from university_year
		where year = @year 
		and pct_international_students> @pct_international_students
end

		select count(university_id) 
		from university_year 
		where year = 2011
		and pct_international_students> 30


declare @out int
exec proc_university_year 2011, 30, @out output
select @out as NumberOfUniversities

--9
create trigger insert_university_ranking 
on university_ranking_year
for insert
as
begin
	SELECT inserted.university_id, university.university_name, ranking_criteria.ranking_system_id, ranking_criteria.criteria_name, inserted.year, inserted.score
	FROM     ranking_criteria INNER JOIN
                  inserted ON ranking_criteria.id = inserted.ranking_criteria_id INNER JOIN
                  university ON inserted.university_id = university.id

end

insert into university_ranking_year(university_id, ranking_criteria_id, year, score) values (1,1,2020, 99),
(12,2,2020, 67)

--10
insert into ranking_system
values (4, 'QS World University Rankings');

insert into ranking_criteria 
values ( 22, 4, 'Academic Reputation'), (23,4, 'Citations per faculty')
