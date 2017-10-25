-- TO_DATE('94-11-30', 'YY-MM-DD') -> DATE
-- SUBSTR("valami",2,1) -> a
-- SUBSTR("valami",-2,1) -> m
-- INSTR("alma",'a', 1, 2) -> 2. a bet� poz�ci�ja (ha > 0 van ilyen)
-- ROUND(SQRT(4.4),2) -> 2.09
-- TO_CHAR(DATE, 'month') -> h�napn�v
-- LENGTH("alma") -> 4
-- RPAD(' ', 3, '#') -> "###"
-- UPPER("alma") -> ALMA
-- LOWER("ALMA") -> alma
-- SYSDATE -> aktu�lis timestamp
-- NVL(jutal�k, 0) -> ha null, 0-ra cser�l


-- 1) Kik azok a dolgoz�k, akik 1982.01.01 ut�n l�ptek be a c�ghez?
SELECT DNEV, BELEPES FROM DOLGOZO WHERE BELEPES > TO_DATE('1982.01.01', 'YYYY.MM.DD');
-- 2) Adjuk meg azon dolgoz�kat, akik nev�nek m�sodik bet�je 'A'.
SELECT DNEV FROM DOLGOZO WHERE SUBSTR(DNEV, 2, 1) = 'A';
-- 3) Adjuk meg azon dolgoz�kat, akik nev�ben van legal�bb k�t 'L' bet�. 
SELECT DNEV FROM DOLGOZO WHERE INSTR(DNEV,'L', 1, 2) > 0;
SELECT DNEV FROM DOLGOZO WHERE DNEV LIKE '%L%L%';
-- 4) Adjuk meg a dolgoz�k nev�nek utols� h�rom bet�j�t.
SELECT SUBSTR(DNEV, -3, 3) FROM DOLGOZO;
-- 5) Adjuk meg a dolgoz�k fizet�seinek n�gyzetgy�k�t k�t tizedesre, �s ennek eg�szr�sz�t. 
SELECT DNEV, ROUND(SQRT(FIZETES), 0) FROM DOLGOZO;
-- 6) Adjuk meg, hogy h�ny napja dolgozik a c�gn�l ADAMS �s milyen h�napban l�pett be.
SELECT DNEV, ROUND(SYSDATE - BELEPES, 0),TO_CHAR(BELEPES, 'month') FROM DOLGOZO WHERE DNEV = 'ADAMS';
-- 7) Adjuk meg azokat a (n�v, f�n�k) p�rokat, ahol a k�t ember neve ugyanannyi bet�b�l �ll. 
SELECT D1.DNEV, D2.DNEV FROM DOLGOZO D1, DOLGOZO D2 WHERE D1.DKOD = D2.FONOKE AND LENGTH(D1.DNEV) = LENGTH(D2.DNEV);
SELECT D1.DNEV, D2.DNEV FROM DOLGOZO D1 JOIN DOLGOZO D2 ON D1.DKOD = D2.FONOKE AND LENGTH(D1.DNEV) = LENGTH(D2.DNEV);
-- 8) List�zzuk ki a dolgoz�k nev�t �s fizet�s�t, valamint jelen�ts�k meg a fizet�st grafikusan
--    �gy, hogy a fizet�st 1000 Ft-ra kerek�tve, minden 1000 Ft-ot egy '#' jel jel�l.
SELECT DNEV, RPAD(' ', SUBSTR(ROUND(FIZETES, -3), 1, 1) + 1, '#') AS FIZETES FROM DOLGOZO; 
-- 9) List�zzuk ki azoknak a dolgoz�knak a nev�t, fizet�s�t, jutal�k�t, �s a jutal�k/fizet�s
--    ar�ny�t, akiknek a foglalkoz�sa elad� (salesman). Az ar�nyt k�t tizedesen jelen�ts�k meg.
SELECT DNEV, FIZETES, JUTALEK, ROUND(JUTALEK/FIZETES, 2) FROM DOLGOZO WHERE FOGLALKOZAS = 'SALESMAN';

--�sszes�t� f�ggv�nyek, csoportk�pz�s
-----------------------------------

