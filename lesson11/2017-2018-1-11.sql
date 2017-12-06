DROP TABLE DOLGOZO2;
CREATE TABLE DOLGOZO2 AS SELECT * FROM DOLGOZO;
SELECT * FROM DOLGOZO2;

create or replace function prim(n number) return number is
begin
    if n < 2 then
        return 0;
    end if;
    -- prim ker
end;
/

DECLARE
    CURSOR CURS1 IS SELECT * FROM DOLGOZO2 ORDER BY DNEV FOR UPDATE;
    REC CURS1%ROWTYPE;
    I INTEGER := 0;
BEGIN
    FOR REC IN CURS1 LOOP
       i:=i+1;
       UPDATE DOLGOZO2 SET SORSZAM = i WHERE CURRENT OF CURS1;
    END LOOP;
END;
/

set serveroutput on;
DECLARE
CURSOR CURS1 is select * from dolgozo2 for update;
rec cur





----------------------------------------------------------------
/*

�rjunk meg egy plsql proced�r�t, amelyik veszi a dolgoz�kat �b�c� szerinti sorrendben, 
�s azon dolgoz� nev�t �s fizet�s�t ki�rja akik t�bbet keresnek mint a n�vsorban el�tt�k �ll�.
*/
--CREATE OR REPLACE PROCEDURE procNevsor IS
--Tesztel�s:
--set serveroutput on
--call procNevsor();

----------------------------------------------------------------
/*

�rjunk meg egy plsql programot (n�v n�lk�li blokkot), amelyik ki�rja azon dolgoz�k 
nev�t �s bel�p�si d�tum�t, akik a felhaszn�l� �ltal megadott oszt�lyon dolgoznak. 
A felhaszn�l� az oszt�ly nev�nek els� bet�j�t adja meg (ACCEPT-tel k�rj�k be). 
A program �rja ki az oszt�ly nev�t is. Ha nincs megfelel� oszt�ly, akkor azt �rja ki.

----------------------------------------------------------------
/*

�rj PL/SQL n�v n�lk�li blokkot, ami a k�perny�re ki�rja a Dolgoz� t�bla azon dolgoz�inak nev�t, akik foglalkoz�sa megegyezik azzal, amit a felhaszn�l� INPUTk�nt megadott, a foglalkoz�s�t, �s azt hogy:
 'csoro' ha a fizet�s < 900	a fizet�st, ha az >=900 de <1200	'gazdag' ha az >=4000

----------------------------------------------------------------
/* (m�dos�t�s)

Hozza l�tre a dolgozo2 t�bl�t az dolgozo t�bl�b�l, �s b�v�tse azt egy sorsz�m oszloppal. Ezt
t�ltse fel 1-t�l kiindulva egyes�vel n�vekv� �rt�kkel minden dolgoz� eset�n a dolgoz�k
nev�nek �b�c� sorrendje szerint. 

----------------------------------------------------------------
/*

N�velj�k meg a dolgozo 2 t�bl�ban a pr�msz�m sorsz�m� dolgoz�k fizeteset 50%-kal.

----------------------------------------------------------------
/*

T�r�lj�k a dolgoz�k k�z�l a 3-mas fizet�si kateg�ri�j� fizet�s�eket.

----------------------------------------------------------------
/*

�rjunk meg egy proced�r�t, amelyik megn�veli azoknak a dolgoz�knak a fizet�s�t 1-el,
akiknek a fizet�si kateg�ri�ja ugyanaz, mint a proced�ra param�tere.
A proced�ra a m�dos�t�s ut�n �rja ki a m�dos�tott (�j) fizet�sek �tlag�t k�t tizedesjegyre kerek�tve.
*/
CREATE OR REPLACE PROCEDURE kat_novel(p_kat NUMBER) IS 
Tesztel�s:
set serveroutput on
call kat_novel(2);


----------------------------------------------------------------
/* (m�dos�t�s kurzorral)
�rjunk meg egy proced�r�t, amelyik m�dos�tja a param�ter�ben megadott oszt�lyon a fizet�seket, �s 
ki�rja a dolgoz� nev�t �s �j fizet�s�t.  A m�dos�t�s mindenki fizet�s�hez adjon hozz� n*10 ezret, 
ahol n a dolgoz� nev�ben lev� mag�nhangz�k sz�ma (a, e, i, o, u).
*/
CREATE OR REPLACE PROCEDURE fiz_mod(p_oazon INTEGER) IS 
Tesztel�s:
set serveroutput on
call fiz_mod(10);
