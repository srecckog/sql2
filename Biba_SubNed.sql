  -- rade nedjeljom a zaplanirani su
  use rfind
  select r.id,pv.datum,r.prezime,r.ime,pv.dosao,pv.otisao,pv.radnomjesto, 'Nedjelja' as dan
  from pregledvremena pv
  left join radnici_ r on r.id=pv.idradnika
  where datepart(dw, datum)=7
  and year(dosao)!=1900
  and year(datum)=2017
  and pv.radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  union all
  select r.id,pv.datum,r.prezime,r.ime,pv.dosao,pv.otisao,pv.radnomjesto, 'Subota' as dan
  from pregledvremena pv
  left join radnici_ r on r.id=pv.idradnika
  where datepart(dw, datum)=6
  and year(dosao)!=1900
  and year(datum)=2017
  and pv.radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  order by pv.datum

  --------------------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  -- rade subotom a zaplanirani su
  select *
  from pregledvremena
  where datepart(dw, datum)=6
  and year(dosao)!=1900
  and year(datum)=4
  and radnomjesto not in ( 'G.O.','B.O.','BO','4. SMJENA','Službeni put') AND HALA!='Režija'
  order by idradnika
  ----------------------------------------------------------------------------------------------