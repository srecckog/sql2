---------------
DECLARE @datum1 date= '2017-08-09';  
use rfind
select *
from evidencijaodsustva
where datum=@datum1
--where DATEDIFF(day,datum,getdate())=1
-----------------------------------------------------------
----------------------------------------------------------
---------------------------------------------------------- izostaNCI
use rfind
select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,'' as 'Zaplanirani (  nije dosao)',''as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as 'Nedostaje (minuta)','' as 'Prerano oti�ao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where (pv.radnomjesto ='BO'  or pv.radnomjesto='GO' or pv.radnomjesto='G.O.' )
AND datum=@datum1

UNION ALL

select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena,case when (pv.otisao=pv.dosao) then 'Nije dosao' end Napomena2,''as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as nedostaje,'' as 'Prerano oti�ao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where  year(pv.otisao)=1900
AND pv.radnomjesto NOT IN ('BO' ,'GO' ,'G.O.','4. SMJENA')
AND datum=@datum1
and r.id is not null

union all

select pv.datum Datum,r.id ID,r.ime Ime,r.prezime Prezime,mt.Naziv MT_naziv,r.MT,pv.radnomjesto RadnoMjesto,pv.hala Hala,pv.Smjena,pv.Napomena, '' as Napomena2 ,''as 'Dosao, nije zaplanirani', pv.kasni as 'Kasni (minuta)','' as nedostaje,pv.PreranoOtisao as 'Prerano oti�ao'
FROM [RFIND].[dbo].[PregledVremena] pv
left join radnici_ r on r.id=pv.IDRadnika
left join MjestoTroska mt on mt.id=r.mt
where  ( pv.kasni>0 or pv.PreranoOtisao>0)
AND pv.radnomjesto NOT IN ('BO' ,'GO' ,'G.O.','4. SMJENA')
AND datum=@datum1
and r.id is not null and r.id !=695

union all

select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,pv.Napomena,'' as napomena2,'Dosao, a vodi se na bolovanju'as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)','' as nedostaje,'' as 'Prerano oti�ao'
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

--select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena, ( rtrim(pv.Napomena)+' nije odradio 8 sati, nedostaje  '+cast( (480-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u '+cast(pv.dosao as nvarchar) +' oti�ao u '+convert(pv.otisao as nvarchar) ) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)'
-- nedostaje1 , �ista�ice
select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 8 sati, nedostaje  '+cast( (420-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' oti�ao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani',pv.kasni as 'Kasni (minuta)', (420-pv.Ukupno_minuta+pv.kasni) as Nedostaje,'' as 'Prerano oti�ao'
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
select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 8 sati, nedostaje  '+cast( (480-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' oti�ao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)', (pv.PreranoOtisao + pv.kasni) as Nedostaje,'' as 'Prerano oti�ao'
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

select pv.datum,r.id,r.ime,r.prezime,mt.naziv mt_naziv,r.mt,pv.RadnoMjesto,pv.Hala,pv.Smjena,  rtrim(pv.Napomena)+' -- nije odradio 16 sati, nedostaje  '+cast( (960-pv.Ukupno_minuta) as nvarchar) +' minuta, dosao u  ' +CONVERT(VARCHAR(24),pv.dosao,108) +' oti�ao u '+ CONVERT(VARCHAR(24),pv.otisao,108) as napomena,'' as napomena2,'' as 'Dosao, nije zaplanirani','' as 'Kasni (minuta)', (960-pv.Ukupno_minuta+pv.kasni) as Nedostaje,'' as 'Prerano oti�ao'
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
use rfind
-----------------------------------------------------------
-- nezaplanirani
select x1.id,x1.ime,x1.prezime,e.dt vrijeme,r.Name
from (
select r.id,r.ime,r.prezime,r.radnomjesto,r.mt
from radnici_ r
where r.id not in 
(
select idradnika
from PregledVremena
where datum=@datum1
)
--and r.id not in 
--(
--select idradnika
--from PregledVremena
--where DATEDIFF(day,datum,@datum1)=1
--and smjena=3
--)
and r.id in
(
select u.extid
from [user] u
left join event e on e.[User]=u.oid
left join reader r on r.id=e.Device_ID
where DATEDIFF(day,e.dt,@datum1)=0 AND E.EVENTTYPE='SP39'
and r.Door in (1,8,2,6,7 )
and DATEPART(hour, e.dt)>5
)	
) x1
left join [user] u on u.extid=x1.id
left join event e on e.[User]=u.oid
left join reader r on r.id=e.Device_ID
where DATEDIFF(day,e.dt,@datum1)=0 AND E.EVENTTYPE='SP39'
order by x1.id,e.dt

-- kontrola dali je zaplaniran i na GO ili BO
use rfind
select r.id,r.prezime,r.ime,pv.rbroj,pv.datum,pv.hala,pv.smjena,pv.radnomjesto
from pregledvremena pv
left join radnici_ r on pv.IDRadnika=r.id
where pv.idradnika in (
select x1.idradnika
from (
select idradnika,count(*) broj
from pregledvremena
where @datum1=datum
group by idradnika
having count(*)>1 
) x1

)
and pv.datum=@datum1
and pv.radnomjesto in ( 'G.O.','B.O.','BO','GO')
order by r.id
-------------------
