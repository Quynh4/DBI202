
select * from (SELECT TOP 5 * FROM Product ORDER BY UnitPrice desc) as a
UNION all
select * from (SELECT top 5 * FROM Product ORDER BY UnitPrice asc) as b 
order by UnitPrice desc
