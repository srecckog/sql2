  select es.linija,es.id_radnika,es.radnik,es.kolicinaok,es.norma,r.id_fink,ez.Datum
  from [dbo].[EvidencijaNormista] es
  left join [dbo].[EvidencijaNormizag] ez on ez.id_enz = es.id_enz
  left join [dbo].radnici r on r.id_radnika=es.ID_radnika
  where datum='2017-05-02'
  order by radnik

