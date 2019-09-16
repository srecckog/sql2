SELECT ID_NarZ, ID_NarS, OrderNo, VrstaNar, BrojRN AS BazniRN, (CASE WHEN Obrada1 = 1 THEN BrojRN1 ELSE '-' END) AS Tokarenje, 
                (CASE WHEN Obrada2 = 1 THEN BrojRN2 ELSE '-' END) AS Kaljenje, 
                (CASE WHEN Obrada3 = 1 THEN BrojRN3 ELSE '-' END) AS TvrdoTokarenje, 
                DatumIsporuke, KolicinaNar, ID_Pro, (select NazivPro from Proizvodi where ID_Pro=NarudzbeDetaljnoView.ID_Pro) as Proizvod 
       FROM NarudzbeDetaljnoView 
       WHERE Aktivno = 1 AND VrstaNar IN (SELECT VrstaNar FROM VrsteNarudzbi WHERE Planiranje = 1) AND BazniRN = 1 
       ORDER BY DatumIsporuke
