with t as (select c.ID as CustomerID, c.CustomerName, count(o.ID) as NumberOfOrders
from Customer c
left join Orders o on c.ID = o.CustomerID
group by c.ID, c.CustomerName)
select * from t
where NumberOfOrders >= all(select NumberOfOrders from t)


