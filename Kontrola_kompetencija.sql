/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Id]
      ,[PrezimeIme]
      ,[Funkcija]
      ,[Projekt]
      ,[Hala]
      ,[Linija]
      ,[Vještine]
      ,[Školovanje_Posto]
      ,[Mjesto_troska]
      ,[RadnoMjesto]
      ,[Vjestina]
      ,[DatumZaposlenja]
      ,[Istek_Ugovora]
      ,[Staz]
      ,[SatnicaStara]
      ,[SatnicaNovaOd]
      ,[SatnicaBruto]
      ,[SatnicaNeto]
      ,[Godisnji_ostalo]
      ,[Godisnji_dana1]
      ,[Godisnji_dana3]
      ,[Godisnji_dana6]
      ,[Godisnji_dana12]
      ,[DolasciNedjeljom1]
      ,[DolasciNedjeljom3]
      ,[DolasciNedjeljom6]
      ,[DolasciNedjeljom12]
      ,[NedolasciNedjeljom1]
      ,[DolasciPraznikom1]
      ,[DolasciPraznikom3]
      ,[DolasciPraznikom6]
      ,[DolasciPraznikom12]
      ,[NedolasciNedjeljom3]
      ,[NedolasciNedjeljom6]
      ,[NedolasciNedjeljom12]
      ,[NedolasciSubotom1]
      ,[NedolasciSubotom3]
      ,[NedolasciSubotom6]
      ,[NedolasciSubotom12]
      ,[Bolovanje_broj1]
      ,[Bolovanje_broj3]
      ,[Bolovanje_broj6]
      ,[Bolovanje_broj12]
      ,[Bolovanja_dana1]
      ,[Bolovanja_dana3]
      ,[Bolovanja_dana6]
      ,[Bolovanja_dana12]
      ,[Stimulacija1]
      ,[Stimulacija3]
      ,[Stimulacija6]
      ,[Stimulacija12]
      ,[NedostajeDo8sati1]
      ,[NedostajeDo8sati3]
      ,[NedostajeDo8sati6]
      ,[NedostajeDo8sati12]
      ,[Kasni1]
      ,[Kasni3]
      ,[Kasni6]
      ,[Kasni12]
      ,[PreranoOtisao1]
      ,[PreranoOtisao3]
      ,[PreranoOtisao6]
      ,[PreranoOtisao12]
      ,[Neopravdano_puta1]
      ,[Neopravdano_puta3]
      ,[Neopravdano_puta6]
      ,[Neopravdano_puta12]
      ,[NeopravdaniDani1]
      ,[NeopravdaniDani3]
      ,[NeopravdaniDani6]
      ,[NeopravdaniDani12]
      ,[NormaPosto1]
      ,[NormaPosto3]
      ,[NormaPosto6]
      ,[NormaPosto12]
      ,[Napomena]
      ,[Poduzece]
  FROM [RFIND].[dbo].[kompetencije1210]
  order by prezimeime


  use rfind
  select k.prezimeime,k.radnomjesto,k2.radnomjesto radnomjesto,'RadnoMjesto' tip
  from kompetencije k
  left join kompetencije1210 k2 on k2.id=k.id
  where k2.RadnoMjesto!=k.RadnoMjesto
    union all
  
  select k.prezimeime,k.funkcija,k2.funkcija funkcija,'Funkcija' tip
  from kompetencije k
  left join kompetencije1210 k2 on k2.id=k.id
  where k2.funkcija!=k.funkcija
    union all
  
  select k.prezimeime,k.mjesto_troska ,k2.mjesto_troska mjesto_troska ,'Mjesto_troska' tip
  from kompetencije k
  left join kompetencije1210 k2 on k2.id=k.id
  where k2.mjesto_troska !=k.mjesto_troska 
