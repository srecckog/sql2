-- Ulaz repra
use feroapp
SELECT VrstaDokumenta, BrojDokumenta, DatumDokumenta, DatumUlaza, ID_SKL, (CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Kupac' END) AS Vlasnistvo, ID_MAT, NazivMat, CAST(KolicinaDokument AS float) AS Kolicina 
       FROM UlazRobeDetaljnoView 
       WHERE ID_MAT = 920258 
             AND VrstaUR = 'UlazULR' 
             AND DatumUlaza >= '2017-01-01'

-- Kontrola
use feroapp
SELECT BrojRN, (SELECT PRO.NazivPro FROM Proizvodi PRO WHERE PRO.ID_Pro = (SELECT NS.ID_Pro FROM NarudzbeSta NS WHERE NS.BrojRN = EPV.BrojRN)) AS Pozicija, SUM(KolicinaOK) AS Kolicina, SUM(OtpadMaterijal) AS OtpadMat, SUM(OtpadObrada) AS OtpadObrada 
       FROM EvidencijaProizvodnjeView EPV 
       WHERE EPV.BrojRN IN(SELECT NS.BrojRN FROM NarudzbeSta NS WHERE NS.ID_Mat = 920258) 
             AND EPV.Datum >= '2017-01-01' 
       GROUP BY BrojRN 
