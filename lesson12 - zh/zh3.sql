-- 1. feladat 
-- �rj PL/SQL proced�r�t ZH1 n�vvel mely ki�rja 
-- a kapott param�ter �sszes pr�moszt�j�t.

SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION IS_PRIME(NO IN NUMBER) RETURN VARCHAR
IS 
    ANS VARCHAR(5);
    N NUMBER;
BEGIN
    IF(NO = 1) THEN
        ANS := 'FALSE';
    ELSIF(NO = 2) THEN
        ANS := 'TRUE';
    ELSE    
        N := NO / 2;    
        FOR I IN 2..N LOOP
            IF(MOD(NO, I) = 0) THEN
                ANS := 'FALSE';
                EXIT;
            ELSE
                ANS := 'TRUE';
            END IF;
        END LOOP;
    END IF;
    RETURN(ANS);
END;
/

CREATE OR REPLACE PROCEDURE ZH1 
(N IN NUMBER)
AS 
    I NUMBER;
    K NUMBER;
BEGIN 
    I := 2;
    K := FLOOR(N / 2);
    FOR I IN 1..K LOOP
        IF (IS_PRIME(I) = 'TRUE' AND (MOD(N, I) = 0)) THEN
            DBMS_OUTPUT.PUT_LINE(i||' is a prime number which is also a divisor');
        END IF;
    END LOOP;
END; 
/

CALL ZH1(100);
DBMS_OUTPUT.ENABLE;

-- 2. feladat
-- �rj PL/SQL f�ggv�nyt ZH2 n�vvel, mely k�t bemen� param�tert kap �s 
-- visszadja h�ny azonos helyen �ll� egyforma karakter�k van. 
-- Ha a k�t sz� nem egyforma hossz� akkor meg -1-et.

CREATE OR REPLACE FUNCTION ZH2(A IN VARCHAR, B IN VARCHAR) RETURN VARCHAR
IS
    ANS NUMBER;
BEGIN
    IF(LENGTH(A) != LENGTH(B)) THEN
        ANS := -1;
    ELSE
        ANS := 0;
        FOR I IN 1..LENGTH(A) LOOP
            IF (SUBSTR(A, I, 1) = SUBSTR(B, I, 1)) THEN
                ANS := ANS + 1;
            END IF;
        END LOOP;
    END IF;

    RETURN(ANS);
END;
/

SELECT ZH2('ALMA', 'ALMA') FROM DUAL; -- 4
SELECT ZH2('ALMA', 'ALAL') FROM DUAL; -- 2
SELECT ZH2('ALMA', 'K�RTE') FROM DUAL; -- -1

-- 3. feladat
-- �rj PL/SQL n�v n�lk�li blokkot, ami a k�perny�re ki�rja a Dolgoz� t�bla azon
-- dolgoz�inak nev�t, akik beosztottjai annaka  dolgoz�nak akit a felhaszn�l� 
-- INPUT-k�nt megadott, a foglalkoz�s�t, �s azt hogy:
-- 'Igen' ha a neve r�videbb a foglalkoz�s�nak hossz�val, egy�bk�nt 'Nem'

DECLARE
    CURSOR CURS IS SELECT D1.DNEV ALKALMAZOTT, D2.DNEV FONOKE, D1.FOGLALKOZAS ALKFOG, D2.FOGLALKOZAS FonFog
FROM DOLGOZO D1 JOIN DOLGOZO D2
ON D1.FONOKE = D2.DKOD;
    REC CURS%ROWTYPE;
    I INTEGER := 0;
    INPUT VARCHAR(15);
    RET VARCHAR(4) := 'Nem';
BEGIN
    INPUT := :INPUT;
    FOR REC IN CURS LOOP
        IF(REC.FONOKE = INPUT) THEN
            IF(LENGTH(REC.ALKALMAZOTT) < LENGTH(REC.ALKFOG)) THEN
                RET := 'Igen';
            END IF;
            DBMS_OUTPUT.PUT_LINE(REC.ALKALMAZOTT || ' ' || REC.ALKFOG || ' ' || RET);
        END IF;
    END LOOP;
END;
/

-- 4. feladat
-- Kurzort haszn�lva �rj PL/SQL procedure-t ZH4 n�vvel, ami param�terk�nt 
-- �tveszi az oszt�lyn�v utols� k�t bet�j�t. A Dolgoz� t�bla minden elem�nek, 
-- aki a param�terben megadott oszt�lyon dolgozik, �s fizet�se 
-- el�ri a 4000-et 15%-al n�veli a fizet�s�t!

CREATE OR REPLACE PROCEDURE ZH4
(INPUT IN VARCHAR)
AS 
    CURSOR CURS IS SELECT * FROM DOLGOZO NATURAL JOIN OSZTALY WHERE SUBSTR(ONEV, LENGTH(ONEV) - 1, 2) = INPUT AND FIZETES >= 4000 FOR UPDATE;
    REC CURS%ROWTYPE;
BEGIN
    FOR REC IN CURS LOOP
        DBMS_OUTPUT.PUT_LINE(REC.DNEV || ' Fizetes, before: ' || REC.FIZETES);
        UPDATE DOLGOZO SET FIZETES = (FIZETES * 1.15) WHERE CURRENT OF CURS;
    END LOOP;
END;
/
CALL ZH4('NG');
DBMS_OUTPUT.ENABLE;

-- 5. feladat
