-- 1
-- khong lam vi qua luoi

-- 2
select * from customers where [state] = 'CA' and country = 'USA'

-- 3
select orderNumber, productCode, quantityOrdered, priceEach from orderdetails
where productCode = 'S18_1749'
and quantityOrdered > 25
order by priceEach asc, quantityOrdered desc

-- 4
select o.orderNumber, o.orderDate, o.requiredDate, o.shippedDate, o.status, o.customerNumber, c.customerName, c.city, c.country from orders o, customers c
where not o.[status] in ('Shipped', 'Resolved') and c.country = 'USA' and o.customerNumber = c.customerNumber
order by c.customerName

-- 5
select c.customerNumber, c.customerName, c.city, c.country, c.total as 'totalAmountOfPayments' from
(select * from
(select customerNumber, customerName, city, country from customers where country = 'Germany') as a
left join
(select c.customerNumber as 'cn', sum(od.quantityOrdered*od.priceEach) as 'total' from orderdetails od, customers c, orders o where c.customerNumber = o.customerNumber and o.orderNumber = od.orderNumber and country = 'Germany' group by c.customerNumber) as b
on a.customerNumber = b.cn) as c
order by totalAmountOfPayments
-- 6
select * from employees where employeeNumber not in (
select distinct salesRepEmployeeNumber from customers
where salesRepEmployeeNumber is not null)

-- 7
select p.productCode, p.productName, p.productCategory, count(distinct o.orderNumber) as 'numberOfOrders', count(distinct o.customerNumber) as 'numberOfCustomers', sum(od.quantityOrdered) as 'totalQuantityOrdered', sum(od.quantityOrdered*(od.priceEach - p.buyPrice)) as 'totalProfit' from products p, orderdetails od, orders o where productCategory = 'Planes' and p.productCode = od.productCode and od.orderNumber = o.orderNumber
group by p.productCode, p.productName, p.productCategory
order by totalProfit desc

-- 8
create proc proc_numberOfOrders
(
@customerNumber int,
@numberOfOrders int output
)
as
begin
select count(customerNumber) from orders where customerNumber = @customerNumber 
end

declare @x int
exec proc_numberOfOrders 103, @x output
print @x

-- 9
create trigger tr_insertPayment on payments for insert
as
begin
select i.customerNumber, c.customerName, i.checkNumber, i.paymentDate, i.amount from inserted i, customers c
where i.customerNumber = c.customerNumber
end

insert into payments(customerNumber, checkNumber, paymentDate, amount)
values
(103, 'HQ336364', '2004-10-29', 1000),
(112, 'QM789234', '2005-10-30', 200)

-- 10
delete from products where productCode not in
(select distinct productCode from orderdetails)
