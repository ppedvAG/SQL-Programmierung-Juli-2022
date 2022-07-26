USE [master]
GO
CREATE LOGIN [Evi] WITH PASSWORD=N'123', 
DEFAULT_DATABASE=[Northwind], 
CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

USE [Northwind]
GO
CREATE USER [Evi] FOR LOGIN [Evi]
GO


select * from sysusers
select * from syslogins

USE [Northwind]
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO

USE [Northwind]
GO
CREATE SCHEMA [MA] AUTHORIZATION [dbo]
GO



create table ma.personal(maperso int)
create table it.personal(itperso int)--

create table it.projekte(itpro int)
create table ma.projekte (mapro int)--



select * from orders

select * from personal

--Grund für Fehler..

select * from northwind.dbo.orders

--jeder User hat immer ein Default Schema (normalerweise = dbo)

--Std anpassen

USE [Northwind]
GO
ALTER USER [Frank] WITH DEFAULT_SCHEMA=[IT]
GO


USE [Northwind]
GO
ALTER USER [Evi] WITH DEFAULT_SCHEMA=[MA]
GO


use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [Frank]
GO
use [Northwind]
GO
GRANT SELECT ON SCHEMA::[MA] TO [Evi]
GO


use [Northwind]
GO
GRANT CREATE TABLE TO [Evi]
GO


use [Northwind]
GO
GRANT ALTER ON SCHEMA::[MA] TO [Evi]
GO

--reine NT Auth
--User kann per Software Dinge tun , die er im SSMS dann nicht kann
select app_name()

--Anwendungsrolle  hat Kennwort
USE [AdventureWorks2014]
GO
CREATE APPLICATION ROLE [Gehaltsrolle] WITH PASSWORD = N'ppedv2019!'
GO



--Gib nie einer normal sterblichen Person das Recht CREATE 
VIEW; PROZ; f(), 


