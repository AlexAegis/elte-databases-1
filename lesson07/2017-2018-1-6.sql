-- Feladatok m�dos�t�sra, t�rl�sre, besz�r�sra.
--------------------------------------------

-- T�BLA L�TREHOZ�S
CREATE TABLE proba123(
    ID INT NOT NULL PRIMARY KEY,
    nev VARCHAR(10) NOT NULL
);

-- N�ZETT�BLA L�TREHOZ�S
CREATE VIEW viewproba123 AS
SELECT nev FROM proba123 WHERE ID = 2;

-- T�BLA OSZLOP T�RL�S/M�DOS�T�S/HOZZ�AD�S
ALTER TABLE proba123 DROP COLUMN nev;
ALTER TABLE proba123 ADD nev varchar(30);

-- T�BLA �SSZES SOR�NAK T�RL�SE
TRUNCATE TABLE proba123;

-- T�BLA TELJES T�RL�SE
DROP TABLE proba123;

-- SOR BESZ�R�S
INSERT INTO proba123 VALUES (2, 'Feri');
INSERT INTO proba123 (nev, uid) VALUES ('Jozsi', 3);

-- SOROK M�DOS�T�SA
UPDATE proba123 SET nev='Peti', id = 1 WHERE nev = 'Jozsi';

-- SOROK T�RL�SE
DELETE FROM proba123 WHERE nev='Peti';


--Feladatok m�dos�t�sra, t�rl�sre, besz�r�sra.
--------------------------------------------

-- A m�dos�t�st egy m�sodp�ld�nyon v�gezz�k, hogy a t�bla eredeti tartalma megmaradjon
CREATE TABLE DOLGOZO2 AS SELECT * FROM nikovits.dolgozo;
CREATE TABLE OSZTALY2 AS SELECT * FROM nikovits.osztaly;

-- DELETE

-- (reset with this after each altering)
DROP TABLE DOLGOZO2;
CREATE TABLE DOLGOZO2 AS SELECT * FROM nikovits.DOLGOZO;

DROP TABLE OSZTALY2;
CREATE TABLE OSZTALY2 AS SELECT * FROM nikovits.OSZTALY;

-- T�r�lj�k azokat a dolgoz�kat, akiknek jutal�ka NULL.
DELETE FROM DOLGOZO2 WHERE JUTALEK IS NULL;
-- T�r�lj�k azokat a dolgoz�kat, akiknek a bel�p�si d�tuma 1982 el�tti.
DELETE FROM DOLGOZO2 WHERE BELEPES < DATE '1982-01-01';
-- T�r�lj�k azokat a dolgoz�kat, akik oszt�ly�nak telephelye DALLAS.
DELETE FROM DOLGOZO2 WHERE DKOD IN 
    (SELECT DOLGOZO2.DKOD FROM DOLGOZO2 NATURAL JOIN OSZTALY2 WHERE TELEPHELY = 'DALLAS');
-- T�r�lj�k azokat a dolgoz�kat, akiknek a fizet�se kisebb, mint az �tlagfizet�s.
DELETE FROM DOLGOZO2 WHERE FIZETES < (SELECT AVG(FIZETES) FROM DOLGOZO2);
-- T�r�lj�k a jelenleg legjobban keres� dolgoz�t.
DELETE FROM DOLGOZO2 WHERE DKOD = 
    (SELECT DKOD 
    FROM DOLGOZO2
    MINUS
    SELECT D2.DKOD 
    FROM DOLGOZO2 D1, DOLGOZO2 D2 
    WHERE D1.FIZETES > D2.FIZETES); 
-- T�r�lj�k ki azokat az oszt�lyokat, akiknek van olyan dolgoz�ja, aki a 2-es fizet�si 
--  kateg�ri�ba esik (l�sd m�g Fiz_kategoria t�bl�t).
-- (Adjuk meg azon oszt�lyok nev�t, amelyeknek van olyan dolgoz�ja, aki a 2-es fizet�si kateg�ri�ba esik)

-- T�r�lj�k ki azon oszt�lyokat, amelyeknek 2 olyan dolgoz�ja van, aki a 2-es fizet�si kateg�ri�ba esik.


-- INSERT

- Vigy�nk fel egy 'Kovacs' nev� �j dolgoz�t a 10-es oszt�lyra a k�vetkez� 
  �rt�kekkel: dkod=1, dnev='Kovacs', oazon=10, bel�p�s=aktu�lis d�tum,
  fizet�s=a 10-es oszt�ly �tlagfizet�se. A t�bbi oszop legyen NULL.


UPDATE

-- N�velj�k meg a 20-as oszt�lyon a dolgoz�k fizet�s�t 20%-kal.

-- N�velj�k meg azok fizet�s�t 500-zal, akik jutal�ka NULL vagy a fizet�s�
-- kisebb az �tlagn�l.

-- N�velj�k meg mindenkinek a jutal�k�t a jelenlegi maxim�lis jutal�kkal. (NULL tekints�k 0-nak)

-- M�dos�tsuk 'Loser'-re a legrosszabbul keres� dolgoz� nev�t.

-- N�velj�k meg azoknak a dolgoz�knak a jutal�k�t 3000-rel, akiknek legal�bb 2 k�zvetlen beosztottjuk van. 
-- Az ismeretlen (NULL) jutal�kot vegy�k �gy, mintha 0 lenne. 

-- N�velj�k meg azoknak a dolgoz�knak a fizet�s�t, akiknek van beosztottja, a minim�lis fizet�ssel

-- N�velj�k meg a nem fon�k�k fizet�s�t a saj�t oszt�lyuk �tlagfizet�s�vel