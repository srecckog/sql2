/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[Ime]
      ,[Mjesec]
      ,[Brojdana]
      ,[Razlog]
      ,[Godina]
      ,[SN]
      ,[NN]
  FROM [RFIND].[dbo].[stat_bo2]


  -------------------------------------------------------------------------------------------------
  -- ne rade nedjeljom a zaplanirani su
  select *
  from pregledvremena
  where datepart(dw, datum)=7
  and year(dosao)=1900
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  --------------------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  -- ne rade subotom a zaplanirani su
  select *
  from pregledvremena
  where datepart(dw, datum)=6
  and year(dosao)=1900
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  ----------------------------------------------------------------------------------------------
  use rfind
  select *
  from pregledvremena
  where datum='2017-05-02'

  
  delete from pregledvremena where datum='2017-05-01'


  select r.id,r.prezime,r.ime,p.datum,datename(dw, datum) dan_u_tjednu,p.dosao,p.otisao,tdoci,totici,napomena,kasni,preranootisao,ukupno_minuta,hala,smjena,p.RadnoMJesto,p.rbroj
  from pregledvremena p
  left join radnici_ r on r.id=p.idradnika
  where p.idradnika=100
  order by datum


  --update pregledvremena set tdoci=6,totici=14 where idradnika=100

  select count(*),idradnika,datum,rbroj
  from pregledvremena
  group by idradnika,datum,rbroj
  having count(*)>1
  order by datum






