
with t as (
select * from Rentals r
join Location l on r.Pick_up_location = l.ID
where l.Country = 'United States'
)
select c.ID as CustomerID, c.First_Name, c.Last_Name, sum(Amount) as TotalAmount
from Customers c 
left join t on c.ID = t.Customer_ID
group by c.ID, c.First_Name, c.Last_Name
order by TotalAmount desc, First_Name asc