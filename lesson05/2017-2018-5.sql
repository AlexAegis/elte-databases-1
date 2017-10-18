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


-- 1) Kik azok a dolgoz�k, akik 1982.01.01 ut�n l�ptek be a c�ghez?
-- 2) Adjuk meg azon dolgoz�kat, akik nev�nek m�sodik bet�je 'A'.
-- 3) Adjuk meg azon dolgoz�kat, akik nev�ben van legal�bb k�t 'L' bet�. 
-- 4) Adjuk meg a dolgoz�k nev�nek utols� h�rom bet�j�t.
-- 5) Adjuk meg a dolgoz�k fizet�seinek n�gyzetgy�k�t k�t tizedesre, �s ennek eg�szr�sz�t. 
-- 6) Adjuk meg, hogy h�ny napja dolgozik a c�gn�l ADAMS �s milyen h�napban l�pett be.
-- 7) Adjuk meg azokat a (n�v, f�n�k) p�rokat, ahol a k�t ember neve ugyanannyi bet�b�l �ll. 
-- 8) List�zzuk ki a dolgoz�k nev�t �s fizet�s�t, valamint jelen�ts�k meg a fizet�st grafikusan
  -- a) �gy, hogy a fizet�st 1000 Ft-ra kerek�tve, minden 1000 Ft-ot egy '#' jel jel�l.
-- 9) List�zzuk ki azoknak a dolgoz�knak a nev�t, fizet�s�t, jutal�k�t, �s a jutal�k/fizet�s
  -- a) ar�ny�t, akiknek a foglalkoz�sa elad� (salesman). Az ar�nyt k�t tizedesen jelen�ts�k meg.


--�sszes�t� f�ggv�nyek, csoportk�pz�s
-----------------------------------

-- 1) Mekkora a maxim�lis fizet�s a dolgoz�k k�z�tt?
-- 2) Mennyi a dolgoz�k �sszfizet�se?
-- 3) Mennyi a 20-as oszt�lyon az �tlagfizet�s?
-- 4) Adjuk meg, hogy h�ny k�l�nb�z� foglalkoz�s fordul el� a dolgoz�k k�z�tt. 
-- 5) H�ny olyan dolgoz� van, akinek a fizet�se > 2000? 
-- 6) Adjuk meg oszt�lyonk�nt az �tlagfizet�st (oazon, atl_fiz).
-- 7) Adjuk meg oszt�lyonk�nt a telephelyet �s az �tlagfizet�st (oazon, telephely, atl_fiz).
-- 8) Adjuk meg, hogy az egyes oszt�lyokon h�ny ember dolgozik.
-- 9) Adjuk meg azokra az oszt�lyokra az �tlagfizet�st, ahol ez nagyobb mint 2000.
-- 10) Adjuk meg az �tlagfizet�st azokon az oszt�lyokon, ahol legal�bb 4-en dolgoznak (oazon, avg_fiz)
-- 11) Adjuk meg az �tlagfizet�st �s telephelyet azokon az oszt�lyokon, ahol legal�bb 4-en dolgoznak.
-- 12) Adjuk meg azon oszt�lyok nev�t �s telephely�t, ahol az �tlagfizet�s nagyobb mint 2000. (onev, telephely)
-- 13) Adjuk meg azokat a fizet�si kateg�ri�kat, amelybe pontosan 3 dolgoz� fizet�se esik.
-- 14) Adjuk meg azokat a fizet�si kateg�ri�kat, amelyekbe es� dolgoz�k mindannyian ugyanazon az oszt�lyon dolgoznak.
-- 15) Adjuk meg azon oszt�lyok nev�t �s telephely�t, amelyeknek van 1-es fizet�si kateg�ri�j� dolgoz�ja.
-- 16) Adjuk meg azon oszt�lyok nev�t �s telephely�t, amelyeknek legal�bb 2 f� 1-es fiz. kateg�ri�j� dolgoz�ja van.
-- 17) K�sz�ts�nk list�t a p�ros �s p�ratlan azonos�t�j� (dkod) dolgoz�k sz�m�r�l.
-- 18) List�zzuk ki munkak�r�nk�nt a dolgoz�k sz�m�t, �tlagfizet�s�t (kerek�tve) numerikusan �s grafikusan is.
  -- a) 200-ank�nt jelen�ts�nk meg egy '#'-ot
