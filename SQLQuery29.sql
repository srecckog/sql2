/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [OID]
      ,[No]
      ,[No2]
      ,[Dt]
      ,[IsPaired]
      ,[User]
      ,[Device_ID]
      ,[EventType]
      ,[TnaEvent]
      ,[OptimisticLockField]
      ,[GCRecord]
  FROM [RFIND].[dbo].[Event]
  WHERE NO LIKE '%B1D1%'