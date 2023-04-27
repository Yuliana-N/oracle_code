----всем кому отправлялась смс ка + сервис активация из евама  -------
select *
from stage.tm_cim#transaction_history tht, stage.tm_cim#transaction_type ttt where tht.transaction_type_code=ttt.code 
and a_mobile_no in (
SELECT a_mobile_no
FROM stage.tm_cim#transaction_history tcth
where tcth.comments LIKE
'%lifecell MIX%3840%SC32%'
)
and tht.comments = 'Service activation'
and agent_name like '%EVAM%'
and ttt.name_ru like '%lifecell MIX%'

----------- активация сервиса  ------------------
select * from stage.tm_cim#transaction_history tht, stage.tm_cim#transaction_type ttt where tht.transaction_type_code=ttt.code 
and tht.comments = 'Service activation'
and tht.a_mobile_no = '375297760719'
--and agent_name like '%EVAM%'
-- ttt.name_ru like '%lifecell MIX%' --900735
--and ttt.name_ru like '%TV+%' -- 900709
--and ttt.name_ru like '%egogo%' 
--and ttt.name_en like '%nizhki%' --900803
--and ttt.name_ru like '%Apps%'-- 900323 
--and ttt.name_ru like '%Fitness%' -- 900798 
--and ttt.name_ru like '%Знакомства%'-- 900795
--and ttt.name_en like '%lifebox%5GB%' 
--and ttt.name_en like '%fizy%'--900583
-- and ttt.name_ru like '%Журналы%'--900543
and ttt.name_en like '%ecucloud%'
and ttt.name_en like '%riends%'

-------------------------Итого по всем сервисам--------------
select a_mobile_no, agent_name
from stage.tm_cim#transaction_history
where a_mobile_no in (
SELECT tcth.a_mobile_no
FROM stage.tm_cim#transaction_history tcth
WHERE entry_date >= '13.03.2020'
AND tcth.comments LIKE
'%3840%SC32%'
AND tcth.TRANSACTION_TYPE_CODE = 107100
)
and TRANSACTION_TYPE_CODE in (900735,900709,900803,900323,900798,900795,900583,900543)
and entry_date >= '13.03.2020'
and agent_name = 'EVAM' ;


