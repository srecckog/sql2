
USE FeroApp

DECLARE @Od date
DECLARE @Do date
SET DATEFORMAT dmy

----------UPISATI PODATKE----------
SET @Od='30.5.2016'
SET @Do='30.5.2016'
-----------------------------------
select x3.datum,x3.pogon,count(*) BrojLinijaNaätelanju
from(
select x2.datum Datum,x2.pogon Pogon,x2.Linija,count(*) Broj_ötelanja
from(

SELECT X1.*
FROM(
SELECT (SELECT EvidencijaNormiZag.Datum FROM EvidencijaNormiZag WHERE EvidencijaNormiZag.ID_ENZ = EvidencijaNormiSta.ID_ENZ) AS Datum, 
       (SELECT EvidencijaNormiZag.Smjena FROM EvidencijaNormiZag WHERE EvidencijaNormiZag.ID_ENZ = EvidencijaNormiSta.ID_ENZ) AS Smjena, 
          (SELECT EvidencijaNormiZag.Hala FROM EvidencijaNormiZag WHERE EvidencijaNormiZag.ID_ENZ = EvidencijaNormiSta.ID_ENZ) AS Pogon, 
       * 
       FROM EvidencijaNormiSta WHERE TekstCheck01 = 1  --  testCheck01 =1  zna?i ötelanje

          ) X1
          WHERE Datum between(@Od) and (@Do) -- razdoblje
          ) x2
          group by x2.datum,x2.linija,x2.pogon
          ) x3
          group by x3.datum,x3.pogon
          order by datum desc,pogoN  -- sortirano po datumu,....
          
 select x2.datum Datum,x2.pogon Pogon,x2.smjena Smjena,x2.linija Linija,count(*) Broj_ötelanja
from(

SELECT X1.*
FROM(
SELECT (SELECT EvidencijaNormiZag.Datum FROM EvidencijaNormiZag WHERE EvidencijaNormiZag.ID_ENZ = EvidencijaNormiSta.ID_ENZ) AS Datum, 
       (SELECT EvidencijaNormiZag.Smjena FROM EvidencijaNormiZag WHERE EvidencijaNormiZag.ID_ENZ = EvidencijaNormiSta.ID_ENZ) AS Smjena, 
          (SELECT EvidencijaNormiZag.Hala FROM EvidencijaNormiZag WHERE EvidencijaNormiZag.ID_ENZ = EvidencijaNormiSta.ID_ENZ) AS Pogon, 
       * 
       FROM EvidencijaNormiSta WHERE TekstCheck01 = 1  --  testCheck01 =1  zna?i ötelanje

          ) X1
          WHERE Datum between(@Od) and (@Do) -- razdoblje
          ) x2
          group by datum,smjena,linija,pogon
          order by datum desc,pogon,linija   -- sortirano po datumu,....


