/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [OID]
      ,[FirstName]
      ,[LastName]
      ,[ExtId]
      ,[IsAdmin]
      ,[OptimisticLockField]
      ,[GCRecord]
  FROM [RFIND].[dbo].[User]
  WHERE EXTID=8158


  UPDATE [RFIND].[dbo].[User] SET LASTNAME='ŽIVKOVIĆ',FIRSTNAME='DAVOR' WHERE EXTID=8158