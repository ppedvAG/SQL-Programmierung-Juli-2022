/*

weniger IO --> weniger CPU
                   --> weniger RAM

--im  Plan:
--> SCAN  (alles von A bis Z lesen)
--> SEEK  (herauspicken)  bei where 

--DS liegen in Seiten (und Bl�cke)
--Seiten sind immer  8 kb gro�
-- 1DS (nur fixen gez�hlt) kannnicht gr��er als 8060 werden und muss in Seiten passen
--Seiten kommen 1:1 in RAM
dbcc showcontig ()  aber ist depricated

Messung : 
set statistics io, time on
--IO : Anzahl der log. Lesevorg�nge


*/

use northwind

select * into KundeUmsatz from vku


insert into Kundeumsatz
select * from kundeumsatz
--Wiederholen bis 551 000 eingef�gt werden --> 1,1 MIO DS

dbcc showcontig('kundeumsatz')
--48286 Seiten mit 97,82% F�llgrad

alter table kundeumsatz add ID int identity

set statistics io, time on
select * from kundeumsatz where id = 10
-- 61782
dbcc showcontig('kundeumsatz')--48881 --49129--47764

select * from sys.dm_db_index_physical_stats(
			db_id(),object_id('kundeumsatz'),NULL,NULL,'detailed'
																					)

--wg ID forward record coutns.. 12901 Seiten 
--eigtl m�ssste der forward record count 0  sein

--Brent Ozar: FirstResponderkit

sp_blitzindex
--Tabelle muss physikalisch neu gerodnet abegelgt werden

--Clustered Index nimmt den gesamten DS und legt ihn sortiert wirder ab
--der CL IX k�nnte danach wieder gels�cht werden
--ist ein CL IX vorhanden , wird es nie wieder forward record coutns geben

--heisser Tipp: DDL Trigger   CREATE DROP ALTER


select * into od from [order details]

