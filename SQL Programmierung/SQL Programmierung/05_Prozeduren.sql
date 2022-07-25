/*
Proz Idee. wie ein Windows Batch

der Code wird exakt genaus so (schenll) ausgeführt, wie er in der Proc auch geschrieben wurde



*/

set statistics io,time on --off

select city, lastname, sum(unitprice*quantity)
from ku3
where city like 'B%'
group by city , lastname

--bei ersten Ausführen Analyse und Komp Zeit vn ca 7 Sek
--beim 2ten Ausführen Zeit anszatweise 10ms

-- Schotterweg: SCAN
--Schnellweg: SEEK


----Problem der normalen Abfragen:  die Ausführungspläne sind im RAM und.. und verschwinden mal
-- SQL Server kann autoparamtetrisieren.. Plan wird wiederverwendbar
--ab komplexereren (join) keine Autoparam.
select * from orders o inner join customers c on c.CustomerID=o.CustomerID	
where orderid = 11000


--mit Prozeduren ist das Problem gegessen
--Die Proz legt beim ersten Ausführen einen Plan fest, der dann immer  - auch nach Nezstart . ausgeführt wird.

--Der Plan der Prozedur kann im Laufe der Zeit auch falsch sein 
--Datenquaität hat sich geändert


create or alter proc gpName @par1 int, @par2 int, @par3 out
as
--Code

exec procname 23,24


create proc gpdemo2 @par1 int, @par2 int 
as
select @par1+@par2

exec gpdemo2 12, 100

exec gpdemo2 @par2 = 100 , @par1 = 12




create or alter proc gpdemo2 @par1 int =2, @par2 int 
as
select @par1+@par2

exec gpdemo2 @par2=200



create or alter proc gpdemo2 @par1 int =2, @par2 int , @par3 int  out --out ist aber auch in
as
select @par3 = @par1+@par2
select @par3

exec gpdemo2 @par1=5, @par2 = 100

select @par3 --kennt SQL nicht



declare @result as int --null
exec gpdemo2 @par1=100, @par2=1000, @par3 =@result out
select @result

