USE [FeroApp]
GO
/****** Object:  UserDefinedFunction [dbo].[StanjeProizvodnjeListPrepak]    Script Date: 21.10.2016. 9:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[StanjeProizvodnjeListPrepak] 
(@VrstaNarudzbe varchar(20), @VrstaStatusa varchar(20), @TmpPrepakiranaStavka tinyint)
RETURNS TABLE 
AS
RETURN
  SELECT NarS_A.ID_NarS, NarudzbeZag.VrstaNar, NarS_A.Aktivno, NarS_A.Isporuceno, NarudzbeZag.OrderNo, NarudzbeZag.DatumNarudzbe, VrsteNarudzbi.RnZaCalcKolicine, NarS_A.BrojRN AS Bazni_RN, CAST(NarS_A.KolicinaNar AS Float) AS KolicinaNar, (SELECT NarS_A.ID_Mat) AS ID_Mat, 
    CAST((SELECT (CASE WHEN ISNULL(Materijali.OmjerPro, 0) = 0 THEN 1 ELSE Materijali.OmjerPro END) FROM Materijali WHERE Materijali.ID_Mat = NarS_A.ID_Mat) AS float) AS OmjerPro, Proizvodi.PodvrstaPro, 
    (CASE WHEN NarS_A.Obrada5 = 1 THEN NarS_A.BrojRN5 WHEN NarS_A.Obrada4 = 1 THEN NarS_A.BrojRN4 WHEN NarS_A.Obrada3 = 1 THEN NarS_A.BrojRN3 WHEN NarS_A.Obrada2 = 1 THEN NarS_A.BrojRN2 ELSE NarS_A.BrojRN END) AS Zavrsni_RN, 
    NarudzbeZag.ID_Par, (SELECT Partneri.NazivPar FROM Partneri WHERE Partneri.ID_Par = NarudzbeZag.ID_Par) AS Narucitelj, (CASE WHEN NarS_A.LoanPosao = 1 THEN 0 ELSE 1 END) AS VlasnistvoFX, NarS_A.DatumIsporuke, 
    (CASE WHEN NarS_A.Obrada1 = 1 THEN 'Tokarenje' WHEN NarS_A.Obrada2 = 1 THEN 'Kaljenje' WHEN NarS_A.Obrada3 = 1 THEN 'Tvrdo tokarenje' WHEN NarS_A.Obrada4 = 1 THEN 'Brusenje' WHEN NarS_A.Obrada5 = 1 THEN 'Obrada #5' ELSE 'Tokarenje' END) AS BaznaObrada, 
    (CASE WHEN NarS_A.Obrada5 = 1 THEN 'Obrada #5' WHEN NarS_A.Obrada4 = 1 THEN 'Brusenje' WHEN NarS_A.Obrada3 = 1 THEN 'Tvrdo tokarenje' WHEN NarS_A.Obrada2 = 1 THEN 'Kaljenje' ELSE 'Tokarenje' END) AS ZavrsnaObrada, 
    (CASE WHEN VrsteNarudzbi.RnZaCalcKolicine = 'Bazni' THEN NarS_A.BrojRN ELSE ISNULL(NarS_A.BrojRN1, '') END) AS RN_Tokarenje, ISNULL((CASE WHEN VrsteNarudzbi.RnZaCalcKolicine = 'Bazni' THEN NarS_A.ID_Pro ELSE (SELECT NarS_B.ID_Pro FROM NarudzbeSta NarS_B WHERE NarS_B.BrojRN = NarS_A.BrojRN1) END), 0) AS ID_Pro_T, 
    ISNULL(Func1.NapravljenoPro, 0) AS NapravljenoT_Pro, ISNULL(Func1.SpremnoPro, 0) AS SpremnoT_Pro, ISNULL(Func1.SpremnoPak, 0) AS SpremnoT_Pak, ISNULL(Func1.OtpadObrada, 0) AS OtpadPro_T, ISNULL(Func1.OtpadMaterijal, 0) AS OtpadMat_T, ISNULL(Func1.KolicinaUzoraka, 0) AS KolicinaUzoraka_T, 
    ISNULL(Func1.IsporucenoPro, 0) AS IsporucenoT_Pro, ISNULL(Func1.IsporucenoPak, 0) AS IsporucenoT_Pak, ISNULL(Func1.DaljnjaObradaPro, 0) AS DaljnjaObradaT_Pro, ISNULL(Func1.DaljnjaObradaPak, 0) AS DaljnjaObradaT_Pak, ISNULL(Func1.PrepakiravanjePro, 0) AS PrepakiravanjeT_Pro, ISNULL(Func1.PrepakiravanjePak, 0) AS PrepakiravanjeT_Pak, 
    ISNULL(Func1.VrstaPakiranja, '') AS PakiranjeT_Pro, CAST(ISNULL((SELECT Pakiranja.TezinaPakiranja FROM Pakiranja WHERE Pakiranja.VrstaPakiranja = Func1.VrstaPakiranja), 0) AS float) AS PakiranjeT_kg, 
    ISNULL(NarS_A.BrojRN2, '') AS RN_Kaljenje, ISNULL((SELECT NarS_B.ID_Pro FROM NarudzbeSta NarS_B WHERE NarS_B.BrojRN = NarS_A.BrojRN2), 0) AS ID_Pro_K, 
    ISNULL(Func2.NapravljenoPro, 0) AS NapravljenoK_Pro, ISNULL(Func2.SpremnoPro, 0) AS SpremnoK_Pro, ISNULL(Func2.SpremnoPak, 0) AS SpremnoK_Pak, ISNULL(Func2.OtpadObrada, 0) AS OtpadPro_K, ISNULL(Func2.OtpadMaterijal, 0) AS OtpadMat_K, ISNULL(Func2.KolicinaUzoraka, 0) AS KolicinaUzoraka_K, 
    ISNULL(Func2.IsporucenoPro, 0) AS IsporucenoK_Pro, ISNULL(Func2.IsporucenoPak, 0) AS IsporucenoK_Pak, ISNULL(Func2.DaljnjaObradaPro, 0) AS DaljnjaObradaK_Pro, ISNULL(Func2.DaljnjaObradaPak, 0) AS DaljnjaObradaK_Pak, ISNULL(Func2.PrepakiravanjePro, 0) AS PrepakiravanjeK_Pro, ISNULL(Func2.PrepakiravanjePak, 0) AS PrepakiravanjeK_Pak, 
    ISNULL(Func2.VrstaPakiranja, '') AS PakiranjeK_Pro, CAST(ISNULL((SELECT Pakiranja.TezinaPakiranja FROM Pakiranja WHERE Pakiranja.VrstaPakiranja = Func2.VrstaPakiranja), 0) AS float) AS PakiranjeK_kg, 
    ISNULL(NarS_A.BrojRN3, '') AS RN_TvrdoTokarenje, ISNULL((SELECT NarS_B.ID_Pro FROM NarudzbeSta NarS_B WHERE NarS_B.BrojRN = NarS_A.BrojRN3), 0) AS ID_Pro_TT, 
    ISNULL(Func3.NapravljenoPro, 0) AS NapravljenoTT_Pro, ISNULL(Func3.SpremnoPro, 0) AS SpremnoTT_Pro, ISNULL(Func3.SpremnoPak, 0) AS SpremnoTT_Pak, ISNULL(Func3.OtpadObrada, 0) AS OtpadPro_TT, ISNULL(Func3.OtpadMaterijal, 0) AS OtpadMat_TT, ISNULL(Func3.KolicinaUzoraka, 0) AS KolicinaUzoraka_TT, 
    ISNULL(Func3.IsporucenoPro, 0) AS IsporucenoTT_Pro, ISNULL(Func3.IsporucenoPak, 0) AS IsporucenoTT_Pak, ISNULL(Func3.DaljnjaObradaPro, 0) AS DaljnjaObradaTT_Pro, ISNULL(Func3.DaljnjaObradaPak, 0) AS DaljnjaObradaTT_Pak, ISNULL(Func3.PrepakiravanjePro, 0) AS PrepakiravanjeTT_Pro, ISNULL(Func3.PrepakiravanjePak, 0) AS PrepakiravanjeTT_Pak, 
    ISNULL(Func3.VrstaPakiranja, '') AS PakiranjeTT_Pro, CAST(ISNULL((SELECT Pakiranja.TezinaPakiranja FROM Pakiranja WHERE Pakiranja.VrstaPakiranja = Func3.VrstaPakiranja), 0) AS float) AS PakiranjeTT_kg, 
    ISNULL(NarS_A.BrojRN4, '') AS RN_Brusenje, ISNULL((SELECT NarS_B.ID_Pro FROM NarudzbeSta NarS_B WHERE NarS_B.BrojRN = NarS_A.BrojRN4), 0) AS ID_Pro_BR, 
    ISNULL(Func4.NapravljenoPro, 0) AS NapravljenoBR_Pro, ISNULL(Func4.SpremnoPro, 0) AS SpremnoBR_Pro, ISNULL(Func4.SpremnoPak, 0) AS SpremnoBR_Pak, ISNULL(Func4.OtpadObrada, 0) AS OtpadPro_BR, ISNULL(Func4.OtpadMaterijal, 0) AS OtpadMat_BR, ISNULL(Func4.KolicinaUzoraka, 0) AS KolicinaUzoraka_BR, 
    ISNULL(Func4.IsporucenoPro, 0) AS IsporucenoBR_Pro, ISNULL(Func4.IsporucenoPak, 0) AS IsporucenoBR_Pak, ISNULL(Func4.DaljnjaObradaPro, 0) AS DaljnjaObradaBR_Pro, ISNULL(Func4.DaljnjaObradaPak, 0) AS DaljnjaObradaBR_Pak, ISNULL(Func4.PrepakiravanjePro, 0) AS PrepakiravanjeBR_Pro, ISNULL(Func4.PrepakiravanjePak, 0) AS PrepakiravanjeBR_Pak, 
    ISNULL(Func4.VrstaPakiranja, '') AS PakiranjeBR_Pro, CAST(ISNULL((SELECT Pakiranja.TezinaPakiranja FROM Pakiranja WHERE Pakiranja.VrstaPakiranja = Func4.VrstaPakiranja), 0) AS float) AS PakiranjeBR_kg, 
    ISNULL(NarS_A.BrojRN5, '') AS RN_Obrada5, ISNULL((SELECT NarS_B.ID_Pro FROM NarudzbeSta NarS_B WHERE NarS_B.BrojRN = NarS_A.BrojRN5), 0) AS ID_Pro_O5, 
    ISNULL(Func5.NapravljenoPro, 0) AS NapravljenoO5_Pro, ISNULL(Func5.SpremnoPro, 0) AS SpremnoO5_Pro, ISNULL(Func5.SpremnoPak, 0) AS SpremnoO5_Pak, ISNULL(Func5.OtpadObrada, 0) AS OtpadPro_O5, ISNULL(Func5.OtpadMaterijal, 0) AS OtpadMat_O5, ISNULL(Func5.KolicinaUzoraka, 0) AS KolicinaUzoraka_O5, 
    ISNULL(Func5.IsporucenoPro, 0) AS IsporucenoO5_Pro, ISNULL(Func5.IsporucenoPak, 0) AS IsporucenoO5_Pak, ISNULL(Func5.DaljnjaObradaPro, 0) AS DaljnjaObradaO5_Pro, ISNULL(Func5.DaljnjaObradaPak, 0) AS DaljnjaObradaO5_Pak, ISNULL(Func5.PrepakiravanjePro, 0) AS PrepakiravanjeO5_Pro, ISNULL(Func5.PrepakiravanjePak, 0) AS PrepakiravanjeO5_Pak, 
    ISNULL(Func5.VrstaPakiranja, '') AS PakiranjeO5_Pro, CAST(ISNULL((SELECT Pakiranja.TezinaPakiranja FROM Pakiranja WHERE Pakiranja.VrstaPakiranja = Func5.VrstaPakiranja), 0) AS float) AS PakiranjeO5_kg, 
	NarS_A.CijenaObrada1, NarS_A. CijenaObrada2, NarS_A.CijenaObrada3, NarS_A.CijenaObrada4, NarS_A.CijenaObrada5, Proizvodi.ObradaA, Proizvodi.ObradaB, Proizvodi.ObradaC, Proizvodi.ZavrsnaObrada AS ZavrsnaObradaTok 
    FROM NarudzbeSta NarS_A
      INNER JOIN NarudzbeZag ON NarS_A.ID_NarZ = NarudzbeZag.ID_NarZ 
      INNER JOIN VrsteNarudzbi ON NarudzbeZag.VrstaNar = VrsteNarudzbi.VrstaNar 
      FULL OUTER JOIN SumeStatusaEvidPro(@TmpPrepakiranaStavka) Func1 ON (CASE WHEN VrsteNarudzbi.RnZaCalcKolicine = 'Bazni' THEN NarS_A.BrojRN ELSE NarS_A.BrojRN1 END) = Func1.BrojRN 
      FULL OUTER JOIN SumeStatusaEvidPro(@TmpPrepakiranaStavka) Func2 ON NarS_A.BrojRN2 = Func2.BrojRN 
      FULL OUTER JOIN SumeStatusaEvidPro(@TmpPrepakiranaStavka) Func3 ON NarS_A.BrojRN3 = Func3.BrojRN 
      FULL OUTER JOIN SumeStatusaEvidPro(@TmpPrepakiranaStavka) Func4 ON NarS_A.BrojRN4 = Func4.BrojRN 
      FULL OUTER JOIN SumeStatusaEvidPro(@TmpPrepakiranaStavka) Func5 ON NarS_A.BrojRN5 = Func5.BrojRN 
	  FULL OUTER JOIN Proizvodi ON NarS_A.ID_Pro = Proizvodi.ID_Pro 
    WHERE (CASE WHEN @VrstaStatusa = 'Neisporuceno' THEN ISNULL(NarS_A.Isporuceno, 0) ELSE ISNULL(NarS_A.Aktivno, 0) END) = (CASE WHEN @VrstaStatusa = 'Neisporuceno' THEN 0 ELSE 1 END) 
      AND NarS_A.BazniRN = 1 
      AND (SELECT VrstaNar FROM NarudzbeZag WHERE ID_NarZ = NarS_A.ID_NarZ) = @VrstaNarudzbe 
      AND NarS_A.DatumIsporuke IS NOT NULL 