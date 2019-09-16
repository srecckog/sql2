  use feroapp
  select s.id_pli,s.broj,s.naziv naziv_stroja,s.hala,l.naziv naziv_linije,s.RedniBroj RedniBrojStroja
  from proizvodnelinije l
  left join proizvodnelinije s on s.parent_pli=l.id_pli and s.hala=l.hala
  where s.vrsta='Stroj'
  order by l.hala,l.naziv,s.rednibroj