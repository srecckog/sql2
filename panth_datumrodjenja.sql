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
  from radniciat0
  where [radnik id]=1.273


  update thr_prsn  set addatebirth=j.[Datum Rodjenja],accitybirth=j.[Mjesto Rodjenja]
  from
  (
  select *
  from radniciat0
  ) j
  inner join thr_prsn p on j.[radnik id]=p.acregno
  


  select p.acregno,j.[Datum Rodjenja],[Mjesto Rodjenja]
  from
  (
  select *
  from radniciat0
  ) j
  inner join thr_prsn p on j.[radnik id]=p.acregno


  select *
  from thr_prsn

  