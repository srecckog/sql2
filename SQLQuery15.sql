/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[Username]
      ,[Password]
  FROM [Sistem].[dbo].[Mailovi]
  order by username