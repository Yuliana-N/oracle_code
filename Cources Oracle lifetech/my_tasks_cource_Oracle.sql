---------------------------------------------Task 1 -------------------------------------------------
select ACCOUNT_ID,,-- контракт
FIRST_ACT_DATE, -- дата активация контракта
TARIFF_PLAN, 
LINE_LVL, -- тип линии (гибрид , постпейд, препейд)
CONTRACT_TYPE -- тип контракта - (ФИзик или корпорация (юрик))
from snaddon.all_subscribers;
select 
ACCOUNT_ID ,-- контракт
PERSONALITY_ID, --уникальный номер абонета, несколько контрактов могут иметь один PERSONALITY_ID
LM -- балас абонента
from snaddon.extra_money_summary;
select ACCOUNT_ID, -- контракт
PERIOD, --дата
AMOUNT --сумма юзача
from snaddon.revenue_by_days_tbl;

Выбрать по 5 абонентов с максимальным и минимальным юзачем (показать юзач для каждого абонента) 
на контракте на каждом тарифном плане за последние 100 дней, которые активировали контракт от 4 до 20 месяцев назад включительно,
 за последние 50 дней был хоть один факт расхода ДС на контракте, при этом на других контрактах у абонента не должно быть долга. 
 Искать все только на контрактах препейдах и гибридах для всех физических лиц.
----
колонки ,которые хотелось бы видеть обязательно:
ACCOUNT_ID, TARIFF_PLAN, sum (AMOUNT) usage_



--25231
select ACCOUNT_ID,-- контракт
 FIRST_ACT_DATE, -- дата активация контракта
  TARIFF_PLAN, 
  LINE_LVL, -- тип линии (гибрид , постпейд, препейд)
  CONTRACT_TYPE -- тип контракта - (ФИзик или корпорация (юрик))
 from snaddon.all_subscribers als
 where 
-- als.account_id = '15134'
als.line_lvl in ('PRE','HYBRID') --24624
and als.contract_type = 'IND'--23534
and als.first_act_date between (add_months(trunc(sysdate, 'mm'), -20)) and last_day((add_months(trunc(sysdate, 'mm'), -4)))--включен весь ноябрь --10350
order by 2 desc 

--1272
select
ACCOUNT_ID ,-- контракт
PERSONALITY_ID, --уникальный номер абонета, несколько контрактов могут иметь один PERSONALITY_ID
 LM -- балас абонента
 from snaddon.extra_money_summary ems
 where ems.lm >= 0 --1605

--102526
--основная таблица (кол-во аккаунтов отсюда)
select ACCOUNT_ID, -- контракт
 PERIOD, --дата
  AMOUNT --сумма юзача
  from snaddon.revenue_by_days_tbl rbdt
where 
rbdt.period > sysdate -100
  order by rbdt.period desc
  
--rbdt.account_id = '33208'
 rbdt.period > sysdate -50 -- ?? --2909
 and rbdt.amount > 0 -- 2909
  order by 2




--1) -- не правильно , выдаёт всё по таблице revenue_by_days_tbl, в т.ч. пустые (неподходящик по дате активации )поля из all_subscribers
select
rbdt.ACCOUNT_ID, -- контракт
ems.personality_id, --уникальный номер абонета, несколько контрактов могут иметь один PERSONALITY_ID
 rbdt.PERIOD, --дата
  rbdt.AMOUNT, --сумма юзача
  ems.lm, -- балас абонента
  all_sub.FIRST_ACT_DATE, -- дата активация контракта
 all_sub.TARIFF_PLAN, 
 all_sub.LINE_LVL, -- тип линии (гибрид , постпейд, препейд)
 all_sub.CONTRACT_TYPE -- тип контракта - (ФИзик или корпорация (юрик))
  from snaddon.revenue_by_days_tbl rbdt left join snaddon.extra_money_summary ems
  on rbdt.account_id = ems.account_id
  left join (select * from snaddon.all_subscribers als
 where als.line_lvl in ('PRE','HYBRID') --24624
and als.contract_type = 'IND'--23534
and als.first_act_date between (add_months(trunc(sysdate, 'mm'), -20)) and last_day((add_months(trunc(sysdate, 'mm'), -4)))+1) all_sub
  on rbdt.account_id = all_sub.account_id
where 
 rbdt.period > sysdate -50 -- ?? --2909
 and rbdt.amount > 0 -- 2909
 and ems.lm >= 0 --1605
 and rbdt.account_id = '58988'
  order by 2
  
  
  
--2) -- 787  -- тупит груп бай с als.TARIFF_PLAN
select sum (rbdt.AMOUNT),
--rbdt.ACCOUNT_ID, -- контракт
ems.personality_id --уникальный номер абонета, несколько контрактов могут иметь один PERSONALITY_ID
 --rbdt.PERIOD, --дата
 -- rbdt.AMOUNT, --сумма юзача
 -- ems.lm, -- балас абонента
 -- als.FIRST_ACT_DATE, -- дата активация контракта
