---SZERET---
------------

-- 1) Melyek azok a gy�m�lcs�k, amelyeket Micimack� szeret?
SELECT GYUMOLCS 
FROM SZERET 
WHERE NEV = 'Micimack�';
-- 2) Melyek azok a gy�m�lcs�k, amelyeket Micimack� nem szeret? (de valaki m�s igen)
SELECT GYUMOLCS 
FROM SZERET 
MINUS
SELECT GYUMOLCS 
FROM SZERET 
WHERE NEV = 'Micimack�';
-- 3) Kik szeretik az alm�t?
SELECT NEV 
FROM SZERET 
WHERE GYUMOLCS = 'alma';
-- 4) Kik nem szeretik a k�rt�t? (de valami m�st igen),
SELECT NEV 
FROM SZERET
MINUS
SELECT NEV 
FROM SZERET 
WHERE GYUMOLCS = 'k�rte';
-- 5) Kik szeretik vagy az alm�t vagy a k�rt�t?
SELECT DISTINCT NEV 
FROM SZERET 
WHERE GYUMOLCS = 'alma' OR GYUMOLCS = 'k�rte';

SELECT NEV 
FROM SZERET
WHERE GYUMOLCS = 'alma' 
UNION
SELECT NEV 
FROM SZERET
WHERE GYUMOLCS = 'k�rte';
-- 6) Kik szeretik az alm�t is �s a k�rt�t is?
SELECT NEV 
FROM SZERET
WHERE GYUMOLCS = 'alma'
MINUS
SELECT NEV 
FROM SZERET
WHERE GYUMOLCS = 'k�rte';
-- 7) Kik azok, akik szeretik az alm�t, de nem szeretik a k�rt�t?


---DOLGOZO---
-------------

-- 1) Kik azok a dolgoz�k, akiknek a fizet�se nagyobb, mint 2800?
SELECT DNEV
FROM DOLGOZO
WHERE FIZETES > 2800;
-- 2) Kik azok a dolgoz�k, akik a 10-es vagy a 20-as oszt�lyon dolgoznak?
SELECT DNEV 
FROM DOLGOZO
WHERE OAZON = 10 OR OAZON = 20;

SELECT DNEV 
FROM DOLGOZO
WHERE OAZON = 10
UNION
SELECT DNEV 
FROM DOLGOZO
WHERE OAZON = 20;
-- 3) Kik azok, akiknek a jutal�ka nagyobb, mint 600?
SELECT DNEV
FROM DOLGOZO
WHERE JUTALEK > 600;
-- 4) Kik azok, akiknek a jutal�ka nem nagyobb, mint 600?
SELECT DNEV 
FROM DOLGOZO
WHERE JUTALEK <= 600 OR JUTALEK IS NULL;
-- 5) Kik azok a dolgoz�k, akiknek a jutal�ka ismeretlen (nincs kit�ltve, vagyis NULL)?
SELECT DNEV 
FROM DOLGOZO
WHERE JUTALEK IS NULL;
-- 6) Adjuk meg a dolgoz�k k�z�tt el�fordul� foglalkoz�sok neveit.
SELECT DISTINCT FOGLALKOZAS 
FROM DOLGOZO
WHERE FOGLALKOZAS IS NOT NULL;
-- 7) Adjuk meg azoknak a nev�t �s k�tszeres fizet�s�t, akik a 10-es oszt�lyon dolgoznak.
SELECT DNEV, FIZETES * 2 
FROM DOLGOZO
WHERE OAZON = 10;
-- 8) Kik azok a dolgoz�k, akik 1982.01.01 ut�n l�ptek be a c�ghez?
SELECT DNEV, BELEPES 
FROM DOLGOZO
WHERE BELEPES > DATE '1982-01-01';
-- 9) Kik azok, akiknek nincs f�n�ke?
SELECT DNEV 
FROM DOLGOZO
WHERE FONOKE IS NULL;
-- 10) Kik azok a dolgoz�k, akiknek a f�n�ke KING? (egyel�re leolvasva a k�perny�r�l)
SELECT DNEV 
FROM DOLGOZO
WHERE FONOKE = (SELECT DKOD
                FROM DOLGOZO
                WHERE DNEV = 'KING'); -- this is not valid in relational algebra

SELECT D1.DNEV
FROM DOLGOZO D1 JOIN DOLGOZO D2
ON D1.FONOKE = D2.DKOD
WHERE D2.DNEV = 'KING';  -- this is valid in relational algebra