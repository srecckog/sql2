/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Id]
      ,[Poduzece]
      ,[Prezime]
      ,[Ime]
      ,[Korekcija]
      ,[IDkorekcije]
  FROM [RFIND].[dbo].[KorekcijaGO]


  select count(*),id
  from radnici_
  group by id
  having count(*)>1


select *
from radnici_
where prezime like 'DEAN%'


where id in ( 125,133)