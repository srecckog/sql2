/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [OID]
      ,[FirstName]
      ,[LastName]
      ,[ExtId]
      ,[IsAdmin]
      ,[OptimisticLockField]
      ,[GCRecord]
  FROM [RFIND].[dbo].[User]
  order by oid desc