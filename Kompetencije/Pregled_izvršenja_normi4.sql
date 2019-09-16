use feroapp
select x1.id_fink , x1.radnik,ceiling(avg( (x1.kolicina+0.0001)/ (x1.norma_pl+0.0001)*100 )) posto
from (

select distinct l.id,  case when n.Tekstcheck02=1 or n.Tekstcheck07=1 then l.kolicina/2 else  l.[max] end as norma_pl,l.kolicina/2 kolicina,l.datum,l.hala,l.smjena,l.linija,n.id_pro,d.id_fink,l.radnik
--select distinct l.id,  l.[max] as norma_pl,l.kolicina kolicina,l.datum,l.hala,l.smjena,l.linija,n.id_pro,d.id_fink,l.radnik
from evidnormi( rfind.dbo.prvizadnjidan(1,1),rfind.dbo.prvizadnjidan(2,1) ,0) n
left join evidnormirada( rfind.dbo.prvizadnjidan(1,1),rfind.dbo.prvizadnjidan(2,1) ) r on n.datum=r.datum and n.brojrn=r.brojrn and n.hala=r.hala and n.smjena=r.smjena and n.linija=r.linija 
left join [fxsql2].fxapp.dbo.ldp_aktivnost_view l on l.proizvod=n.nazivpro and l.datum=r.datum and r.hala=l.hala and r.smjena=l.smjena and r.linija=l.linija and l.id_partner=n.id_par
left join radnici d on r.id_radnika=d.id_radnika
where l.kolicina>0 and l.max>1
and l.proizvod in
(
'1-57926-0000-MB-00',
'1-58080-0000-MB-00',
'1-58081-0000-MB-01',
'1-58089-0000-MB-00',
'1-58102-0000-MB-00',
'1-58233-0000-MB-00',
'1-58234-0000-MB-00',
'1-58235-0000-MB-00',
'1-58080-0000-MB-00 / SKIDANJE SRHA',
'KUÆIŠTE FY 504M',
'KUÆIŠTE FY 505M',
'KUÆIŠTE FY 506M',
'KUÆIŠTE FY 507M',
'KUÆIŠTE FY 508M',
'KUÆIŠTE FY 509M',
'KUÆIŠTE FY 510M',
'KUÆIŠTE FY 511M',
'KUÆIŠTE FYJ 504',
'KUÆIŠTE FYJ 505',
'KUÆIŠTE FYJ 506',
'KUÆIŠTE FYJ 507',
'KUÆIŠTE FYJ 508',
'KUÆIŠTE SY 507M',
'KUÆIŠTE SY 508M',
'KUÆIŠTE SY 509M',
'KUÆIŠTE SY 510M',
'KUÆIŠTE SY 511M',
'KUÆIŠTE SYF 504',
'KUÆIŠTE SYF 505',
'KUÆIŠTE SYF 506',
'KUÆIŠTE SYF 507',
'KUÆIŠTE SYF 508',
'KUÆIŠTE SYF 509',
'KUÆIŠTE SYF 510',
'KUÆIŠTE SYJ 508',
'KUÆIŠTE FYTF 504',
'KUÆIŠTE FYTF 505',
'KUÆIŠTE FYTB 506M',
'KUÆIŠTE SYJ 507',
'KUÆIŠTE HC-FY 508M',
'KUÆIŠTE FY 513M'
)



union all

select distinct l.id,  case when n.Tekstcheck02=1 or n.Tekstcheck07=1 then l.kolicina else  l.[max] end as norma_pl,l.kolicina kolicina,l.datum,l.hala,l.smjena,l.linija,n.id_pro,d.id_fink,l.radnik
--select distinct l.id,  l.[max] as norma_pl,l.kolicina kolicina,l.datum,l.hala,l.smjena,l.linija,n.id_pro,d.id_fink,l.radnik
from evidnormi( rfind.dbo.prvizadnjidan(1,1),rfind.dbo.prvizadnjidan(2,1) ,0) n
left join evidnormirada( rfind.dbo.prvizadnjidan(1,1),rfind.dbo.prvizadnjidan(2,1) ) r on n.datum=r.datum and n.brojrn=r.brojrn and n.hala=r.hala and n.smjena=r.smjena and n.linija=r.linija 
left join [fxsql2].fxapp.dbo.ldp_aktivnost_view l on l.proizvod=n.nazivpro and l.datum=r.datum and r.hala=l.hala and r.smjena=l.smjena and r.linija=l.linija and l.id_partner=n.id_par
left join radnici d on r.id_radnika=d.id_radnika
where l.kolicina>0 and l.max>1
and l.proizvod not in
(
'1-57926-0000-MB-00',
'1-58080-0000-MB-00',
'1-58081-0000-MB-01',
'1-58089-0000-MB-00',
'1-58102-0000-MB-00',
'1-58233-0000-MB-00',
'1-58234-0000-MB-00',
'1-58235-0000-MB-00',
'1-58080-0000-MB-00 / SKIDANJE SRHA',
'KUÆIŠTE FY 504M',
'KUÆIŠTE FY 505M',
'KUÆIŠTE FY 506M',
'KUÆIŠTE FY 507M',
'KUÆIŠTE FY 508M',
'KUÆIŠTE FY 509M',
'KUÆIŠTE FY 510M',
'KUÆIŠTE FY 511M',
'KUÆIŠTE FYJ 504',
'KUÆIŠTE FYJ 505',
'KUÆIŠTE FYJ 506',
'KUÆIŠTE FYJ 507',
'KUÆIŠTE FYJ 508',
'KUÆIŠTE SY 507M',
'KUÆIŠTE SY 508M',
'KUÆIŠTE SY 509M',
'KUÆIŠTE SY 510M',
'KUÆIŠTE SY 511M',
'KUÆIŠTE SYF 504',
'KUÆIŠTE SYF 505',
'KUÆIŠTE SYF 506',
'KUÆIŠTE SYF 507',
'KUÆIŠTE SYF 508',
'KUÆIŠTE SYF 509',
'KUÆIŠTE SYF 510',
'KUÆIŠTE SYJ 508',
'KUÆIŠTE FYTF 504',
'KUÆIŠTE FYTF 505',
'KUÆIŠTE FYTB 506M',
'KUÆIŠTE SYJ 507',
'KUÆIŠTE HC-FY 508M',
'KUÆIŠTE FY 513M'

)
--and l.datum='2017-04-18' and l.hala=1 and l.smjena=1 and l.linija='01'
--order by l.radnik

) x1
--where x1.datum='2017-04-18' and x1.hala=3 and x1.smjena=3 and x1.linija='19'
--order by radnik
group by x1.id_fink,x1.radnik
order by x1.radnik



