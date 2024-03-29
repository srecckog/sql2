/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Id]
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
      ,[NedolasciNedjeljom]
      ,[NedolasciSubotom]
      ,[Bolovanje_broj]
      ,[Bolovanja_dana]
      ,[Stimulacija]
      ,[Destimulacija]
      ,[NedostajeDo8sati]
      ,[Kasni]
      ,[PreranoOtisao]
      ,[Neopravdano_puta]
      ,[NeopravdaniDani]
      ,[NormaPosto]
      ,[Zadnji_mjesec]
      ,[Zadnje_tromjesecje]
      ,[Zadnjih_6mjeseci]
      ,[Zadnjih_12mjeseci]
      ,[Napomena]
      ,[Poduzece]
  FROM [RFIND].[dbo].[Kompetencije1105]
  order by id


  insert into kompetencije1105
  
  (
  r.id,
  k.prezime i ime

  select r.id,r.ime,r.prezime,k.*
  from radnici_ r
  left join kompetence2 k on r.id=k.id
  left join kompetencije1105 l on r.id=l.id
  where r.neradi=0 and l.id is null and grupa is not null
  



  update radnici_ set neradi=1 where id in

  (

  select radnikid
  from plansatirada
  where godina=2017 and mjesec>3
  and danodlaska is not null
  and radnikid not in
  (
  select id
  from radnici_
  where neradi=1

  )

  )


  delete from kompetencije2017 where id in 
  (
  select k.id
  from kompetencije2017 k
  left join radnici_ r on k.id=r.id
  where r.neradi=1
  )
