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
  where godina=2017
  and (
dan01='8b' or dan01='0e' or
dan01='8b' or dan01='0e' or
dan02='8b' or dan02='0e' or
dan03='8b' or dan03='0e' or
dan04='8b' or dan04='0e' or
dan05='8b' or dan05='0e' or
dan06='8b' or dan06='0e' or
dan07='8b' or dan07='0e' or
dan08='8b' or dan08='0e' or
dan09='8b' or dan09='0e' or
dan10='8b' or dan10='0e' or
dan11='8b' or dan11='0e' or
dan12='8b' or dan12='0e' or
dan13='8b' or dan13='0e' or
dan14='8b' or dan14='0e' or
dan15='8b' or dan15='0e' or
dan16='8b' or dan16='0e' or
dan17='8b' or dan17='0e' or
dan18='8b' or dan18='0e' or
dan19='8b' or dan19='0e' or
dan20='8b' or dan20='0e' or
dan21='8b' or dan21='0e' or
dan22='8b' or dan22='0e' or
dan23='8b' or dan23='0e' or
dan24='8b' or dan24='0e' or
dan25='8b' or dan25='0e' or
dan26='8b' or dan26='0e' or
dan27='8b' or dan27='0e' or
dan28='8b' or dan28='0e' or
dan29='8b' or dan29='0e' or
dan30='8b' or dan30='0e' or
dan31='8b' or dan31='0e' 
)
and 
radnikid not in 
(


select radnikid
from [FxSAP].[dbo].[PlanSatiRada]
where godina=2017
and danodlaska is NOT NULL
--ORDER BY RADNIKID


)


order by ime,mjesec