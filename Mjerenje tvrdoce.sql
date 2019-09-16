     
select 
x1.*,
ktm.Tvrdomjer,
Etalon,ktm.BrojIgle ,
ktm.Tvrdoca1 ,
ktm.Tvrdoca2 ,
ktm.Tvrdoca3 ,
(ktm.Tvrdoca1 +ktm.Tvrdoca2 +ktm.Tvrdoca3)/3 Tvrdoca_avg 
from (

SELECT ksa.id_ktz,kzag.pec,kzag.BrojSarze as sarza, 
kzag.Tvrdomjer,ksa.KratkiNaziv,kkn.Materijal,kkn.C_D,kkn.QM,ksa.Kolicina,ksa.VrstaKT,ksa.PodvrstaKT ,kzag.BrojPeciKaljenje,kzag.BrojPeciPopustanje , 
ksa.Tvrdoca ,ksa.DatumUnosa,ksa.VrijemeUnosa ,ksa.UserName, 
case when  DATEPART(HOUR, ksa.vrijemeunosa) >=6 and  DATEPART(HOUR, ksa.vrijemeunosa) <=13 then 1 when  DATEPART(HOUR, ksa.vrijemeunosa) >=14 and  DATEPART(HOUR, ksa.vrijemeunosa) <=21 then 2when  DATEPART(HOUR, ksa.vrijemeunosa) >=22 and  DATEPART(HOUR, ksa.vrijemeunosa) <=5 then 3 end smjena 
FROM KalionicaTvrdoceSta ksa 
left join KalionicaTvrdoceZag kzag on ksa.ID_KTZ=kzag.ID_KTZ 
left join KalionicaKratkiNazivi kkn on kkn.KratkiNaziv=ksa.KratkiNaziv 
WHERE DateAdd(Hour, DatePart(hh, vrijemeunosa), Convert(DateTime, datumunosa)) between '2016-06-06' and '2016-06-07' 


) x1 
left join KalionicaTvrdomjeriMjerenja ktm on ktm.Datum =x1.DatumUnosa  and ktm.Smjena=x1.smjena and x1.Tvrdomjer=ktm.Tvrdomjer
where sarza='C9523'
ORDER BY dateadd(hour,datepart(hh,vrijemeunosa),convert(datetime,datumunosa)) desc 
      