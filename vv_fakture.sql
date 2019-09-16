USE FeroApp

-- SELECT * FROM FaktureZag WHERE DatumFakture = '2016-11-02'
SELECT ID_Pro, NazivPro, CAST(ISNULL(CijenaMatKom, 0) AS float) AS CijenaMatKom, CAST((SELECT ISNULL(MC.BaznaCijenaMat, 0) FROM MaterijaliCijene MC WHERE MC.ID_Mat = FaktureSta.ID_Mat AND MC.Godina = 2016 AND MC.Kvartal = 4) AS float) AS CijenaMatCjenik, 
	CAST(ISNULL(Obrada1 * CijenaObrada1, 0) AS float) AS Tokarenje, CAST(ISNULL(Obrada2 * CijenaObrada2, 0) AS float) AS Kaljenje, CAST(ISNULL(Obrada3 * CijenaObrada3, 0) AS float) AS TvrdoTok, CAST(ISNULL(Obrada4 * CijenaObrada4, 0) AS float) AS Brusenje, 
	CAST(CijenaProKom AS float) AS CijenaProKom 
	FROM FaktureSta 
	WHERE ID_FZ IN(14427, 14428) 
	AND VrstaTroska = 'Proizvod'