select *
from [fxsql2].fxapp.dbo.ldp_aktivnost_view
where month(datum)=4 and year(datum)=2017
and radnik like '%Carin%'
order by DATUM


select *
from evidnormi('2017-04-19','2017-04-19',0)
where hala=1 and linija='36' and smjena=3




						--if rsDetalji("TekstCheck01")=1 then TestCheckovi="Štelanje/"		
      --                  if rsDetalji("TekstCheck02")=1 then TestCheckovi=TestCheckovi & "Kraj serije/"
      --                  if rsDetalji("TekstCheck03")=1 then TestCheckovi=TestCheckovi & "Prekid serije/"
      --                  if rsDetalji("TekstCheck04")=1 then TestCheckovi=TestCheckovi & "Bolovanja-zdravst. problemi/"
      --                  if rsDetalji("TekstCheck05")=1 then TestCheckovi=TestCheckovi & "Rad pod pauzom/"
      --                  if rsDetalji("TekstCheck06")=1 then TestCheckovi=TestCheckovi & "Nema djelatnika/"
      --                  if rsDetalji("TekstCheck07")=1 then TestCheckovi=TestCheckovi & "Kvar stroja/"
      --                  if rsDetalji("TekstCheck08")=1 then TestCheckovi=TestCheckovi & "Remont/"
      --                  if rsDetalji("TekstCheck09")=1 then TestCheckovi=TestCheckovi & "Problem sa steznim alatom/"
      --                  if rsDetalji("TekstCheck10")=1 then TestCheckovi=TestCheckovi & "Problem sa reznim alatom/"
      --                  if rsDetalji("TekstCheck11")=1 then TestCheckovi=TestCheckovi & "Problem sa mjerama/"
      --                  if rsDetalji("TekstCheck12")=1 then TestCheckovi=TestCheckovi & "Rad bez transporetera/"
      --                  if rsDetalji("TekstCheck13")=1 then TestCheckovi=TestCheckovi & "Podbaèaj norme/"
      --                  if rsDetalji("TekstCheck14")=1 then TestCheckovi=TestCheckovi & "Prebaèaj norme/"
      --                  if rsDetalji("TekstCheck15")=1 then TestCheckovi=TestCheckovi & "Nema sirovog materijala/"
      --                  if rsDetalji("TekstCheck16")=1 then TestCheckovi=TestCheckovi & "Pripomoæ drugog radnika/"
      --                  if rsDetalji("TekstCheck17")=1 then TestCheckovi=TestCheckovi & "Novi nalog/"



