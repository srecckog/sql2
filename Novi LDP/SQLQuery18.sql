SELECT *, (SELECT VrstaNar FROM NarudzbeZag WHERE ID_NarZ = (SELECT ID_NarZ FROM NarudzbeSta WHERE BrojRN = (SELECT BrojRN FROM EvidencijaProizvodnjeZag WHERE ID_EPZ = EvidencijaProizvodnjeView.ID_EPZ))) AS VrstaProizvoda, 
(SELECT BrojRN FROM EvidencijaProizvodnjeZag WHERE ID_EPZ = EvidencijaProizvodnjeView.ID_EPZ) AS RN, ISNULL((SELECT CijenaObrada2 FROM NarudzbeSta WHERE BrojRN = (SELECT BrojRN FROM EvidencijaProizvodnjeZag WHERE ID_EPZ = EvidencijaProizvodnjeView.ID_EPZ)), 0) AS CijenaKaljenjaKom, 
(SELECT NazivPro FROM Proizvodi WHERE ID_Pro = (SELECT ID_Pro FROM NarudzbeSta WHERE BrojRN = (SELECT BrojRN FROM EvidencijaProizvodnjeZag WHERE ID_EPZ = EvidencijaProizvodnjeView.ID_EPZ))) AS Proizvod, 
ISNULL((SELECT TezinaPro FROM Proizvodi WHERE ID_Pro = (SELECT ID_Pro FROM NarudzbeSta WHERE BrojRN = (SELECT BrojRN FROM EvidencijaProizvodnjeZag WHERE ID_EPZ = EvidencijaProizvodnjeView.ID_EPZ))), 0) AS TezinaProKom 
FROM EvidencijaProizvodnjeView 
WHERE Datum = '2017-07-25' 
AND Linija = 'TO'



-- list dnevne proizvodnje excel
SELECT PEC,SUM(KOLICINA) komada,SUM(KOLICINA*TEZINAPROKOM) tezina
FROM (
select x3.pec,x3.kratkinaziv,x3.radnik,x3.TezinaProKom,x3.Smjena,sum(x3.Kolicina-x3.KrivuljaRezanje) as kolicina 
from (select x1.Datum,x1.ID_Radnika,x1.NapomenaCodere,x1.NapomenaSolo,x1.Radnik,x1.Smjena,x2.* from ( 
SELECT [ID_KKSZ],[Datum] ,[Smjena] ,[ID_Radnika] ,[Radnik] ,[NapomenaCodere] ,[NapomenaSolo]  FROM [FeroApp].[dbo].[KalionicaKnjigaSmjeneZag] 
WHERE DATUM='2017-07-25' ) x1 
left join [FeroApp].[dbo].[KalionicaKnjigaSmjenesta] as x2  on x1.id_kksz=x2.ID_KKSZ ) x3 
group by x3.pec,x3.kratkinaziv,x3.smjena,x3.TezinaProKom,x3.radnik 
) X1
GROUP BY PEC


order by x3.pec,x3.kratkinaziv,x3.smjena