 --30320_Early repayment [RFC #30320]: configuration [CFG #30509]
--Author: Y.Nesterovich
declare
  v_result number := -1;
begin
  for cur in ( select 'ROOT/NON_USAGE_EVENT/CHARGE/288/FPO_COMMON_LBF_VoiceUnlimAllnet_Act' as RDM,
                     'ОП' as CLASS_NAME_SHORT,
                     'Оплата предложения' as CLASS_NAME,
                     'Безлимит звонков во все сети' as CATEGORY_NAME_SHORT,
                     'Безлимит звонков во все сети' as CATEGORY_NAME,
                     'PL_600_01_2_1_2_3' as PNL_CODE
               from dual union
               select 'ROOT/NON_USAGE_EVENT/CHARGE/1199/FPO_EarlyRepaymentF_EarlyRepaymentEquip' as RDM,
                     'ОУ' as CLASS_NAME_SHORT,
                     'Оплата устройства' as CLASS_NAME,
                     'Устройство (досрочное погашение)' as CATEGORY_NAME_SHORT,
                     'Устройство (досрочное погашение)' as CATEGORY_NAME,
                     'PL_600_01_2_6' as PNL_CODE
               from dual union
               select 'ROOT/NON_USAGE_EVENT/CHARGE/1199/FPO_EarlyRepaymentF_EarlyRepaymentServ' as RDM,
                     'ОП' as CLASS_NAME_SHORT,
                     'Оплата предложения' as CLASS_NAME,
                     'Предложение (досрочное погашение)' as CATEGORY_NAME_SHORT,
                     'Предложение (досрочное погашение)' as CATEGORY_NAME,
                     'PL_600_01_2_4_2' as PNL_CODE
               from dual           
) loop
    update cds.st_event_service_path_info /*y*/ spi
    set spi.rdm_code = null
    ,spi.nls_language = 'RUSSIAN'
    ,spi.class_code = null
    ,spi.class_name_short = cur.class_name_short--Тип:
    ,spi.class_name = cur.class_name
    ,spi.category_code = null
    ,spi.category_name_short = cur.category_name_short--Направление:
    ,spi.category_name = cur.category_name
    ,spi.pnl_code = cur.pnl_code
    ,spi.event_code_n = null--?
    ,spi.event_code = null
    where spi.rdm = cur.rdm;
    v_result := SQL%ROWCOUNT;
      if v_result = 0 then
      insert into cds.st_event_service_path_info /*ayarmosh.test*/ (rdm_code,rdm,nls_language,class_code,class_name_short,class_name,category_code,category_name_short,category_name,pnl_code,event_code_n,event_code)
      values (null,cur.rdm,'RUSSIAN',null,cur.class_name_short,cur.class_name,null,cur.category_name_short,cur.category_name,cur.pnl_code,null,null);
      v_result := SQL%ROWCOUNT;
    elsif v_result > 1 then raise_application_error(-20099, 'Error happened during update: duplicate rows in cds.st_event_service_path_info');
    end if;
  end loop;
end;
/
