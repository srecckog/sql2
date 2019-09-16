    use feroapp
	-- comand1
      SELECT id_ktz as sarza,avg(tvrdoca) as avg_tvrdoca,stdev(tvrdoca) as stdv_tvrdoca 
      FROM KalionicaTvrdoceSta 
      WHERE dateadd(hour,datepart(hh,vrijemeunosa),convert(datetime,datumunosa))
      between '2016-05-26' and '2016-05-27'
      group by id_ktz
      ORDER BY id_ktz

	  -- command 3
	  select x1.*,ktm.Tvrdomjer,Etalon,ktm.BrojIgle ,ktm.Tvrdoca1 ,ktm.Tvrdoca2 ,ktm.Tvrdoca3 ,(ktm.Tvrdoca1 +ktm.Tvrdoca2 +ktm.Tvrdoca3)/3 Tvrdoca_avg
	  from (
	  SELECT kzag.pec,kzag.BrojSarze as sarza,ksa.KratkiNaziv,kkn.Materijal,kkn.C_D,kkn.QM,ksa.Kolicina,ksa.VrstaKT,ksa.PodvrstaKT ,kzag.BrojPeciKaljenje,kzag.BrojPeciPopustanje ,ksa.Tvrdoca ,ksa.DatumUnosa,ksa.VrijemeUnosa ,ksa.UserName,
	  case when  DATEPART(HOUR, ksa.vrijemeunosa) >=6 and  DATEPART(HOUR, ksa.vrijemeunosa) <=13 then 1
	  when  DATEPART(HOUR, ksa.vrijemeunosa) >=14 and  DATEPART(HOUR, ksa.vrijemeunosa) <=21 then 2
	  when  DATEPART(HOUR, ksa.vrijemeunosa) >=22 and  DATEPART(HOUR, ksa.vrijemeunosa) <=5 then 3 end smjena
      FROM KalionicaTvrdoceSta ksa
	  left join KalionicaTvrdoceZag kzag on ksa.ID_KTZ=kzag.ID_KTZ
	  left join KalionicaKratkiNazivi kkn on kkn.KratkiNaziv=ksa.KratkiNaziv
	  WHERE dateadd(hour,datepart(hh,vrijemeunosa),convert(datetime,datumunosa))
      between '2016-05-26' and '2016-12-31' 
	  ) x1
	  left join KalionicaTvrdomjeriMjerenja ktm on ktm.Datum =x1.DatumUnosa  and ktm.Smjena=x1.smjena 
      ORDER BY dateadd(hour,datepart(hh,vrijemeunosa),convert(datetime,datumunosa)) desc
      
	  -- cpk
	  use feroapp
	  select 
	  x2.pec,x2.materijal,x2.vrstaKT,x2.PodvrstaKT,AVG(x2.tvrdoca) AVGG
	  from (

	  select x1.*,ktm.Tvrdomjer,Etalon,ktm.BrojIgle ,ktm.Tvrdoca1 ,ktm.Tvrdoca2 ,ktm.Tvrdoca3 ,(ktm.Tvrdoca1 +ktm.Tvrdoca2 +ktm.Tvrdoca3)/3 Tvrdoca_avg
	  from (
	  SELECT kzag.pec,kzag.BrojSarze as sarza,ksa.KratkiNaziv,kkn.Materijal,kkn.C_D,kkn.QM,ksa.Kolicina,ksa.VrstaKT,ksa.PodvrstaKT ,kzag.BrojPeciKaljenje,kzag.BrojPeciPopustanje ,ksa.Tvrdoca ,ksa.DatumUnosa,ksa.VrijemeUnosa ,ksa.UserName,
	  case when  DATEPART(HOUR, ksa.vrijemeunosa) >=6 and  DATEPART(HOUR, ksa.vrijemeunosa) <=13 then 1
	  when  DATEPART(HOUR, ksa.vrijemeunosa) >=14 and  DATEPART(HOUR, ksa.vrijemeunosa) <=21 then 2
	  when  DATEPART(HOUR, ksa.vrijemeunosa) >=22 and  DATEPART(HOUR, ksa.vrijemeunosa) <=5 then 3 end smjena
      FROM KalionicaTvrdoceSta ksa
	  left join KalionicaTvrdoceZag kzag on ksa.ID_KTZ=kzag.ID_KTZ
	  left join KalionicaKratkiNazivi kkn on kkn.KratkiNaziv=ksa.KratkiNaziv
	  WHERE dateadd(hour,datepart(hh,vrijemeunosa),convert(datetime,datumunosa))
      between '2016-05-26' and '2016-06-01' 
	  ) x1
	  left join KalionicaTvrdomjeriMjerenja ktm on ktm.Datum =x1.DatumUnosa  and ktm.Smjena=x1.smjena 
	--  order by x1.datumunosa desc,x1.VrijemeUnosa  desc
      
	  ) x2
	  group by x2.pec,x2.materijal,x2.vrstaKT,x2.PodvrstaKT
	  ------------------------




 select *
 from kalionicatvrdoceZag

  select *
 from kalionicatvrdocesta

 select *
from KalionicaKratkiNazivi