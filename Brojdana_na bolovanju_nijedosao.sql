/****** Script for SelectTopNRows command from SSMS  ******/
SELECt [PsrID]
      ,[Firma]
      ,[RadnikID]
      ,[Ime]
      ,[SifraRM]
      ,[VrstaRM]
      ,[MT]
      ,[SatnicaKn]
      ,[TjednoRadnihSati]
      ,[DjelomicanRad]
      ,[DanDolaska]
      ,[DanOdlaska]
      ,[Godina]
      ,[Mjesec]
      ,[BrojDanaUmjesecu]
      ,[Dan01]
      ,[Dan02]
      ,[Dan03]
      ,[Dan04]
      ,[Dan05]
      ,[Dan06]
      ,[Dan07]
      ,[Dan08]
      ,[Dan09]
      ,[Dan10]
      ,[Dan11]
      ,[Dan12]
      ,[Dan13]
      ,[Dan14]
      ,[Dan15]
      ,[Dan16]
      ,[Dan17]
      ,[Dan18]
      ,[Dan19]
      ,[Dan20]
      ,[Dan21]
      ,[Dan22]
      ,[Dan23]
      ,[Dan24]
      ,[Dan25]
      ,[Dan26]
      ,[Dan27]
      ,[Dan28]
      ,[Dan29]
      ,[Dan30]
      ,[Dan31]
      ,[Stimulacija1]
      ,[Stimulacija2]
      ,[Stimulacija3]
      ,[Stimulacija4]
      ,[Stimulacija5]
      ,[RFID]
      ,[PsrUserList]
  FROM [FxSAP].[dbo].[PlanSatiRada]
  where radnikid=372 and godina=2017 and mjesec=1
  order by ime
    

use rfind
select x1.*,b.[zbrojsati] brojsati
from (
  select godina,mjesec,firma,radnikid,mt,m.Naziv,x1.ime,(len(dani) - len(replace(dani,'e',''))) broje,(len(dani) - len(replace(dani,'b',''))) brojb
  from (
  select radnikid,ime,firma,godina,mjesec,(dan01+','+dan02+','+dan03+','+dan04+','+dan05+','+dan06+','+dan07+','+dan08+','+dan09+','+dan10+','+dan11+','+dan12+','+dan13+','+dan14+','+dan15+','+dan16+','+dan17+','+dan18+','+dan19+','+dan20+','+dan21+','+dan22+','+dan23+','+dan24+','+dan25+','+dan26+','+dan27+','+dan28+','+dan29+','+dan30+','+dan31) as dani 
  from fxsap.dbo.plansatirada 
  where godina=2017
  ) x1
  inner join rfind.dbo.radnici_ r on r.id=x1.radnikid
  left join rfind.dbo.mjestotroska m on m.id=r.mt
  where r.neradi=0
  ) x1
  left join brojsatipomjesecima b on b.id=x1.radnikid and b.mjesec=x1.mjesec
  order by ime



  select g.*,r.mt,m.naziv nazivmt,r.poduzece poduzecer
  from go_2017$ g
  left join radnici_ r on r.id=g.id 
  left join mjestotroska  m on m.id=r.mt
  where r.poduzece=g.poduzece
order by r.id


select *
from radnici_
where prezime='BARBIĆ'





  select *
  from radnici_



declare @myvar varchar(max), @tocount varchar(20)
set @myvar = 'Hello World, Hello World'
set @tocount = 'lo'
select (len(@myvar) - len(replace(@myvar,@tocount,''))) / LEN(@tocount)



use rfind
select x1.*,b.[zbrojsati] brojsati
from (

  select godina,mjesec,firma,radnikid,mt,m.Naziv,x1.ime,(len(dani) - len(replace(dani,'e',''))) broje,(len(dani) - len(replace(dani,'b',''))) brojb
  from (
  select radnikid,ime,firma,godina,mjesec,(dan01+','+dan02+','+dan03+','+dan04+','+dan05+','+dan06+','+dan07+','+dan08+','+dan09+','+dan10+','+dan11+','+dan12+','+dan13+','+dan14+','+dan15+','+dan16+','+dan17+','+dan18+','+dan19+','+dan20+','+dan21+','+dan22+','+dan23+','+dan24+','+dan25+','+dan26+','+dan27+','+dan28+','+dan29+','+dan30+','+dan31) as dani 
  from fxsap.dbo.plansatirada 
  where godina=2017
  ) x1
  inner join rfind.dbo.radnici_ r on r.id=x1.radnikid and ( ( x1.firma=1 and r.poduzece='Feroimpex')  or (x1.firma=3 and r.poduzece='Tokabu'))
  left join rfind.dbo.mjestotroska m on m.id=r.mt
  where r.neradi=0
  ) x1
  left join brojsatipomjesecima b on b.id=x1.radnikid and b.mjesec=x1.mjesec and b.firma=x1.Firma
  order by ime


  select *
  from radnici_
  where id=8008

  select *
  from Brojsatipomjesecima


