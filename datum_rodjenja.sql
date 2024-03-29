/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Radnik Id]
      ,[Ime X]
      ,[Prezime X]
      ,[Mt]
      ,[Lokacija]
      ,[Rfid]
      ,[Radno Mjesto]
      ,[Ne Radi]
      ,[Radni Staz Prije Dan]
      ,[Datum Zaposljavanja]
      ,[Sifra Rm]
      ,[Adresa]
      ,[Posta]
      ,[Vrijeme Mirovanja God]
      ,[Mjesto]
      ,[Vrsta Isplate]
      ,[Datum Prestanka Rada]
      ,[Nacin Zaposljavanja]
      ,[Datum Rodjenja]
      ,[Datum Sklapanja Ugovora]
      ,[Bazna Osnovica]
      ,[Osnovica]
      ,[Satnica]
      ,[Spol]
      ,[Mjesto Rodjenja]
      ,[Funkcija]
      ,[Zanimanje]
  FROM [PantheonFxAt].[dbo].[radniciat0]


  select *
  from thr_prsn


  select * into prsn0712
  from thr_prsn



  update thr_prsn set adDateBirth=j.datr
  from
  (
  select [radnik id] id,[datum rodjenja] datr
  from radniciat0
  ) j
  inner join thr_prsn p on ltrim(p.acregno)=ltrim(j.id)




  update thr_prsn set adDateBirth=j.datumr2
  from
  (
  select [radnik id] id,[datum rodjenja] datr, CONVERT(date, [datum rodjenja], 104) AS datumr2
  from radniciat0
  ) j
  inner join thr_prsn p on ltrim(p.acregno)=ltrim(j.id)



  



