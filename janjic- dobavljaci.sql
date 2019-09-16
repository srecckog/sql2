 SELECT (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULP_Kn.ID_SKL) AS Grupacija, BrojRN, ID_Pro, NazivPro, VerzijaPro, BrojNacrta, VrstaPro, JM,
 ISNULL(CijenaObrada1, 0) as CijenaObrada1, BrojRN1, BrojNar1, ISNULL(CijenaObrada2, 0) AS CijenaObrada2, BrojRN2, BrojNar2, isnull(CijenaObrada3, 0) as CijenaObrada3, BrojRN3, BrojNar3, VrstaPakiranja,
 (CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Loan' END) AS Vlasnistvo, CAST(SUM(SaldoKolPro) AS Float) AS Kolicina,
 CAST(SUM(VrijednostPredatnice) AS Float) AS Vrijednost,
 (SELECT NazivPar FROM Partneri WHERE ID_Par = StanjeULP_Kn.ID_Par) AS Partneri

 FROM StanjeULP_Kn('2016-07-07', 0)
 WHERE SaldoKolPro <> 0
 AND Neaktivno = 0
 GROUP BY BrojRN, ID_Pro, NazivPro, VerzijaPro, BrojNacrta, VrstaPro, JM, VlasnistvoFX, ID_Par,
 CijenaObrada1, BrojRN1, BrojNar1, CijenaObrada2, BrojRN2, BrojNar2, CijenaObrada3, BrojRN3, BrojNar3, VrstaPakiranja, StanjeULP_Kn.ID_SKL
 ORDER BY CASE WHEN (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULP_Kn.ID_SKL) IS NULL THEN 'ZZZZZ' ELSE (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULP_Kn.ID_SKL) END, NazivPro


 select *
 from evidnormi('2016-06-01','2016-07-10',0)
 where orderno = 5129832

 where nazivpro like '%F-565314-0124.IR.TR2I-W220-W240F-HLA%'





 select *
 FROM StanjeULP_Kn('2016-07-07', 0)
 --where nazivpro like '%F-565314-0124.IR.TR2I-W220-W240F-HLA%'


