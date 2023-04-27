with xml_list     as (select * from  ROAMING_PARTNERS_LOB where id =21),
     rz_list      as (select * from  ROAMING_PARTNERS_DICT where type =1),
     tadig_list   as (select * from  ROAMING_PARTNERS),
     rates_list   as (select * from  ROAMING_CUSTOMER_RATES /*where STATE =1*/),-- STATE =1 - новые цены, таблицу нужно обновлять
     service_list as (select xml_table.* from xml_list,  xmltable ('/a/service_tree/service_tree/service_tree/service_tree'
      PASSING xmltype(clob_content)
      COLUMNS 
      --aaa xmltype PATH '/service_tree',
         service varchar2(1000) PATH '@name',
         service_zone varchar2(1000) PATH '/service_tree/match_set' ,
         local varchar2(1000) PATH '/service_tree/service_tree[1]/@name',
         belarus varchar2(1000) PATH '/service_tree/service_tree[2]/@name',
         world varchar2(1000) PATH '/service_tree/service_tree[3]/@name'
         ) 
      xml_table)
--select rz_list.id, tadig, textvalue, service_list.*, mtc_novat from service_list, rz_list, tadig_list, rates_list
select DISTINCT (service_list.service), rz_list.id, tadig, textvalue, service_list.*,  moc_national_novat, moc_belarus_novat, moc_international_novat, smsmo from service_list, rz_list, tadig_list, rates_list
where service_zone like '%' || textvalue || '%'
and rz_list.id=tadig_list.id
and rates_list.partnerid=tadig_list.id
and service like '%RMOC_Benin_Glomobile_Belarus%'
--and tadig like '%IDNLT%'
order by tadig
