select fizetes from dolgozo
minus
select distinct d1.fizetes
from dolgozo d1, dolgozo d2
where d1.fizetes > d2.fizetes;

--minim�lis fizet�s� nevek list�z�sa, h�zi, emailben