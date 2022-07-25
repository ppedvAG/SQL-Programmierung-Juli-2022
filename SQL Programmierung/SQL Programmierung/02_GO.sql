create or alter proc gpdemo1 
as
select getdate();
GO --ohne Go.. ist der Teil mit exec Bestandteil der Proc geworden--> Rekursives auflösen

exec gpdemo1




declare @var as int = 100
select @var
go  --ab hier keine Variable mehr

select @var+100









select customerid 
from 


customers