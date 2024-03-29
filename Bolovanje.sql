/****** Script for SelectTopNRows command from SSMS  ******/
use radnici_

select sum(brojdana),mjesec,b.ID,b.ime
FROM [RFIND].[dbo].[stat_bo2] b
where b.id in (

select id
from (

select count(*) broj,x1.ime,x1.id,x2.bdana
from (
SELECT r.ID
      ,b.Ime
      ,[Mjesec]
      ,[Brojdana]
      ,[Razlog]
      ,[Godina]
      ,[SN]
      ,[NN]
      ,[Firma]
  FROM [RFIND].[dbo].[stat_bo2] b
  left join radnici_ r on r.id=b.id
  where razlog='B'
  and godina=2017
  and mjesec>2 and mjesec<9
  and r.neradi=0
  )x1
  left join   
  (
  select b.ime,b.id, sum(brojdana) bdana
  FROM [RFIND].[dbo].[stat_bo2] b
  left join radnici_ r on r.id=b.id
  where razlog='B'
  and godina=2017
  and mjesec>2 and mjesec<9
  and r.neradi=0  
  group by b.ime,b.id
  ) x2 on x1.id=x2.id
group by x1.ime,x1.id,x2.bdana
having count(*)>3

) x3

group by mjesec,b.ID,b.ime



select sum(brojdana) BrojDana,mjesec,b.ID,b.ime,m.Naziv,r.radnomjesto
FROM [RFIND].[dbo].[stat_bo2] b
left join radnici_ r on r.id=b.id
left join mjestotroska m on r.mt=m.id
where 
mjesec>2 and mjesec<9 and godina=2017
and razlog='B'
and b.id in (

34,
36,
46,
53,
58,
61,
62,
70,
70,
516,
521,
541,
639,
690,
708,
715,
826,
829,
870,
875,
895,
897,
954,
991,
1022,
1125,
1163,
1177,
1178,
1184,
1193,
1198,
1199,
1208,
1220,
1247,
1248,
1251,
1259,
1335,
1346,
1362,
1365,
1371,
1388
)
group by mjesec,b.ID,b.ime,m.Naziv,r.radnomjesto
order by b.ime


select *
FROM [RFIND].[dbo].[stat_bo2] b
where 
mjesec>2 and mjesec<9
and razlog='B'
and b.id=954


select distinct b.ime,m.Naziv,r.radnomjesto
FROM [RFIND].[dbo].[stat_bo2] b
left join radnici_ r on r.id=b.id
left join mjestotroska m on r.mt=m.id
where 
mjesec>2 and mjesec<9 and godina=2017
and razlog='B'
and b.id in (

34,
36,
46,
53,
58,
61,
62,
70,
70,
516,
521,
541,
639,
690,
708,
715,
826,
829,
870,
875,
895,
897,
954,
991,
1022,
1125,
1163,
1177,
1178,
1184,
1193,
1198,
1199,
1208,
1220,
1247,
1248,
1251,
1259,
1335,
1346,
1362,
1365,
1371,
1388
)
group by mjesec,b.ID,b.ime,m.Naziv,r.radnomjesto
order by b.ime