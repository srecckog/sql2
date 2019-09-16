SELECT @TmpGrupacija AS Grupacija, ID_Pro, (SELECT NazivPro FROM Proizvodi WHERE ID_Pro = StanjeULP_Kn.ID_Pro) AS Proizvod, CAST(SUM(SaldoKolPro) AS Float) AS Kolièina, CAST(SUM(VrijednostPredatnice) AS Float) AS Vrijednost
	FROM StanjeULP_Kn(@TmpDatum, 0) 
	WHERE ID_Skl IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija)
	AND SaldoKolPro <> 0
	GROUP BY ID_Pro
	HAVING SUM(SaldoKolPro) <> 0