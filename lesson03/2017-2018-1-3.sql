---SZERET---
------------

-- 1) Kik szeretnek legal�bb k�tf�le gy�m�lcs�t?
SELECT DISTINCT SZ1.NEV 
FROM SZERET SZ1, SZERET SZ2 
WHERE SZ1.NEV = SZ2.NEV AND SZ1.GYUMOLCS != SZ2.GYUMOLCS;

SELECT NEV
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) >= 2;
-- 2) Kik szeretnek legal�bb h�romf�le gy�m�lcs�t?
SELECT DISTINCT SZ1.NEV 
FROM SZERET SZ1, SZERET SZ2, SZERET SZ3
WHERE SZ1.NEV = SZ2.NEV 
    AND SZ2.NEV = SZ3.NEV
    AND SZ3.NEV = SZ1.NEV -- this is unnecessary due to transitivity
    AND SZ1.GYUMOLCS != SZ2.GYUMOLCS 
    AND SZ2.GYUMOLCS != SZ3.GYUMOLCS 
    AND SZ3.GYUMOLCS != SZ1.GYUMOLCS;

SELECT NEV
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) >= 3;
-- 3) Kik szeretnek legfeljebb k�tf�le gy�m�lcs�t?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) <= 2;
-- 4) Kik szeretnek pontosan k�tf�le gy�m�lcs�t?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) = 2;

---DOLGOZO---
-------------

-- 1) Kik azok a dolgoz�k, akiknek a f�n�ke KING? (nem leolvasva)
SELECT D1.DNEV "Alkalmazott", D2.DNEV "F�n�ke"
FROM DOLGOZO D1 JOIN DOLGOZO D2
ON D1.FONOKE = D2.DKOD
WHERE D2.DNEV = 'KING';
-- 2) Adjuk meg azoknak a f�n�k�knek a nev�t, akiknek a foglalkoz�sa nem 'MANAGER'. (dnev)
SELECT DISTINCT D1.DNEV "N�v", D1.FOGLALKOZAS "Foglalkoz�s"
FROM DOLGOZO D1 JOIN DOLGOZO D2
ON D2.FONOKE = D1.DKOD 
WHERE D1.FOGLALKOZAS != 'MANAGER';
-- 3) Adjuk meg azokat a dolgoz�kat, akik t�bbet keresnek a f�n�k�kn�l.
SELECT D1.DNEV "F�n�k", D1.FOGLALKOZAS "F�n�k foglalkoz�sa", D1.FIZETES "F�n�k fizet�se",  D2.DNEV "Alkalmazott", D2.FOGLALKOZAS "Alkalmazott foglalkoz�sa", D2.FIZETES "Alkalmazott fizet�se"
FROM DOLGOZO D1 JOIN DOLGOZO D2
ON D2.FONOKE = D1.DKOD
WHERE D2.FIZETES > D1.FIZETES;

SELECT D1.DNEV "F�n�k", D1.FOGLALKOZAS "F�n�k foglalkoz�sa", D1.FIZETES "F�n�k fizet�se",  D2.DNEV "Alkalmazott", D2.FOGLALKOZAS "Alkalmazott foglalkoz�sa", D2.FIZETES "Alkalmazott fizet�se"
FROM DOLGOZO D1, DOLGOZO D2
WHERE D2.FONOKE = D1.DKOD AND D2.FIZETES > D1.FIZETES;
-- 4) Kik azok a dolgoz�k, akik f�n�k�nek a f�n�ke KING?
SELECT D1.DKOD "Alk k�d",
        D1.DNEV "Alk",
        D1.FONOKE "Alk f�n�ke",
        D2.DKOD "F�n k�d",
        D2.DNEV "F�n",
        D2.FONOKE "F�n f�n�ke",
        D3.DKOD "F�n f�n k�d",
        D3.DNEV "F�n f�n",
        D3.FONOKE "F�n f�n f�n�ke"
FROM DOLGOZO D1,
        DOLGOZO D2,
        DOLGOZO D3
WHERE D1.FONOKE = D2.DKOD 
    AND D2.FONOKE = D3.DKOD
    AND D3.DNEV = 'KING';
