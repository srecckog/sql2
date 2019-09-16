/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[acworker]
      ,[MT]
      ,[Poduzece]
  FROM [RFIND].[dbo].[panth_radnici]



  select r.mt rad_mt,p.mt pant_mt,r.*
  from radnici_ r
  left join panth_radnici p on p.id=r.id
  where r.mt<>p.mt