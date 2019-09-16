  select p.acRegNo id,p.acworker,addate Pocetak_RO,addateend Prestanak_RO,cast(anwrk04 as varchar(15)) bruto,cast(anwrk23 as varchar(15)) satnica,  'AT Pomocna' Baza
  from [PantheonFxAtPomocna].dbo.thr_prsn p
  left join [PantheonFxAtPomocna].dbo.thr_prsnjob j on p.acworker=j.acworker
  where adDateEnd is null or adDateEnd>='2018-07-01'
  union all
  select p.acregno id,p.acworker,addate Pocetak_RO,addateend Prestanak_RO,cast(anwrk04 as varchar(15)) bruto,cast(anwrk23 as varchar(15)) satnica,  'TKB Pomocna' Baza
  from [PantheonTKBPomocna].dbo.thr_prsn p
  left join [PantheonTKBPomocna].dbo.thr_prsnjob j on p.acworker=j.acworker
    where adDateEnd is null or adDateEnd>='2018-07-01'  
  order by acworker