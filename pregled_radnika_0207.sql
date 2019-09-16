select distinct r.id,r.poduzece,r.prezime,r.ime,p.dosao,p.otisao,P.Ukupno_minuta,P.radnomjesto,r.mt,p.hala,s.dan02,s.RadnikID,case when s.Firma=1 then 'AT' else 'TKB' end firma
from radnici_ r
left join pregledvremena p on r.id=p.IDRadnika
LEFT JOIN feroapp.dbo.radnici r2 on r2.id_radnika=r.id_radnika
left join fxsap.dbo.plansatirada s on s.RadnikID=r2.ID_Fink and r2.ID_Firme=s.Firma and s.mjesec=7 and s.godina=2019
where p.datum='2019-07-02'
order by prezime


select *
from radnici_
order by prezime


update RADNICI_ SET prezime ='ŠEBALJ' WHERE ID=1229

select *
from pregledvremena
where IDRadnika=1229
and datum='2019-07-02'
