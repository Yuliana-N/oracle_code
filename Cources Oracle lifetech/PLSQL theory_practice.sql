--���������

declare -- �� ����������� 
begin 
  null; -- ������ ������ ������� ����
  --exeption
  end; 
  
  
--�����������
  
  function f_name (param in varchar2)
    return varchar2
    is 
    -- ����� ��������� ���������� 
    begin
     v_var:=0;
      return  '1';
      end; --
      
      --������� ���������� ���� ��������
      
 procedure p_name (par1 in varchar2, par2 out number) -- par1 - ���������, par2- ���������� (par2 in out number)
   is
   begin
     --����� ������ ������ ��������� ��� par1 (��� ����������)
     par2:=to_number(par1);--��� �����
     par2:= par2+1;
     end;
   
 number -- xxxxxx,xx (�� ����� �����)
 integer -- �����  
 char(5) -- 5 ��������
 varchar2(5) -- 2 ������� \ 5 ����
 date
 
 
 cur_date: = sysdate + 1 /(12*60)
 --1 /12 - 2 ����, 1 /(12*60) - 2 ������, 1 /(12*60*60) - 2 ������� 
 
  cur_date: = sysdate + 1 /(24*60*60)
 --1 /12 - 1 ���, 1 /(12*60) - 1 ������, 1 /(12*60*60) - 1 ������� 
 
 
 --���������
 
--������� :
--case - ���� ������� �� ���� �������� , �������� when sum = 10 then ... , when sum = 11 then...,
--if elsif 


--decode (var1,var2,action,var3,action2,action3)  (�� �����)



--������� 10 ����� ������������������ ��������� 


--� SELECT min_razr,max_razr INTO minraz,maxraz FROM dolgnosti - � PL\SQL ������� ������ ���������� ���� ������
-- ��� ����, ����� ������ ��������� ���� �������� ����� ������ ������

--insert, delete, update - ����������� �������




delete from test where rowid not in (select min(rowid) from test group by col1, col2, col3); -- ������� ���������

--����� ���������
a=1 b=1
for n in 1...8 loop
  a=a+b; 
  b=a-b;
  dbms_output.put(a);
  
  
  --��������� �� ������ , 
  s1:='10234801122115'
  substr(s1,2,5) = '02348' -- �� ������� ������� �������� 5 ��������
  
  
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
� ������������ ���� �� ���������� �� ���� (if ��������� - > ����� � ����, ����� ���� ������� � if �� ��������, �� �� �� ����� � ����)
� ������������ ���� ���������� ���� ���� ��� (�������� � ����, ��������� ������� - ���� ���� ������, ����� ������ �� �����


update, ���� �� ������������ , �� insert
if SQL%No_data_found



�������  - ������� ���������� � ������, (������ �� ������)
*/

---------------------------------------------------�������  - ������� ���������� � ������, (������ �� ������) --����� ������� select (����� ���) ----------
declare
cursor c_1 as
(select sysdate from dual)

--��������� � �������
begin
  for r_1 in c_1 loop
    dbms_output.put(r_1.cur_date);
    end loop;
    end;

/*
cursor c_1 as � ���� ���� ���, 
(select sysdate from dual)

1) open - �������
2) fetch - ��������� ���� �������
3) close � �������
���� ���� loop, �� �� ������� open, fetch � close ���
*/


--------------������ � ���������� (��� ���-�� �� ����) -------------
cursor get_acoount_id (p_msisdn varchar2)
as
(select account_id
from baspre.account_tbl where account_name = p_msisdn)
 
--��������� � ������� (����� ����������� �������� ��� ��������)
for i IN 0...9 loop
  for rec_1 in get_account_id ('37525125456'|| to_char(i)) loop
    s:=rec_1.account_id;
  dbms_output.put(s); --  dbms_output.put(to_char(s)); -� ������, �� ����������� ������� ��������������
    end loop;
  end loop;
 ------------------------------------------------------------------------
 -- ������� ���������� ��������� � ��� �������� ----  
function f_calc (..) 
  return number;
  begin
    a:=f_calc(...);
  end;

--- ��������� ������ �������� � ���������� inout   
procedure p_calc (...) 
  begin
    p_calc();
  end;
 ------------------------------------------------------------------------

--�������  
create function get_acc_id (p_msisdn varchar2)
return number
is
v_acc_id number;
begin
  select account_id into v_account_id--������� ������
  from bas.account_tbl--������� ������
  where account_name = p_msisdn;--������� ������
  return v_acc_id
  exeption 
  when NO_DATA_FOUND then
    return null;
    when other then
      raise_application_error ('������');
      end get_acc_id;
      
--����� �������
begin
  for i in 0...9 loop
    dbms_output.put(
      to_char (
         nvl(get_acc_id('37525123456' || to_char(i) )
       )
     )
   )
  
