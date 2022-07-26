--Anzahl der CPus pro Abfrage

--Plän

set statistics io, time on

select country, city , sum(freight) from kundeumsatz
group by country, city

--im Plan ist Paralellismus zu entdecken
,--CPU-Zeit = 312 ms, verstrichene Zeit = 163 ms.
--lohnt sich, weil schneller fertig


--Standard: Kostenschwellwert = 5
--     MAXDOP  = Anzahl der Kerne , aber nicht mehr als 8 (seit SQL2016)
-- maxdop  =0 Alle Kerne

--überschreiten wir den Kostenschwellwert 
--werden soviele kern eingesetz wie Maxdop

--SIND MEHR kERNE BESSER??


select country, city , sum(freight) from kundeumsatz
group by country, city option (maxdop 8)
-- 8 Kerne: , CPU-Zeit = 654 ms, verstrichene Zeit = 96 ms.
-- 1 Kerne , CPU-Zeit = 375 ms, verstrichene Zeit = 386 ms.
--2 Kerne , CPU-Zeit = 407 ms, verstrichene Zeit = 200 ms.
--4 Kerne , CPU-Zeit = 406 ms, verstrichene Zeit = 101 ms.
--6 Kerne , CPU-Zeit = 453 ms, verstrichene Zeit = 90 ms.
--8   750 ms, verstrichene Zeit = 110 ms.

--Welche Einstllung zählt. .. die , die am nächsten and er Abfrage konfiguriert wurde
--option maxdop geht vor DB Settings
--DB settings gehen vor Serversetttings
--allerdings Kostenschwellwert wird leider nur auf Server konfiguriert



ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 4;
GO

--bei Abfrage option (maxdop Anzahl der Kerne)




