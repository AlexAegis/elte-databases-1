---SZERET---
------------

--Kik szeretnek legal�bb k�tf�le gy�m�lcs�t?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) >= 2;
--Kik szeretnek legal�bb h�romf�le gy�m�lcs�t?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) >= 3;
--Kik szeretnek legfeljebb k�tf�le gy�m�lcs�t?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) <= 2;
--Kik szeretnek pontosan k�tf�le gy�m�lcs�t?
SELECT NEV, COUNT(*)
FROM SZERET
GROUP BY NEV
HAVING COUNT(*) = 2;

---DOLGOZO---
-------------

--Kik azok a dolgoz�k, akiknek a f�n�ke KING? (nem leolvasva)
SELECT D1.DNEV "Alkalmazott", D2.DNEV "F�n�ke"
FROM DOLGOZO D1 JOIN DOLGOZO D2
ON D1.FONOKE = D2.DKOD
WHERE D2.DNEV = 'KING';
--Adjuk meg azoknak a f�n�k�knek a nev�t, akiknek a foglalkoz�sa nem 'MANAGER'. (dnev)
SELECT DISTINCT D1.DNEV "N�v", D1.FOGLALKOZAS "Foglalkoz�s"
FROM DOLGOZO D1
JOIN DOLGOZO D2
ON D2.FONOKE = D1.DKOD 
WHERE D1.FOGLALKOZAS != 'MANAGER';
--Adjuk meg azokat a dolgoz�kat, akik t�bbet keresnek a f�n�k�kn�l.
SELECT * FROM DOLGOZO;
--Kik azok a dolgoz�k, akik f�n�k�nek a f�n�ke KING?
SELECT * FROM DOLGOZO;
--Kik azok a dolgoz�k, akik oszt�ly�nak telephelye DALLAS vagy CHICAGO?
SELECT * FROM DOLGOZO;
--Kik azok a dolgoz�k, akik oszt�ly�nak telephelye nem DALLAS �s nem CHICAGO?
SELECT * FROM DOLGOZO;
--Adjuk meg azoknak a nev�t, akiknek a fizet�se > 2000 vagy a CHICAGO-i oszt�lyon dolgoznak.
SELECT * FROM DOLGOZO;
--Melyik oszt�lynak nincs dolgoz�ja?
SELECT * FROM DOLGOZO;
--Adjuk meg azokat a dolgoz�kat, akiknek van 2000-n�l nagyobb fizet�s� beosztottja.
SELECT * FROM DOLGOZO;
--Adjuk meg azokat a dolgoz�kat, akiknek nincs 2000-n�l nagyobb fizet�s� beosztottja.
SELECT * FROM DOLGOZO;
--Adjuk meg azokat a telephelyeket, ahol van elemz� (ANALYST) foglalkoz�s� dolgoz�.
SELECT * FROM DOLGOZO;
--Adjuk meg azokat a telephelyeket, ahol nincs elemz� (ANALYST) foglalkoz�s� dolgoz�.
SELECT * FROM DOLGOZO;
--Adjuk meg a maxim�lis fizet�s� dolgoz�(k) nev�t.
SELECT * FROM DOLGOZO;