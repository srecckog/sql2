/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID_Radnika]
      ,[ID_Fink]
      ,[ID_Firme]
      ,[Ime]
      ,[SifraRM]
      ,[Hala]
      ,[RadNaStroju]
      ,[Steler]
      ,[Kontrola]
      ,[Bravar]
      ,[Pilar]
      ,[NeRadi]
  FROM [FeroApp].[dbo].[Radnici]
  order by ime desc
 
use rfind
select *
from MjestoTroska

update feroapp.dbo.radnici set hala=3 where id_radnika=1668

select *
from radnici_
where id=34

update rfind.dbo.radnici_ set mt=702,lokacija=521,RADNOMJESTO='POSLUŽITELJ TOPLINSKE OBRADE' where id=34
