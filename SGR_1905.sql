use feroapp
SELECT 
      
             Grupacija,
             SUM((CASE WHEN VlasnistvoFX = 1 THEN SaldoKolPro ELSE 0 END)) AS KolicinaFX,
             SUM((CASE WHEN VlasnistvoFX = 1 THEN 0 ELSE 0 END)) AS TezinaFX,
             SUM((CASE WHEN VlasnistvoFX = 0 THEN SaldoKolPro ELSE 0 END)) AS KolicinaLoan,
             SUM((CASE WHEN VlasnistvoFX = 0 THEN 0 ELSE 0 END)) AS TezinaLoan,
             SUM((CASE WHEN VlasnistvoFX = 1 THEN VrijednostPredatnice ELSE 0 END)) AS KnFX,
             SUM((CASE WHEN VlasnistvoFX = 0 THEN VrijednostPredatnice ELSE 0 END)) AS KnLoan
            FROM StanjeULP_Kn_Grupacije('2016-05-19',0)
            WHERE SaldoKolPro <> 0
            AND Neaktivno = 0
            GROUP BY Grupacija
           ORDER BY Grupacija