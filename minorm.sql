use rfind
INSERT INTO MINorm (ID , DATUM     , IME                   , mt , funkcija , hala , smjena , POSTO , N1 , N2 , SA , psr , minuta , n3 ) 
select              id , getdate() , (prezime+' '+ime) ime , mt , -1       , 0    , 0      , 0     , '' , '' , '' , 'ND' ,0 , '' 
from radnici_ where datumzaposlenja>'2018-01-25'


