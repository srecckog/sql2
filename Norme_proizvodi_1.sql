select datum,hala,linija,id_pro,id_mat,nazivpro,norma,sum(kolicinaok) kolicinaok,kupac
from feroapp.dbo.evidnormi(getdate()-5,getdate(),0)
where norma=1 and kolicinaok>0
group by datum,hala,linija,id_pro,id_mat,nazivpro,norma,kupac
