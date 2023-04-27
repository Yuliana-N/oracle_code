create or replace view vw_1day_before_prolong_opr
SELECT sc.account_fk as actorId
FROM stage.incore_cretrigger_full c, 
    stage.ref#prod_comp_code pc, 
    stage.bas#sold_component_tbl sc, 
    stage.bas#account_tbl ac ,
    stage.tm_om#asset_types mo,
    (select a.*, ah.ENTRY_DATE, ah.ACTION_CODE,
    ROW_NUMBER() OVER (PARTITION BY a.msisdn ORDER BY ah.ENTRY_DATE desc) AS RN
    from stage.tm_om#assets_registry a, stage.tm_om#asset_history ah
    where a.CODE = ah.ASSET_CODE) aa
-- prolongation tomorrow 
WHERE trunc(to_date(c.nexttriggerdate, 'yyyymmddhh24miss')) = trunc(sysdate + 1)
    and c.ruleid = pc.rop_cre_trigger_rule_id(+)
    and pc.tracking_id(+) = sc.prod_comp_code_id
    and c.accountid(+) = sc.account_fk
    and sc.account_fk = ac.account_id
    and c.enddate(+) IS NULL
    and c.status(+) = 1
    -- active obligation ROP
    and sc.sold_component_name LIKE 'OPR_%'
    and sc.LC_STATE || sc.LC_SUB_STATE_CODE_ID = 'ACTSTD'
    -- active line
    and ac.account_type='SUB'
    and ac.lc_state||ac.lc_sub_state_code_id IN ('ACTSTD','ACTSAVE')
    -- terminal class
    and aa.MSISDN = ac.ACCOUNT_NAME
    and aa.asset_type = mo.CODE(+)
    and mo.ASSET_CLASS in ('SMARTPHONES','3G_TABLETS')
    and aa.RN =1
group by sc.account_fk