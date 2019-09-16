  exec sp_addlinkedserver @server="FXSERVER";
  Exec sp_addlinkedsrvlogin @rmtsrvname="FXserver",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";


  select x1.id , count(*)

  select * into ft
  from (

  select acregno as ID,p.acworker as Name,CONVERT(VARCHAR(10), j.adDate, 104)  as Datum_zaposlenja2, CONVERT(VARCHAR(10), addateexit, 104) Datum_prestanka_rada,j.acJob Radno_mjesto,convert( int,round( DATEDIFF(MONTH, j.adDate, GetDate()) / 12,0)) Staz_godina,( DATEDIFF(MONTH, j.adDate, GetDate()))  Staz_mjeseci, CONVERT(VARCHAR(10),j.adEmployedTo , 104) istek_ugovora,k.funkcija,k.vještine,k.ima,k.norme,k.bolovanja,k.napomena,k.grupa,'FX' as poduzece
  from [feroimpex].dbo.tHR_Prsn p
  left join [feroimpex].dbo.thr_prsnjob j on j.acworker=p.acWorker
  left join fxserver.rfind.dbo.radnici_ r on r.id=p.acRegNo
  left join Fxserver.rfind.dbo.kompetence2 k on k.id=p.acRegNo
  --order by [prezime i ime]
  

  union all
   
  select acregno as ID,p.acworker as Name,CONVERT(VARCHAR(10), j.adDate, 104)  as Datum_zaposlenja2, CONVERT(VARCHAR(10), addateexit, 104) Datum_prestanka_rada,j.acJob Radno_mjesto,convert( int,round( DATEDIFF(MONTH, j.adDate, GetDate()) / 12,0)) Staz_godina,( DATEDIFF(MONTH, j.adDate, GetDate()))  Staz_mjeseci, CONVERT(VARCHAR(10),j.adEmployedTo , 104) istek_ugovora,k.funkcija,k.vještine,k.ima,k.norme,k.bolovanja,k.napomena,k.grupa,'TB' as poduzece 
  from [To-Ka-Bu doo].dbo.tHR_Prsn p
  left join [To-Ka-Bu doo].dbo.thr_prsnjob j on j.acworker=p.acWorker
  left join fxserver.rfind.dbo.radnici_ r on r.id=p.acRegNo
  left join Fxserver.rfind.dbo.kompetence2 k on k.id=p.acRegNo
  WHERE R.NERADI=0 or  p.addateexit is NULL
  --order by p.acworker

  ) x1


  group by x1.id
  having count(*)>1
  order by p.acWorker




  select *
  from Fxserver.rfind.dbo.kompetence2
  order by [prezime i ime]
  
  select *
  from [To-Ka-Bu doo].dbo.tHR_Prsn



  where grupa is NUll



   k on k.id=p.acRegNo



  exec sp_addlinkedserver @server="FXSERVER";
  Exec sp_addlinkedsrvlogin @rmtsrvname="FXSERVER",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";
  
  --use [fx1server].rfind
  
  select *
  from [fxserver].rfind.dbo.radnici_


  use feroimpex
  select *
  from tHR_Prsn p
  

  select * from [fxserver].rfind.dbo.PREGLEDVREMENA
  where idradnika=1324
  order  by datum


  delete from [fxserver].rfind.dbo.PREGLEDVREMENA
  where idradnika=1324 and datum>'2017-02-24'



  select acregno as ID,p.acworker as Name, CONVERT(VARCHAR(10), addateenter, 104)  as Datum_zaposlenja, CONVERT(VARCHAR(10), addateexit, 104) Datum_prestanka_rada,j.acJob Radno_mjesto,convert( int,round( DATEDIFF(MONTH, j.adDate, GetDate()) / 12,0)) Staz_godina,( DATEDIFF(MONTH, j.adDate, GetDate()))  Staz_mjeseci, CONVERT(VARCHAR(10),j.adEmployedTo , 104) istek_ugovora
  from [feroimpex].dbo.tHR_Prsn p
  left join [feroimpex].dbo.thr_prsnjob j on j.acworker=p.acWorker
  left join fxserver.rfind.dbo.radnici_ r on r.id=p.acRegNo
  left join Fxserver.rfind.dbo.kompetence2 k on k.id=p.acRegNo



  select *
  from [feroimpex].dbo.tHR_Prsnjob p
  order by p.acWorker


  use [fxsql2].fxapp
  select *
  from ldp_aktivnost
  where datum='2017-04-29'


exec sp_addlinkedserver @server="192.168.0.6";
Exec sp_addlinkedsrvlogin @rmtsrvname="192.168.0.6",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";

use [feroimpex]
select x1.*,case when satnicaneto>0 then (anwrk23/satnicaneto)  else 0.0 end odnos into obrplace0317
from (
select acworker,acperiod,annet,anhourfund,anwrk23,case when anhourfund>0 then (annet/anhourfund) else 0.011 end satnicaneto
from tHR_SlryCalcSum
where acperiod='2017-03'
) x1


