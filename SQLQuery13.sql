/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [datum]
      ,[id_pro]
      ,[staranorma]
      ,[novanorma]
      ,[hala]
      ,[linija]
      ,[hostname]
  FROM [RFIND].[dbo].[Norme_log