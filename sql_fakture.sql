USE FeroApp

SELECT ID_NarZ, ID_Pro, NazivPro, CAST(SUM(KolicinaPro) AS float) AS Kolicina 
	FROM FaktureDetaljnoView 
	WHERE ID_Par = 274 
	AND DatumFakture BETWEEN '2016-09-01' AND '2016-09-30' 
	AND VrstaTroska = 'Proizvod' 
	AND ISNULL(ID_Pro, 0) <> 0 
	AND VrstaFakture LIKE 'Prsten%'
	GROUP BY ID_NarZ, ID_Pro, NazivPro
	ORDER BY NazivPro, ID_NarZ




USE FeroApp

SELECT OrderNo, ID_Par, (SELECT Partneri.NazivPar FROM Partneri WHERE Partneri.ID_Par = TmpJanjic.ID_Par) AS NazivKupca, 
	ISNULL((SELECT SUM(EPS.KolicinaOK) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.Status = 0 AND EPS.ID_EPZ IN(SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN IN(SELECT NarS.BrojRN1 FROM NarudzbeSta NarS WHERE NarS.ID_NarZ = (SELECT NarZ.ID_NarZ FROM NarudzbeZag NarZ WHERE NarZ.OrderNo = TmpJanjic.OrderNo) AND NarS.BazniRN = 1 AND NarS.Isporuceno = 0))), 0) AS SpremnoTok, 
	ISNULL((SELECT SUM(EPS.KolicinaOK) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.Status = 0 AND EPS.ID_EPZ IN(SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN IN(SELECT NarS.BrojRN2 FROM NarudzbeSta NarS WHERE NarS.ID_NarZ = (SELECT NarZ.ID_NarZ FROM NarudzbeZag NarZ WHERE NarZ.OrderNo = TmpJanjic.OrderNo) AND NarS.BazniRN = 1 AND NarS.Isporuceno = 0))), 0) AS SpremnoKalj, 
	ISNULL((SELECT SUM(EPS.KolicinaOK) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.Status = 0 AND EPS.ID_EPZ IN(SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN IN(SELECT NarS.BrojRN3 FROM NarudzbeSta NarS WHERE NarS.ID_NarZ = (SELECT NarZ.ID_NarZ FROM NarudzbeZag NarZ WHERE NarZ.OrderNo = TmpJanjic.OrderNo) AND NarS.BazniRN = 1 AND NarS.Isporuceno = 0))), 0) AS SpremnoTvrdoTok, 
	ISNULL((SELECT SUM(EPS.KolicinaOK) FROM EvidencijaProizvodnjeSta EPS WHERE EPS.Status = 0 AND EPS.ID_EPZ IN(SELECT EPZ.ID_EPZ FROM EvidencijaProizvodnjeZag EPZ WHERE EPZ.BrojRN IN(SELECT NarS.BrojRN4 FROM NarudzbeSta NarS WHERE NarS.ID_NarZ = (SELECT NarZ.ID_NarZ FROM NarudzbeZag NarZ WHERE NarZ.OrderNo = TmpJanjic.OrderNo) AND NarS.BazniRN = 1 AND NarS.Isporuceno = 0))), 0) AS SpremnoBruseno 
	FROM TmpJanjic 
	GROUP BY OrderNo, ID_Par 
	ORDER BY OrderNo
