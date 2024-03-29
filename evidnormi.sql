/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID_ENZ]
      ,[UserName]
      ,[Hala]
      ,[Steler]
      ,[ID_Steler]
      ,[BrojSati_Steler]
      ,[Steler2]
      ,[ID_Steler2]
      ,[BrojSati_Steler2]
      ,[Kontrola]
      ,[ID_Kontrola]
      ,[BrojSati_Kontrola]
      ,[Kontrola2]
      ,[ID_Kontrola2]
      ,[BrojSati_Kontrola2]
      ,[Kontrola3]
      ,[ID_Kontrola3]
      ,[BrojSati_Kontrola3]
      ,[Bravar]
      ,[ID_Bravar]
      ,[BrojSati_Bravar]
      ,[Bravar2]
      ,[ID_Bravar2]
      ,[BrojSati_Bravar2]
      ,[Pilar]
      ,[ID_Pilar]
      ,[BrojSati_Pilar]
      ,[Ekolog]
      ,[ID_Ekolog]
      ,[BrojSati_Ekolog]
      ,[Datum]
      ,[Smjena]
  FROM [FeroApp].[dbo].[EvidencijaNormiZag] z


  select s.*
  from EvidencijaNormiZAG Z
  left join EvidencijaNormiSTA S on z.id_enz=Z.ID_ENZ
  where datumunosa='2017-04-04'
  and radnik like '%KRALJ%'


  select s.*
  from EvidencijaNormista s
  where radnik like '%KRALJ%'

