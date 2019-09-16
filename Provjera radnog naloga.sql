  

    SELECT  NarudzbeSta.ID_NarS, NarudzbeSta.BazniRN, NarudzbeSta.Obrada1, NarudzbeSta.BrojRN1, NarudzbeSta.Obrada2, NarudzbeSta.BrojRN2, NarudzbeSta.BrojRN, CAST(NarudzbeSta.KolicinaNar AS float) AS NarucenaKolicina,
            (SELECT Proizvodi.NazivPro FROM  Proizvodi WHERE Proizvodi.ID_Pro = NarudzbeSta.ID_Pro) AS NazivPro,
            (SELECT ISNULL(SUM(ISNULL(KolicinaOK, 0)), 0) AS Kolicina FROM EvidencijaProizvodnjeSta WHERE EvidencijaProizvodnjeSta.ID_EPZ = (SELECT EvidencijaProizvodnjeZag.ID_EPZ FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = NarudzbeSta.BrojRN2) AND DATEDIFF(day, DatumUnosa, '06/28/2016') < 2 AND (CASE WHEN DatumUnosa =  '06/29/2016' AND VrijemeUnosa <= '6:00' THEN 1 WHEN DatumUnosa < '06/28/2016' AND VrijemeUnosa > '06:00' THEN 1 ELSE 0 END) = 1) AS Zakaljeno_u_zadnja_24h,
            ISNULL((SELECT SUM(ISNULL(EvidencijaProizvodnjeSta.KolicinaOK, 0)) FROM EvidencijaProizvodnjeSta WHERE EvidencijaProizvodnjeSta.ID_EPZ = (SELECT EvidencijaProizvodnjeZag.ID_EPZ FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = '2730/2016') AND EvidencijaProizvodnjeSta.Status = 1), 0) AS IsporucenoTokraeno,
            ISNULL((SELECT SUM(ISNULL(Kolicina, 0)) FROM KalionicaKnjigaSmjeneSta WHERE BrojRN = '2730/2016'), 0) AS ZakaljenoKnjigaSmjene          
		    (SELECT SUM(ISNULL(KalionicaKnjigaSmjeneSta.Kolicina, 0)) FROM KalionicaKnjigaSmjeneSta WHERE KalionicaKnjigaSmjeneSta.BrojRN = '2730/2016' AND KalionicaKnjigaSmjeneSta.ID_KKSZ IN(SELECT KalionicaKnjigaSmjeneZag.ID_KKSZ FROM KalionicaKnjigaSmjeneZag WHERE KalionicaKnjigaSmjeneZag.Datum BETWEEN '06/28/2016' and '06/29/2016')) AS Zakaljeno_u_periodu            
			(SELECT ISNULL(SUM(ISNULL(KolicinaOK, 0)), 0) AS Kolicina FROM EvidencijaProizvodnjeSta WHERE EvidencijaProizvodnjeSta.ID_EPZ = (SELECT EvidencijaProizvodnjeZag.ID_EPZ FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = NarudzbeSta.BrojRN1)) AS Tokareno_sveukupno 
            FROM NarudzbeSta
            WHERE NarudzbeSta.BrojRN =  '2730/2016'




			 		--(SELECT ISNULL(SUM(ISNULL(KolicinaOK, 0)), 0) AS Kolicina FROM EvidencijaProizvodnjeSta WHERE EvidencijaProizvodnjeSta.ID_EPZ = (SELECT EvidencijaProizvodnjeZag.ID_EPZ FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = NarudzbeSta.BrojRN1)) 
					--FROM NarudzbeSta
                    --WHERE NarudzbeSta.BrojRN =  '2730/2016'


					select *
					from KalionicaKnjigaSmjeneSta
					where brojrn = '2179/2016'
					

					select sum(kolicinaok)
					from EvidencijaProizvodnjesta where id_epz=
					(SELECT id_epz
					FROM EvidencijaProizvodnjeZag
					where brojrn ='2181/2016')

