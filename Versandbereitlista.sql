 use FeroApp 
 SELECT StanjeProizvodnjeList.Bazni_RN, (SELECT NarudzbeDetaljnoView.OrderNo FROM NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.BrojRN = (CASE WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Kaljenje' THEN StanjeProizvodnjeList.RN_Kaljenje WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Tvrdo tokarenje' THEN StanjeProizvodnjeList.RN_TvrdoTokarenje WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Brusenje' THEN StanjeProizvodnjeList.RN_Brusenje ELSE StanjeProizvodnjeList.RN_Tokarenje END)) AS Narudzba, 
 StanjeProizvodnjeList.ID_Mat, 
 (SELECT NarudzbeSta.ID_NarZ FROM NarudzbeSta WHERE NarudzbeSta.BrojRN = (CASE WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Kaljenje' THEN StanjeProizvodnjeList.RN_Kaljenje WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Tvrdo tokarenje' THEN StanjeProizvodnjeList.RN_TvrdoTokarenje WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Brusenje' THEN StanjeProizvodnjeList.RN_Brusenje ELSE StanjeProizvodnjeList.RN_Tokarenje END)) AS NarudzbaFull, 
 (SELECT Proizvodi.NazivPro FROM Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Kaljenje' THEN StanjeProizvodnjeList.ID_Pro_K WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Tvrdo tokarenje' THEN StanjeProizvodnjeList.ID_Pro_TT WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Brusenje' THEN StanjeProizvodnjeList.ID_Pro_BR ELSE StanjeProizvodnjeList.ID_Pro_T END)) AS Proizvod, 
 StanjeProizvodnjeList.BaznaObrada, StanjeProizvodnjeList.ZavrsnaObrada, StanjeProizvodnjeList.RN_Tokarenje, StanjeProizvodnjeList.SpremnoT_Pro, StanjeProizvodnjeList.SpremnoT_Pak, 
 StanjeProizvodnjeList.PakiranjeT_Pro, StanjeProizvodnjeList.PakiranjeT_kg, StanjeProizvodnjeList.RN_Kaljenje, StanjeProizvodnjeList.SpremnoK_Pro, StanjeProizvodnjeList.SpremnoK_Pak, 
 StanjeProizvodnjeList.PakiranjeK_Pro, StanjeProizvodnjeList.PakiranjeK_kg, 
 StanjeProizvodnjeList.RN_TvrdoTokarenje , StanjeProizvodnjeList.SpremnoTT_Pro, StanjeProizvodnjeList.SpremnoTT_Pak, StanjeProizvodnjeList.PakiranjeTT_Pro, StanjeProizvodnjeList.PakiranjeTT_kg, 
 StanjeProizvodnjeList.RN_Brusenje , StanjeProizvodnjeList.SpremnoBR_Pro, StanjeProizvodnjeList.SpremnoBR_Pak, StanjeProizvodnjeList.PakiranjeBR_Pro, StanjeProizvodnjeList.PakiranjeBR_kg, 
 StanjeProizvodnjeList.KolicinaNar, StanjeProizvodnjeList.IsporucenoT_Pro, StanjeProizvodnjeList.IsporucenoK_Pro, StanjeProizvodnjeList.IsporucenoTT_Pro, StanjeProizvodnjeList.IsporucenoBR_Pro, 
 ISNULL((SELECT Proizvodi.TezinaPro FROM Proizvodi WHERE Proizvodi.ID_Pro = (CASE WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Kaljenje' THEN StanjeProizvodnjeList.ID_Pro_K WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Tvrdo tokarenje' THEN StanjeProizvodnjeList.ID_Pro_TT WHEN StanjeProizvodnjeList.ZavrsnaObrada = 'Brusenje' THEN StanjeProizvodnjeList.ID_Pro_BR ELSE StanjeProizvodnjeList.ID_Pro_T END)),0) AS TezinaProKom, 
 StanjeProizvodnjeList.VlasnistvoFX, 
 (SELECT EvidencijaProizvodnjeZag.BrojKomadaPoPakiranju FROM EvidencijaProizvodnjeZag WHERE EvidencijaProizvodnjeZag.BrojRN = (CASE StanjeProizvodnjeList.ZavrsnaObrada WHEN 'Brusenje' THEN StanjeProizvodnjeList.RN_Brusenje WHEN 'Tvrdo tokarenje' THEN StanjeProizvodnjeList.RN_TvrdoTokarenje WHEN 'Kaljenje' THEN StanjeProizvodnjeList.RN_Kaljenje ELSE StanjeProizvodnjeList.RN_Tokarenje END)) AS BrojKomadaPoPakiranju, 
 DatumIsporuke 
 FROM StanjeProizvodnjeList('Prsteni', 'Neisporuceno') 
 WHERE StanjeProizvodnjeList.ID_Par = 274 
 AND (StanjeProizvodnjeList.SpremnoT_Pro <> 0 OR StanjeProizvodnjeList.SpremnoK_Pro <> 0 OR StanjeProizvodnjeList.SpremnoTT_Pro <> 0 OR StanjeProizvodnjeList.SpremnoBR_Pro <> 0) 
 
 --and bazni_rn<>rn_tokarenje


 ORDER BY StanjeProizvodnjeList.VlasnistvoFX, Proizvod