-- 5) Kik azok a dolgoz�k, akik oszt�ly�nak telephelye DALLAS vagy CHICAGO?
SELECT * 
FROM DOLGOZO JOIN OSZTALY 
ON DOLGOZO.OAZON = OSZTALY.OAZON
WHERE OSZTALY.TELEPHELY = 'DALLAS' OR OSZTALY.TELEPHELY = 'CHICAGO';

SELECT * 
FROM DOLGOZO, OSZTALY 
WHERE DOLGOZO.OAZON = OSZTALY.OAZON
      AND (OSZTALY.TELEPHELY = 'DALLAS' OR OSZTALY.TELEPHELY = 'CHICAGO');
-- 6) Kik azok a dolgoz�k, akik oszt�ly�nak telephelye nem DALLAS �s nem CHICAGO?
SELECT * 
FROM DOLGOZO JOIN OSZTALY 
ON DOLGOZO.OAZON = OSZTALY.OAZON
WHERE OSZTALY.TELEPHELY != 'DALLAS' AND OSZTALY.TELEPHELY != 'CHICAGO';

SELECT * 
FROM DOLGOZO, OSZTALY 
WHERE DOLGOZO.OAZON = OSZTALY.OAZON
      AND (OSZTALY.TELEPHELY != 'DALLAS' AND OSZTALY.TELEPHELY != 'CHICAGO');
-- 7) Adjuk meg azoknak a nev�t, akiknek a fizet�se > 2000 vagy a CHICAGO-i oszt�lyon dolgoznak.
SELECT * 
FROM DOLGOZO JOIN OSZTALY 
ON DOLGOZO.OAZON = OSZTALY.OAZON
WHERE OSZTALY.TELEPHELY = 'CHICAGO' OR DOLGOZO.FIZETES > 2000;

SELECT * 
FROM DOLGOZO, OSZTALY 
WHERE DOLGOZO.OAZON = OSZTALY.OAZON
      AND (OSZTALY.TELEPHELY = 'CHICAGO' OR DOLGOZO.FIZETES > 2000);
-- 8) Melyik oszt�lynak nincs dolgoz�ja?
SELECT TELEPHELY FROM OSZTALY 
MINUS
SELECT DISTINCT TELEPHELY
FROM DOLGOZO JOIN OSZTALY
ON OSZTALY.OAZON = DOLGOZO.OAZON;
-- 9) Adjuk meg azokat a dolgoz�kat, akiknek van 2000-n�l nagyobb fizet�s� beosztottja.
SELECT DISTINCT D1.DNEV 
FROM DOLGOZO D1, DOLGOZO D2 
WHERE D1.DKOD = D2.FONOKE 
    AND D2.FIZETES > 2000; 
-- 10) Adjuk meg azokat a dolgoz�kat, akiknek nincs 2000-n�l nagyobb fizet�s� beosztottja.
SELECT DISTINCT DNEV 
FROM DOLGOZO
MINUS 
SELECT DISTINCT D1.DNEV 
FROM DOLGOZO D1, DOLGOZO D2 
WHERE D1.DKOD = D2.FONOKE 
    AND D2.FIZETES > 2000; 
-- 11) Adjuk meg azokat a telephelyeket, ahol van elemz� (ANALYST) foglalkoz�s� dolgoz�.
SELECT DISTINCT OSZTALY.TELEPHELY 
FROM DOLGOZO, OSZTALY 
WHERE DOLGOZO.OAZON = OSZTALY.OAZON 
    AND DOLGOZO.FOGLALKOZAS = 'ANALYST';
-- 12) Adjuk meg azokat a telephelyeket, ahol nincs elemz� (ANALYST) foglalkoz�s� dolgoz�.
SELECT TELEPHELY FROM OSZTALY
MINUS
SELECT DISTINCT OSZTALY.TELEPHELY 
FROM DOLGOZO, OSZTALY 
WHERE DOLGOZO.OAZON = OSZTALY.OAZON 
    AND DOLGOZO.FOGLALKOZAS = 'ANALYST';
-- 13) Adjuk meg a maxim�lis fizet�s� dolgoz�(k) nev�t.
SELECT DNEV 
FROM DOLGOZO
MINUS
SELECT D2.DNEV 
FROM DOLGOZO D1, DOLGOZO D2 
WHERE D1.FIZETES > D2.FIZETES; 