USE [PaperNo_2]
--1
select staff_id, first_name, last_name
from staff where active =1

--2
SELECT film.film_id, film.title, film.length, film.rating
FROM     film INNER JOIN
                  film_category ON film.film_id = film_category.film_id INNER JOIN
                  category ON film_category.category_id = category.category_id
where category.name = 'Documentary'
and film.length >170
order by film_id

--3
SELECT category.name, count(film_category.film_id) 'Number of films'
FROM     category INNER JOIN
                  film_category ON category.category_id = film_category.category_id
group by category.name
order by [Number of films]

--4
with t as (SELECT category.name, count(film_category.film_id) 'Number of films'
FROM     category INNER JOIN
                  film_category ON category.category_id = film_category.category_id
group by category.name)
select * from t where [Number of films] >= all (select [Number of films] from t)
order by name

--5
SELECT actor.first_name, count(film_actor.actor_id) 'Number of films'
FROM     film_actor INNER JOIN
                  actor ON film_actor.actor_id = actor.actor_id
group by  actor.first_name
having  count(film_actor.actor_id) >= 90
order by [Number of films]

--6
select film_id, title, rating, [length] from film
where [length] > (select [length] from film where title = 'THEORY MERMAID')
and rating = (select rating from film where title = 'THEORY MERMAID')


--7
go
create proc NumberOfFilm(@catName varchar(25), @count int output)
as
begin
	SELECT @count = count(film_category.film_id)
	FROM     film_category INNER JOIN
					  category ON film_category.category_id = category.category_id
	where category.name = @catName
end

declare @count int
exec NumberOfFilm 'Documentary', @count output
select @count

--8
CREATE TRIGGER TR1
ON Film
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM Film WHERE title IN (SELECT title FROM inserted))
    BEGIN
        RAISERROR ('Duplicate film title is not allowed.', 16, 1);
        ROLLBACK;
        RETURN;
    END;
END;

--9