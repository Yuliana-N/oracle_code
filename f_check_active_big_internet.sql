create or replace function F_CHECK_ACTIVE_BIG_INTERNET(account_id_in in stage.bas#sold_component_tbl.account_fk%TYPE) RETURN NUMBER IS
  v_check_ok NUMBER;
BEGIN

SELECT count(distinct account_fk) into v_check_ok from STAGE.BAS#SOLD_COMPONENT_TBL f
where f.lc_state||f.lc_sub_state_code_id IN ('PASWAIT', 'ACTSTD', 'ACTBAR')
and regexp_like(upper(sold_component_name), '^(O|P)P(R|O)')
and UPPER(sold_component_name) like '%INTERNET%'
and UPPER(sold_component_name) not in
(
    'PPR_INTERNET_01_GB',
    'PPR_INTERNET_01_GB_TRY_BUY',
    'PPR_INTERNET_025_GB',
    'PPR_INTERNET_05_GB',
    'PPR_INTERNET_0.5_GB_TRY_BUY',
    'PPR_INTERNET_1_GB',
    'PPR_INTERNET_1_2_GB_TRY_BUY',
    'PPR_INTERNET_2_2_GB_TRY_BUY',
    'PPR_INTERNET_3_2_GB_TRY_BUY',
    'PPR_INTERNET_1_2_GB',
    'PPR_INTERNET_2_2_GB',
    'PPR_INTERNET_3_2_GB',
    'OPR_INTERNET_2_GB',
    'OPR_INTERNET_2X3_GB',
    'PPR_INTERNET_3_GB',
    'OPR_INTERNET_3_GB',
    'PPR_INTERNET_3X3_GB',
    'PPR_INTERNET_3_GB_DISCOUNT',
    'PPR_INTERNET_1_4_GB',
    'PPR_INTERNET_2_4_GB',
    'PPR_INTERNET_3_4_GB',
    'OPR_INTERNET_4_GB',
    'OPR_INTERNET_4_GB_WOG',
    'OPR_INTERNET_4X3_GB',
    'PPR_INTERNET_5_GB',
    'OPR_INTERNET_5_GB',
    'OPR_INTERNET_5_GB_WOG',
    'PPR_TVPLUS_INTERNET',
'PPR_INTERNET_UNLIM_FITNESSCLUB',
'PPR_INTERNET_UNLIM_DAILY_FIZY',
'PPR_INTERNET_DAILY_UNLIM_ITV_3',
'PPR_INTERNET_DAILY_UNLIM_ITV_3_TRY_BUY',
'PPR_INTERNET_MONTHLY_UNLIM_ITV_20',
'PPR_INTERNET_MONTHLY_UNLIM_ITV_20_TRY_BUY',
'PPR_INTERNET_MONTHLY_UNLIM_ITV_20_DISCOUNTED_TRY_BUY',
'PPR_INTERNET_UNLIM_KIDSCLUB',
'PPR_INTERNET_LIFEBOX_25GB',
'PPR_INTERNET_LIFEBOX_100GB',
'PPR_INTERNET_LIFEBOX_500GB',
'PPR_INTERNET_UNLIM_MAGAZINES',
'PPO_INTERNET_APPS_CLUB_GIFT_OTF',
'PPO_INTERNET_DEALSCLUB_GIFT_OTF',
'PPO_INTERNET_UNLIM_MONTHLY_FIZY_GIFT',
'PPR_INTERNET_UNLIM_MAGAZINES_GIFT',
'PPR_INTERNET_UNLIM_YANDEX_GEO',
'PPR_INTERNET_UNLIM_DAILY_YANDEX',
'PPR_INTERNET_UNLIM_YANDEX_PLUS',
'PPO_NEW_INTERNET_BASE',
'PPR_NEW_INTERNET_BASE',
'PPO_INTERNET_BASE',
'PPR_INTERNET_UNLIM_MONTHLY_FIZY',
'PPO_INTERNET_UNLIM_FIZY_GIFT')
    and f.account_fk = account_id_in;
    return v_check_ok;
    end;