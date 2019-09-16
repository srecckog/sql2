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
'KU�I�TE FY 504M',
'KU�I�TE FY 505M',
'KU�I�TE FY 506M',
'KU�I�TE FY 507M',
'KU�I�TE FY 508M',
'KU�I�TE FY 509M',
'KU�I�TE FY 510M',
'KU�I�TE FY 511M',
'KU�I�TE FYJ 504',
'KU�I�TE FYJ 505',
'KU�I�TE FYJ 506',
'KU�I�TE FYJ 507',
'KU�I�TE FYJ 508',
'KU�I�TE SY 507M',
'KU�I�TE SY 508M',
'KU�I�TE SY 509M',
'KU�I�TE SY 510M',
'KU�I�TE SY 511M',
'KU�I�TE SYF 504',
'KU�I�TE SYF 505',
'KU�I�TE SYF 506',
'KU�I�TE SYF 507',
'KU�I�TE SYF 508',
'KU�I�TE SYF 509',
'KU�I�TE SYF 510',
'KU�I�TE SYJ 508',
'KU�I�TE FYTF 504',
'KU�I�TE FYTF 505',
'KU�I�TE FYTB 506M',
'KU�I�TE SYJ 507',
'KU�I�TE HC-FY 508M',
'KU�I�TE FY 513M'
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
'KU�I�TE FY 504M',
'KU�I�TE FY 505M',
'KU�I�TE FY 506M',
'KU�I�TE FY 507M',
'KU�I�TE FY 508M',
'KU�I�TE FY 509M',
'KU�I�TE FY 510M',
'KU�I�TE FY 511M',
'KU�I�TE FYJ 504',
'KU�I�TE FYJ 505',
'KU�I�TE FYJ 506',
'KU�I�TE FYJ 507',
'KU�I�TE FYJ 508',
'KU�I�TE SY 507M',
'KU�I�TE SY 508M',
'KU�I�TE SY 509M',
'KU�I�TE SY 510M',
'KU�I�TE SY 511M',
'KU�I�TE SYF 504',
'KU�I�TE SYF 505',
'KU�I�TE SYF 506',
'KU�I�TE SYF 507',
'KU�I�TE SYF 508',
'KU�I�TE SYF 509',
'KU�I�TE SYF 510',
'KU�I�TE SYJ 508',
'KU�I�TE FYTF 504',
'KU�I�TE FYTF 505',
'KU�I�TE FYTB 506M',
'KU�I�TE SYJ 507',
'KU�I�TE HC-FY 508M',
'KU�I�TE FY 513M'

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




						--if rsDetalji("TekstCheck01")=1 then TestCheckovi="�telanje/"		
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
      --                  if rsDetalji("TekstCheck13")=1 then TestCheckovi=TestCheckovi & "Podba�aj norme/"
      --                  if rsDetalji("TekstCheck14")=1 then TestCheckovi=TestCheckovi & "Preba�aj norme/"
      --                  if rsDetalji("TekstCheck15")=1 then TestCheckovi=TestCheckovi & "Nema sirovog materijala/"
      --                  if rsDetalji("TekstCheck16")=1 then TestCheckovi=TestCheckovi & "Pripomo� drugog radnika/"
      --                  if rsDetalji("TekstCheck17")=1 then TestCheckovi=TestCheckovi & "Novi nalog/"



