/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Id
      ,[PrezimeIme]
      ,[Funkcija]
      ,[Mjesto_troska]
      ,[RadnoMjesto]
      ,[Vjestina]
      ,[DatumZaposlenja]
      ,[Istek_Ugovora]
      ,[Staz]
      ,[SatnicaStara]
      ,[SatnicaNovaOd]
      ,[Satnica]
      ,[SatnicaNeto1]
      ,[SatnicaNeto3]
      ,[SatnicaNeto6]
      ,[SatnicaNeto12]
      ,[NedolasciNedjeljom1]
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
      ,[Zadnji_mjesec]
      ,[Zadnje_tromjesecje]
      ,[Zadnjih_6mjeseci]
      ,[Zadnjih_12mjeseci]
      ,[Napomena]
      ,[Poduzece]
  FROM [RFIND].[dbo].[Kompetencije]



-------------------------------
  insert into kompetencije 
     ( 
	  [Id]
      ,[PrezimeIme]
      ,[Funkcija]
      ,[Mjesto_troska]
      ,[RadnoMjesto]
      ,[Vjestina]
      ,[DatumZaposlenja]
      ,[Istek_Ugovora]
      ,[Staz]
      ,[SatnicaStara]
      ,[SatnicaNovaOd]
      ,[Satnica]
      ,[SatnicaNeto1]
      ,[SatnicaNeto3]
      ,[SatnicaNeto6]
      ,[SatnicaNeto12]
      ,[NedolasciNedjeljom1]
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
      ,[Zadnji_mjesec]
      ,[Zadnje_tromjesecje]
      ,[Zadnjih_6mjeseci]
      ,[Zadnjih_12mjeseci]
      ,[Napomena]
      ,[Poduzece]
	  )

	  select 
	  [Id]
      ,[PrezimeIme]
      ,[Funkcija]
      ,[Mjesto_troska]
      ,[RadnoMjesto]
      ,[Vjestina]
      ,[DatumZaposlenja]
      ,[Istek_Ugovora]
      ,[Staz]
      ,[SatnicaStara]
      ,[SatnicaNovaOd]
      ,[Satnica]
      ,[SatnicaNeto]
      ,0
      ,0
      ,0
      ,[NedolasciNedjeljom]
      ,0
      ,0
      ,0
      ,[NedolasciSubotom]
      ,0
      ,0
      ,0
      ,[Bolovanje_broj]
      ,0
      ,0
      ,0
      ,[Bolovanja_dana]
      ,0
      ,0
      ,0
      ,[Stimulacija]
      ,0
      ,0
      ,0
      ,[NedostajeDo8sati]
      ,0
      ,0
      ,0
      ,[Kasni]
      ,0
      ,0
      ,0
      ,[PreranoOtisao]
      ,0
      ,0
      ,0
      ,[Neopravdano_puta]
      ,0
      ,0
      ,0
      ,[NeopravdaniDani]
      ,0
      ,0
      ,0
      ,[NormaPosto]
      ,0
      ,0
      ,0
      ,[Zadnji_mjesec]
      ,[Zadnje_tromjesecje]
      ,[Zadnjih_6mjeseci]
      ,[Zadnjih_12mjeseci]
      ,[Napomena]
      ,[Poduzece]
	  from Kompetencije1105

-------------------------------------------
- update kompetencije iz kompetencije2017 , 2017 godina, ili zadnje_tromjesecje=1
-------------------------------------------


  update kompetencije 
     
	  set
	  
	  [SatnicaNeto3] = kk.SatnicaNeto
      ,[NedolasciNedjeljom3]=kk.NedolasciNedjeljom
      ,[NedolasciSubotom3]=kk.NedolasciSubotom
      ,[Bolovanje_broj3]=kk.Bolovanje_broj
      ,[Bolovanja_dana3]=kk.Bolovanja_dana
      ,[Stimulacija3]=kk.Stimulacija
      ,[NedostajeDo8sati3]=kk.NedostajeDo8sati
      ,[Kasni3]=kk.Kasni
      ,[PreranoOtisao3]=kk.PreranoOtisao
      ,[Neopravdano_puta3]=kk.Neopravdano_puta
      ,[NeopravdaniDani3]=kk.NeopravdaniDani
      ,[NormaPosto3]=kk.NormaPosto
     
	  from 

	  kompetencije k
	  inner join kompetencije2017 kk on k.id=kk.id
	  where kk.zadnje_tromjesecje=1

	  