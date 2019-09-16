USE FeroApp;

WITH MyTmpTable AS(
SELECT FS.ID_Mat, FS.ID_Pro, CAST((SELECT Materijali.OmjerPro FROM Materijali WHERE Materijali.ID_Mat = FS.ID_Mat) AS float) AS OmjerMatPro, 
	CAST(FS.CijenaMatKom AS float) AS CijenaMat, CAST(FS.CijenaProKom AS float) AS CijenaPro, CAST((FS.CijenaObrada1 * FS.Obrada1) AS float) AS Tokarenje, CAST((FS.CijenaObrada2 * FS.Obrada2) AS float) AS Kaljenje, CAST(KolicinaPro AS float) AS KolicinaPro 
	FROM FaktureSta FS 
	WHERE FS.ID_FZ IN(SELECT FaktureZag.ID_FZ FROM FaktureZag WHERE FaktureZag.DatumFakture BETWEEN '2016-07-01' AND '2016-09-30') 
	AND FS.ID_Pro_Kup IN('083478639-0000','083478647-0000','083478485-0000','083478493-0000','083478116-0000','083478124-0000','083478027-0000','085474070-0000','085607070-0000','085607479-0000','076821307-0000','086167995-0000','086168002-0000')
	AND FS.VrstaTroska = 'Proizvod')

SELECT MTT.ID_Mat, Materijali.ID_Mat_Dob, Materijali.NazivMat, MTT.ID_Pro, Proizvodi.ID_Pro_Kup, Proizvodi.NazivPro, MTT.OmjerMatPro, MTT.CijenaMat, MTT.CijenaPro, MTT.Tokarenje, MTT.Kaljenje, SUM(MTT.KolicinaPro) AS KolicinaPro 
	FROM MyTmpTable MTT
		LEFT JOIN Materijali ON MTT.ID_Mat = Materijali.ID_Mat 
		LEFT JOIN Proizvodi ON MTT.ID_Pro = Proizvodi.ID_Pro 
	GROUP BY MTT.ID_Mat, MTT.ID_Pro, MTT.OmjerMatPro, MTT.CijenaMat, MTT.CijenaPro, MTT.Tokarenje, MTT.Kaljenje, Materijali.NazivMat, Materijali.ID_Mat_Dob, Proizvodi.ID_Pro_Kup, Proizvodi.NazivPro 
	ORDER BY MTT.ID_Pro, MTT.ID_Mat, MTT.CijenaMat, MTT.CijenaPro