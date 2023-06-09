-- print no. of stage.og_acc_sub joined in each month for year in which 
-- max stage.og_acc_sub joined
set serveroutput on 
declare
   v_count number(2);
   v_year  number(4);
begin
   select to_char(hire_date,'yyyy') into v_year
   from stage.og_acc_sub
   group by to_char(hire_date,'yyyy') 
   having count(*) = 
     (select max(count(*))
      from stage.og_acc_sub
      group by to_char(hire_date,'yyyy'));
      
   for month in  1..12
   loop
      select count(*) into v_count
      from stage.og_acc_sub
      where to_char(hire_date,'yyyy') = v_year and 
            to_char(hire_date,'mm') = month;
            
      dbms_output.put_line(month || ' - ' || v_count);
  end loop;
  
end;