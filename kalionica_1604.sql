use feroapp
select * from( select top 5000 count(*) broj, sarza,x1.materijal,x1.vrstakt,x1.podvrstakt, x1.pec, x1.toplinskaobrada 
from ( 
SELECT ksa.id_ktz,kzag.pec,kzag.BrojSarze as sarza,kzag.tvrdomjer, 
ksa.KratkiNaziv,kkn.Materijal,kkn.C_D,kkn.QM,kkn.toplinskaobrada,ksa.Kolicina,ksa.VrstaKT,ksa.PodvrstaKT ,kzag.BrojPeciKaljenje,kzag.BrojPeciPopustanje ,
ksa.Tvrdoca ,ksa.DatumUnosa,ksa.VrijemeUnosa ,ksa.UserName, 
case when DATEPART(HOUR, ksa.vrijemeunosa) >=6 and  DATEPART(HOUR, ksa.vrijemeunosa) <=13 then 1 when  DATEPART(HOUR, ksa.vrijemeunosa) >=14 and  DATEPART(HOUR, ksa.vrijemeunosa) <=21 then 2 when  ( DATEPART(HOUR, ksa.vrijemeunosa) >=22  or  DATEPART(HOUR, ksa.vrijemeunosa) <=5) then 3 end smjena 
FROM KalionicaTvrdoceSta ksa 
left join KalionicaTvrdoceZag kzag on ksa.ID_KTZ=kzag.ID_KTZ 
left join KalionicaKratkiNazivi kkn on kkn.KratkiNaziv=ksa.KratkiNaziv 
WHERE datumunosa>= '2016-07-10' 
) x1 
 group by x1.sarza,x1.pec,x1.vrstakt,x1.podvrstakt,x1.materijal,x1.toplinskaobrada 
 order by x1.pec,x1.materijal,x1.vrstakt,x1.podvrstakt 
 ) x2 
 where (vrstakt='Popustanje' and broj!=6)  or ( vrstakt='Kaljenje' and podvrstakt ='rub' and broj<>3) or ( vrstakt='Kaljenje' and podvrstakt ='jezgra' and broj<>1 ) 
 order by sarza 


 -- težine proizvoda
 select distinct proizvod,replace(cast(tezinaprokom as varchar),'.',',') tezina
 from (
SELECT *, (SELECT VrstaNar FROM NarudzbeZag WHERE ID_NarZ = (SELECT ID_NarZ FROM NarudzbeSta WHERE BrojRN = (SELECT BrojRN FROM EvidencijaProizvodnjeZag WHERE ID_EPZ = EvidencijaProizvodnjeView.ID_EPZ))) AS VrstaProizvoda, 
(SELECT BrojRN FROM EvidencijaProizvodnjeZag WHERE ID_EPZ = EvidencijaProizvodnjeView.ID_EPZ) AS RN, ISNULL((SELECT CijenaObrada2 FROM NarudzbeSta WHERE BrojRN = (SELECT BrojRN FROM EvidencijaProizvodnjeZag WHERE ID_EPZ = EvidencijaProizvodnjeView.ID_EPZ)), 0) AS CijenaKaljenjaKom, 
(SELECT NazivPro FROM Proizvodi WHERE ID_Pro = (SELECT ID_Pro FROM NarudzbeSta WHERE BrojRN = (SELECT BrojRN FROM EvidencijaProizvodnjeZag WHERE ID_EPZ = EvidencijaProizvodnjeView.ID_EPZ))) AS Proizvod, 
ISNULL((SELECT TezinaPro FROM Proizvodi WHERE ID_Pro = (SELECT ID_Pro FROM NarudzbeSta WHERE BrojRN = (SELECT BrojRN FROM EvidencijaProizvodnjeZag WHERE ID_EPZ = EvidencijaProizvodnjeView.ID_EPZ))), 0) AS TezinaProKom 
FROM EvidencijaProizvodnjeView 
WHERE Datum >= '2018-01-01'
AND Linija = 'TO' ) x1


