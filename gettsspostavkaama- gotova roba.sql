 IF GotovaRoba = 1 Then
                        SQL = "SELECT (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULP_Kn.ID_SKL) AS Grupacija, BrojRN, ID_Pro, NazivPro, VerzijaPro, BrojNacrta, VrstaPro, JM," _
                            & " ISNULL(CijenaObrada1, 0) as CijenaObrada1, BrojRN1, BrojNar1, ISNULL(CijenaObrada2, 0) AS CijenaObrada2, BrojRN2, BrojNar2, isnull(CijenaObrada3, 0) as CijenaObrada3, BrojRN3, BrojNar3, VrstaPakiranja," _
                            & " (CASE WHEN VlasnistvoFX = 1 THEN 'FX' ELSE 'Loan' END) AS Vlasnistvo, CAST(SUM(SaldoKolPro) AS Float) AS Kolicina," _
                            & " CAST(SUM(VrijednostPredatnice) AS Float) AS Vrijednost," _
                            & " (SELECT NazivPar FROM Partneri WHERE ID_Par = StanjeULP_Kn.ID_Par) AS Partneri" _
                        & " FROM StanjeULP_Kn(convert(datetime,'" & Datum & "',104), 0)" _
                        & " WHERE SaldoKolPro <> 0" _
                            & " AND Neaktivno = 0" _
                        & " GROUP BY BrojRN, ID_Pro, NazivPro, VerzijaPro, BrojNacrta, VrstaPro, JM, VlasnistvoFX, ID_Par," _
                            & " CijenaObrada1, BrojRN1, BrojNar1, CijenaObrada2, BrojRN2, BrojNar2, CijenaObrada3, BrojRN3, BrojNar3, VrstaPakiranja, StanjeULP_Kn.ID_SKL" _
                        & " ORDER BY CASE WHEN (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULP_Kn.ID_SKL) IS NULL THEN 'ZZZZZ' ELSE (SELECT Grupacija FROM Skladista WHERE ID_SKL = StanjeULP_Kn.ID_SKL) END, NazivPro"