/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Rbroj]
      ,[Hala]
      ,[RadnaPozicija]
      ,[Smjena1]
      ,[Od1]
      ,[Do1]
      ,[Napomena1]
      ,[Smjena2]
      ,[Od2]
      ,[Do2]
      ,[Napomena2]
      ,[Smjena3]
      ,[Od3]
      ,[Do3]
      ,[Napomena3]
      ,[Bolovanje]
      ,[Godišnji]
      ,[Grupa]
  FROM [RFIND].[dbo].[PlanDjelatnika22]


  insert into plandjelatnika22 (rbroj,hala,radnapozicija)  select cast(r.rbr as integer) rbr1, hala,radnomjesto from rezija r

  select  ROW_NUMBER() OVER(ORDER BY rbroj)
  from plandjelatnika22
