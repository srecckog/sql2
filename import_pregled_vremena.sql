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
  FROM [FeroApp].[dbo].[EvidencijaNormiZag]


  use rfind
  select  * 
  from pregledvremena
  where datum='2017-03-13'



  select * into pv11 from pregledvremena where datum='2017-03-13'

delete from pregledvremena2 where datum='2017-03-13'


insert into pregledvremena2 ( 
rbroj,idradnika,prezimeime,datum,dosao,otisao,tdoci,totici,checker,napomena,poduzece,smjena,radnomjesto,hala,ukupno_minuta,kasni) ( 

select rbroj,p11.idradnika,rtrim(r.prezime)+' '+rtrim(r.ime)+ ' ( '+ str(r.id)+')' as prezimeime ,datum,dosao,otisao,tdoci,totici,checker,napomena,p11.poduzece,smjena,p11.radnomjesto,hala,ukupno_minuta,kasni
from pv11 p11
left join radnici_ r on p11.idradnika=r.id

)


