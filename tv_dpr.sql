select '1' id,'D' tip,1 oznaka, isnull(sum(isnull(kolicinaok,0)),0) kolicinaok,kupac
  from feroapp.dbo.evidnormi(getdate(),getdate(),0)  
  where lINIJA NOT IN ( 'GT600-1','GT600-2','GT600-3','GT600-4','GT600-5','HURCO','VC510','INDEX')
  and obrada3=0
  group by kupac

  