/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[ComputerName]
      ,[UserName]
      ,[Password]
      ,[IP]
      ,[MAC]
      ,[Napomena]
  FROM [Sistem].[dbo].[Racunala]
  order by username