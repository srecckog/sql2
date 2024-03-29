/****** Script for SelectTopNRows command from SSMS  ******/
use feroapp
SELECT s.datum Datum, p.nazivpro Naziv_proizvoda,s.kolicinaok KolicinaOk,s.brojsarze Broj_šarže,s.otpadobrada Otpad_obrada,s.otpadmaterijal Otpad_materijal, z.brojrn
  FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z
left join [dbo].[EvidencijaProizvodnjeSta] s on z.ID_EPZ=s.id_epz
left join narudzbesta n on n.brojrn=z.brojrn
left join proizvodi p on p.id_pro=n.id_pro
where linija='TO' and year(datum)>=2018
and (otpadobrada>0 or otpadmaterijal>0)
order by datum

SELECT s.datum Datum, s.kolicinaok KolicinaOk,s.brojsarze Broj_šarže,s.otpadobrada Otpad_obrada,s.otpadmaterijal Otpad_materijal,z.brojrn
  FROM [FeroApp].[dbo].[EvidencijaProizvodnjeZag] z
left join [dbo].[EvidencijaProizvodnjeSta] s on z.ID_EPZ=s.id_epz
where brojrn='3482/2014'

USE FeroApp;
WITH MyTmpTable AS(
SELECT (SELECT KKSZ.Datum FROM KalionicaKnjigaSmjeneZag KKSZ WHERE KKSZ.ID_KKSZ = KKSS.ID_KKSZ) AS Datum, KKSS.KratkiNaziv, CAST(KKSS.QM AS float) AS QM, CAST(KKSS.C_D AS float) AS CD, KKSS.Materijal, KKSS.Pec, KKSS.BrojRN, KKSS.BrojSarze, KKSS.Kolicina, 
       (SELECT (CASE WHEN MAT.OmjerPro = 2 THEN 'TURM' ELSE '-' END) FROM Materijali MAT WHERE MAT.ID_Mat = (SELECT NS.ID_Mat FROM NarudzbeSta NS WHERE NS.BrojRN = KKSS.BrojRN)) AS TURM 
       FROM KalionicaKnjigaSmjeneSta KKSS 
       WHERE KKSS.KratkiNaziv IN('AR.800792.04.W220','AR.800792.10.W220','JR.565314/2.W220','JR.566425/2.W220','JR.800792AB/1.W220','JR.800792AB/2.W220','JR.800792AE/1.W220','JR.800792AE/2.W220','JR.800792D/1.W220','JR.800792D/2.W220','JR.F-565314/1.W220','JR.F-565314/2.W220','JR.F-566425/1.W220','JR.F-566425/2.W220')
             AND KKSS.ID_KKSZ IN(SELECT KKSZ.ID_KKSZ FROM KalionicaKnjigaSmjeneZag KKSZ WHERE KKSZ.Datum >= '2016-01-01'))          

SELECT Datum, KratkiNaziv, BrojRN, SUM(Kolicina) AS Kolicina, COUNT(DISTINCT BrojSarze) AS '# šarži', TURM FROM MyTmpTable 
       GROUP BY Datum, KratkiNaziv, BrojRN, TURM
