procedure new_shake_offer_bank_inst(  p_terminal_id   tm_om.om_product_offerings.code%type--Terminal ID
                          ,p_TID             tm_om.om_product_attributes.value%type--Атрибут для биллинга
                          ,p_OTF             tm_om.om_product_attributes.value%type--Атрибут для биллинга
                          ,p_mid             tm_om.om_product_attributes.value%type--Атрибут для биллинга
                          ,p_generic_name  tm_om.asset_types.id_generic_name%type:=0 -- generic name
                          ,p_name_en         tm_om.om_channel_localizations.value%type--[1] название предложения
                          ,p_name_ru         tm_om.om_channel_localizations.value%type--[1] название предложения
                          ,p_report_name_en         tm_om.om_channel_localizations.value%type--[1] название предложения для отчетов
                          ,p_report_name_ru         tm_om.om_channel_localizations.value%type--[1] название предложения для отчетов
                          ,p_terminal_group  tm_om.asset_class.code%type:='SMARTPHONES'
                          ,p_description     tm_om.om_product_offerings.description%type
                          ,p_annex_att1     tm_om.om_po_instance_attrs_values.value%type--  [1] название ОАУ
                          ,p_annex_att2     tm_om.om_po_instance_attrs_values.value%type--  [2] тип ОАУ
                          ,p_annex_att3     tm_om.om_po_instance_attrs_values.value%type--  [3] стоимость ОАУ
                          ,p_annex_att4     tm_om.om_po_instance_attrs_values.value%type--  [4] стоимость ОАУ прописью
                          ,p_annex_att5     tm_om.om_po_instance_attrs_values.value%type--  [5] название ТП
                          ,p_annex_att6     tm_om.om_po_instance_attrs_values.value%type--  [6] количество минут life:)
                          ,p_annex_att61     tm_om.om_po_instance_attrs_values.value%type-- [6.1] количество минут life:) суммарно
                          ,p_annex_att7     tm_om.om_po_instance_attrs_values.value%type--  [7] количество минут во все
                          ,p_annex_att71     tm_om.om_po_instance_attrs_values.value%type-- [7.1] количество во все суммарно
                          ,p_annex_att8     tm_om.om_po_instance_attrs_values.value%type--  [8] количество ГБ
                          ,p_annex_att81     tm_om.om_po_instance_attrs_values.value%type-- [8.1] количество ГБ суммарно
                          ,p_annex_att9     tm_om.om_po_instance_attrs_values.value%type--  [9] название услуги
                          ,p_annex_att10     tm_om.om_po_instance_attrs_values.value%type-- [10] период действия услуги
                          ,p_annex_att11     tm_om.om_po_instance_attrs_values.value%type-- [11] количество ГБ
                          ,p_annex_att12     tm_om.om_po_instance_attrs_values.value%type-- [12]стоимость услуги со скидкой
                          ,p_annex_att13     tm_om.om_po_instance_attrs_values.value%type-- [13] стоимость услуги со скидкой прописью
                          ,p_annex_att14     tm_om.om_po_instance_attrs_values.value%type-- [14] стоимость услуги без скидки
                          ,p_annex_att15     tm_om.om_po_instance_attrs_values.value%type-- [15] стоимость услуги без скидки прописью
                          ,p_annex_att16     tm_om.om_po_instance_attrs_values.value%type-- [16] размер скидки
                          ,p_annex_att17     tm_om.om_po_instance_attrs_values.value%type-- [17] размер скидки прописью
                          ,p_annex_att18     tm_om.om_po_instance_attrs_values.value%type-- [18] платеж за ОАУ в 1-ый мес.
                          ,p_annex_att19     tm_om.om_po_instance_attrs_values.value%type-- [19] платеж за ТП в 1-ый мес.
                          ,p_annex_att191     tm_om.om_po_instance_attrs_values.value%type--  [19.1] платеж за ТП в мес.
                          ,p_annex_att192     tm_om.om_po_instance_attrs_values.value%type--  [19.2] общая сумма за ТП
                          ,p_annex_att20     tm_om.om_po_instance_attrs_values.value%type-- [20] платеж за ОАУ в 1-ый мес. + платеж за ТП в 1-ый мес. + платеж за услугу
                          ,p_annex_att201     tm_om.om_po_instance_attrs_values.value%type--  [20.1] итоговая сумма за весь период обязательств
                          ,p_annex_att21     tm_om.om_po_instance_attrs_values.value%type-- [21] количество месяцев
                          ,p_annex_att22     tm_om.om_po_instance_attrs_values.value%type-- [22] % пеня
                          ,p_annex_att221     tm_om.om_po_instance_attrs_values.value%type--  [22.1] % пеня прописью
                          ,p_annex_att23     tm_om.om_po_instance_attrs_values.value%type-- [23] дополнительные услуги
                          ,p_annex_att24     tm_om.om_po_instance_attrs_values.value%type-- [24] назначение использования ОАУ, SIM
                          ,p_annex_att25     tm_om.om_po_instance_attrs_values.value%type-- [25] количество месяцев гарантии на ОАУ
                          ,p_annex_att26     tm_om.om_po_instance_attrs_values.value%type-- [26] просрочка оплаты
                          ,p_annex_att27     tm_om.om_po_instance_attrs_values.value%type-- [27] просрочка оплаты + пеня
                          ,p_annex_att28     tm_om.om_po_instance_attrs_values.value%type:='0'--Стоимость по мобильной страховке
                          ,p_annex_att29     tm_om.om_po_instance_attrs_values.value%type-- платеж за ОАУ в мес.
                          ,p_annex_att30     tm_om.om_po_instance_attrs_values.value%type--Терминальный код
                          ,p_annex_att32    tm_om.om_po_instance_attrs_values.value%type--Актив
                          ,p_annex_att33     tm_om.om_po_instance_attrs_values.value%type--Тип предложения
                          ,p_annex_att34     tm_om.om_po_instance_attrs_values.value%type--Срок
                          ,p_annex_att35    tm_om.om_po_instance_attrs_values.value%type--Первые N платежей
                          ,p_annex_att36     tm_om.om_po_instance_attrs_values.value%type--Частота1
                          ,p_annex_att37     tm_om.om_po_instance_attrs_values.value%type--Параметр1
                          ,p_annex_att38     tm_om.om_po_instance_attrs_values.value%type--Частота2
                          ,p_annex_att39     tm_om.om_po_instance_attrs_values.value%type--Комментарий
                          )
