-- 1) Adjuk meg, hogy az egyes oszt�lyokon h�ny ember dolgozik.
SELECT COUNT(*) FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON;
-- 2) Adjuk meg azokra az oszt�lyokra az �tlagfizet�st, ahol ez nagyobb mint 2000.
SELECT ROUND(AVG(FIZETES), 2) FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON HAVING AVG(FIZETES) > 2000;
-- 3) Adjuk meg az �tlagfizet�st azokon az oszt�lyokon, ahol legal�bb 4-en dolgoznak (oazon, avg_fiz)
SELECT ROUND(AVG(FIZETES), 2) FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON HAVING COUNT(*) >= 4;
-- 4) Adjuk meg az �tlagfizet�st �s telephelyet azokon az oszt�lyokon, ahol legal�bb 4-en dolgoznak.
SELECT TELEPHELY, ROUND(AVG(FIZETES), 2) FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON, TELEPHELY HAVING COUNT(*) >= 4;
-- 5) Adjuk meg azon oszt�lyok nev�t �s telephely�t, ahol az �tlagfizet�s nagyobb mint 2000. (onev, telephely)
SELECT ONEV, TELEPHELY FROM DOLGOZO NATURAL JOIN OSZTALY GROUP BY OAZON, ONEV, TELEPHELY HAVING AVG(FIZETES) > 2000;
-- 6) Adjuk meg azokat a fizet�si kateg�ri�kat, amelybe pontosan 3 dolgoz� fizet�se esik.
SELECT KATEGORIA
FROM DOLGOZO JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA HAVING COUNT(KATEGORIA) = 3;
-- 7) Adjuk meg azokat a fizet�si kateg�ri�kat, amelyekbe es� dolgoz�k mindannyian ugyanazon az oszt�lyon dolgoznak.

-- 8) Adjuk meg azon oszt�lyok nev�t �s telephely�t, amelyeknek van 1-es fizet�si kateg�ri�j� dolgoz�ja.
SELECT ONEV, TELEPHELY, KATEGORIA, COUNT(KATEGORIA) 
FROM DOLGOZO NATURAL JOIN OSZTALY JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA, OAZON, ONEV, TELEPHELY HAVING KATEGORIA = 1;
-- 9) Adjuk meg azon oszt�lyok nev�t �s telephely�t, amelyeknek legal�bb 2 f� 1-es fiz. kateg�ri�j� dolgoz�ja van.
SELECT ONEV, TELEPHELY, KATEGORIA, COUNT(KATEGORIA) 
FROM DOLGOZO NATURAL JOIN OSZTALY JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA, OAZON, ONEV, TELEPHELY HAVING KATEGORIA = 1 AND COUNT(KATEGORIA) >= 2;
-- 10) K�sz�ts�nk list�t a p�ros �s p�ratlan azonos�t�j� (dkod) dolgoz�k sz�m�r�l.

-- 11) List�zzuk ki munkak�r�nk�nt a dolgoz�k sz�m�t, �tlagfizet�s�t (kerek�tve) numerikusan �s grafikusan is.
--     200-ank�nt jelen�ts�nk meg egy '#'-ot
SELECT KATEGORIA, COUNT(KATEGORIA), ROUND(AVG(FIZETES), 2), RPAD(' ', ROUND(AVG(FIZETES) / 200, 0) + 1, '#') AS ATLAG_FIZETES
FROM DOLGOZO JOIN FIZ_KATEGORIA ON FIZETES BETWEEN ALSO AND FELSO 
GROUP BY KATEGORIA;
-- 12) Adjuk meg azokat a fizet�si kateg�ri�kat, amelybe pontosan 3 dolgoz� fizet�se esik.

-- 13) Adjuk meg azokat a fizet�si kateg�ri�kat, amelyekbe es� dolgoz�k mindannyian ugyanazon az oszt�lyon dolgoznak.
-- 14) Adjuk meg azon oszt�lyok nev�t �s telephely�t, amelyeknek van 1-es fizet�si kateg�ri�j� dolgoz�ja.
-- 15) Adjuk meg azon oszt�lyok nev�t �s telephely�t, amelyeknek legal�bb 2 f� 1-es fiz. kateg�ri�j� dolgoz�ja van.
-- 16) K�sz�ts�nk list�t a p�ros �s p�ratlan azonos�t�j� (dkod) dolgoz�k sz�m�r�l.
-- 17) List�zzuk ki munkak�r�nk�nt a dolgoz�k sz�m�t, �tlagfizet�s�t (kerek�tve) numerikusan �s grafikusan is. 200-ank�nt jelen�ts�nk meg egy '#'-ot

------------
---SZERET---
------------
-- 1) Kik szeretnek minden gy�m�lcs�t?
-- 2) Kik azok, akik legal�bb azokat a gy�m�lcs�ket szeretik, mint Micimack�?
-- 3) Kik azok, akik legfeljebb azokat a gy�m�lcs�ket szeretik, mint Micimack�?
-- 4) Kik azok, akik pontosan azokat a gy�m�lcs�ket szeretik, mint Micimack�?
-- 5) Melyek azok a (n�v,n�v) p�rok, akiknek legal�bb egy gy�m�lcsben elt�r az �zl�s�k, azaz az  egyik szereti ezt a gy�m�lcs�t, a m�sik meg nem?
-- 6) Melyek azok a (n�v,n�v) p�rok, akiknek pontosan ugyanaz az �zl�s�k, azaz  pontosan  ugyanazokat a gy�m�lcs�ket szeretik? 
-- 7) SZERET(NEV, GYUMOLCS) t�bla helyett EVETT(NEV, KG) legyen a rel�ci�s�ma �s azt tartalmazza, hogy ki mennyi gy�m�lcs�t evett �sszesen. Ki ette a legt�bb gy�m�lcs�t? 