select 2 tip,p.firma,p.radnikid,p.ime,p.mt,p.dan14,v.dosao,v.otisao,v.ukupno_minuta/60 sati,v.smjena,v.radnomjesto 
from  fxsap.dbo.plansatirada p 
left join feroapp.dbo.radnici r on r.id_fink=p.radnikid and r.id_firme=p.Firma 
left join rfind.dbo.radnici_ a on a.id_radnika=r.id_radnika 
left join rfind.dbo.pregledvremena v on v.idradnika=a.id and v.Datum='2019-05-14' 
where mjesec=5 and godina=2019 and ( year(v.dosao)!=1900 or v.ukupno_minuta>60 ) and 
p.mt not in ( 710,713,704) and ( p.dan14 is null or p.dan14 ='0e') 
order by ime