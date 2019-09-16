
USE FeroApp
SELECT X1.*
FROM(
SELECT (SELECT EvidencijaNormiZag.Datum FROM EvidencijaNormiZag WHERE EvidencijaNormiZag.ID_ENZ = EvidencijaNormiSta.ID_ENZ) AS Datum, 
       (SELECT EvidencijaNormiZag.Smjena FROM EvidencijaNormiZag WHERE EvidencijaNormiZag.ID_ENZ = EvidencijaNormiSta.ID_ENZ) AS Smjena, 
       * 
       FROM EvidencijaNormiSta WHERE TekstCheck15 = 1
	   ) X1
	   WHERE YEAR(X1.DATUM)=2016
