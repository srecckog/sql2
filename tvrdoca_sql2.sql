             
select top 3000  
 x3.pec,x3.materijal,x3.brojpecikaljenje,4 velicina_uzorka, avg(x3.tvrdoca_avg) tvrdoca_avg, avg(x3.razlika) razlika_avg  
 from ( 
 select x2.pec,x2.materijal, x2.BrojPeciKaljenje, avg(x2.tvrdoca) as tvrdoca_avg,max(x2.tvrdoca) tvrdoca_max1 , min(x2.tvrdoca) tvrdoca_min1,( max(x2.tvrdoca)-min(x2.tvrdoca) ) razlika from ( 
 select x1.*, 
 Etalon,ktm.BrojIgle , 
 ktm.Tvrdoca1 , 
 ktm.Tvrdoca2 , 
 ktm.Tvrdoca3 , 
 (ktm.Tvrdoca1 +ktm.Tvrdoca2 +ktm.Tvrdoca3)/3 Tvrdoca_avg  
 from (
 
 --SELECT AVG(TVRDOCA)
 --from(
 
 SELECT TOP 3000 ksa.id_ktz,kzag.pec,kzag.BrojSarze as sarza,kzag.tvrdomjer,  
 ksa.KratkiNaziv,kkn.Materijal,kkn.C_D,kkn.QM,ksa.Kolicina,ksa.VrstaKT,ksa.PodvrstaKT ,kzag.BrojPeciKaljenje,kzag.BrojPeciPopustanje ,  
 ksa.Tvrdoca ,ksa.DatumUnosa,ksa.VrijemeUnosa ,ksa.UserName,  
 case when DATEPART(HOUR, ksa.vrijemeunosa) >=6 and  DATEPART(HOUR, ksa.vrijemeunosa) <=13 then 1 when  DATEPART(HOUR, ksa.vrijemeunosa) >=14 and  DATEPART(HOUR, ksa.vrijemeunosa) <=21 then 2 when  ( DATEPART(HOUR, ksa.vrijemeunosa) >=22  or  DATEPART(HOUR, ksa.vrijemeunosa) <=5) then 3 end smjena  
 FROM KalionicaTvrdoceSta ksa  
 left join KalionicaTvrdoceZag kzag on ksa.ID_KTZ=kzag.ID_KTZ  
 left join KalionicaKratkiNazivi kkn on kkn.KratkiNaziv=ksa.KratkiNaziv  

 WHERE datumunosa <= '2016-06-09'    
 --AND PEC='CODERE' AND MATERIJAL='W3' AND BrojPeciKaljenje =2
 order by DateAdd(Hour, DatePart(hh, vrijemeunosa), Convert(DateTime, datumunosa)) desc 
 --) xx
 
 
  ) x1  
 left join KalionicaTvrdomjeriMjerenja ktm on ktm.Datum =x1.DatumUnosa  and ktm.Smjena=x1.smjena and x1.tvrdomjer=ktm.tvrdomjer ) x2  
 group by x2.pec,x2.materijal,x2.BrojPeciKaljenje ) x3  
 group by x3.pec,x3.materijal,x3.BrojPeciKaljenje  
 ORDER BY x3.pec,x3.materijal,x3.BrojPeciKaljenje              


 -- SQL2 09.06
              
 select top 3000  
 x3.pec,x3.materijal,x3.brojpecikaljenje,4 velicina_uzorka, avg(x3.tvrdoca_avg) tvrdoca_avg, avg(x3.razlika) razlika_avg  , sum(sumtvrd) sumatvrdoca, sum(brojmjerenja) brojmjerenja, sum(razlika) sumrazlika
 from ( 
 select x2.pec,case when x2.materijal is null then '' else x2.materijal  end materijal, x2.BrojPeciKaljenje,x2.sarza, sum(x2.tvrdoca) sumtvrd,count(*) brojmjerenja, avg(x2.tvrdoca) as tvrdoca_avg,max(x2.tvrdoca) tvrdoca_max1 , min(x2.tvrdoca) tvrdoca_min1,( max(x2.tvrdoca)-min(x2.tvrdoca) ) razlika from ( 
 select x1.*, 
 Etalon,ktm.BrojIgle , 
 ktm.Tvrdoca1 , 
 ktm.Tvrdoca2 , 
 ktm.Tvrdoca3 , 
 (ktm.Tvrdoca1 +ktm.Tvrdoca2 +ktm.Tvrdoca3)/3 Tvrdoca_avg  
 from (
 
--SELECT AVG(TVRDOCA)
--from(
 SELECT TOP 3000 ksa.id_ktz,kzag.pec,kzag.BrojSarze as sarza,kzag.tvrdomjer,  
 ksa.KratkiNaziv,kkn.Materijal,kkn.C_D,kkn.QM,ksa.Kolicina,ksa.VrstaKT,ksa.PodvrstaKT ,kzag.BrojPeciKaljenje,kzag.BrojPeciPopustanje ,  
 ksa.Tvrdoca ,ksa.DatumUnosa,ksa.VrijemeUnosa ,ksa.UserName,  
 case when DATEPART(HOUR, ksa.vrijemeunosa) >=6 and  DATEPART(HOUR, ksa.vrijemeunosa) <=13 then 1 when  DATEPART(HOUR, ksa.vrijemeunosa) >=14 and  DATEPART(HOUR, ksa.vrijemeunosa) <=21 then 2 when  ( DATEPART(HOUR, ksa.vrijemeunosa) >=22  or  DATEPART(HOUR, ksa.vrijemeunosa) <=5) then 3 end smjena  
 FROM KalionicaTvrdoceSta ksa  
 left join KalionicaTvrdoceZag kzag on ksa.ID_KTZ=kzag.ID_KTZ  
 left join KalionicaKratkiNazivi kkn on kkn.KratkiNaziv=ksa.KratkiNaziv  
 WHERE datumunosa<= '2016-06-09'   
--AND PEC='CODERE' AND MATERIJAL='W3' AND BrojPeciKaljenje =2
 order by DateAdd(Hour, DatePart(hh, vrijemeunosa), Convert(DateTime, datumunosa)) desc 
--) XX
 
 ) x1  
 left join KalionicaTvrdomjeriMjerenja ktm on ktm.Datum =x1.DatumUnosa  and ktm.Smjena=x1.smjena and x1.tvrdomjer=ktm.tvrdomjer ) x2  
 group by x2.pec,x2.materijal,x2.BrojPeciKaljenje,x2.sarza,x2.vrstakt,x2.podvrstakt ) x3  
 group by x3.pec,x3.materijal,x3.BrojPeciKaljenje  
 ORDER BY x3.pec,x3.materijal,x3.BrojPeciKaljenje 