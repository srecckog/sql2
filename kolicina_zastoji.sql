use feroapp
select *
from evidnormi('2017-04-13','2017-04-13',0)
where tekstcheck01+tekstcheck02+tekstcheck03+tekstcheck04+tekstcheck05+tekstcheck06+tekstcheck07+tekstcheck08+tekstcheck09+tekstcheck10+tekstcheck11+tekstcheck12+tekstcheck13+tekstcheck14+tekstcheck14+tekstcheck15+tekstcheck16+tekstcheck17+tekstcheck18+tekstcheck19+tekstcheck20=0
order by RADNIK desc


use feroapp
select radnik,vrijemeod,vrijemedo,TekstCheck01,TekstCheck02,TekstCheck03,TekstCheck04,TekstCheck05,TekstCheck06
from evidnormi('2017-04-13','2017-04-13',0)
order by radnik


WHERE RADNIK LIKE '%bagiæ%'


GROUP BY RADNIK


order by datum desc