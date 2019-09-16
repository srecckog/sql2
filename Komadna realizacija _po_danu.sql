use feroapp
select *
from EvidencijaProizvedenoFakturirano_Zbirno('2017-03-01', '2017-03-31')
order by kupac


use feroapp
select *
from EvidencijaProizvedenoFakturirano_PoDanu('2017-03-01', '2017-03-31')
order by kupac

