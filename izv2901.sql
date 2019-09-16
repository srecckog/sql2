select radnik,vrsta,firma,datum,hala,smjena,linija,proizvod,norma,kolicinaok,otpadobrada,satiradaradnika,napomena1
from feroapp.dbo.evidnormirada(getdate(),getdate())
order by radnik

select r.id,r.prezime,r.ime,r.mt,r.DatumZaposlenja,k.Funkcija
from radnici_ r
left join kompetencije k on r.id=k.id
where r.neradi=0 and r.mt in ( 700,716)
order by r.id
