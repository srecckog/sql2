select x1.idradnika,x1.prezime,x1.ime,sum(kasni) kasni,sum(po) preranootisao , sum(kasni+po)  nedostaje_pl,sum(nedostaje_do8) nedostaje_do8 
  from (
  
  select p.idradnika,datum, r.prezime,r.ime,r.poduzece,isnull(kasni,0) kasni,case when preranootisao>0 then  preranootisao else 0 end  po,case when (480-ukupno_minuta)>0 then  (480-ukupno_minuta) else 0 end nedostaje_do8
  from pregledvremena p
  left join radnici_ r on r.id=p.idradnika
  where year(dosao)!=1900 and dosao!=otisao
  --and r.FixnaIsplata=0
  and r.neradi=0
  --and dbo.razlikamjeseci2( month(p.datum), year(p.datum) ,1 )=1  
  --and p.datum='2017-04-03'
  -- and (480-Ukupno_minuta)>0
and month(datum)=3 and year(datum)=2018
 and idradnika=282
  --order by datum
 
  ) x1
  group by x1.idradnika,x1.prezime,x1.ime,x1.poduzece
