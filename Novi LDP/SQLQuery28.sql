USE FeroApp
SELECT PL.Naziv, PL.Hala, PLIA.* FROM ProizvodneLinijeAktivnosti PLIA 
       LEFT JOIN ProizvodneLinije PL ON PLIA.ID_PLI = PL.ID_PLI 
