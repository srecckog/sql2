USE FeroApp ; DECLARE @TmpGrupacija varchar(50), @TmpDatum date 
SET @TmpGrupacija = 'SCHAEFFLER AUSTRIA'
SET @TmpDatum = '2017-12-30'

SELECT *
	FROM StanjeULR_Kn(@TmpDatum) 
	WHERE ID_SKL IN(103,145,303,400,22 )
	AND SaldoKolicina <> 0
	AND VrstaUR <> 'Povrat'
	--and id_mat=274006
	--GROUP BY ID_MAT
	order by id_skl,id_mat,datumulaza
	--HAVING SUM(SaldoKolicina) <> 0




SELECT @TmpGrupacija AS Grupacija, ID_MAT, (SELECT NazivMat FROM Materijali WHERE ID_MAT = StanjeULR_Kn.ID_MAT) AS Materijal, CAST(SUM(SaldoKolicina) AS Float) AS Kolièina, CAST(SUM(Vrijednost) AS Float) AS Vrijednost 
	FROM StanjeULR_Kn(@TmpDatum) 
	WHERE ID_SKL IN(SELECT ID_SKL FROM Skladista WHERE Grupacija = @TmpGrupacija) 
	AND SaldoKolicina <> 0
	AND VrstaUR <> 'Povrat'
	GROUP BY ID_MAT
	HAVING SUM(SaldoKolicina) <> 0