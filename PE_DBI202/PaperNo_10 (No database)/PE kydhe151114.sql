/*
--q2
select *
from stores

-- q3
select customer_id, first_name, last_name, city, state
from customers
where city = 'New York' OR city = 'Bellmore'
order by city asc

-- q4
select products.product_id, product_name, list_price, brand_name, category_name, stocks.store_id, stocks.quantity
from products
left join stocks ON stocks.product_id = products.product_id
where stocks.store_id = 1 and stocks.quantity > 25
order by category_name asc,
list_price desc

-- q5

select s.staff_id, s.first_name, s.last_name, a.NumberOfOrders
from staffs as s
left join
(
	select staff_id,year(orders.order_date) as year, count(*) NumberOfOrders
	from orders
	group by staff_id, year(orders.order_date)
) as a
on s.staff_id = a.staff_id
where a.year = 2016
order by a.NumberOfOrders desc


-- q6
select p.product_id, p.product_name, p.model_year, s.store_id, s.quantity
from products as p
left join stocks as s on s.product_id = p.product_id
where s.quantity =
(
	select MIN(quantity)
	from stocks
)


-- q7
with table1 as
(
	select or1.store_id, or1.staff_id, stores.store_name, or1.year, staffs.first_name, staffs.last_name, or1.NumberOfOrders
	from stores
	inner join staffs  on stores.store_id = staffs.store_id
	inner join 
	(
		select orders.staff_id, orders.store_id, YEAR(orders.order_date) as year, count(*) as NumberOfOrders
		from orders
		group by orders.staff_id, orders.store_id, YEAR(orders.order_date)
	) as or1
	on or1.store_id =stores.store_id and or1.staff_id = staffs.staff_id
)

select t1.store_name, t1.year, t1.first_name, t1.last_name, t1.NumberOfOrders
from table1 as t1
right join
(
	select store_id, year, max(NumberOfOrders) as maxOrders
	from table1
	group by store_id, year
)as a
on a.year = t1.year and a.maxOrders = NumberOfOrders and a.store_id = t1.store_id
order by t1.store_name asc, t1.year asc

-- q8
DROP PROCEDURE IF EXISTS dbo.proc2
go

create procedure proc2(
@store_name varchar(255),
@numberOfOrders int output
)
as
begin
set @numberOfOrders =
(
	select a.numberOfOrders
	from stores
	inner join
	(
		select orders.store_id, count(*) as numberOfOrders
		from orders
		group by orders.store_id
	) as a
	on a.store_id = stores.store_id
	where stores.store_name = @store_name
)
end

declare @x int
exec proc2 @store_name ='Baldwin Bikes', @numberOfOrders = @x output

-- q9
drop trigger if exists trigger_update_orderItems
go
create trigger trigger_update_orderItems on order_items
after update
as
begin
	select i.order_id, i.item_id, i.product_id, (d.list_price * d.quantity * (1 - d.discount)) as OldAmount, (i.list_price * i.quantity * (1 - i.discount)) as NewAmount
	from inserted as i, deleted as d
end
go
update order_items
set quantity = 2, discount = 0.3
where order_id = 1 and item_id = 1

-- q10
insert into staffs(staff_id, first_name, last_name, email, active, store_id, manager_id)
values(19, 'White', 'Mary', 'white.mary@bikes.shop', 1, 3, 7)


select *
from staffs
where staff_id = 19
*/

select p.product_id, p.product_name, p.model_year, a.store_id, a.MinQuantity as quantity
from products as p
inner join stocks as s on s.product_id = p.product_id
right join
(
	select stocks.store_id, MIN(quantity) as MinQuantity
	from stocks
	group by stocks.store_id
)as a
on s.store_id = a.store_id






















































































































































































































































































































































































































































































































































































































































































































































































































































