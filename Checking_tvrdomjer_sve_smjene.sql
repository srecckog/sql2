SELECT datum, tvrdomjer,COUNT(*) broj_mjerenja_po_danu
  FROM KalionicaTvrdomjeriMjerenja
  GROUP BY tvrdomjer,datum
  having count(*)<3