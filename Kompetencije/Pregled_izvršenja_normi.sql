  select es.linija,es.ID_ENS,es.ID_ENZ,es.id_radnika,es.radnik,es.kolicinaok,es.norma,r.id_fink,ez.Datum
  from fxserver.fxapp.[dbo].[EvidencijaNormista] es
  left join fxserver.fxapp.[dbo].[EvidencijaNormizag] ez on ez.id_enz = es.id_enz
  left join [dbo].radnici r on r.id_radnika=es.ID_radnika
  where year(datum)=2017 and month(datum)=3
  and es.id_radnika not in ( 0)
  order by radnik,datum



  select *
  from [dbo].[EvidencijaNormista] es
  where ID_Radnika=1506

