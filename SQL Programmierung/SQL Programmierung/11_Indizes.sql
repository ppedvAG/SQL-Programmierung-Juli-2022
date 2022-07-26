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
gefilterter IX
IX mit eingeschlossenen SPalten
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

