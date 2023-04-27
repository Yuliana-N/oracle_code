 Function pp_count_pp(P_msisdn   varchar2)
  return number is
/* 2 Онлайн Наличие сим-карт с активной услугой РР (у абонента может быть 2 и меньше сим-карт с активной услугой РР при проверке перед подключением).2*/
 cnt_pp number :=0;
 p_pp number;

begin

for rec in (
select msisdn from snaddon.POSTPAID_LINE_TBL plt1,
(select  distinct plt.PERSONALITY_ID PERSONALITY_ID
  from snaddon.POSTPAID_LINE_TBL plt
     where 1=1
    -- and  plt.msisdn = '375256257541'
   and plt.msisdn =  P_msisdn 
     and plt.state = 'ACT/STD') plt_pre
     where plt_pre.PERSONALITY_ID = plt1.PERSONALITY_ID
     and plt1.STATE = 'ACT/STD')
loop      
  begin
    select SUM(CASE
                       WHEN BALANCE_NAME IN ('Line_PP_Limit') THEN
                        VALUE_BALANCE
                       ELSE
                        0
                     END)
                   AS Line_PP_Limit  
   into p_pp
  --     from table(snaddon.get_ussd_balance('375256257541'));    
      from table(snaddon.get_ussd_balance(rec.msisdn));
 if p_pp > 0 then cnt_pp := cnt_pp + 1; end if;
end ;
end loop;
  
   return cnt_pp;
 
end;