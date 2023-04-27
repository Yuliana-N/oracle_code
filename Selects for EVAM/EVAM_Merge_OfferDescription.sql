select * from EVAM.EVAM_OFFER_DESCRIPTIONS_TMP
select * from EVAM.EVAM_OFFER_DESCRIPTIONS d--114
where d.scenario_name like '%63%'

MERGE INTO evam_offer_descriptions o
  USING 
  (
  SELECT * FROM evam_offer_descriptions_tmp
  ) t
   ON (o.SCENARIO_NAME = t.SCENARIO_NAME and o.ACTION_NAME = t.ACTION_NAME)
   WHEN MATCHED THEN 
  UPDATE SET  o.OFFER = t.OFFER, 
        o.STATE = t.STATE, 
        o.PREVIOUS_STATE = t.PREVIOUS_STATE, 
        o.DATE_FROM = t.DATE_FROM, 
        o.DATE_TO = t.DATE_TO
   WHEN NOT MATCHED THEN 
  INSERT (o.SCENARIO_NAME, o.ACTION_NAME, o.OFFER, o.STATE, o.PREVIOUS_STATE, o.DATE_FROM, o.DATE_TO)
    VALUES (t.SCENARIO_NAME, t.ACTION_NAME, t.OFFER, t.STATE, t.PREVIOUS_STATE, t.DATE_FROM, t.DATE_TO);



SELECT count(1) from stage.bas#account_tbl l where account_type='SUB' and lc_state||lc_sub_state_code_id IN ('ACTSTD','ACTSAVE','ACTBAR') and l.account_id = '24581119' 

select check_component_valid_time(24581119, 2, 'TPR_FUTP, OPR_FUTP', 90) from dual

SELECT count(1) FROM vw_agg_traffic ag WHERE ag.account_id = 28981570

select nvl(max(ROUND(arpu_avr_3m, 5)),0) from vw_arpu_stat_cal where account_id = 2895750

select check_offer_futp(2895750) from dual

select * from VW_FIRST_ACT_DATE where first_act_date < add_months(sysdate, -3) and account_id = " + @actorId

select count(1) from VW_FIRST_ACT_DATE where first_act_date < add_months(sysdate, -3) and account_id = '26434399'

select created_at, promo_id, account_id from stage.promo s
where regexp_like (lower(s.promo_id), 'sc38|sc24|sc30|sc08')
and s.CREATED_AT > sysdate - 15

select account_id, created_at, promo_id from stage.promo s
where regexp_like (lower(s.promo_id), 'sc38|sc24|sc30|sc08')
and s.CREATED_AT > sysdate - 15

select * from stage.promo s
where regexp_like (lower(s.promo_id), 'sc38|sc24|sc30|sc08')
and s.CREATED_AT > sysdate - 15

create or replace view evam_srv.vw_15days_promo_esb as
select max(created_at) date_, account_id from stage.promo
where regexp_like (lower(promo_id), 'sc38|sc24|sc30|sc08')
and CREATED_AT > sysdate - 15
--and account_id = 25967176
group by account_id


SELECT count(1) FROM vw_15days_promo_esb WHERE account_id = 123


   
   
   
SELECT count(1) FROM stage.bas#sold_component_tbl sc
 WHERE lower(sc.sold_component_name) IN ('ppr_moc_100allnet','ppr_moc_100offnet','ppr_moc_200allnet','ppr_moc_200offnet','ppr_unlim_allnet_calls_shake_voice','ppr_internet_1_gb','ppr_internet_2_2_gb','ppr_internet_3_gb_discount','ppr_internet_2_4_gb','ppr_internet_5_gb','ppr_internet_2_8_gb')
   AND sc.lc_state||sc.lc_sub_state_code_id IN ('PASWAIT', 'ACTSTD')
   and sc.account_fk = 25997762
   
   
   select count(1) from STAGE.LIFEGO#PROMO_USERS where ACCOUNT_ID = 25997762
   
select lower(get_past_mid(28725526)) from dual

SELECT * 
FROM (
SELECT ACCOUNT_FK
        , category
        , tariff_plan
        , tariff_name
        , mobile_no
        , valid_to 
        , ROW_NUMBER() OVER (ORDER BY VALID_TO desc) rn 
        FROM stage.BAS#ACCOUNT_EX_HIST_TBL 
        WHERE ACCOUNT_FK = 28725526 
        ) 
        WHERE rn = 2
        and valid_to > add_months(sysdate,-1)

"select get_past_mid(" + @actorId + ") from dual"

"SELECT count(1) from stage.bas#account_tbl where account_type='SUB' and lc_state||lc_sub_state_code_id IN ('ACTSTD','ACTSAVE','ACTBAR') where actorid = " + @actorId

select tp.account_id, tp.rate_plan, cmid.mid
from vw_rate_plan tp, VW_CONTRACT_MID cmid
where tp.account_id in
(
28725526
)
and cmid.account_id = tp.account_id
;
