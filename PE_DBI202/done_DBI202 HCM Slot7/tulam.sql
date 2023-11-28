use SaleMNG
--2 
select * from tblInvoices where employeeid ='S002'
--3
SELECT tblProducts.proid, tblProducts.proname, tblSuppliers.supname
FROM     tblProducts INNER JOIN
                  tblSuppliers ON tblProducts.supcode = tblSuppliers.supcode
where tblSuppliers.supname = N'Hoàn Vũ'
--4 
SELECT tblProducts.proname, sum(tblInv_Detail.quantity) as 'Total quantity'
FROM     tblProducts INNER JOIN
                  tblInv_Detail ON tblProducts.proid = tblInv_Detail.proid
where tblProducts.proname= N'Router Wifi Chuẩn Wifi 6 AX5400 TP-Link Archer AX73'
group by tblProducts.proname
--5
select employeeid, count(*) as 'Total Number' from tblInvoices
group by employeeid;

--6
with t as (select invid, sum(quantity * price) as [Total amount] from tblInv_Detail
group by invid)
select * from t where [Total amount] = (select max([Total amount]) from t)

--7
SELECT tblInv_Detail.invid, tblInvoices.invdate, tblProducts.proid, tblInv_Detail.quantity, tblInv_Detail.price
FROM     tblInv_Detail INNER JOIN
                  tblInvoices ON tblInv_Detail.invid = tblInvoices.invid INNER JOIN
                  tblProducts ON tblInv_Detail.proid = tblProducts.proid
where tblInvoices.employeeid = 'S003';

--8

drop procedure PR1
create procedure PR1
@supcode nchar(2), @Productnumber int output
as
begin
	select @Productnumber  = count(*) from tblProducts
	where supcode = @supcode
	group by supcode
end


go
declare @Productnumber int
exec PR1 'MT', @Productnumber output
select @Productnumber

--9
go
create trigger TR1
on tblInv_Detail
after insert
as
begin
	select count(t.invid) from tblInv_Detail t
	join inserted i on t.invid = i.invid
end

insert into tblInv_Detail
values('000003','RTPL02',1,10000000)

--10
select * from tblInvoices
delete from tblInvoices
where customer = N'Lê Minh phương'

select * from tblInv_Detail