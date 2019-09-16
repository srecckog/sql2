
	SELECT  NarudzbeZag.VrstaNar,narudzbezag.id_par,EvidencijaNormiView.BrojRN, EvidencijaNormiView.ID_Pro, Proizvodi.ID_Pro_Kup, Proizvodi.NazivPro, NarudzbeSta.KolicinaNar, SUM(EvidencijaNormiView.KolicinaOK) AS Potokareno_steleri, 
      ISNULL(SSEP.NapravljenoPro, 0) AS Potokareno_kontrola, ISNULL(SSEP.IsporucenoPro, 0) AS Isporuceno_kontrola, ISNULL(SSEP.SpremnoPro, 0) AS Spremno_kontrola 
      FROM feroapp.dbo.EvidencijaNormiView 
        INNER JOIN feroapp.dbo.Proizvodi ON EvidencijaNormiView.ID_Pro = Proizvodi.ID_Pro 
        INNER JOIN feroapp.dbo.NarudzbeSta ON EvidencijaNormiView.BrojRN = NarudzbeSta.BrojRN 
        INNER JOIN feroapp.dbo.NarudzbeZag ON NarudzbeSta.ID_NarZ = NarudzbeZag.ID_NarZ 
        FULL OUTER JOIN feroapp.dbo.SumeStatusaEvidPro(9) SSEP ON EvidencijaNormiView.BrojRN = SSEP.BrojRN 
      WHERE EvidencijaNormiView.BrojRN IN(SELECT feroapp.dbo.NarudzbeDetaljnoView.BrojRN FROM feroapp.dbo.NarudzbeDetaljnoView WHERE NarudzbeDetaljnoView.ID_Par = 274 AND NarudzbeDetaljnoView.Isporuceno = 0) 
        AND EvidencijaNormiView.ObradaA = 1 
        
      GROUP BY  narudzbezag.id_par,NarudzbeZag.VrstaNar,EvidencijaNormiView.BrojRN, EvidencijaNormiView.ID_Pro, Proizvodi.ID_Pro_Kup, Proizvodi.NazivPro, NarudzbeSta.KolicinaNar, SSEP.NapravljenoPro, SSEP.IsporucenoPro, SSEP.SpremnoPro



	  select *
	  from
	  feroapp.dbo.Narudzbezag