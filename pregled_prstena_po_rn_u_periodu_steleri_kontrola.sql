USE FeroApp;

WITH MyTmpTable AS(
SELECT NZ.ID_Par, NS.BrojRN, NS.ID_Pro, NS.KolicinaNar, 
       (SELECT SUM(ENS.KolicinaOK) FROM EvidencijaNormiSta ENS WHERE ENS.BrojRN = NS.BrojRN AND ENS.ObradaA = 1) AS KolicinaEN, 
       (SELECT SUM(EPS.KolicinaOK) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.ID_EPZ = (SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN = NS.BrojRN)) AS KolicinaEP 
       FROM NarudzbeSta NS 
             LEFT JOIN NarudzbeZag NZ ON NS.ID_NarZ = NZ.ID_NarZ 
       WHERE NZ.VrstaNar = 'Prsteni'
             AND NS.Obrada1 = 1 
             AND NS.Obrada2 = 0 
             AND NS.Obrada3 = 0 
             AND NS.BazniRN = 1 
             AND NS.DatumIsporuke BETWEEN '2017-01-01' AND '2017-12-31') 

SELECT MTT.ID_Par, (SELECT PAR.NazivPar FROM Partneri PAR WHERE PAR.ID_Par = MTT.ID_Par) AS Kupac, MTT.ID_Pro, 
       (SELECT PRO.NazivPro FROM Proizvodi PRO WHERE PRO.ID_Pro = MTT.ID_Pro) AS 'Naziv proizvoda', 
       CAST(SUM(MTT.KolicinaNar) AS float) AS 'Naruèeno', 
       SUM(MTT.KolicinaEN) AS 'Šteleri', 
       SUM(MTT.KolicinaEP) AS 'Kontrola' 
       FROM MyTmpTable MTT 
       GROUP BY MTT.ID_Pro, MTT.ID_Par LP,
