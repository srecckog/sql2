  select id,ime,mjesec,godina,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog into odsustva0417
  from stat_bo2
  where mjesec=3 and godina=2017
  group by id,ime,mjesec,godina,firma,razlog
  order by id


 
  drop table odsustva2017

  select r.mt,mt.naziv mjestotroska,r.id,b.ime,godina,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog into odsustva2017
  from stat_bo2 b
  left join radnici_ r on r.id=b.id
  left join MjestoTroska mt on mt.id=r.mt
  where godina=2017
  group by mt,mt.naziv,r.id,b.ime,godina,firma,razlog
  order by ime


  
  select r.mt,mt.naziv mjestotroska,r.id,b.ime,mjesec,godina,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog into odsustva201704
  from stat_bo2 b
  left join radnici_ r on r.id=b.id
  left join MjestoTroska mt on mt.id=r.mt
  where godina=2017
  and mjesec=4
  group by mt,mt.naziv,r.id,b.ime,mjesec,godina,firma,razlog
  order by ime


  select r.mt,mt.naziv mjestotroska,r.id,b.ime,mjesec,godina,count(*) puta,sum(brojdana) brojdana,max(isnull(sn,0)) sn,max(isnull(nn,0)) nn,firma,razlog into odsustva201704
  from stat_bo2 b
  left join radnici_ r on r.id=b.id
  left join MjestoTroska mt on mt.id=r.mt
  where godina=2017
  or   mjesec=4
  group by mt,mt.naziv,r.id,b.ime,mjesec,godina,firma,razlog
  order by ime



  select *
  from Kompetencije1005
  order by prezimeime



  select *
  from stat_bo2
  where id=870
  and razlog='B'




  select count(*),idradnika
  from pregledvremena
  where datepart(dw, datum)=7
  and year(dosao)=1900
  and year(datum)=2017
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  group  by idradnika
  order by idradnika



  select *
  from stat_bo2
  
  
  where id=26


  where id=870
  and razlog='B'



select *
from PlanSatiRada
where radnikid=26