--als.TARIFF_PLAN
 --als.LINE_LVL, -- тип линии (гибрид , постпейд, препейд)
-- als.CONTRACT_TYPE -- тип контракта - (ФИзик или корпорация (юрик))
  from snaddon.revenue_by_days_tbl rbdt left join snaddon.extra_money_summary ems
  on rbdt.account_id = ems.account_id  
left join snaddon.all_subscribers als on rbdt.account_id = als.account_id  
 where als.line_lvl in ('PRE','HYBRID') --24624
and als.contract_type = 'IND'--23534
and als.first_act_date between (add_months(trunc(sysdate, 'mm'), -20)) and last_day((add_months(trunc(sysdate, 'mm'), -4)))+1 -- trunc не надо
and rbdt.period > sysdate -50 --  за последние 50 дней был хоть один факт расхода ДС на контракте (юзача)????  --2909
 and rbdt.amount  -- 2909 
 and ems.lm >= 0 --1605
-- and rbdt.account_id = '58988'
  group by ems.personality_id --90
  
  
 --3) 
 select www.TARIFF_PLAN, www.account_id from ( select
rbdt.ACCOUNT_ID,
    max(case 
             when rbdt.period between sysdate -50 and sysdate then 1
           else 0
           end) exist, -- факт расхода ДС на контракте 
        sum(case 
             when rbdt.period between sysdate -50 and sysdate then rbdt.amount
           else 0
           end) sum_usage -- сумма юзача за 50 дней на каждом контракте 
  from snaddon.revenue_by_days_tbl rbdt, snaddon.extra_money_summary ems,   
snaddon.all_subscribers als 
where
 rbdt.account_id = ems.account_id
 and rbdt.account_id = als.account_id
 and als.line_lvl in ('PRE','HYBRID') --24624
and als.contract_type = 'IND'--23534
and als.first_act_date between (add_months(trunc(sysdate, 'mm'), -20)) and last_day((add_months(trunc(sysdate, 'mm'), -4)))+1
 and ems.lm >= 0 --1605
 group by rbdt.ACCOUNT_ID ) account_usage left join snaddon.all_subscribers www on www.account_id = account_usage.ACCOUNT_ID
 
 
 --4) работает!!!!!!!!!
select account_id, TARIFF_PLAN, sum_usage  from (
select nn.*, row_number () over (partition by nn.tariff_plan order by nn.sum_usage desc ) rn from ( select tbl1.account_id, tbl1.TARIFF_PLAN, account_usage.sum_usage from ( select
rbdt.ACCOUNT_ID,
    max(case when rbdt.period between sysdate -50 and sysdate then 1
           else 0
           end) exist,
        sum(case when rbdt.period between sysdate -50 and sysdate then rbdt.amount
           else 0
           end) sum_usage
  from snaddon.revenue_by_days_tbl rbdt, snaddon.extra_money_summary ems,   
snaddon.all_subscribers als 
where
 rbdt.account_id = ems.account_id
 and rbdt.account_id = als.account_id
 and als.line_lvl in ('PRE','HYBRID') 
and als.contract_type = 'IND'
and als.first_act_date between add_months(sysdate, -20) and add_months(sysdate, -4)
and rbdt.period > sysdate -100
 and ems.lm >= 0 
 group by rbdt.ACCOUNT_ID ) account_usage left join snaddon.all_subscribers tbl1 on tbl1.account_id = account_usage.ACCOUNT_ID where account_usage.exist > 0 )nn)
 where rn <= 5
 


------------------------------------------- Cursor --------------------------------------------

declare
  cursor rec is
    select account_id
      from all_subscribers a   
 where a.account_id < 1000;
  acc_id_2 number;

begin
  open rec; -- открыть курсор 
  LOOP
  
    EXIT WHEN rec%NOTFOUND; --выход из loop - a (%NOTFOUND -когда курсор не найден) - строки ещё найдены , то проскакивает мимо exit , и перепрыгивает на след fetch 
    fetch rec -- переключает на след строку из курсора , забирает значение из курсора 
      into acc_id_2; -- записывает в переменную 
  
    dbms_output.put_line(acc_id_2); -- выводим содержимое переменной
  end loop;
  close rec;
end;


-------------------------------------------25.03.2019------------------------------------------



select s.*, lead (s.first_act_date) over (partition by s.personality_id order by s.first_act_date)next_ from snaddon.extra_money_summary s
order by s.personality_id, s.first_act_date

select * from snaddon.payments_by_days

