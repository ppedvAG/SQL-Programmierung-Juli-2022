--Prozedur


create or alter proc procname @par1 int =1  , @par2 int out
as
--Code;
GO


use northwind;

--ALFKI  BLAUS   
exec gpKundenSuche  'ALFKI' ;--1 Treffer
exec gpKundenSuche  'A'        --4  Treffer..alle mit A beginnend
exec gpKundenSuche            --   alle


create or alter proc gpKundenSuche @Kd varchar(5)='%'
as
select * from customers where customerid like  @kd  + '%'
GO



exec gpKundenSuche  'ALFKI' ;--1 Treffer
exec gpKundenSuche  'A'        --4  Treffer..alle mit A beginnend
exec gpKundenSuche            --   alle

--Ganz schlecht...!!!!



---Suche alle Ang im Rentenalter (ab 65 )
select * from Employees

--dateadd
--datediff
select dateadd(yy,+- Zahl, Datum)
select datediff(yy, Datum1, Datum2)

select * from Employees
										where  birthdate <= dateadd(yy,-65, getdate())

										--gut und schnell



				
select datediff(yy,birthdate, getdate())  , * from Employees
										where  datediff(yy,birthdate, getdate()) >=65
		--schlecht weil langsam
										

declare  @rentendatum as datetime
set @rentendatum = dateadd (yy,-65, getdate())

select * from employees where birthdate <=@rentendatum
--geht so .... nicht schelcht ,aber auch nicht das beste


select year(o

--alle Bestellungen aus dem Jahr 1997
select * from orders where year(orderdate) = '1997' --korrekt aber langsam
--nicht konvertieren lassen, wenn es nicht sein muss.. year erwartert int

select * from orders where year(orderdate) = 1997  --korrekt aber langsam

select * from orders where 
orderdate >= '1.1.1997' and orderdate <= '31.12.1997' --falsch, aber schnell
---                      1.1.1997 00:00:00.000         31.12.1997 00:00:00.000

select * from orders where 
		orderdate between '1.1.1997' and '31.12.1997 23:59:59.999'  
		--falsch
		---datetime wird nicht exakt gespeichert..  2 bis 3ms Varianz


select * from orders where orderdate between '1.1.1997' and '31.12.1997' --falsch aber schnell
select * from orders where orderdate between '1.1.1997' and '1.1.1998' --falsch aber schnell
select * from orders where 
		orderdate between '1.1.1997' and '31.12.1997 23:59.59.999'  --falsch aber schnell
select * from orders where orderdate between '1.1.1997' and '31.12.1997 23:59:59.997'  --korrekt und schnell


