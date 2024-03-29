/****** Script for SelectTopNRows command from SSMS  ******/
use feroapp


SELECT
kz.Datum, 
      [KratkiNaziv]
      ,[BrojSarze]
      ,[Kolicina]
      ,kz.ID_KKSZ kzid,ks.ID_KKSZ ksid
  FROM [FeroApp].[dbo].[KalionicaKnjigaSmjenezag] kz
  left join [dbo].[KalionicaKnjigaSmjeneSta] ks on kz.ID_KKSZ=ks.ID_KKSZ
  where KratkiNaziv in
  (
  'AR.800792.04.W220',
'AR.800792.10.W220',
'JR.565314/2.W220',
'JR.566425/2.W220',
'JR.800792AB/1.W220',
'JR.800792AB/2.W220',
'JR.800792AE/1.W220',
'JR.800792AE/2.W220',
'JR.800792D/1.W220',
'JR.800792D/2.W220',
'JR.F-565314/1.W220',
'JR.F-565314/2.W220',
'JR.F-566425/1.W220',
'JR.F-566425/2.W220')
and kz.Datum>='2016-01-01'
