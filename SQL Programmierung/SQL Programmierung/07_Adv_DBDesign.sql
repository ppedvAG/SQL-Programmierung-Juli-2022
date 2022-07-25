/*
DB besteht normalerweise aus :

.ldf (Logfile)

.mdf (master data file)
USE [master]
GO
ALTER DATABASE [demoDB] ADD FILEGROUP [HOT]
GO
ALTER DATABASE [demoDB] ADD FILE ( NAME = N'nwmessdaten', FILENAME = N'D:\_SQLDBDATA\nwmessdaten.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [HOT]
GO

*/

create table testxy (id int) ON HOT

--wie kann ich best Tabellen auf andere Dgruppen verschieben.

--kein Verschiebe Befehl


--für den Client transparent.. der merkt nix!!



--Tabelle A mit 1000 DS
--Tabelle B mit 100000 DS

--identische Tabellen 

--Abfrage, die bei A und B 10 Zeilen ausgibt

--> Tabellen kleiner machen


--Part Sicht


--Ausgang: Tabelle Umsatz (seit 2000) 
--Idee: u2022 u2021 u2019 u2020
--aber dennoch : select * from umsatz 

create view Umsatz
as
select * from u2020
UNION ALL
select * from u2019
UNION ALL
select * from u2021
UNION ALL
select * from u2022

select * from vumsatz where jahr = 2019

select * from vumsatz where id = 2019


create table test1(id int, spx int not null)


--Nachteile 
--select ja... ins up del auf Sicht geht..
--hier: nur dann INS UP DEL wenn kein identity, PK muss Eindeutigkeit über Sicht erzeugen



--Partitioinierung

--Dateigruppen, F() , PartSchema

--Wie würdet ihr Bereich machen  ABC
--zwischen 1 und 10 dann 1
--101 und 200 dann 2
--restliches 3 


*/
---1 bis 100   102 bis 2000 .. rest
create function fABC (@par1 int) retunrs int
as
BEGIN 
	returns  (select case	

								when @par1 between 1 and 100 then 1
								when @par1 between 1 and 100 then 1
END


-----------------100---------200-----------------
--    1                          2                            3


create partition function fZahl2(int)
as
RANGE LEFT for VALUES(100,200)

select $partition.fzahl2(117)


--Dateigruppe bis100 bis200 rest

create partition scheme schZahl2
as
partition fzahl2 to (bis100, bis200,rest)
---                            1           2             3


create table parttab (id int identity, nummer int, spx char(4100))
ON schZahl2(nummer)


declare @i as int = 1

while @i<=20000
	begin 
			insert into parttab (nummer, spx) values (@i, 'xy')
			set @i+=1
	end


--10 Sekunden statt 12
set statistics io, time on
select * from parttab where id = 117

select * from parttab where nummer = 117




























