
use [To-Ka-Bu doo]
select r.id,r.prezime+' '+rime+ ' ('+cast(id as varchar)+')' prezimeime,radnomjesto,poduzece


insert  into fxserver.rfind.dbo.kompetencije ( id, prezimeime, mjesto_troska,radnomjesto,datumzaposlenja,istek_ugovora)

select r.id , p.acworker prezimeime,m.naziv mjesto_troska,r.radnomjesto,p.adDateEnter datum_zaposlenja,j.adEmployedTo istek_ugovora
from fxserver.rfind.dbo.radnici_ r
left join fxserver.rfind.dbo.mjestotroska m on m.id=r.mt
left join thr_prsn p on p.acregno=r.id
left join tHR_Prsnjob j on p.acWorker=j.acworker
where r.id not in (
select id
from fxserver.rfind.dbo.kompetencije)
and neradi=0
--and FixnaIsplata=0
and p.acworker is not null


----------------------------
- dodavanje novih u kompetencije iz radnici_
----------------------------
insert  into fxserver.rfind.dbo.kompetencije ( id, prezimeime, mjesto_troska,radnomjesto,datumzaposlenja)
select r.id,r.prezime+' '+r.ime+'('+cast(r.id as varchar(4)) +')' prezimeime,mt.naziv mjestotroska,r.radnomjesto,
from fxserver.rfind.dbo.radnici_ r
left join fxserver.rfind.dbo.mjestotroska mt on mt.id=r.mt
where r.neradi=0
and r.id not in 
(
select id
from fxserver.rfind.dbo.kompetencije
)



select *
from fxserver.rfind.dbo.kompetencije k
order by id

select *
from fxserver.rfind.dbo.radnici_
order by id desc

select *
from thr_prsn
order by cast(acregno as int) desc


select p.acactive,p.addateexit,k.*
from fxserver.rfind.dbo.kompetencije k
left join thr_prsn p on p.acregno=k.id
where p.adDateExit is not null
order by k.id

use feroimpex
select *
from thr_prsn
order by addateenter desc

------------------------------------------------
-- provjera  onih koji su otišli
------------------------------------------------
select k.id,r.*
from fxserver.rfind.dbo.radnici_ r
left join fxserver.rfind.dbo.kompetencije k on r.id=k.id
where r.neradi=1 and k.id is not null
order by prezime

delete from fxserver.rfind.dbo.kompetencije where id in (
select r.id
from fxserver.rfind.dbo.radnici_ r
where r.neradi=1
)
--------------------------------------------------
--
--------------------
update fxserver.rfind.dbo.radnici_3
set datumzaposlenja=j.addateenter,datumprestanka=j.adexit

from (

select *
from thr_prsn
) j
inner join fxserver.rfind.dbo.radnici_3 r on r.id = j.acregno


--
-- UPDATE RADNICI_ na temelju pantheona
--
update fxserver.rfind.dbo.radnici_ 

set datumprestanka=j.addATeExit,
grad=j.accity,
ulicA=J.ACSTREET,
POSTA=SUBSTRING(J.ACPOST,4,5)

from
(
select *
from thr_prsn
) j
inner join fxserver.rfind.dbo.radnici_ r on j.acregno=r.id

-- update 8065,8008.8070
update fxserver.rfind.dbo.radnici_ 
set 
datumzaposlenja=j.addATeenter,
datumprestanka=j.addATeExit,
grad=j.accity,
ulicA=J.ACSTREET,
POSTA=SUBSTRING(J.ACPOST,4,5)


from
(
select *
from thr_prsn
) j
,fxserver.rfind.dbo.radnici_ r 
where j.acregno=(r.id-8000)


----------------------------
-- update radnici_  datumprestanka ovisno o danodlaska
----------------------------
update radnici_ set datumprestanka=j.DanOdlaska
from
(
select *
from [Fxsap].DBO.plansatirada
where DanOdlaska is not null
AND GODINA=2017 and mjesec>3
) j
inner join radnici_ r on r.id=j.radnikid
and r.DatumPrestanka is null

