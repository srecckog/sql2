/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [PsrID]
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
  where firma=2 and mjesec=8 and godina=2018
  order by radnikid


  select /