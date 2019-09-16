USE [FxApp]
GO

/****** Object:  View [dbo].[ldp_aktivnost_view]    Script Date: 10.04.2017. 9:25:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[ldp_aktivnost_view]
AS
SELECT        TOP (100) PERCENT id, datum, hala, linija, smjena, proizvod, norma, max, cijena, kolicina, iznos, norma * cijena AS norma_iznos, radnik, ID_Partner, ABS(kvarovi) AS kvarovi, 
                         CASE WHEN kvarovi > 0 THEN ABS(kvarovi_minuta) ELSE NULL END AS kvarovi_vrijeme, ABS(bolovanja) AS bolovanja, ABS(materijal) AS materijal, ABS(alati) AS alati, ABS(izostanci) AS izostanci, ABS(stelanja) 
                         AS stelanja, CASE WHEN stelanja > 0 THEN ABS(stelanja_minuta) ELSE NULL END AS stelanja_vrijeme, norma - stelanja - kvarovi AS [Norma-stelanja], CASE WHEN month(datum) > 9 THEN (CAST(YEAR(datum) 
                         AS varchar(4)) + '-' + CAST(MONTH(datum) AS varchar(2))) ELSE (CAST(YEAR(datum) AS varchar(4)) + '- 0' + CAST(MONTH(datum) AS varchar(2))) END AS Mjesec, 
                         CASE WHEN norma < kolicina THEN 1 ELSE 0 END AS prebacaj, CASE WHEN max > (kolicina + abs(kvarovi) + abs(bolovanja) + abs(materijal) + abs(alati) + Abs(izostanci) + abs(stelanja)) 
                         THEN 1 ELSE 0 END AS podbacaj, CASE WHEN max > (kolicina + abs(kvarovi) + abs(bolovanja) + abs(materijal) + abs(alati) + Abs(izostanci) + abs(stelanja)) THEN norma - abs(kvarovi) - abs(bolovanja) 
                         - abs(materijal) - abs(alati) - Abs(izostanci) - abs(stelanja) - kolicina ELSE 0 END AS podbacaj_kolicina, CASE WHEN norma < kolicina THEN kolicina - norma ELSE 0 END AS prebacaj_kolicina, ABS(materijal) 
                         * cijena AS materijal_iznos, CASE WHEN stelanja > 0 THEN 1 ELSE 0 END AS Broj_Stelanja, CASE WHEN kvarovi > 0 THEN 1 ELSE 0 END AS Broj_Kvarova, CASE WHEN DATEDIFF(d, datum, getdate()) 
                         < 8 THEN 1 ELSE 0 END AS Zadnji_Tjedan, CASE WHEN datediff(ww, DATEADD(dd, - @@datefirst, GETDATE()), DATEADD(dd, - @@datefirst, datum)) >= DATEDIFF(wk, GETDATE(), DATEadd(d, - 30, GETDATE())) 
                         THEN 1 ELSE 0 END AS Zadnji_Mjesec, CASE WHEN DATEDIFF(m, datum, getdate()) < 12 THEN 1 ELSE 0 END AS Zadnja_Godina, DATEPART(ISO_WEEK, datum) AS Tjedan, CASE WHEN DATEDIFF(d, datum, 
                         getdate()) < 2 AND DATEDIFF(d, datum, getdate()) > 0 THEN Isnull(1, 0) ELSE 0 END AS Jucer, 'H' + CAST(hala AS varchar(2)) + '-' + linija AS HLinija,
                             (SELECT        NazivPar
                               FROM            VLADO.FeroApp.dbo.Partneri AS Partneri_1
                               WHERE        (ID_Par = dbo.ldp_aktivnost.ID_Partner)) AS PARTNER, idealno, ROUND(ISNULL(kolicina + 0.00000000000001, 0.0000000000001) / ISNULL(idealno + 0.00000000000001, 0.00000000000001), 2) 
                         AS OEE, 0.86 AS Cilj_OEE,
                             (SELECT        NazivPar
                               FROM            VLADO.FeroApp.dbo.Partneri AS Partneri_1
                               WHERE        (ID_Par = dbo.ldp_aktivnost.ID_Partner)) AS PARTNER2, skart_obrada, skart_materijal, ISNULL(turm, 0) AS TURM, CASE WHEN CAST(ISNULL(turm, 0) AS int) 
                         > 1 THEN skart_materijal ELSE 0 END AS SK_MAT_TURM, CASE WHEN CAST(ISNULL(turm, 0) AS int) < 2 THEN skart_materijal ELSE 0 END AS SK_MAT_SINGLE, CASE WHEN CAST(ISNULL(turm, 0) AS int) 
                         > 1 THEN skart_obrada ELSE 0 END AS SK_OBR_TURM, CASE WHEN CAST(ISNULL(turm, 0) AS int) < 2 THEN skart_obrada ELSE 0 END AS SK_OBR_SINGLE, CASE WHEN CAST(ISNULL(turm, 0) AS int) 
                         < 2 THEN kolicina + skart_materijal + skart_obrada ELSE 0 END AS UKUPNO_SINGLE, CASE WHEN CAST(ISNULL(turm, 0) AS int) 
                         > 1 THEN kolicina + skart_materijal + skart_obrada ELSE 0 END AS UKUPNO_TURM, norma * 480 / 450 AS norma8_kol,norma*cijena* 480/450 as norma8_EUR, norma * 480 / 450 * 85 / 100 AS norma_85, norma * 480 / 450 * 75 / 100 AS norma8_75, 
                         norma * cijena * 480 / 450 AS norma8iznos, norma * cijena * 480 / 450 * 85 / 100 AS norma_85iznos, norma * cijena * 480 / 450 * 75 / 100 AS norma8_75iznos, 650/3 pausal

FROM            dbo.ldp_aktivnost
WHERE        (ID_Partner > 0) AND (hala < 100) AND (DATEDIFF(m, datum, GETDATE()) < 13)
ORDER BY YEAR(datum), MONTH(datum), DAY(datum), hala, linija, smjena

GO


