/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Id]
      ,[Naziv]
      ,[Grupa1]
      ,[Grupa2]
  FROM [RFIND].[dbo].[MjestoTroska]


  select *
  from pregledvremena
  where datum>='2017-10-01'
  and idradnika in ( 272)
  order by datum


  select *
  from radnici_
  where rv=1
  and id in (
  select idradnika
  from pregledvremena
  where tdoci=7
  and datum='2017-10-24'
    )


	update radnici_ set rv=2 where id in (
	select idradnika
	from pregledvremena
	where datum='2017-10-24' and tdoci=7
	)

	select *
	from radnici_
	where rv=1
	and sifrarm like '%Re%'
	order by sifrarm


	update radnici_ set rv=2 where id=257


	and sifrarm='Tok'


