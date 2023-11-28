with t as (
select r.Customer_ID, max( r.Amount) as MaxAmount from Rentals r
group by r.Customer_ID
)
select c.ID as CustomerID, c.First_Name, c.Last_Name,
 r.Reservation_Number, t.MaxAmount as Amount 
from Customers c 
join t on c.ID = t.Customer_ID
join Rentals as r on t.Customer_ID = r.Customer_ID and t.MaxAmount = r.Amount
order by Amount desc
