--Datum: 02.06.2016
--Subject: Zastoji linija zbog nedostatka materijala u ovoj godini  
--Bok Vlado.
--Trebao bih napraviti DETALJNU analizu za ovu godinu, za Schaeffler Austriju, ali da bi to mogao napraviti trebam jedan pametan izvadak iz baze, gdje mi vadi samo bitno i filtrira ostalo smeæe van.
--Uglavnog, trebam za situacije kad je na liniji naštelan Schaeffler Austria proizvod...
--za radne dane (izbaciti subote treæa smjena, nedjelje, blagdane) – možeš li napraviti neki tag/check za te dane pa da ih ja izfiltriram van, ruèno micanje toga je poprilièno zahtjevno?
--Za Schaeffler Austria
--Za situacije kad je oznaèeno „nedostatak materijala“
--U tablici trebam:
--Datum                  Pogon                  Linija                     Djelatnik                             Proizvod                             Radni nalog                        Norma                               Napravljeno                      Vrste obrade                    Cijene obrade
--Molim te, probaj mi da mi ne ispisuje ostale podatke, jer gubim vrijeme na formatiranju toga.
--Tek kad dobijem podatke, moram iæi od stavke do stavke i filtrirati po drugim kriterijima o èemu se radi, tj. da li svaka stavka opravdano u tablici, tako da bi trebao za poèetak što manje smeæa u ovim podacima.


USE FeroApp;
 
WITH MyTmpTable AS(
SELECT C.Datum AS Datum, 
(CASE DATEPART(dw, C.Datum) WHEN 1 THEN 'Ponedjeljak' WHEN 2 THEN 'Utorak' WHEN 3 THEN 'Srijeda' WHEN 4 THEN 'Èetvrtak' WHEN 5 THEN 'Petak' WHEN 6 THEN 'Subota' WHEN 7 THEN 'Nedjelja' ELSE '???' END) AS Dan,
(SELECT Partneri.NazivPar FROM Partneri WHERE Partneri.ID_Par = (SELECT NarudzbeZag.ID_Par FROM NarudzbeZag WHERE NarudzbeZag.ID_NarZ = B.ID_NarZ)) AS Kupac,
 C.Hala, 
 C.Smjena AS Smjena, 
 (SELECT Proizvodi.NazivPro FROM Proizvodi WHERE Proizvodi.ID_Pro = B.ID_Pro) AS NazivProizvoda,
 (CASE WHEN B.Obrada1 = 1 THEN 'Tokarenje' WHEN B.Obrada2 = 1 THEN 'Kaljenje' WHEN B.Obrada3 = 1 THEN 'TvrdoTokarenje' WHEN B.Obrada4 = 1 THEN 'Brušenje' WHEN B.Obrada5 = 1 THEN '???' ELSE 'Tokarenje' END) AS Obrada,
 A.*, 
 CAST(ISNULL(B.CijenaObrada1, 0) - ISNULL(B.CijenaObrada1B, 0) - ISNULL(B.CijenaObrada1C, 0) AS float) AS TokarenjeEUR,
 CAST(ISNULL(B.CijenaObrada1B, 0) AS float) AS GlodanjeEUR, CAST(ISNULL(B.CijenaObrada1C, 0) AS float) AS BusenjeEUR, 
 CAST(ISNULL(B.CijenaObrada3, 0) AS float) AS TvrdoTokEUR,
 CAST(ISNULL(B.CijenaObrada4, 0) AS float) AS BrusenjeEUR

 FROM EvidencijaNormiSta A
 INNER JOIN EvidencijaNormiZag C ON A.ID_ENZ = C.ID_ENZ
 INNER JOIN NarudzbeSta B ON A.BrojRN = B.BrojRN)
 
SELECT Datum, Dan, Kupac, Hala, Linija, Radnik, NazivProizvoda, BrojRN, Norma, KolicinaOK, Obrada, ObradaA, ObradaB, ObradaC, TokarenjeEUR, GlodanjeEUR, BusenjeEUR, TvrdoTokEUR, BrusenjeEUR 
FROM MyTmpTable 
WHERE TekstCheck15 = 1 AND Datum >= '2016-01-01' AND (CASE WHEN Dan = 'Subota' AND Smjena = 3 THEN 0 ELSE 1 END) = 1 AND Dan <> 'Nedjelja' 
ORDER BY Datum, Smjena
