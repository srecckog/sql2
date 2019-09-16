-------------------------------
--  feroimpex
-------------------------------
update radnici_ set neradi=j.neradi,datumprestanka=j.addateend,mt=j.mt1,radnomjesto=j.rm,fixnaisplata=j.fi
from
(
select acregno,case when l.addateend is not null then 1 else 0 end  neradi,l.accostdrv mt1,l.addateend,l.acjob rm,case when fi is null then 1 else 0 end fi
from [192.168.0.6].[PantheonFXAt].dbo.thr_prsn p
left join ( select acworker,max(anid) anid,acfieldsf fi from [192.168.0.6].[PantheonFXAt].dbo.thr_prsnjob group by acworker,acfieldsf ) j on j.acworker=p.acworker
inner join [192.168.0.6].[PantheonFXAt].dbo.thr_prsnjob  l on j.acworker=l.acworker and j.anid=l.anid
--order by acregno
--where l.addateend is null 
--where addateexit is not null
) j
inner join radnici_ k on k.id=j.acregno
where k.poduzece='Feroimpex' 
and k.id = j.acregno
---------------------------------------------
--  tokabu
---------------------------------------------
update radnici_ set neradi=j.neradi,datumprestanka=j.addateend,mt=j.mt1,radnomjesto=j.rm,fixnaisplata=j.fi
from
(
select acregno,case when l.addateend is not null then 1 else 0 end  neradi,l.accostdrv mt1,l.addateend,l.acjob rm,case when fi is null then 1 else 0 end fi
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p
left join ( select acworker,max(anid) anid,acfieldsf fi  from [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob group by acworker,acfieldsf ) j on j.acworker=p.acworker
inner join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob  l on j.acworker=l.acworker and j.anid=l.anid
--where l.addateend is null 
--where addateexit is not null
) j
inner join radnici_ k on k.id=j.acregno
where k.poduzece='Tokabu' 
and k.id = j.acregno
----------------
--update rfind.dbo.radnici_ set fixnaisplata=0 where id>8000 and id<8900 and rv=1
--update rfind.dbo.radnici_ set fixnaisplata=1 where id>8000 and id<8900 and rv=2
--------------------

--- provjera dali je fixna isplata
select *
from rfind.dbo.radnici_
where fixnaisplata=1 and datumprestanka is null and poduzece like 'T%' and radnomjesto like 'CNC%'
order by prezime

select *
from rfind.dbo.radnici_
where fixnaisplata=1 and datumprestanka is null and poduzece like 'F%' and radnomjesto like 'CNC%'
order by prezime
--------------------

--update rfind.dbo.radnici_ set datumprestanka='',neradi=0 where id=12 and DatumPrestanka='2018-11-06' 

-------------------------------
--  feroimpex update feroapp.dbo.radnici->neradi
-------------------------------
--update feroapp.dbo.radnici set neradi=1 where datumodlaska is not null and neradi=0 and DatumOdlaska<'2019-03-01'
------------------------------------------------------------

select *
from radnici_
where id=1033


