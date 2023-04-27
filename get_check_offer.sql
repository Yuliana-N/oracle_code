CREATE OR REPLACE FUNCTION get_check_offer (
    v_account_id   IN stage.bas#account_ex_tbl.account_fk%TYPE)
    RETURN NUMBER
IS
    v_check_ok   NUMBER;
BEGIN


    IF v_account_id IS NULL
    THEN
        RETURN 0;
    END IF;

    IF REGEXP_LIKE (v_account_id, '[[:alpha:]]')
    THEN
        RETURN 0;
    END IF;

    SELECT
           CASE -- кейс 1
               WHEN     a1.contract_type = 'IND' -- абонент - физ лицо
                    AND a1.passport_type IN ('PASSPORT_RB', 'RESEDENCE_RB') -- гражданин РБ и резидент РБ 
                    AND NOT (    a1.passport_type = 'RESEDENCE_RB'
                             AND (  NVL (CAST (a1.passport_valid_to AS DATE),
                                         SYSDATE)
                                  - SYSDATE) <
                                 180) -- скрок действия вида на жительства закончиться не ранее  чем через 180 дней
                    and trunc(months_between(sysdate,nvl(cast (a1.birthday as date), sysdate))/12) >= 18 -- абонент совершеннолетний
                    AND NVL (a3.counter_remain_obligation, 0) < 1 -- нет обязательств
                    AND a1.passport_no IS NOT NULL -- у выбранных абонентов в БД обязательно есть номер паспорта 
                    --AND a1.passport_valid_to > SYSDATE /*EVAM-491 Убрать проверку на срок действия паспорта в функции stage.get_check_offer*/
                    AND NVL (personal_id, '0') = '0'
                    AND a3.line_main >= 0 -- на балансе Line_Main есть средства
                    AND NVL (a3.line_extralimit, 0) = 0 -- нет услуг Мой лимит и Доп деньги
                    AND (SELECT COUNT (1)
                         FROM stage.bas#account_ex_tbl aet1,
                              stage.bas#account_ex_tbl aet2,
                              stage.bas#account_tbl at1,
                              stage.tm_om#om_product_attributes opa
                         WHERE     LOWER (aet1.passport_no) =
                                   LOWER (a1.passport_no)
                               AND LOWER (aet1.passport_series) =
                                   LOWER (a1.passport_series)
                               AND aet1.contract_type = 'IND'
                               AND at1.account_type = 'SUB'
                               AND at1.lc_state != 'TRM'
                               AND aet1.account_fk = at1.top_level_account_id
                               AND opa.om_ref_code_valuescode =
                                   'CATEGORY_GROUP'
                               AND at1.account_id = aet2.account_fk
                               AND opa.VALUE = 'XS-XXL'
                               AND opa.om_product_offeringscode =
                                   aet2.category) <= 1
               THEN
                   1 -- абонент удовлетворяет условиям из первого кейса, функция возвращает 1
               ELSE
                   0 -- иначе
           END offer_sheik
    INTO v_check_ok --возвращаемое значение присваивается этой перемнной
    FROM stage.bas#account_ex_tbl a1,
         stage.bas#account_tbl a2,
         stage.tm_cim#blacklist bl,
         (SELECT ROUND (
                     SUM (
                         CASE
                             WHEN balance_name IN ('Line_Main', 'Line_Debt')
                             THEN
                                 value_balance
                             ELSE
                                 0
                         END),
                     2) AS line_main,
                 ROUND (
                     SUM (
                         CASE
                             WHEN balance_name = 'Counter_Remain_Obligation'
                             THEN
                                 value_balance
                             ELSE
                                 0
                         END),
                     2) AS counter_remain_obligation,
                 ROUND (
                     SUM (
                         CASE
                             WHEN balance_name = 'Line_Extra'
                             THEN
                                 value_balance
                             ELSE
                                 0
                         END),
                     2) AS line_extra2,
                 ROUND (
                     SUM (
                         CASE
                             WHEN balance_name = 'Line_Debt_Obligation'
                             THEN
                                 value_balance
                             ELSE
                                 0
                         END),
                     2) AS line_debt_obligation,
                 ROUND (
                     SUM (
                         CASE
                             WHEN balance_name = 'Line_ExtraLimit'
                             THEN
                                 value_balance
                             ELSE
                                 0
                         END),
                     2) AS line_extralimit,
                 ROUND (
                     SUM (
                         CASE
                             WHEN balance_name = 'Bundle_GPRS_itscheaper'
                             THEN
                                 value_balance
                             ELSE
                                 0
                         END),
                     2) AS bundle_gprs_itscheaper,
                 ROUND (
                     SUM (
                         CASE
                             WHEN balance_name = 'Bundle_Flag_CL_Active'
                             THEN
                                 value_balance
                             ELSE
                                 0
                         END),
                     2) AS bundle_flag_cl_active,
                 ROUND (
                     SUM (
                         CASE
                             WHEN balance_name =
                                  'Bundle_Flag_Cancelling_Services'
                             THEN
                                 value_balance
                             ELSE
                                 0
                         END),
                     2) AS bundle_fl_cancelling_services,
                 a3.account_fk
          FROM stage.bas#account_ex_tbl a3,
               TABLE (stage.get_ussd_balance (a3.account_fk))
          GROUP BY account_fk) a3 -- присвоение знчений балансов переменным, которые проверяются в SELECT выше
    WHERE     a2.top_level_account_id = a1.account_fk
          AND UPPER (bl.personal_id(+)) = UPPER (a1.identification_code)
          AND TRUNC (bl.birth_date(+)) = TRUNC (CAST (a1.birthday AS DATE))
          AND a2.account_id = a3.account_fk
          AND a2.account_id = v_account_id;

    RETURN NVL (v_check_ok, 0); --возвращает значение из функции
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;
END;
