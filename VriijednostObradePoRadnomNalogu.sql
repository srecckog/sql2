USE FeroApp
SELECT Datum, BrojRN, NazivLinije, Linija, Hala, Kupac, NazivPro, Smjena, VrstaNarudzbe, ObradaA AS Tokarenja, ObradaB AS Glodanje, ObradaC AS Busenje, CAST(CijenaObradaA AS float) AS CijenaTok, 
       CAST(CijenaObradaB AS float) AS CijenaGlo, CAST(CijenaObradaC AS float) AS CijenaBus, CAST(CijenaObrada3 AS float) AS CijenaTvrdTok, 
       SUM(KolicinaOK) AS Kolicina, Norma, CAST(SUM(((ObradaA * CijenaObradaA) + (Obrada3 * CijenaObrada3)) * KolicinaOK) AS float) AS IznosTok, 
       CAST(SUM(ObradaB * CijenaObradaB * KolicinaOK) AS float) AS IznosGlo, CAST(SUM(ObradaC * CijenaObradaC * KolicinaOK) AS float) AS IznosBus 
       FROM EvidNormi('2016-05-30', '2016-05-31', 0) WHERE KolicinaOK <> 0 
       GROUP BY Datum, BrojRN, NazivLinije, Linija, Hala, Kupac, NazivPro, Smjena, VrstaNarudzbe, ObradaA, ObradaB, ObradaC, CijenaObradaA, CijenaObradaB, CijenaObradaC, CijenaObrada3, Norma ORDER BY Hala, Linija, VrstaNarudzbe, Smjena 


