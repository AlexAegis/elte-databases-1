--CREATE OR REPLACE PROCEDURE procedure_neve IS -- PROCEDURE-NAK NINCS RETURNJE
--valtozonev t�pus:= '�rt�k';
--BEGIN
   --PROGRAMBLOKK
--   dbms_output.put_line(); -- KIIRAT�S
--END;

--CREATE OR REPLACE FUNCTION f�ggv�ny_neve(n integer) RETURN number IS -- F�GGV�NYNEK VAN RETURNJE

--------- FELADATOK ---------

--1, PL/SQL Hello World procedure
--   set serveroutput on;
--   call helloWorld();
--2, Pr�m-e F�ggv�ny 
--   SELECT prim(263062) from dual;
--3, N. fibonacci f�ggv�ny
--   select fib(10) from dual;
--4, LNKO f�ggv�ny
--   select lnko(80,100) from dual;
--5, Faktori�lis f�ggv�ny
--   select faktor(5) from dual;
--6, Hanyszor fordul el� egy sz�vegben egy m�sik string
--   SELECT hanyszor ('ab c ab ab de ab fg a', 'ab') FROM dual;
--7, Sz�vegb�l �sszeg
--   select osszeg('1+2+3+40+5+6') from dual;

create or replace function osszeg(szoveg varchar2)
    return integer is
osszeg1 int:= 0;
tmp varchar2(10) := '';
begin
    for i in 1..length(szoveg) LOOP 
        if SUBSTR(szoveg, i , 1) = '+'  then
            osszeg1 := osszeg1 + TO_NUMBER(tmp);
            tmp := '';
        else
            tmp := tmp || SUBSTR(szoveg, i, 1);
        end if;
    end loop;
    osszeg1 := osszeg1 + TO_NUMBER(tmp);
return osszeg1;
end osszeg;
/
select osszeg ('1+2+3+20') from dual;