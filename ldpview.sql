USE [FxApp]
GO

/****** Object:  View [dbo].[ldp_aktivnost_view]    Script Date: 06.04.2017. 11:45:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ldp_aktivnost_view2]
AS
SELECT   top(100)      id, datum, hala, linija, smjena, proizvod, norma, max, cijena, kolicina, iznos, norma * cijena AS norma_iznos, radnik, ID_Partner, ABS(kvarovi) AS kvarovi, 
                         CASE WHEN kvarovi > 0 THEN ABS(kvarovi_minuta) ELSE NULL END AS kvarovi_vrijeme, ABS(bolovanja) AS bolovanja, ABS(materijal) AS materijal, ABS(alati) AS alati, ABS(izostanci) AS izostanci, ABS(stelanja) 
                         AS stelanja, CASE WHEN stelanja > 0 THEN ABS(stelanja_minuta) ELSE NULL END AS stelanja_vrijeme, norma - stelanja - kvarovi AS [Norma-stelanja], year(datum)*100+month(datum) AS Mjesec, 
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
                         > 1 THEN kolicina + skart_materijal + skart_obrada ELSE 0 END AS UKUPNO_TURM
FROM            dbo.ldp_aktivnost
WHERE        (ID_Partner > 0) AND (hala < 100) AND (DATEDIFF(m, datum, GETDATE()) < 13)
ORDER BY YEAR(datum), MONTH(datum), DAY(datum), hala, linija, smjena

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[10] 4[41] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = -1640
      End
      Begin Tables = 
         Begin Table = "ldp_aktivnost"
            Begin Extent = 
               Top = 0
               Left = 38
               Bottom = 144
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 19
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 43
         Width = 284
         Width = 1500
         Width = 1905
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 915
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2385
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 11715
         Alias = 2565
         Table = 2790
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 2625
         Or = 1350
         Or = 1350
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ldp_aktivnost_view'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ldp_aktivnost_view'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ldp_aktivnost_view'
GO


