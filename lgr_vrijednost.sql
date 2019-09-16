USE FeroApp;

WITH MyTmpTable AS(
SELECT SPLP.Bazni_RN,id_par, SPLP.OrderNo, SPLP.ID_Mat, SPLP.VrstaNar, PRO.ID_Pro, PRO.ID_Pro_Kup, PRO.NazivPro AS Proizvod, SPLP.BaznaObrada, SPLP.ZavrsnaObrada, 
       SPLP.RN_Tokarenje, SPLP.SpremnoT_Pro, SPLP.SpremnoT_Pak, SPLP.PakiranjeT_Pro, SPLP.PakiranjeT_kg, 
       SPLP.RN_Kaljenje, SPLP.SpremnoK_Pro, SPLP.SpremnoK_Pak, SPLP.PakiranjeK_Pro, SPLP.PakiranjeK_kg, 
       SPLP.RN_TvrdoTokarenje , SPLP.SpremnoTT_Pro, SPLP.SpremnoTT_Pak, SPLP.PakiranjeTT_Pro, SPLP.PakiranjeTT_kg, 
       SPLP.RN_Brusenje , SPLP.SpremnoBR_Pro, SPLP.SpremnoBR_Pak, SPLP.PakiranjeBR_Pro, SPLP.PakiranjeBR_kg, 
       SPLP.KolicinaNar, SPLP.IsporucenoT_Pro, SPLP.IsporucenoK_Pro, SPLP.IsporucenoTT_Pro, SPLP.IsporucenoBR_Pro, PRO.TezinaPro AS TezinaProKom, SPLP.VlasnistvoFX, SPLP.DatumIsporuke, 
       (SELECT RPZ.BrojKomadaPoPakiranju FROM feroapp.dbo.EvidencijaProizvodnjeZag RPZ WHERE RPZ.BrojRN = (CASE SPLP.ZavrsnaObrada WHEN 'Brusenje' THEN SPLP.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN SPLP.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN SPLP.RN_Kaljenje ELSE SPLP.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
       (SELECT MAX(EPV.Datum) FROM FeroApp.dbo.EvidencijaProizvodnjeView EPV WHERE EPV.BrojRN = (CASE SPLP.ZavrsnaObrada WHEN 'Brusenje' THEN SPLP.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN SPLP.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN SPLP.RN_Kaljenje ELSE SPLP.RN_Tokarenje END)) AS Datumproizvodnje, 
       (SELECT TOP 1 FCP.ID_FCP FROM FeroApp.dbo.FakturneCijeneProizvoda FCP WHERE FCP.ID_Pro_Kup = PRO.ID_Pro_Kup AND FCP.Godina = DATEPART(YEAR, GETDATE()) ORDER BY FCP.ID_FCP DESC) AS ID_FCP 
       FROM FeroApp.dbo.StanjeProizvodnjeListPrepak('Prsteni', 'Neisporuceno', 0) SPLP 
             LEFT JOIN FeroApp.dbo.Proizvodi PRO ON (CASE SPLP.ZavrsnaObrada WHEN 'Kaljenje' THEN SPLP.ID_Pro_K WHEN 'Tvrdo tokarenje' THEN SPLP.ID_Pro_TT WHEN 'Brusenje' THEN SPLP.ID_Pro_BR ELSE SPLP.ID_Pro_T END) = PRO.ID_Pro         
       WHERE (SPLP.SpremnoT_Pro <> 0 
             OR SPLP.SpremnoK_Pro <> 0 
             OR SPLP.SpremnoTT_Pro <> 0 
             OR SPLP.SpremnoBR_Pro <> 0)) 

SELECT MTT.*, FCP.Tokarenje, FCP.Kaljenje, FCP.CijenaProQ1, FCP.CijenaProQ2, FCP.CijenaProQ3, FCP.CijenaProQ4 , fcp.tokarenje*spremnot_pro v_tok,fcp.kaljenje*spremnok_pro v_kalj,(fcp.cijenaproq4- fcp.tokarenje-fcp.kaljenje)*(spremnot_pro+spremnok_pro) materijal
       FROM MyTmpTable MTT 
       LEFT JOIN FakturneCijeneProizvoda FCP ON MTT.ID_FCP = FCP.ID_FCP
