SELECT ACREGNO,ACNOTEN,LEN(ACNOTEN)
FROM THR_PRSN
WHERE ACNOTEN  LIKE '%e+%'


ORDER BY LEN(ACNOTEN)

UPDATE THR_PRSN SET ACNOTEN=SUBSTRING(ACNOTEN,3,12) WHERE LEN(ACNOTEN)=14