is
  v_result number := -1;
  v_procedure_name varchar2(64) := 'new_shake_offer_bank_inst';
  v_params varchar2(4000) := 'p_terminal_id='||p_terminal_id||
  ';p_TID='||p_TID||
  ';p_name_en='||p_name_en||
  ';p_name_ru='||p_name_ru||
  ';p_terminal_group='||p_terminal_group||
  ';p_description='||p_description||'.';
  v_log_rowid varchar2(64);
  --
  v_pa_tbl configuration_pkg.product_att_tbl;
  --
  v_offer_group_name tm_om.asset_class.offer_group_name%type;--
--
  v_asset_code tm_om.asset_types.code%type;
  v_obligat_period number:=p_annex_att21;--[21] количество месяцев
  v_device_name tm_om.asset_types.screen_name%type:=p_annex_att1;--[1] название оборудования
  v_device_class tm_om.asset_class.code%type:=p_terminal_group;

  v_rule_code tm_om.asset_rules.code%type;
  --
  v_count number;
  
  device_cost_otp varchar2(32);
  v_warranty_coverage varchar2(32);
  v_warranty_cost varchar2(32);
begin
  v_log_rowid := configuration_pkg.write_log(v_procedure_name,v_params);
  --create new asset and rule
  v_asset_code:=p_terminal_id;
  --
  v_result:=configuration_pkg.asset_types(v_asset_code,v_device_class,v_device_name,p_description);
  --
  v_rule_code:='CONDITION_'||v_asset_code;
  v_result:=configuration_pkg.asset_rules(v_rule_code,p_description);
  v_result:=configuration_pkg.asset_type_to_rule(v_rule_code,v_asset_code);
  
  -- Мобильная страховка
  begin
  if p_annex_att28 !='0' then device_cost_otp := p_annex_att28;
    else select MAX(iav.value) into device_cost_otp from tm_om.om_po_instance_attrs_values iav where iav.attr_code = 'DEVICE_COST_OTP'
         and iav.om_po_instance_code in (select ii.id from tm_om.om_po_instance ii where ii.device_code in 
             (select ast.code from tm_om.asset_types ast where ast.id_generic_name = p_generic_name)); 
    end if;
    select REPLACE(to_char(t.coverage,'9999.99'), ' ','') into v_warranty_coverage from OM_EXTENDED_WARRANTY t where TO_NUMBER(REPLACE(REPLACE(device_cost_otp, ',', '.'), ' ',''), '9999.99') between t.price_from and t.price_to;
    select REPLACE(to_char(t.price,'9999.99'), ' ','') into v_warranty_cost from OM_EXTENDED_WARRANTY t where TO_NUMBER(REPLACE(REPLACE(device_cost_otp, ',', '.'), ' ',''), '9999.99') between t.price_from and t.price_to;
    exception
    when no_data_found then
    raise_application_error(-20000, ' not found  in tm_om.OM_EXTENDED_WARRANTY');
  end;

  --get offer_group_name
  select a.offer_group_name into v_offer_group_name from tm_om.asset_class a where a.code = v_device_class;

  --preparing om_product_attributes
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('AGREEMENT_TEMPLATE_INDIVIDUAL','DEFAULT',v_pa_tbl);
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('ANEX_TEMPLATE_INDIVIDUAL','SMARTSHAKE_BANK',v_pa_tbl);--render_anex.xsl
  --[BSPDT-2647] Some offers with obligations are available for existing subscribers in Public Iguana [#27520]
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('AVAILABLE_FOR_EXISTING','true',v_pa_tbl);--Existing sim card: yes
  --
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('CUSTOMER_TYPE_ATRIBUTE','INDIVIDUAL',v_pa_tbl);--Legal entity: yes
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('DEVICE_FOR_EXISTING',configuration_pkg.v_condition_wo_obligation,v_pa_tbl);
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('DEVICE_FOR_NEW',v_rule_code,v_pa_tbl);
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('DEVICE_ID_NUMBER',p_TID,v_pa_tbl);--атрибут для биллинга
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('DEVICE_IMEI',null,v_pa_tbl);--Additional field(s)
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('DEVICE_OTF',p_OTF,v_pa_tbl);--атрибут для биллинга
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('DEVICE_TYPE',null,v_pa_tbl);--Additional field(s)
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('MAIN_CATEGORY',p_mid,v_pa_tbl);--MID
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('OFFER_GROUP_NAME','DEVICES_WITH_BANK_INSTALLMENT',v_pa_tbl);
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('PANALTY_FOR_DEBT_COLLECTION','0',v_pa_tbl);--null
  --v_pa_tbl:=configuration_pkg.extend_product_att_tbl('PRODUCT_OFFERING_TYPE','STARTER_PACK',v_pa_tbl);--неизвестно на что влияет присутствие этого атрибута
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('STARTER_PACK_AGE_USAGE','18',v_pa_tbl);--From age, years
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('STARTER_PACK_CONDITION_TARIFF_PLAN',p_annex_att5,v_pa_tbl);
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('STARTER_PACK_CONDITION_TYPE','WITH_OFFER',v_pa_tbl);
  v_pa_tbl:=configuration_pkg.extend_product_att_tbl('STARTER_PACK_DURATION',v_obligat_period,v_pa_tbl);--[12] количество обязательных периодов


  --create new starter_pack
  configuration_pkg.new_starter_pack(p_terminal_id,null,p_name_ru,p_name_en,p_description,v_pa_tbl);
  
  -- name for Reports
  configuration_pkg.new_channel_registry(p_terminal_id,'REPORT',p_report_name_ru,p_report_name_en);

  --om_poi_instance_values_v
--OFFERING_SCREEN_NAME
--TARIFF_SCREEN_NAME
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'SUM_FIRST_PAYMENT',p_annex_att20);--[20] платеж за ОАУ в 1-ый мес. + платеж за ТП в 1-ый мес. + платеж за услугу

configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'OFFERING_SCREEN_NAME',p_annex_att1);--[1] название ОАУ
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'TYPE_DEVICE',p_annex_att2);--[2] тип ОАУ
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'DEVICE_COST',p_annex_att3);--[3] стоимость ОАУ
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'DEVICE_COST_WORDS',p_annex_att4);--[4] стоимость ОАУ прописью
--configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'TARIFF_SCREEN_NAME',p_annex_att1);--[5] название ТП
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'MINUTES_AMOUNT_LIFE',p_annex_att6);--[6] количество минут life:)
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'TOTAL_MINUTES_AMOUNT_LIFE',p_annex_att61);--[6.1] количество минут life:) суммарно
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'MINUTES_AMOUNT_OTHER',p_annex_att7);--[7] количество минут во все
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'TOTAL_MINUTES_AMOUNT_OTHER',p_annex_att71);--[7.1] количество во все суммарно
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'MB_AMOUNT',p_annex_att8);--[8] количество ГБ
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'TOTAL_MB_AMOUNT',p_annex_att81);--[8.1] количество ГБ суммарно
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'SERVICE_NAME',p_annex_att9);--[9] название услуги
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'SERVICE_DURATION',p_annex_att10);--[10] период действия услуги
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'SERVICE_GB_AMOUNT',p_annex_att11);--[11] количество ГБ
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'SERVICE_DISCOUNT',p_annex_att12);--[12]стоимость услуги со скидкой
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'SERVICE_DISCOUNT_WORDS',p_annex_att13);--[13] стоимость услуги со скидкой прописью
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'SERVICE_WITHOUT_DISCOUNT',p_annex_att14);--[14] стоимость услуги без скидки
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'SERVICE_WITHOUT_DISCOUNT_WORDS',p_annex_att15);--[15] стоимость услуги без скидки прописью
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'DISCOUNT',p_annex_att16);--[16] размер скидки
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'DISCOUNT_WORDS',p_annex_att17);--[17] размер скидки прописью
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'DEVICE_INITIAL_PAYMENT',p_annex_att18);--[18] платеж за ОАУ в 1-ый мес.
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'TARIFF_INITIAL_PAYMENT',p_annex_att19);--[19] платеж за ТП в 1-ый мес.
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'NEXT_TARIFF_INITIAL_PAYMENT',p_annex_att191);--[19.1] платеж за ТП в мес.
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'TOTAL_TARIFF_INITIAL_PAYMENT',p_annex_att192);--[19.2] общая сумма за ТП
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'TOTAL_INITIAL_PAYMENT',p_annex_att20);--[20] платеж за ОАУ в 1-ый мес. + платеж за ТП в 1-ый мес. + платеж за услугу
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'TOTAL_ALL_PAYMENT',p_annex_att201);--[20.1] итоговая сумма за весь период обязательств
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'OBLIGATION_PERIODS',p_annex_att21);--[21] количество месяцев
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'PERCENTAGE_OF_FINE',p_annex_att22);--[22] % пеня
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'PERCENTAGE_OF_FINE_WORDS',p_annex_att221);--[22.1] % пеня прописью
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'OFFER_ADDITIONAL_DESCRIPTION',p_annex_att23);--[23] дополнительные услуги
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'ASSIGNMENT_USAGE_DEVICE',p_annex_att24);--[24] назначение использования ОАУ, SIM
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'WARRANTY_PERIOD',p_annex_att25);--[25] количество месяцев гарантии на ОАУ
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'LATE_PAYMENT',p_annex_att26);--[26] просрочка оплаты
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'LATE_PAYMENT_FINE',p_annex_att27);--[27] просрочка оплаты + пеня
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'TID',p_TID);
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'DEVICE_COST_OTP', device_cost_otp);
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'DEVICE_WARRANTY_COVERAGE',v_warranty_coverage);
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'DEVICE_WARRANTY_COST',v_warranty_cost);
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'NEXT_DEVICE_INITIAL_PAYMENT',p_annex_att29);-- платеж за ОАУ в мес.
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'PM_DEVICE_CODE',p_annex_att30); --Терминальный код
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'PM_ACTIVE',p_annex_att32); --Актив
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'PM_OFFERING_TYPE',p_annex_att33); --Тип предложения
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'PM_PERIOD',p_annex_att34); --Срок
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'PM_FIRST_N_PAYMENTS',p_annex_att35); --Первые N платежей
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'PM_FREQUENCY_1',p_annex_att36); --Частота1
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'PM_PARAM_1',p_annex_att37); --Параметр1
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'PM_FREQUENCY_2',p_annex_att38); --Частота2
configuration_pkg.new_annex_att(v_asset_code,p_terminal_id,p_annex_att5,'PM_COMMENTS',p_annex_att39); --Комментарий


  --
  configuration_pkg.result_log(v_log_rowid,'DONE');
end new_shake_offer_bank_inst;


/***************************************************************************/