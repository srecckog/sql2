USE [FeroApp]
GO
/****** Object:  UserDefinedFunction [dbo].[SumeStatusaEvidPro]    Script Date: 21.10.2016. 10:29:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[SumeStatusaEvidPro] 
(@TmpPrepakiranaStavka tinyint)
RETURNS TABLE 
AS
RETURN
  SELECT (SELECT EvidencijaProizvodnjeZag.BrojRN FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.ID_EPZ = EvidencijaProizvodnjeSta.ID_EPZ) AS BrojRN, 
      (SELECT (CASE WHEN @TmpPrepakiranaStavka IN(9, 0) THEN (CASE WHEN ISNULL(EvidencijaProizvodnjeZag.VrstaPakiranjaSec, '') = '' THEN EvidencijaProizvodnjeZag.VrstaPakiranjaPri ELSE EvidencijaProizvodnjeZag.VrstaPakiranjaSec END) ELSE (CASE WHEN ISNULL(EvidencijaProizvodnjeZag.VrstaPakiranjaPrepak, '') = '' THEN EvidencijaProizvodnjeZag.VrstaPakiranjaPri ELSE EvidencijaProizvodnjeZag.VrstaPakiranjaPrepak END) END) FROM EvidencijaProizvodnjeZag WHERE ID_EPZ = EvidencijaProizvodnjeSta.ID_EPZ) AS VrstaPakiranja,
	  ISNULL(SUM(ISNULL(EvidencijaProizvodnjeSta.KolicinaOK, 0)), 0) AS NapravljenoPro, 
      ISNULL(SUM((CASE WHEN ISNULL(EvidencijaProizvodnjeSta.Status, 0) = 0 THEN ISNULL(EvidencijaProizvodnjeSta.KolicinaOK, 0) ELSE 0 END)), 0) AS SpremnoPro, 
	  ISNULL(SUM((CASE WHEN ISNULL(EvidencijaProizvodnjeSta.Status, 0) = 0 THEN ISNULL(EvidencijaProizvodnjeSta.BrojPakiranja, 0) ELSE 0 END)), 0) AS SpremnoPak, 
      ISNULL(SUM((CASE WHEN EvidencijaProizvodnjeSta.Status = 1 THEN ISNULL(EvidencijaProizvodnjeSta.KolicinaOK, 0) ELSE 0 END)), 0) AS IsporucenoPro, 
	  ISNULL(SUM((CASE WHEN EvidencijaProizvodnjeSta.Status = 1 THEN ISNULL(EvidencijaProizvodnjeSta.BrojPakiranja, 0) ELSE 0 END)), 0) AS IsporucenoPak, 
	  ISNULL(SUM((CASE WHEN EvidencijaProizvodnjeSta.Status = 2 THEN ISNULL(EvidencijaProizvodnjeSta.KolicinaOK, 0) ELSE 0 END)), 0) AS DaljnjaObradaPro, 
	  ISNULL(SUM((CASE WHEN EvidencijaProizvodnjeSta.Status = 2 THEN ISNULL(EvidencijaProizvodnjeSta.BrojPakiranja, 0) ELSE 0 END)), 0) AS DaljnjaObradaPak, 
	  ISNULL(SUM((CASE WHEN EvidencijaProizvodnjeSta.Status = 3 THEN ISNULL(EvidencijaProizvodnjeSta.KolicinaOK, 0) ELSE 0 END)), 0) AS PrepakiravanjePro, 
	  ISNULL(SUM((CASE WHEN EvidencijaProizvodnjeSta.Status = 3 THEN ISNULL(EvidencijaProizvodnjeSta.BrojPakiranja, 0) ELSE 0 END)), 0) AS PrepakiravanjePak, 
	  ISNULL(SUM(ISNULL(OtpadObrada, 0)), 0) AS OtpadObrada, 
	  ISNULL(SUM(ISNULL(OtpadMaterijal, 0)), 0) AS OtpadMaterijal, 
	  ISNULL(SUM(ISNULL(KolicinaUzoraka, 0)), 0) AS KolicinaUzoraka 
    FROM EvidencijaProizvodnjeSta 
	WHERE (CASE WHEN @TmpPrepakiranaStavka = 9 THEN 1 ELSE (CASE WHEN @TmpPrepakiranaStavka = ISNULL(PrepakiranaStavka, 0) THEN 1 ELSE 0 END) END) = 1 
	GROUP BY EvidencijaProizvodnjeSta.ID_EPZ