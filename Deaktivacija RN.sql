USE FeroApp; 

WITH MyTmpTable1 AS(
SELECT ID_NarS, VrstaNar, BaznaObrada, ZavrsnaObrada, RN_Tokarenje, RN_Kaljenje, RN_TvrdoTokarenje, 
	(CASE StanjeProizvodnjeList.ZavrsnaObrada WHEN 'Brusenje' THEN RN_Brusenje WHEN 'Tvrdo tokarenje' THEN RN_TvrdoTokarenje WHEN 'Kaljenje' THEN RN_Kaljenje ELSE RN_Tokarenje END) AS ZavrsniRN, 
	SpremnoT_Pro, SpremnoK_Pro, SpremnoTT_Pro, SpremnoBR_Pro, 
	(SELECT MAX(EvidencijaProizvodnjeView.Datum) FROM EvidencijaProizvodnjeView WHERE EvidencijaProizvodnjeView.BrojRN = (CASE StanjeProizvodnjeList.ZavrsnaObrada WHEN 'Brusenje' THEN RN_Brusenje WHEN 'Tvrdo tokarenje' THEN RN_TvrdoTokarenje WHEN 'Kaljenje' THEN RN_Kaljenje ELSE RN_Tokarenje END)) AS DatumZadnjeObrade 
	FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno') 
	WHERE (NapravljenoT_Pro + NapravljenoK_Pro + NapravljenoTT_Pro + NapravljenoBR_Pro) > 0
	AND (SpremnoT_Pro + SpremnoK_Pro + SpremnoTT_Pro + SpremnoBR_Pro) = 0) 

SELECT DATEDIFF(DAY,  DatumZadnjeObrade, GETDATE()) AS DanaOdZadnjeObrade, * FROM MyTmpTable1 WHERE DatumZadnjeObrade IS NOT NULL AND DATEDIFF(DAY,  DatumZadnjeObrade, GETDATE()) > 20 ORDER BY DatumZadnjeObrade


/*SELECT * FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno') 
	WHERE BaznaObrada = 'Tokarenje' 
	AND NapravljenoT_Pro > 0 
	AND (CASE ZavrsnaObrada WHEN 'Tokarenje' THEN IsporucenoT_Pro WHEN 'Kaljenje' THEN IsporucenoK_Pro WHEN 'Tvrdo tokarenje' THEN IsporucenoT_Pro WHEN 'Brusenje' THEN IsporucenoBR_Pro ELSE 0 END) >= KolicinaNar
	AND (SpremnoT_Pro + SpremnoK_Pro + SpremnoTT_Pro + SpremnoBR_Pro) = 0*/