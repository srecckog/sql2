/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID_ENS]
      ,[ID_ENZ]
      ,[Linija]
      ,[BrojStroja]
      ,[ID_Radnika]
      ,[Radnik]
      ,[BrojRN]
      ,[ObradaA]
      ,[ObradaB]
      ,[ObradaC]
      ,[ObradaD]
      ,[ObradaE]
      ,[ObradaF]
      ,[ObradaG]
      ,[ObradaH]
      ,[ObradaI]
      ,[BrojSatiRada]
      ,[VrijemeOd]
      ,[VrijemeDo]
      ,[Norma]
      ,[KolicinaOK]
      ,[KolicinaPorozno]
      ,[OtpadObrada]
      ,[OtpadMat]
      ,[ID_Radnika2]
      ,[Radnik2]
      ,[VrijemeOd2]
      ,[VrijemeDo2]
      ,[Napomena1]
      ,[Napomena2]
      ,[Napomena3]
      ,[TekstCheck01]
      ,[TekstCheck02]
      ,[TekstCheck03]
      ,[TekstCheck04]
      ,[TekstCheck05]
      ,[TekstCheck06]
      ,[TekstCheck07]
      ,[TekstCheck08]
      ,[TekstCheck09]
      ,[TekstCheck10]
      ,[TekstCheck11]
      ,[TekstCheck12]
      ,[TekstCheck13]
      ,[TekstCheck14]
      ,[TekstCheck15]
      ,[TekstCheck16]
      ,[TekstCheck17]
      ,[TekstCheck18]
      ,[TekstCheck19]
      ,[TekstCheck20]
      ,[NapomenaTC04]
      ,[NapomenaTC07]
      ,[NapomenaTC09]
      ,[NapomenaTC10]
      ,[NapomenaTC11]
      ,[NapomenaTC12]
      ,[NapomenaTC15]
      ,[NapomenaTC19]
      ,[StrojeviTC12]
      ,[VrijemeOdTC01]
      ,[VrijemeDoTC01]
      ,[VrijemeTC02]
      ,[VrijemeTC03]
      ,[VrijemeOdTC04]
      ,[VrijemeDoTC04]
      ,[VrijemeOdTC07]
      ,[VrijemeDoTC07]
      ,[VrijemeTC09]
      ,[VrijemeTC10]
      ,[VrijemeTC11]
      ,[VrijemeOdTC15]
      ,[VrijemeDoTC15]
      ,[VrijemeOdTC19]
      ,[VrijemeDoTC19]
      ,[UserName]
      ,[DatumUnosa]
      ,[VrijemeUnosa]
  FROM [FeroApp].[dbo].[EvidencijaNormiSta]

  
  select r.*,r2.prezime,r2.poduzece,r2.neradi
  from radnici r
  left joIN rfind.dbo.radnici_ r2 on r.id_fink=r2.id
  where r.neradi!=r2.neradi
  and r2.neradi=0
  order by ime


  select *
  from rfind.dbo.radnici_
  where id=80

  select *
  from feroapp.dbo.radnici
  order by ime


  select *
  from EvidencijaNormiSta
  where id_radnika=1818

  select *
  from EvidencijaNormiRadnici
  where id_radnika=1818


  update EvidencijaNormiSta set id_radnika=1978 where id_radnika=1818 and datumunosa>='2018-01-01'
  update EvidencijaNormiradnici set id_radnika=1978 where id_radnika=1818 and datumunosa>='2018-01-01'