select ACCOUNT_FK, sum(DAYS_)/count_ from (select ACCOUNT_FK, PERIOD, PAYMENT_AMOUNT, 
lead(PERIOD) over (partition by ACCOUNT_FK order by PERIOD) - PERIOD days_,
count (distinct ACCOUNT_FK) over (partition ACCOUNT_FK ) count_
from snaddon.payments_by_days)
group by ACCOUNT_FK,count_ -- чтобы использовать столбец в селекте, то нужно его указать в group by (в данном случае count_ или обромить его в селекте функцией maxl(count_) )


-- для груп бай, если посчитать каунт , count (1) подсчитает количество 
x, count (1)
group x


------------------------ EVAM ---------------------

SELECT round(cast (atn as date)-cast(fe as date),1) a, count(1) from(
SELECT ACTORID, max(CASE WHEN action_template_name='FutureEventOA' then log_time end) fe,
min(case when action_template_name='SendSmsOA' then log_time end) atn
FROM int_log_table PARTITION ( p_20190325)
WHERE 1 = 1
and scenario_name LIKE '%SC14%'
and action_template_name in ('SendSmsOA', 'FutureEventOA')

group by ACTORID ) s
GROUP BY round(cast (atn as date)-cast(fe as date),1)
--ORDER BY ACTORID desc; 


--------------------------------------------------------Task 2 --------------------------------------------------

/*С таблицы 
select * from snaddon.vw_all_subsribers_pers
вывести 
FIRST_NAME, LAST_NAME, IDENTIFICATION_CODE, PASSPORT, первый подключенный контракт, дату подключения, последний подключенный контракт, дату поключения,
если на одном паспорте один только контракт, то последние два столбца должны быть пусты.*/

select FIRST_NAME, LAST_NAME, IDENTIFICATION_CODE, PASSPORT, p.FIRST_ACT_DATE, P.ACCOUNT_ID from snaddon.vw_all_subsribers_pers p
where p.IDENTIFICATION_CODE = '3160987C029PB3'
group by IDENTIFICATION_CODE, FIRST_NAME, LAST_NAME, IDENTIFICATION_CODE, PASSPORT, p.FIRST_ACT_DATE
--order by p.FIRST_ACT_DATE


--работает
select FIRST_NAME, LAST_NAME, IDENTIFICATION_CODE, PASSPORT, max( case when p.FIRST_ACT_DATE is not null then p.FIRST_ACT_DATE end ) dd , max( case when p.ACCOUNT_ID is not null then p.ACCOUNT_ID end ) pp, min( case when p.FIRST_ACT_DATE is not null then p.FIRST_ACT_DATE end ) dd , min( case when p.ACCOUNT_ID is not null then p.ACCOUNT_ID end ) pp from snaddon.vw_all_subsribers_pers p
where p.IDENTIFICATION_CODE = '3130272AO18PB7'
group by IDENTIFICATION_CODE, FIRST_NAME, LAST_NAME, IDENTIFICATION_CODE, PASSPORT




select max( p.FIRST_ACT_DATE ) over (PARTITION BY IDENTIFICATION_CODE) dd,
max( p.ACCOUNT_ID ) over (PARTITION BY IDENTIFICATION_CODE) ttt,
min(p.FIRST_ACT_DATE ) over (PARTITION BY IDENTIFICATION_CODE) dd,
min( case when count (*) = 1 then 'лена' end ) over (PARTITION BY IDENTIFICATION_CODE) ttt */
from snaddon.vw_all_subsribers_pers p
where p.IDENTIFICATION_CODE = '3130272AO18PB7'
--group by IDENTIFICATION_CODE, FIRST_NAME, LAST_NAME, IDENTIFICATION_CODE, PASSPORT, p.FIRST_ACT_DATE

select p.first_name, p.last_name, p.identification_code, p.passport, case /*when count(*) = 1 then null*/ WHEN count(*) > 1 THEN min(p.FIRST_ACT_DATE ) over (PARTITION BY IDENTIFICATION_CODE) end p  --, max( case when p.ACCOUNT_ID is not null then p.ACCOUNT_ID end ) pp, min( case when p.FIRST_ACT_DATE is not null then p.FIRST_ACT_DATE end ) dd , min( case when p.ACCOUNT_ID is not null then p.ACCOUNT_ID end ) pp 
from snaddon.vw_all_subsribers_pers p
where p.IDENTIFICATION_CODE = '3160987C029PB3'
group by p.first_name, p.last_name, p.identification_code, p.passport, p.FIRST_ACT_DATE 
--group by IDENTIFICATION_CODE, FIRST_NAME, LAST_NAME, IDENTIFICATION_CODE, PASSPORT



