--История состояний жизненного цикла
SELECT ex.account_fk
      ,ex.mobile_no
      ,ex.line_lvl
      ,ex.category AS mid
      ,lc.lc_state || ' / ' || lc.lc_sub_state_code_id AS lc_state
      ,lc.lc_reason_code_id AS reason
      ,DECODE(lc.lc_state || ' / ' || lc.lc_sub_state_code_id
             ,'DPL / STD',   'Технический предактив'
             ,'DPL / HOLD',  'Начальный'
             ,'DPL / PRE',   'Предактивированный'
             ,'ACT / STD',   'Активный'
             ,'ACT / BAR',   'Заблокирован по неуплате'
             ,'ACT / SUSPW', 'Приостановлен по желанию'
             ,'ACT / SUSPF', 'Приостановлен по мошенничеству'
             ,'ACT / SUSPD', 'Приостановлен по задолженности'
             ,'ACT / SUSPL', 'Приостановлен по утере СИМ'
             ,'ACT / SUSP',  'Приостановлен'
             ,'ACT / SUSPCH','Приостановлен при смене владельца'
             ,'ACT / SAVE',  'Сохранение номера'
             ,'ACT / SUSPQ', 'Карантин'
             ,'TWL / STD',   'Карантин с долгом'
             ,'TRM / STD',   'Отключен'
                            ,'Неизвестное состояние - ' || lc.lc_state || ' / ' || lc.lc_sub_state_code_id) AS status
      ,TO_CHAR(lc.lc_date_from,'dd.mm.yyyy hh24:mi:ss') AS с
      ,TO_CHAR(lc.lc_date_to,'dd.mm.yyyy hh24:mi:ss') AS по
  FROM baspre.lc_account_tbl lc
      ,baspre.account_ex_tbl ex
 WHERE ex.account_fk = lc.account_fk
--   AND ex.mobile_no = '375257155276'
   AND ex."ACCOUNT_FK" = '44159'
   AND lc.lc_date_from between to_date('28.08.2018 15:00:00','dd.mm.yyyy hh24:mi:ss') and to_date('30.08.2018 18:00:00','dd.mm.yyyy hh24:mi:ss')
 ORDER BY 2               ASC
         ,lc.lc_date_from ASC
