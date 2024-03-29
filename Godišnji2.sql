/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [acWorker]
      ,[anYear]
      ,[anVacationLOS]
      ,[anVacationjob]
      ,[anVacationCircum]
      ,[anVacationKids]
      ,[anVacationDisab]
      ,[anVacationAdditional]
      ,[anVacationLastYr]
      ,[anVacationFormula]
      ,[anUserIns]
      ,[anUserChg]
      ,[adTimeIns]
      ,[adTimeChg]
      ,[acVacationCalcType]
      ,[acName]
      ,[anVacationCorr]
      ,[acSendedByEMail]
      ,[acEMailPayroll]
      ,[anVacationLYUnused]
      ,[adVacationDelete]
      ,[adVacationLastYr]
      ,[anQId]
      ,[adEMailSend]
      ,[anVacationF1]
      ,[anVacationF2]
      ,[anVacationF3]
      ,[acEMailReport]
  FROM [PantheonFxAt].[dbo].[tHR_PrsnVacation]
  where acworker like '%hren%'

  
  select p.acregno id, p.acworker,j.adDate PocetakRada,j.acDept MT,j.acCostDrv Location,v.anVacationKids, [anVacationF1],'Feroimpex' poduzeće
  from [PantheonFxAt].[dbo].[tHR_Prsn] p
  left join [PantheonFxAt].[dbo].[tHR_Prsnstatus] s on s.acworker=p.acworker
  left join [PantheonFxAt].[dbo].[tHR_Prsnjob] j on j.acworker=p.acworker
  left join [PantheonFxAt].[dbo].[tHR_PrsnVacation] v on v.acworker=p.acworker
  where p.acActive='T' and j.adDateEnd is null and s.acStatus like '%Radnik%'
  union all
  select p.acregno id, p.acworker,j.adDate PocetakRada,j.acDept MT,j.acCostDrv Location,v.anVacationKids, [anVacationF1],'Tokabu' poduzeće
  from [PantheonTKB].[dbo].[tHR_Prsn] p
  left join [PantheonTKB].[dbo].[tHR_Prsnstatus] s on s.acworker=p.acworker
  left join [PantheonTKB].[dbo].[tHR_Prsnjob] j on j.acworker=p.acworker
  left join [PantheonTKB].[dbo].[tHR_PrsnVacation] v on v.acworker=p.acworker
  where p.acActive='T' and j.adDateEnd is null and s.acStatus like '%Radnik%'   
  order by acworker


  select *
  from [PantheonFxAt].[dbo].[tHR_Prsnjob] p

  select *
  from [PantheonFxAt].[dbo].[tHR_Prsn] p

  order by acworker