----------работает -----------------
select p.first_name,p.last_name, p.identification_code, p.passport, max (p.ACCOUNT_ID ) ACCOUNT_ID_1, max(p.FIRST_ACT_DATE ) FIRST_ACT_DATE_1, 
case when count(p.ACCOUNT_ID) > 1 then min( p.ACCOUNT_ID) end ACCOUNT_ID_2, 
case when count(p.ACCOUNT_ID) > 1 then min(p.FIRST_ACT_DATE ) end FIRST_ACT_DATE_2
from snaddon.vw_all_subsribers_pers p
--where p.IDENTIFICATION_CODE = '3160987C029PB3'
group by p.identification_code, p.first_name,p.last_name, p.passport
--------------------------------------

select LAST_VALUE(p.FIRST_ACT_DATE) over (PARTITION BY IDENTIFICATION_CODE) count_ from snaddon.vw_all_subsribers_pers p 
where p.passport = 'AB2202211'

LAST_VALUE( distinct p.ACCOUNT_ID) over (PARTITION BY IDENTIFICATION_CODE) min_1 from snaddon.vw_all_subsribers_pers p

select FIRST_VALUE( p.FIRST_ACT_DATE) over (PARTITION by IDENTIFICATION_CODE) as first_ from snaddon.vw_all_subsribers_pers p
where p.IDENTIFICATION_CODE = '3928175R555AB2'


------------------------Task 3 -----------------------------------
/*вывести абонентов (FIRST_NAME, LAST_NAMEб IDENTIFICATION_CODE, PASSPORT,personality_id) ,
 на чей паспорт зарегено ровно от 3 до 5 контрактов включительно, один из которых на ТП йо1200 (DL012) 
 и один из любых контрактов был зарегистрирован в текущем году (select * from snaddon.vw_all_subsribers_pers - использовать только это)*/
  
 
 

 --сверху определили алиас для таблицы
with t as (select /*+ materialized */ * from 
snaddon.vw_all_subsribers_pers b)

--в нижнем скрипте можем вместо таблицы приделать алиас 
select a.personality_id--, count(a.ACCOUNT_ID) -- проверяет записи, в from условия , одно их них exists , если под условие внутри ексиста попадет строчка из верхнего селекта, то exists возвращает true и строчка попадает в результирующую выборку
  from t a
 where exists (select 1
          from t b
         where b.FIRST_ACT_DATE > trunc(sysdate, 'yyyy')
           and a.personality_id = b.personality_id) -- передать внутрь запроса в exists из внешнего запроса какой то параметр (в данном случае - как связываем тоже самое) 
            and exists (select 1 --- exists - "включает в себя",  верхний селект включает что-то из нижнего. но верхний селект включает что-то ещё
          from t b 
         where b.tariff_plan in 'TP_DL012'
           and a.personality_id = b.personality_id) -- передать внутрь запроса в exists из внешнего запроса какой то параметр (в данном случае - как связываем тоже самое) 
           
          
 group by a.personality_id
having count(a.ACCOUNT_ID) between 3 and 5




 
 
 ------------------------ Task 4 ------------------------------------
 /*Хочу видеть раздельно тип контракта и тарифный план  и сколько контрактов на каждом состоянии контракта (поле  STATE); сделать в один селект!!!*/
 
 

 
 select distinct pers.TARIFF_PLAN, pers.CONTRACT_TYPE,pers.STATE, count(*) over  (PARTITION BY pers.state) count_ from snaddon.vw_all_subsribers_pers pers where pers.TARIFF_PLAN = 'TP_ANDR'-- pers.TARIFF_PLAN like '%AMBSD%'
 
 
  select distinct pers.TARIFF_PLAN, pers.CONTRACT_TYPE,pers.STATE, count(*)
  from snaddon.vw_all_subsribers_pers pers where pers.TARIFF_PLAN = 'TP_ANDR' 
  group by pers.state, pers.TARIFF_PLAN, pers.CONTRACT_TYPE
  
  select /*distinct pers.TARIFF_PLAN, pers.CONTRACT_TYPE,*/ listagg(pers.STATE || '_ '||  count(*),'; ') WITHIN GROUP(ORDER BY pers.STATE) as count_
  from snaddon.vw_all_subsribers_pers pers --where pers.TARIFF_PLAN = 'TP_ANDR' 
  group by pers.state, pers.TARIFF_PLAN, pers.CONTRACT_TYPE

 
listagg(pers.STATE || '_ '||  count(*),'; ') WITHIN GROUP(ORDER BY pers.STATE) 
 

------------работает ------------------
select distinct s.contract_type,s.tariff_plan,listagg(s.state || '-' || count(1), '; ') within group(order by s.state) over(partition by s.contract_type, s.tariff_plan)
from snaddon.all_subscribers s
group by s.contract_type, s.tariff_plan, s.state
------------------------------------------------------------------

  
 
