create or replace FUNCTION          check_offer_futp (v_account_id IN stage.bas#account_ex_tbl.account_fk%TYPE)
  RETURN NUMBER IS
  v_check_ok NUMBER;
BEGIN
  IF v_account_id IS NULL THEN
    RETURN 0;
  END IF;

  IF REGEXP_LIKE(v_account_id, '[[:alpha:]]') THEN
    RETURN 0;
  END IF;

SELECT case
           when ex2.CONTRACT_TYPE_CODE = 'IND' and
                ex2.PASSPORT_TYPE in ('PASSPORT_RB', 'RESEDENCE_RB') and
                trunc(months_between(sysdate,nvl(cast (ex2.BIRTHDAY as date), sysdate))/12) >= 18 and
                not (ex2.PASSPORT_TYPE = 'RESEDENCE_RB' 
                     and (nvl(cast(ex2.PASSPORT_VALID_TO as date), sysdate) - SYSDATE) < 270) and 
                nvl(k.PERSONAL_Id, '0') = '0' and
                nvl(sim.OFFER_MIX_COUNT, 0) < 2 and 
				ex2.IDENTIFICATION_CODE is not null
            then
            '1'
           else
            '0'
         end special_offer
    into v_check_ok
    FROM 
         stage.og_acc_sub ex2,
         stage.tm_cim#BLACKLIST k
         
         ,
         (
            select vw.account_id,vw.offer_mix_count
            from evam_srv.vw_offer_group_cnt_sim_year vw 
            group by vw.account_id, vw.offer_mix_count
        ) sim
 
   WHERE 
     UPPER(k.PERSONAL_ID(+)) = UPPER(ex2.IDENTIFICATION_CODE)
     AND TRUNC(k.BIRTH_DATE(+)) = TRUNC(CAST(ex2.BIRTHDAY AS DATE))
     and sim.account_id(+) = ex2.account_id
     and ex2.ACCOUNT_ID = v_account_id;

  RETURN NVL(v_check_ok, 0);
EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
END;