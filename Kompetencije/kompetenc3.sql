  ----------- 
insert into fxserver.rfind.dbo.kompetencije0305 (id , prezimeime , funkcija , radnomjesto , mjesto_troska, vjestina , datumzaposlenja ,istek_ugovora, staz , satnica , bolovanja_dana , normaposto,napomena,stimulacija,poduzece ) 

select x1.id , x1.name , x1.funkcija , x1.radno_mjesto radnomjesto,x1.accostdrv mjesto_troska,x1.vještine , x1.datum_zaposlenja2 datum_zaposlenja,istek_ugovora,cast(x1.staz_godina as varchar) +' god '+ cast( (x1.staz_mjeseci - x1.staz_godina*12) as varchar) + ' mjes' Staz,x1.satnica,x1.bolovanja,x1.norme normaposto,x1.napomena,x1.anextras,x1.poduzece
from (

  select p.acregno as ID,p.acworker as Name,j.accostdrv,j.adDate  as Datum_zaposlenja2, j.adEmployedTo istek_ugovora,convert(VARCHAR(10), addateexit, 104) Datum_prestanka_rada,j.acJob Radno_mjesto,convert( int,round( DATEDIFF(MONTH, j.adDate, GetDate()) / 12,0)) Staz_godina,( DATEDIFF(MONTH, j.adDate, GetDate()))  Staz_mjeseci,k.funkcija,k.vještine,j.anWrk23 satnica,k.norme,k.bolovanja,k.napomena,k.grupa,s.anextras,'FX' as poduzece
  from [feroimpex].dbo.tHR_Prsn p
  left join [feroimpex].dbo.thr_prsnjob j on j.acworker=p.acWorker
  left join [feroimpex].dbo.thr_slrycalcsum s on s.acworker=p.acWorker
  left join fxserver.rfind.dbo.radnici_ r on r.id=p.acRegNo
  left join Fxserver.rfind.dbo.kompetence2 k on k.id=p.acRegNo
  WHERE (R.NERADI=0 or  p.addateexit is NULL)
  and p.adDateExit is null
  and s.acPeriod='2017-03'
  and r.fixnaisplata=0

  union all
    
  --select x11.*, cast(x11.staz_godina as varchar) +' godina '+ cast( (x11.staz_mjeseci - x11.staz_godina*12) as varchar) + ' mjeseci' Staž from ( 
  select p.acregno as ID, p.acworker as Name,j.acCostDrv,j.adDate as Datum_zaposlenja2, j.adEmployedTo istek_ugovora,CONVERT(VARCHAR(10), addateexit, 104) Datum_prestanka_rada,j.acJob Radno_mjesto,convert( int,round( DATEDIFF(MONTH, j.adDate, GetDate()) / 12,0)) Staz_godina,( DATEDIFF(MONTH, j.adDate, GetDate()))  Staz_mjeseci, k.funkcija,k.vještine,j.anWrk23 satnica ,k.norme,k.bolovanja,k.napomena,k.grupa,s.anextras, 'TB' as poduzece
 --select acregno as ID,p.acworker as Name,CONVERT(VARCHAR(10), j.adDate, 104)  as Datum_zaposlenja2
 
  from [To-Ka-Bu doo].dbo.tHR_Prsn p
  left join [To-Ka-Bu doo].dbo.thr_prsnjob j on j.acworker=p.acWorker
  left join [feroimpex].dbo.thr_slrycalcsum s on s.acworker=p.acWorker
  left join fxserver.rfind.dbo.radnici_ r on r.id=p.acRegNo
  left join Fxserver.rfind.dbo.kompetence2 k on k.id=p.acRegNo
  WHERE (R.NERADI=0 or  p.addateexit is NULL)
  and p.adDateExit is null
  and s.acPeriod='2017-03'
  and r.fixnaisplata=0
  ) x1

--------------------------------
-- pregled stimulacija za period
--------------------------------
select c.ACWORKER,annet,t.acName
from
--thr_slrycalcsum 
thr_SlryCalcET c
left join thr_SetSlryET t on t.acet=c.acet
where acperiod='2017-01'
and C.acet='STM'
order by annet
------------------
select *
from
thr_slrycalcsum 
where acperiod='2017-03'
and acregno=1028
--and anextras>0
-----------
-- vrste zarada
select *
from
thr_SetSlryET
where acperiod='2017-03'
and anextras>0
-----------------------------------------------------
-----------------
  select *
  from [dbo].[tHR_Prsn]
  order by acregno
  where acworker like '%1375%'


 ------------------------
 - UPDATE stimulacija
 ---------------------------
 
  UPDATE
    fxserver.rfind.dbo.kompetencije0305
SET
    stimulacija = j.annet
FROM
   thr_SlryCalcET J
INNER JOIN
    fxserver.rfind.dbo.kompetencije0305 k
ON 
    j.acworker=k.prezimEime
	where j.acet='STM'
	AND J.ACPERIOD='2017-03'
---------------------------------------------------------

------------------------
 - UPDATE ne radi subotom
 ---------------------------
 
  UPDATE
    fxserver.rfind.dbo.kompetencije0305
SET
    nedolascinedjeljom = 1
FROM
   (
   -- ne rade nedjeljom a zaplanirani su
  select *
  from pregledvremena
  where datepart(dw, datum)=7
  and year(dosao)=1900
  and month(datum)=3
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'


   )
INNER JOIN
    fxserver.rfind.dbo.kompetencije0305 k
ON 
    j.acworker=k.prezimEime
	where j.acet='STM'
	AND J.ACPERIOD='2017-03'
-

-----------------------------------------------------
---------------------------------------------------------

------------------------
 - UPDATE satnice
 ---------------------------
 
  UPDATE
    fxserver.rfind.dbo.kompetencije0805
SET
    satnica = j.satnica,
	satnicastara=j.satnicastara,
	satnicaod=CONVERT(varchar(4), j.godina) +' - '+CONVERT(varchar(2), j.mjesec)
FROM
   (
      
  select *
  from satnica j
  
   )
INNER JOIN
    fxserver.rfind.dbo.kompetencije0805 k
ON 
    j.radnikd=k.id 


-

use feroimpex
select x1.*,case when satnicaneto>0 then (anwrk23/satnicaneto)  else 0.0 end odnos into fxserver.rfind.dbo.obrplace0317
from (
select acworker,acperiod,annet,anhourfund,anwrk23,case when anhourfund>0 then (annet/anhourfund) else 0.011 end satnicaneto
from tHR_SlryCalcSum
where acperiod='2017-03'
) x1
