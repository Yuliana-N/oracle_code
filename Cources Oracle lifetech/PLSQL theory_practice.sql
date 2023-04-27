--анонимный

declare -- не об€зательно 
begin 
  null; -- всегда должна команда быть
  --exeption
  end; 
  
  
--именованный
  
  function f_name (param in varchar2)
    return varchar2
    is 
    -- здесь объ€вл€ем переменные 
    begin
     v_var:=0;
      return  '1';
      end; --
      
      --функци€ возвращает одно значение
      
 procedure p_name (par1 in varchar2, par2 out number) -- par1 - константа, par2- переменна€ (par2 in out number)
   is
   begin
     --здесь нельз€ ничего присвоить дл€ par1 (она посто€нна€)
     par2:=to_number(par1);--так можно
     par2:= par2+1;
     end;
   
 number -- xxxxxx,xx (не целое число)
 integer -- целое  
 char(5) -- 5 символов
 varchar2(5) -- 2 символа \ 5 байт
 date
 
 
 cur_date: = sysdate + 1 /(12*60)
 --1 /12 - 2 часа, 1 /(12*60) - 2 минуты, 1 /(12*60*60) - 2 секунды 
 
  cur_date: = sysdate + 1 /(24*60*60)
 --1 /12 - 1 час, 1 /(12*60) - 1 минута, 1 /(12*60*60) - 1 секунда 
 
 
 --коллекции
 
--услови€ :
--case - неск условий на одно значение , допустим when sum = 10 then ... , when sum = 11 then...,
--if elsif 


--decode (var1,var2,action,var3,action2,action3)  (см фотки)



--вывести 10 числе последовательности ‘иббоначи 


--в SELECT min_razr,max_razr INTO minraz,maxraz FROM dolgnosti - в PL\SQL селекты всегда возвращают одну строку
-- дл€ того, чтобы селект возвращал неск значений нужно писать курсор

--insert, delete, update - срабатывает триггер




delete from test where rowid not in (select min(rowid) from test group by col1, col2, col3); -- удалить дубликаты

--число фибоначчи
a=1 b=1
for n in 1...8 loop
  a=a+b; 
  b=a-b;
  dbms_output.put(a);
  
  
  --вычленить из строки , 
  s1:='10234801122115'
  substr(s1,2,5) = '02348' -- со второго символа достанет 5 символов
  
  
  function f_1(s varchar2)
    return number
    is
    sub_s1,sub_s2 varchar2(50);
    len,i,j number; 
    begin
      len:= length(s);
      for i IN 1...len-1 loop
        sub_s1 := substr(s,i,1);
        sub_s2 :=sub_s1;
        for j IN 2...len loop
          sub_s1:= sub_s1
          
          
          
          
 ----------------------------------------------
 declare
  s1 varchar2(20) := '10234801122115';
  sub_s1 varchar2(20);
  sub_s2 varchar2(20);
  len number;
  i number;
  j number;
begin
  len := length(s1);
  DBMS_OUTPUT.ENABLE;

  for i IN 1..len-1 loop
    sub_s1 := substr(s1, i, 1);
    sub_s2 := sub_s1;
    for j IN i+1..len loop
      sub_s1 := sub_s1 || substr(s1, j, 1);
      sub_s2 := substr(s1, j, 1) || sub_s2;
      if length(sub_s1) > 1 and sub_s1 = sub_s2 THEN
        dbms_output.put_line(sub_s1);
      END IF;
    end loop;
  end loop;
end;declare
  s1 varchar2(20) := '10234801122115';
  sub_s1 varchar2(20);
  sub_s2 varchar2(20);
  len number;
  i number;
  j number;
begin
  len := length(s1);
  DBMS_OUTPUT.ENABLE;

  for i IN 1..len-1 loop
    sub_s1 := substr(s1, i, 1);
    sub_s2 := sub_s1;
    for j IN i+1..len loop
      sub_s1 := sub_s1 || substr(s1, j, 1);
      sub_s2 := substr(s1, j, 1) || sub_s2;
      if length(sub_s1) > 1 and sub_s1 = sub_s2 THEN
        dbms_output.put_line(sub_s1);
      END IF;
    end loop;
  end loop;
end;


/*
с предусловием цикл не выполнитс€ ни разу (if сработало - > зашел в цикл, иначе если условие в if не выолнено, то он не зайдЄт в цикл)
с постусловием цикл выполнитс€ хоть один раз (запхнули в цикл, выполнили условие - один цикл прошел, иначе выйдет из цикла


update, если не заапдейтилс€ , то insert
if SQL%No_data_found



 урсоры  - запросы хран€щиес€ в пам€ти, (ссылка на запрос)
*/

--------------------------------------------------- урсоры  - запросы хран€щиес€ в пам€ти, (ссылка на запрос) --чисто запросы select (циклы нет) ----------
declare
cursor c_1 as
(select sysdate from dual)

--обращение к курсору
begin
  for r_1 in c_1 loop
    dbms_output.put(r_1.cur_date);
    end loop;
    end;

/*
cursor c_1 as Ц если есть им€, 
(select sysdate from dual)

1) open - открыть
2) fetch - прочитать одну записть
3) close Ц закрыть
≈сли есть loop, то он сделает open, fetch и close сам
*/


--------------курсор с параметром (даЄм что-то на вход) -------------
cursor get_acoount_id (p_msisdn varchar2)
as
(select account_id
from baspre.account_tbl where account_name = p_msisdn)
 
--обращение к курсору (нужно об€зательно передать ему параметр)
for i IN 0...9 loop
  for rec_1 in get_account_id ('37525125456'|| to_char(i)) loop
    s:=rec_1.account_id;
  dbms_output.put(s); --  dbms_output.put(to_char(s)); -в строку, но отпработало не€вное преобразование
    end loop;
  end loop;
 ------------------------------------------------------------------------
 -- функци€ возвращает результат в своЄ название ----  
function f_calc (..) 
  return number;
  begin
    a:=f_calc(...);
  end;

--- процедура хранит значени€ в переменных inout   
procedure p_calc (...) 
  begin
    p_calc();
  end;
 ------------------------------------------------------------------------

--функци€  
create function get_acc_id (p_msisdn varchar2)
return number
is
v_acc_id number;
begin
  select account_id into v_account_id--не€вный курсор
  from bas.account_tbl--не€вный курсор
  where account_name = p_msisdn;--не€вный курсор
  return v_acc_id
  exeption 
  when NO_DATA_FOUND then
    return null;
    when other then
      raise_application_error ('ќшибка');
      end get_acc_id;
      
--вызов функции
begin
  for i in 0...9 loop
    dbms_output.put(
      to_char (
         nvl(get_acc_id('37525123456' || to_char(i) )
       )
     )
   )
  
