select m.NazivMat,m.VrstaMat,en.*
from evidnormi('2016-05-01','2016-05-31',0) en
left join materijali m on m.ID_Mat=en.ID_Mat
where en.BrojRN like '1978/2016'