/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[Username]
      ,[Password]
      ,[Comment]
      ,[Comment2]
      ,[MjestaTroska]
      ,[Grupa]
  FROM [RFIND].[dbo].[Korisnici]


  select r.id,r.prezime,r.ime,r.DatumPrestanka
  from badge b
  left join [user] u on u.ExtId=b.extid
  left join radnici_ r on r.id=u.extid
  where b.active=1 and id is not null and r.DatumPrestanka is not null --and r.datumprestanka>='2019-09-05'
  order by r.prezime

  --update badge set active=0 where active=1 and extid in ( 
  --select r.id
  --from badge b
  --left join [user] u on u.ExtId=b.extid
  --left join radnici_ r on r.id=u.extid
  --where b.active=1 and id is not null and r.DatumPrestanka is not null )

  --select * into badge_old2 from badge