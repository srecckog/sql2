select k.id,k.poduzece,k.prezimeime,k.istek_ugovora,k.mjesto_troska,k.radnomjesto,k.datumzaposlenja,k.godisnji_ostalo,
j.datumo,j.mt,j.rm,j.datz,j.go_ostalo,' Update fx' napomena1
from
(
select p.acregno,j.adEmployedTo  datumo,mt.naziv mt,j.acfieldsb funkcija,j.acjob rm,p.addateenter datz,v.anvacationf1 GO_ostalo
from [192.168.0.6].[PantheonFXAt].dbo.thr_prsn p
left join [192.168.0.6].[PantheonFXAt].dbo.thr_prsnjob j on j.acworker=p.acworker
left join [192.168.0.6].[PantheonFXAt].dbo.thr_prsnvacation v on v.acworker=p.acworker
left join MjestoTroska mt on mt.id=j.accostdrv
where j.addateend is null 
) j
inner join kompetencije k on k.id=j.acregno
where k.poduzece='FX'
and
( 
k.istek_ugovora!=j.datumo or
k.mjesto_troska!=j.mt or
k.radnomjesto!=j.rm or 
k.datumzaposlenja!=j.datz or
k.godisnji_ostalo!=j.go_ostalo)
union all
select k.id,k.poduzece,k.prezimeime,k.istek_ugovora,k.mjesto_troska,k.radnomjesto,k.datumzaposlenja,k.godisnji_ostalo,
j.datumo,j.mt,j.rm,j.datz,j.go_ostalo,' Update tb' napomena1
from
(
select p.acregno,j.adEmployedTo  datumo,mt.naziv mt,j.acfieldsb funkcija,j.acjob rm,p.addateenter datz,v.anvacationf1 GO_ostalo
from [192.168.0.6].[PantheonTKB].dbo.thr_prsn p
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnjob j on j.acworker=p.acworker
left join [192.168.0.6].[PantheonTKB].dbo.thr_prsnvacation v on v.acworker=p.acworker
left join MjestoTroska mt on mt.id=j.accostdrv
where j.addateend is null 
) j
inner join kompetencije k on k.id=j.acregno
where k.poduzece='Tokabu'
and
( 
k.istek_ugovora!=j.datumo or
k.mjesto_troska!=j.mt or
k.radnomjesto!=j.rm or 
k.datumzaposlenja!=j.datz or
k.godisnji_ostalo!=j.go_ostalo)

--
select distinct r.id,r.prezime+' '+r.ime+'('+cast(r.id as varchar(4)) +')' prezimeime,mt.naziv mjestotroska,r.radnomjesto,r.datumzaposlenja ,'FX' poduzece,'Novi u FX' napomena1
from fxserver.rfind.dbo.radnici_ r
left join fxserver.rfind.dbo.mjestotroska mt on mt.id=r.mt
where r.neradi=0
and r.id not in 
(
select ID
from fxserver.rfind.dbo.kompetencije
where poduzece='FX'
--order by id
)
and r.id not in
(
select radnikid
from fxserver.fxsap.dbo.plansatirada
where danodlaska IS NOT  NULL
--order by radnikid
)
and ( year(r.datumprestanka)=1900 or r.datumprestanka is null)
and r.poduzece='Feroimpex'
ORDER BY R.ID

select distinct r.id,r.prezime+' '+r.ime+'('+cast(r.id as varchar(4)) +')' prezimeime,mt.naziv mjestotroska,r.radnomjesto,r.datumzaposlenja ,'Tokabu' poduzece,'Novi u TB' napomena1
from fxserver.rfind.dbo.radnici_ r
left join fxserver.rfind.dbo.mjestotroska mt on mt.id=r.mt
where r.neradi=0
and r.id not in 
(
select ID
from fxserver.rfind.dbo.kompetencije
where poduzece='Tokabu'
--order by id
)
and r.id not in
(
select radnikid
from fxserver.fxsap.dbo.plansatirada
where danodlaska IS NOT  NULL
--order by radnikid
)
and ( year(r.datumprestanka)=1900 or r.datumprestanka is null)
and r.poduzece='Tokabu'
ORDER BY R.ID


