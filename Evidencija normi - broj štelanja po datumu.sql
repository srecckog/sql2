-- 192.168.0.5
USE FeroApp
select x2.datum Datum,x2.pogon Pogon,x2.Linija,x2.smjena Smjena,count(*) Broj_štelanja
from(

SELECT X1.*
FROM(
SELECT (SELECT EvidencijaNormiZag.Datum FROM EvidencijaNormiZag WHERE EvidencijaNormiZag.ID_ENZ = EvidencijaNormiSta.ID_ENZ) AS Datum, 
       (SELECT EvidencijaNormiZag.Smjena FROM EvidencijaNormiZag WHERE EvidencijaNormiZag.ID_ENZ = EvidencijaNormiSta.ID_ENZ) AS Smjena, 
	   (SELECT EvidencijaNormiZag.Hala FROM EvidencijaNormiZag WHERE EvidencijaNormiZag.ID_ENZ = EvidencijaNormiSta.ID_ENZ) AS Pogon, 
       * 
       FROM EvidencijaNormiSta WHERE TekstCheck01 = 1  --  testCheck01 =1  znaèi štelanje

	   ) X1
	   WHERE YEAR(X1.DATUM)=2016 and month(x1.datum)=month(getdate()) -- za tekuæi mjesec 2016 godine
	   ) x2
	   group by datum,smjena,linija,pogon
	   order by datum desc,pogoN,smjena   -- sortirano po datumu,....


