/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID_KKSZ]
      ,[Datum]
      ,[Smjena]
      ,[ID_Radnika]
      ,[Radnik]
      ,[NapomenaCodere]
      ,[NapomenaSolo]
  FROM [FeroApp].[dbo].[KalionicaKnjigaSmjeneZag]


  use feroapp
  select  x1.smjena,x1.kratkinaziv , x1.pec , sum(kolicina) kolicina
  from (
  select ksz.*,kss.BrojPeciKaljenje,kss.BrojRN,(kss.Kolicina-kss.KrivuljaRezanje) kolicina ,kss.KratkiNaziv ,kss.Materijal ,kss.Pec 
  from KalionicaKnjigaSmjeneZag ksz
  left join KalionicaKnjigaSmjeneSta kss on ksz.id_kksz=kss.id_kksz
  where ksz.datum='2016-05-26'
  ) x1
--and ksz.smjena=1
group by x1.radnik , x1.smjena , x1.kratkinaziv , x1.pec 
  order by x1.smjena,x1.kratkinaziv
