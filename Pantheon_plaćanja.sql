SELECT TOP 1000 
a.adTimeIns,
	S.ACNAME2	
      ,[anNo]
      ,[acAcct]
      ,a.acSubject
      ,[anDebit]
      ,[anCredit]
      ,[acDoc]
      ,[adDateDoc]
      ,[acLinkDoc]
      ,[adDateDue]
      ,a.[acCurrency]
      ,[anFXRate]
      ,[anValDebit]
      ,[anValCredit]
      ,a.[acDept]
      ,a.[acNote]
      ,[acVATPayed]
      ,[acContraAcct]
      ,[acForeignDoc]
      ,[adDateVAT]
      ,[acCostDrv]
      ,a.[adTimeChg]
      ,a.[anUserChg]
      ,[anOrgNo]
      ,[acKeyCloseAcctTrans]
      ,[anEventTypeID]
      ,[anStatus]
      ,a.[anQId]
      ,[acAutoPosting]	  
  FROM [PantheonFxAt].[dbo].[tHE_AcctTransItem] a
  left join [PantheonFxAt].[dbo].[tHE_SetSubj] s on s.acsubject=a.acsubject
  where andebit>0 
  and a.acsubject in ( '511852','16950','511855','260950','36250','1829','28900','511806','20200')  -- IT oprema, slovoreklam
  --and aclinkdoc like '%4269%'
  --order by anQid desc
  order by a.adDateDoc desc,acname2 



  select *
  FROM [PantheonFxAt].[dbo].[tHE_AcctTransItem] a
  where acsubject='511806'
  order by addatedoc desc
  
  SELECT *
  FROM [PantheonFxAt].[dbo].[tHE_SetSubj]
  WHERE ACNAME2 LIKE '%analogbit%'



  select a.adTimeIns,
	S.ACNAME2	
      ,[anNo]
      ,[acAcct]
      ,a.acSubject
      ,[anDebit]
      ,[anCredit]
      ,[acDoc]
      ,[adDateDoc]
      ,[acLinkDoc]
      ,[adDateDue]
      ,a.[acCurrency]
      ,[anFXRate]
      ,[anValDebit]
      ,[anValCredit]
      ,a.[acDept]
      ,a.[acNote]
      ,[acVATPayed]
      ,[acContraAcct]
      ,[acForeignDoc]
      ,[adDateVAT]
      ,[acCostDrv]
      ,a.[adTimeChg]
      ,a.[anUserChg]
      ,[anOrgNo]
      ,[acKeyCloseAcctTrans]
      ,[anEventTypeID]
      ,[anStatus]
      ,a.[anQId]
      ,[acAutoPosting]	  
  from [PantheonFxAt].[dbo].[tHE_AcctTransItem] a
  left join [PantheonFxAt].[dbo].[tHE_SetSubj] s on s.acsubject=a.acsubject
   order by a.adDateDoc desc,acname2 



