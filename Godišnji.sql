  select v1.acworker,anvacationf1 brojdana_3107, isnull(v2.brojdanago,0) iskoristeno_go,(anvacationf1+-isnull(v2.brojdanago,0)) preostalo_go
  FROM [PantheonFxAt].[dbo].[tHR_PrsnVacation] v1
  left join (  select accode,count(*) brojdanago
  FROM [PantheonFxAt].[dbo].[tHR_PrsnCalendar]
  where actype2='GOO' AND ADdateSTART>='2018-08-01'
  GROUP BY ACCODE ) v2 on v1.acWorker=v2.accode
  left join  ( select acworker, acActive
  FROM [PantheonFxAt].[dbo].[tHR_Prsn] ) v3
  on v3.acworker=v1.acworker
  where v3.acActive='T'