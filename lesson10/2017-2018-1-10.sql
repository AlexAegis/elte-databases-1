/* (select ... into)
�rjunk meg egy f�ggv�nyt, amelyik visszaadja egy adott fizet�si kateg�ri�ba tartoz�
dolgoz�k �tlagfizet�s�t.
*/
CREATE OR REPLACE FUNCTION kat_atlag(n INTEGER) 
RETURN FLOAT IS
    CURSOR curs1 IS SELECT * FROM dolgozo;
    rec curs1%ROWTYPE;
    osszeg float := 0.0;
    db integer := 0;
BEGIN
    OPEN curs1;
    LOOP
    FETCH curs1 INTO rec;
    EXIT WHEN curs1%NOTFOUND;
    db := db + 1;
    osszeg  := osszeg + rec.fizetes;
    DBMS_OUTPUT.put_line(rec.dnev || ' - ' || rec.fizetes);
    END LOOP;
    CLOSE curs1;
    RETURN osszeg/db;
END;
/
--Tesztel�s:
SELECT kat_atlag(4) FROM dual;

-- Vagy
CREATE OR REPLACE FUNCTION kat_atlag(n INTEGER) 
RETURN FLOAT IS
    CURSOR curs1 IS SELECT * FROM dolgozo;
    rec curs1%ROWTYPE;
    osszeg float := 0.0;
    db integer := 0;
BEGIN
    FOR rec IN curs1 LOOP
        db := db + 1;
        osszeg  := osszeg + rec.fizetes;
        DBMS_OUTPUT.put_line(rec.dnev || ' - ' || rec.fizetes);
    END LOOP;
    RETURN osszeg/db;
END;
/
--Tesztel�s:
SELECT kat_atlag(4) FROM dual;



----------------------------------------------------------------
/*
�rjunk meg egy plsql proced�r�t, amelyik veszi a dolgoz�kat �b�c� szerinti sorrendben, 
�s minden p�ratlan sorsz�m� dolgoz� nev�t �s fizet�s�t ki�rja
*/
--CREATE OR REPLACE PROCEDURE proc9 IS
--Tesztel�s:
--set serveroutput on
--call proc9();


----------------------------------------------------------------
/* (param�teres kurzor)
�rjunk meg egy plsql programot (n�v n�lk�li blokkot), amelyik ki�rja azon dolgoz�k 
nev�t �s bel�p�si d�tum�t, akik a felhaszn�l� �ltal megadott oszt�lyon dolgoznak. 
A felhaszn�l� az oszt�ly nev�nek els? bet?j�t adja meg (ACCEPT-tel k�rj�k be). 
A program �rja ki az oszt�ly nev�t is. Ha nincs megfelel? oszt�ly, akkor azt �rja ki.
*/
set serveroutput on;
ACCEPT OSZT PROMPT 'ADD MEG AZ OSZTALYT';
DECLARE
    CURSOR CURS1 IS SELECT * FROM DOLGOZO NATURAL JOIN OSZTALY;
    REC CURS1%ROWTYPE;
BEGIN
    FOR REC IN CURS1 LOOP
        IF REC.FIZETES < 900 THEN
            DBMS_OUTPUT.PUT_LINE(REC.DNEV || ' - csoro');
        ELSIF REC.FIZETES < 1200 THEN
            DBMS_OUTPUT.PUT_LINE(REC.DNEV || REC.FIZETES);
        ELSE
            DBMS_OUTPUT.PUT_LINE(REC.DNEV || ' - gazdag');
        END IF;
    END LOOP;
END;
/

----------------------------------------------------------------
/* (m�dos�t�s)
�rjunk meg egy proced�r�t, amelyik megn�veli azoknak a dolgoz�knak a fizet�s�t 1-el,
akiknek a fizet�si kateg�ri�ja ugyanaz, mint a proced�ra param�tere.
A proced�ra a m�dos�t�s ut�n �rja ki a m�dos�tott (�j) fizet�sek �tlag�t k�t tizedesjegyre kerek�tve.
*/
CREATE OR REPLACE PROCEDURE kat_novel(p_kat NUMBER) IS 
--Tesztel�s:
set serveroutput on
call kat_novel(2);


----------------------------------------------------------------
/* (m�dos�t�s kurzorral)
�rjunk meg egy proced�r�t, amelyik m�dos�tja a param�ter�ben megadott oszt�lyon a fizet�seket, �s 
ki�rja a dolgoz� nev�t �s �j fizet�s�t.  A m�dos�t�s mindenki fizet�s�hez adjon hozz� n*10 ezret, 
ahol n a dolgoz� nev�ben lev? mag�nhangz�k sz�ma (a, e, i, o, u).
*/
CREATE OR REPLACE PROCEDURE fiz_mod(p_oazon INTEGER) IS 
--Tesztel�s:
set serveroutput on
call fiz_mod(10);
