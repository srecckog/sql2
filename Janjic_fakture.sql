select fz.DatumFakture,sum(kolicinamat) kolicina
  from fakturesta fs
  left join fakturezag fz on fs.ID_FZ=fz.ID_FZ
  where fz.ID_Par=121273
  and fz.DatumFakture>='2016-09-01'
  group by fz.datumfakture
  


  select fs.ID_Pro,fs.NazivPro,fz.DatumFakture,sum(kolicinamat) kolicina
  from fakturesta fs
  left join fakturezag fz on fs.ID_FZ=fz.ID_FZ
  where fz.ID_Par=121273
  and fz.DatumFakture>='2016-09-01'
  and id_pro is not null
  group by fz.datumfakture,fs.ID_Pro,fs.NazivPro