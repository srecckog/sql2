use planiranje
insert into planiranjeshare ( datum,proizvedeno_tok,proizvedeno_do,vrijednost_tok,vrijednost_do,tjedan,kupac,lgr_kom,lgr_eur)
select datum,kolicina_tok,kolicina_do,vrijednost_tok,vrijednost_do,tjedan,id_kupac,sgr_kom,sgr_eur
from rfind.dbo.dpr


delete from planiranje.dbo.planiranjeshare

