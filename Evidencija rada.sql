select *
from EvidencijaNormiRadnici 
where radnik like '%antunovi%'


select *
from EvidencijaNormiView
where  datum='2016-07-04' and radnik <>''
order by radnik


select e.radnik,e.datum,e.hala,e.smjena,e.linija,e.brojrn,p.NazivPro ,e.norma,e.kolicinaok,e.OtpadObrada,e.otpadmat,e.napomena1,e.napomena2,e.Napomena3,case when e.vrijemedo>e.vrijemeod then datediff(hour,e.vrijemeod,e.vrijemedo) else datediff(hour,vrijemeod,vrijemedo)+24 end   SatiRada
from EvidencijaNormiView e
left join proizvodi p on p.ID_Pro=e.ID_Pro
where  datum>='2016-01-01' and datum<='2016-06-30' and radnik <>''
order by radnik,datum