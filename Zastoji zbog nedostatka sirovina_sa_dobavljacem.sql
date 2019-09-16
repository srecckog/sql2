USE FeroApp;

WITH MyTmpTable AS(
SELECT C.Datum AS Datum, (CASE DATEPART(dw, C.Datum) WHEN 1 THEN 'Ponedjeljak' WHEN 2 THEN 'Utorak' WHEN 3 THEN 'Srijeda' WHEN 4 THEN 'Èetvrtak' WHEN 5 THEN 'Petak' WHEN 6 THEN 'Subota' WHEN 7 THEN 'Nedjelja' ELSE '???' END) AS Dan, 
          (SELECT Partneri.NazivPar FROM Partneri WHERE Partneri.ID_Par = (SELECT NarudzbeZag.ID_Par FROM NarudzbeZag WHERE NarudzbeZag.ID_NarZ = B.ID_NarZ)) AS Kupac, 
          (SELECT Partneri.NazivPar FROM Partneri WHERE Partneri.ID_Par = (SELECT TOP 1 UlazRobeDetaljnoView.ID_Par FROM UlazRobeDetaljnoView WHERE UlazRobeDetaljnoView.ID_MAT = B.ID_Mat AND UlazRobeDetaljnoView.VlasnistvoFX = (CASE WHEN B.LoanPosao = 1 THEN 0 ELSE 1 END) ORDER BY ID_ULR DESC)) AS Dobavljac, 
          C.Hala, C.Smjena AS Smjena, (SELECT Proizvodi.NazivPro FROM Proizvodi WHERE Proizvodi.ID_Pro = B.ID_Pro) AS NazivProizvoda, 
          (CASE WHEN B.Obrada1 = 1 THEN 'Tokarenje' WHEN B.Obrada2 = 1 THEN 'Kaljenje' WHEN B.Obrada3 = 1 THEN 'TvrdoTokarenje' WHEN B.Obrada4 = 1 THEN 'Brušenje' WHEN B.Obrada5 = 1 THEN '???' ELSE 'Tokarenje' END) AS Obrada, 
       A.*, CAST(ISNULL(B.CijenaObrada1, 0) - ISNULL(B.CijenaObrada1B, 0) - ISNULL(B.CijenaObrada1C, 0) AS float) AS TokarenjeEUR, CAST(ISNULL(B.CijenaObrada1B, 0) AS float) AS GlodanjeEUR, CAST(ISNULL(B.CijenaObrada1C, 0) AS float) AS BusenjeEUR, CAST(ISNULL(B.CijenaObrada3, 0) AS float) AS TvrdoTokEUR, 
          CAST(ISNULL(B.CijenaObrada4, 0) AS float) AS BrusenjeEUR 
       FROM EvidencijaNormiSta A 
          INNER JOIN EvidencijaNormiZag C ON A.ID_ENZ = C.ID_ENZ 
          INNER JOIN NarudzbeSta B ON A.BrojRN = B.BrojRN)

SELECT Datum, Dan, Kupac, Dobavljac, Hala, Linija, Radnik, NazivProizvoda, BrojRN, Norma, KolicinaOK, Obrada, ObradaA, ObradaB, ObradaC, TokarenjeEUR, GlodanjeEUR, BusenjeEUR, TvrdoTokEUR, BrusenjeEUR FROM MyTmpTable WHERE TekstCheck15 = 1 AND Datum >= '2016-01-01' AND (CASE WHEN Dan = 'Subota' AND Smjena = 3 THEN 0 ELSE 1 END) = 1 AND Dan <> 'Nedjelja' ORDER BY Datum, Smjena
