/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[Grupa]
      ,[prezime i ime]
      ,[pogon (ukloniti)]
      ,[funkcija]
      ,[vještine]
      ,[staž]
      ,[ima]
      ,[ne dolasci subotom]
      ,[ne dolasci subotom zadnji]
      ,[norme]
      ,[rad vikendom]
      ,[rad vikendom zadnji mjesec]
      ,[ne dolasci vikendom_p]
      ,[ne dolasci vikendom_p zadnji mjesec]
      ,[bolovanja]
      ,[napomena]
      ,[datumzaposlenja]
      ,[godinas]
      ,[mjesecis]
  FROM [RFIND].[dbo].[kompetence2]


  select x1.id,(x1.prezime+' '+x1.ime+' ('+cast(x1.id as varchar)+')' ) as prezimeime,x1.funkcija,x1.[Vjestina],x1.mjesto_troska,x1.datumzaposlenja,x1.satnica,x1.staz,x1.poduzece,x1.napomena
  from 
  (

  select r.id id,r.prezime,r.ime,r.fixnaisplata,k.funkcija,k.vještine as vjestina,r.radnomjesto,mt.Naziv mjesto_troska,k.datumzaposlenja,k.ima satnica,k.staž as staz,r.poduzece,k.napomena
  from radnici_ r
  left join MjestoTroska mt on mt.id=r.mt
  left join kompetence2 k on k.id=r.id
  where r.id not in
  (
  select id
  from kompetencije1105
   
  )
  and r.FixnaIsplata=0
  and r.neradi=0
  and k.id is not null
  ) x1
  order by id


  insert into kompetencije1105 (id,PrezimeIme,Funkcija,Vjestina,Mjesto_troska,radnomjesto,DatumZaposlenja,Satnica,staz,Poduzece,napomena)

  select x1.id,(x1.prezime+' '+x1.ime+' ('+cast(x1.id as varchar)+')' ) as prezimeime,x1.funkcija,x1.[Vjestina],x1.mjesto_troska,x1.radnomjesto,x1.datumzaposlenja,x1.satnica,x1.staz,x1.poduzece,x1.napomena
  from 
  (

  select r.id id,r.prezime,r.ime,r.fixnaisplata,k.funkcija,k.vještine as vjestina,r.radnomjesto,mt.Naziv mjesto_troska,k.datumzaposlenja,k.ima satnica,k.staž as staz,r.poduzece,k.napomena
  from radnici_ r
  left join MjestoTroska mt on mt.id=r.mt
  left join kompetence2 k on k.id=r.id
  where r.id not in
  (
  select id
  from kompetencije1105
   
  )
  and r.FixnaIsplata=0
  and r.neradi=0
  and k.id is not null
  ) x1





  select *
  from kompetencije2017
  where Zadnje_tromjesecje=0