-- 1) Mekkora a maxim�lis fizet�s a dolgoz�k k�z�tt?
SELECT MAX(FIZETES) FROM DOLGOZO;
-- 2) Mennyi a dolgoz�k �sszfizet�se?
SELECT SUM(FIZETES) FROM DOLGOZO;
-- 3) Mennyi a 20-as oszt�lyon az �tlagfizet�s?
SELECT SUM(FIZETES) / COUNT(*) FROM DOLGOZO WHERE OAZON = 20;
-- 4) Adjuk meg, hogy h�ny k�l�nb�z� foglalkoz�s fordul el� a dolgoz�k k�z�tt. 
SELECT COUNT(DISTINCT FOGLALKOZAS) FROM DOLGOZO WHERE FOGLALKOZAS IS NOT NULL;
-- 5) H�ny olyan dolgoz� van, akinek a fizet�se > 2000? 
SELECT COUNT(*) FROM DOLGOZO WHERE FIZETES > 2000;
-- 6) Adjuk meg oszt�lyonk�nt az �tlagfizet�st (oazon, atl_fiz).
SELECT OAZON, ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON; 
-- 7) Adjuk meg oszt�lyonk�nt a telephelyet �s az �tlagfizet�st (oazon, telephely, atl_fiz).
SELECT OAZON, TELEPHELY, ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON, TELEPHELY;
-- 8) Adjuk meg, hogy az egyes oszt�lyokon h�ny ember dolgozik.
SELECT TELEPHELY, COUNT(DKOD) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY TELEPHELY;
-- 9) Adjuk meg azokra az oszt�lyokra az �tlagfizet�st, ahol ez nagyobb mint 2000.
SELECT OAZON, TELEPHELY, ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON, TELEPHELY HAVING ROUND(AVG(FIZETES), 2) > 2000;
-- 10) Adjuk meg az �tlagfizet�st azokon az oszt�lyokon, ahol legal�bb 4-en dolgoznak (oazon, avg_fiz)
SELECT OAZON, COUNT(DKOD), ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON HAVING COUNT(DKOD) > 4;
-- 11) Adjuk meg az �tlagfizet�st �s telephelyet azokon az oszt�lyokon, ahol legal�bb 4-en dolgoznak.
SELECT OAZON, TELEPHELY, COUNT(DKOD), ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON, TELEPHELY HAVING COUNT(DKOD) > 4;
-- 12) Adjuk meg azon oszt�lyok nev�t �s telephely�t, ahol az �tlagfizet�s nagyobb mint 2000. (onev, telephely)
SELECT ONEV, TELEPHELY, ROUND(AVG(FIZETES), 2) 
FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY ONEV, TELEPHELY HAVING ROUND(AVG(FIZETES), 2) > 2000;
-- 13) Adjuk meg azokat a fizet�si kateg�ri�kat, amelybe pontosan 3 dolgoz� fizet�se esik.
SELECT KATEGORIA, COUNT(KATEGORIA) 
FROM DOLGOZO JOIN FIZ_KATEGORIA ON FIZETES > ALSO AND FIZETES < FELSO 
GROUP BY KATEGORIA HAVING COUNT(KATEGORIA) = 3 ;
-- 14) Adjuk meg azokat a fizet�si kateg�ri�kat, amelyekbe es� dolgoz�k mindannyian ugyanazon az oszt�lyon dolgoznak.

-- 15) Adjuk meg azon oszt�lyok nev�t �s telephely�t, amelyeknek van 1-es fizet�si kateg�ri�j� dolgoz�ja.
SELECT ONEV, TELEPHELY, KATEGORIA, COUNT(KATEGORIA) 
FROM DOLGOZO NATURAL JOIN OSZTALY JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA, OAZON, ONEV, TELEPHELY HAVING KATEGORIA = 1;
-- 16) Adjuk meg azon oszt�lyok nev�t �s telephely�t, amelyeknek legal�bb 2 f� 1-es fiz. kateg�ri�j� dolgoz�ja van.
SELECT ONEV, TELEPHELY, KATEGORIA, COUNT(KATEGORIA) 
FROM DOLGOZO NATURAL JOIN OSZTALY JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA, OAZON, ONEV, TELEPHELY HAVING KATEGORIA = 1 AND COUNT(KATEGORIA) >= 2;
-- 17) K�sz�ts�nk list�t a p�ros �s p�ratlan azonos�t�j� (dkod) dolgoz�k sz�m�r�l.
-- 18) List�zzuk ki munkak�r�nk�nt a dolgoz�k sz�m�t, �tlagfizet�s�t (kerek�tve) numerikusan �s grafikusan is.
--     200-ank�nt jelen�ts�nk meg egy '#'-ot
