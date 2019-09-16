  
  exec sp_addlinkedserver @server="";
  Exec sp_addlinkedsrvlogin @rmtsrvname="FXSERVER",@useself=false, @rmtuser="sa", @rmtpassword="AdminFX9.";
  
  ----------------------------------------
  -- kreiranje obracun place za 3 2017
  ----------------------------------------
  select acworker,anhourfund,anwrk23,annet,case when anhourfund>0 then annet/anhourfund else 0 end netokn into obrplac0317
  from [192.168.0.6].[feroimpex].[dbo].[tHR_SlryCalcSum] s
  where acperiod='2017-03'

  select acworker,anhourfund,anwrk23,annet,case when anhourfund>0 then annet/anhourfund else 0 end netokn 
  from [192.168.0.6].[feroimpex].[dbo].[tHR_SlryCalcSum] s
  where acperiod='2017-02'

  select *
  from [192.168.0.6].[feroimpex].[dbo].[tHR_SlryCalcSum] s
  where acperiod='2017-03'
  and acregno=659
  ----------------

  select id,ime,mjesec,godina,sum(brojdana) brojdana,max(sn) sn,max(nn) nn,firma
  from stat_bo2
  group by id,ime,mjesec,godina,firma



  -------------------
   UPDATE
    kompetencije1005
SET
    satnicaneto = j.netokn	
FROM
   (
      
  select *
  from obrplac0317
  
   ) j
INNER JOIn kompetencije1005 k
ON 
    j.acworker=k.prezimeime
------------------------------

update kompetencije1005 set [Bolovanje_broj]=0,[Bolovanja_dana]=0,nedolascinedjeljom=0,[NedolasciSubotom]=0,[NeopravdaniDani]=0,[NedostajeDo8sati]=0,kasni=0,[PreranoOtisao]=0



   UPDATE
    kompetencije1005
SET
   nedolascinedjeljom = j.nn,
   [NedolasciSubotom]=j.sn,
   [NeopravdaniDani]=j.brojdana
	--[Bolovanje_broj]=j.puta,
	--[Bolovanja_dana]=j.brojdana
FROM
   (
      
  select *
  from odsustva0317
  where firma=1
  and razlog='N'
  
   ) j
INNER JOIn kompetencije1005 k
ON 
    j.id=k.id and k.poduzece='FX'
	where j.razlog='N' and k.poduzece='FX'

--------------------
	select *
	from kompetencije1005
	order by prezimeime