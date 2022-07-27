--Indizes sind wichtig für:

--das Sperrniveau
--deutlich weniger IO
--Ordnung auf pyhsikal Ebene
--deutlich mehr IO
---


--JOIN LEFT RIGHT INNER CROSS  FULL

--LOOP MERGE HASH

select * from customers c inner join orders o on c.CustomerID=o.CustomerID




--Typen von Indizes

/*
CLUSTERED IX 
Tabelle in sort Form
kann es nur 1* pro Tabelle
gut bei Bereichsabfragen aber auch sehr gut bei rel geringen Ergebnissen  zb ID


NON CLUSTERED INDEX
rel wenig Ergebniszeilen (vor allem beim LOOKUP: ca 1% Tipping Point.. rel wenig ist ID 
zusätzliche Kopie der Daten + Baum
ca 1000 NON CL IX pro Tabelle anlegen
-----------------------------
eindeutiger IX
zusammengesetzter IX
max 16 Spalten enthalten / max 900bytes

gefilterter IX
IX mit eingeschlossenen SPalten
der Baum wird nur mit der Suchspalte gefüllt, aber am Ende des Baumes haben wir sehr viele Were (Evtl alle, weil 1000 Sp möglich)
--Schlüsselspalte = where


abdeckender IX
indizierte Sicht
part IX
realer hypothetischer IX
-----------------------------------
Columnstore 
*/


select * from best  --  CL IX SCAN-- bullshit!!!!!!!
								-- der PK wid über das SSMS grundsätzlich als CL IX angelegt
								--der PK erfordert keine CL .. er fordert Eindeutigkeit

-- welceh Spalte würden wir vermutlich am häufigsten mit between oder > bzw < abfragen

select * from best



--Tipp: lege immer zuerst den CL IX fest oder noch besser leg ihn an, bevor du irgendetwas aners machtst, wie PK , Beziehungen, 
--andere Inidzes

select newid()

set statistics io, time on
--PLAN
select id from kundeumsatz where id = 10 --TABLE SCAN

--besser mit:  NON CL IX ID --CL IX auf Orderdate vorreserviert
select id from kundeumsatz where id = 10  --  NON CL IX SEEK --3 Seiten 0 Sek

select id, freight from kundeumsatz where id = 10 --IX Seek mit Lookup .. 4 Seiten


select id, freight from kundeumsatz where id < 100 --IX Seek mit Lookup ..Seiten


select id, city, country, lastname, freight
from kundeumsatz
where freight < 10


--


-- 102 Seiten Lookup 99% + IX Seek

-- ab ca 12250 DS Wechsel von Seek zu Scan
select id, freight from kundeumsatz where id < 11000
--47764 --

--das muss besser gehen: der Lookup muss weg!!!
--besser mit NIX_ID_FR

select id, freight from kundeumsatz where id < 900000--auch hier noch  reiner IX Seek

--Land dazu --Lookup.. ab 12250 Scan
select id, freight, country from kundeumsatz where id < 12000

--* nicht besonders gut


--eingeschlossene Spalten  SELECT

--NIX_Pid_incl_CYCIUPQU
select country, city, sum(unitprice*quantity)
from kundeumsatz
where  productid < 3
group by country, city

--eigtl 2 Indizes aber SQL schlägtnmnix mehr vor
select country, city, sum(unitprice*quantity)
from kundeumsatz
where  productid < 3 or freight < 1
group by country, city


-- in so einem Fall: 
--immer Klammern setzen.. das AND wird immer zuerst gebunden
select country, city, sum(unitprice*quantity)
from kundeumsatz
where  productid < 3 or freight < 1 and employeeid = 2
group by country, city

