     select * from SS_SIM_CARD_V
      where msisdn is null
        and ki1='FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'
        and k4sno is not null
        ORDER BY dbms_random.value
            )
where rownum <=1;                     


select* from (
    select msisdn from ss_msisdn_v
        where msisdn like '3752555%'
        and state_name in ('FREE', 'REUSE', 'ACTIVE')
    ORDER BY dbms_random.value
    )
where rownum <= 10;


-- 3.проверка icid или msisdn на статус контракта (act - зареган, пусто/trm - можно)
--select* from (                                  
    select  iccid, mobile_no, tbl.lc_state
            from baspre.account_ex_tbl@PRE_GOLD ac , baspre.account_tbl@PRE_GOLD tbl
            where tbl.account_id=ac.account_fk
            --and iccid in ('893750333330000529' )
            and mobile_no in (  '375255501032'  )
            order by  account_fk desc,LC_DATE desc;
--            )
--where rownum <=1;            



-- 4.связка между msisdn и isid
                 select * from SS_SIM_CARD where msisdn in('375255500570');
                 
                 select * from SS_SIM_CARD where iccid in('893750333330000155');
