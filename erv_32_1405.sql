DECLARE @datum1 date= '2018-05-11';  
use rfind
select *
from evidencijaodsustva
where datum=@datum1
--where DATEDIFF(day,datum,getdate())=1
-----------------------------------------------------------
----------------------------------------------------------
---------------------------------------------------------- izostaNCI
use rfind
select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,'' as 'Zaplanirani (  nije dosao)',''as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as 'Nedostaje (minuta)','' as 'Prerano otišao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where (pv.radnomjesto ='BO'  or pv.radnomjesto='GO' or pv.radnomjesto='G.O.' )
AND datum=@datum1

UNION ALL

select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,case when (pv.otisao=pv.dosao) then 'Nije dosao' end Napomena2,''as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as nedostaje,'' as 'Prerano otišao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where  year(pv.otisao)=1900
AND pv.radnomjesto NOT IN ('BO' ,'GO' ,'G.O.','4. SMJENA')
AND datum=@datum1
and r.id is not null

union all

select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena, '' as Napomena2 ,''as 'Dosao, nije zaplanirani', pv.kasni as 'Kasni (minuta)','' as nedostaje,pv.PreranoOtisao as 'Prerano otišao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where  ( pv.kasni>0 or pv.PreranoOtisao>0)
AND pv.radnomjesto NOT IN ('BO' ,'GO' ,'G.O.','4. SMJENA')
AND datum=@datum1
and r.id is not null and r.id !=695

union all

select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,pv.Napomena,'' as napomena2,'Dosao, a vodi se na bolovanju'as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as nedostaje,'' as 'Prerano otišao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where pv.RadnoMjesto in ( 'BO','GO')
and pv.IDRadnika in
(
select u.ExtId
from [User] u
left join event e on u.OID=e.[User]
left join reader r on r.id=e.Device_ID
where DATEDIFF(day,e.dt,@datum1)=0 AND E.EVENTTYPE='SP39'
and r.Door not in ( 7,8,9,10)
)
and datum=@datum1

union all

--select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena, ( rtrim(pv.Napomena)+' nije odradio 8 sati, nedostaje  '+cast( (480-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u '+cast(pv.dosao as nvarchar) +' otišao u '+convert(pv.otisao as nvarchar) ) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)'
-- nedostaje1 , èistaèice
select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 8 sati, nedostaje  '+cast( (420-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' otišao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani',pv.kasni as 'Kasni (minuta)', (420-pv.Ukupno_minuta+pv.kasni) as Nedostaje,'' as 'Prerano otišao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv=8
and pv.Ukupno_minuta<420
and ((420 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and datum=@datum1

union all
-- nedostaje11, ostali 8 sati
select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 8 sati, nedostaje  '+cast( (480-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' otišao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)', (pv.PreranoOtisao + pv.kasni) as Nedostaje,'' as 'Prerano otišao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv!=8
and pv.Ukupno_minuta<480
and ((480 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and datum=@datum1

union all

-- nedostaje111, 16 sati

select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 16 sati, nedostaje  '+cast( (960-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' otišao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)', (960-pv.Ukupno_minuta+pv.kasni) as Nedostaje,'' as 'Prerano otišao'
from PregledVremena pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where PV. dosao!=PV.otisao
and r.rv!=8
and ( pv.Ukupno_minuta<960 and pv.Ukupno_minuta>800)
and ((960 - PV.ukupno_minuta)>30  or pv.kasni>20) 
and datum=@datum1

order by r.mt,r.prezime,pv.datum,pv.RadnoMjesto,PV.Smjena
-----------------------------------------------------
-----------------------------------------------------	
-----------------------------------------------------------
-- nezaplanirani
select r.id,r.ime,r.prezime,r.radnomjesto,r.mt
from radnici_ r
where r.id not in 
(
select idradnika
from PregledVremena
where datum=@datum1
)
and r.id not in 
(
select idradnika
from PregledVremena
where DATEDIFF(day,datum,@datum1)=1
and smjena=3
)
and r.id in
(
select u.extid
from [user] u
left join event e on e.[User]=u.oid
where DATEDIFF(day,e.dt,@datum1)=0
)



------------------------
-- NEW nije zaplaniran a dosao
use rfind
select distinct x1.id,x1.ime,x1.prezime,x1.radnomjesto,x1.pvid
from (

select r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika as pvid
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id and DATEDIFF(day,pv.datum,getdate())=1
left join [user] u on u.extid=r.id
left join event e on e.[user]=u.oid
where sifrarm not in ('Režija1','Rez1')
and pv.idradnika is null
and DATEDIFF(day,pv.datum,getdate())=1
--and pv.datum='2018-03-26'
--and id=373
--and e.eventtype='SP39'
group by r.id,r.ime,r.prezime,r.radnomjesto,pv.idradnika

) x1
order by x1.prezime

------------
-- OLD
-- prijavio se nije zaplaniran
use rfind
--select distinct r.*,min(e.Dt),e.Device_ID
select r.id,r.ime,r.prezime,r.radnomjesto
from radnici_ r
left join PregledVremena pv on pv.idradnika=r.id
left join [user] u on u.extid=r.id
left join event e on e.[user]=u.oid
where pv.idradnika is null
and sifrarm not in ('Režija','Rez')
--and DATEDIFF(day,e.dt,getdate())>=1 and e.dt>'2018-01-29'
--and DATEDIFF(day,e.dt,getdate())=1
and day(e.dt)=26 and month(e.dt)=3
and e.eventtype='SP39'
group by r.id,r.ime,r.prezime,r.radnomjesto
order by r.prezime
------------------------------