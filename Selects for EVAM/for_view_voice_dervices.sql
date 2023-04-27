select * from basdb.sold_component_tbl l
where l.sold_component_name like '%SHARED_100_MINUTES'
and l.overld_last_act_date  > to_date ('01.02.2019', 'dd.mm.yyyy')



select sc.sold_component_name,
(select p.om_product_offeringscode, c.component_code
from stage.tm_om#om_comp_registry c  
left join stage.tm_om#om_product_attributes p   
on p.om_product_offeringscode=c.product_offer_code
where p.value= 'VOICE_SERVICES'
and c.extra_value like 'P%'
and sc.sold_component_name = c.component_code)
from stage.bas#sold_component_tbl sc

select * from tm_om.om_code_pocket_label v, tm_om.om_product_attributes p
where v.om_code = p.om_product_offeringscode
and p.value= 'VOICE_SERVICES'

select * from tm_om.om_product_attributes v

select p.om_product_offeringscode, c.component_code, c.extra_value
from stage.tm_om#om_comp_registry c, stage.tm_om#om_product_attributes p   
where p.om_product_offeringscode=c.product_offer_code(+)
and p.value= 'VOICE_SERVICES'
--and c.extra_value like 'P%'
--and c.component_code like 'Bundle%'


select sc.account_fk, sc.sold_component_name, sc.lc_state||sc.lc_sub_state_code_id from stage.bas#sold_component_tbl sc
where sc.account_fk = 6368908

select * from table(stage.snaddon#.get_ussd_balance(79620))


select * from stage.bas#

select ki.*, yt.component_code, yt.extra_value from tm_om.om_product_attributes ki  left join 
tm_om.om_comp_registry yt on ki.om_product_offeringscode=yt.product_offer_code 
where ki.value= 'VOICE_SERVICES'



SELECT atb.account_id
     , COALESCE((SELECT DISTINCT 1
                   FROM stage.tm_om#om_product_attributes      s
                      , stage.tm_om#om_product_offering_info_v v
                      , stage.bas#sold_component_tbl           sc
                  WHERE s.om_ref_code_valuescode = 'SERVICE_CATEGORY_FOR_REDIRECT'
                    AND s.value = 'INTERNET'
                    AND LOWER(s.om_product_offeringscode) = LOWER(v.code)
                    AND LOWER(v.billing_component) = LOWER(sc.sold_component_name)
                    AND sc.lc_state||sc.lc_sub_state_code_id IN ('ACTBAR', 'PASWAIT', 'ACTSTD')
                    AND atb.account_id = sc.account_fk), 0) AS exists_
  FROM stage.bas#account_tbl atb;
  
  
  select * from table(snaddon.get_ussd_balance(79620))

grant execute on get_ussd_balance to YNESTEROVICH;


select * from 

tm_om.om_code_pocket_label v, 
tm_om.om_product_attributes p
where v.om_code = p.om_product_offeringscode
and p.value= 'VOICE_SERVICES'

select p.om_product_offeringscode, v.pocket_label, o.component_code, o.extra_value from
tm_om.om_product_attributes p 
left join tm_om.om_code_pocket_label v 
on v.om_code = p.om_product_offeringscode
left join tm_om.om_comp_registry o
on p.om_product_offeringscode = o.product_offer_code
where p.value= 'VOICE_SERVICES'
and o.extra_value not like 'T%'

AND lower(s.om_product_offeringscode) = lower(v.code)
AND lower(v.billing_component) = lower(sc.sold_component_name)


select p.om_product_offeringscode, v.pocket_label, o.component_code, o.extra_value, p.value from
tm_om.om_product_attributes p 
left join tm_om.om_code_pocket_label v 
on lower(v.om_code) = lower(p.om_product_offeringscode)
left join tm_om.om_comp_registry o
on lower(p.om_product_offeringscode) = lower(o.product_offer_code)
where 
(p.value = 'VOICE_SERVICES'
and o.extra_value like 'P%') or (lower(v.pocket_label) like '%pl_all_in_one%' and p.value = 'SERVICE')
  

select * from table(stage.get_ussd_balance(27425454))

grant execute on get_ussd_balance to YNESTEROVICH


with t1(account_id) as (select account_id from baspre.account_tbl@goldpre)
select t1.account_id,
(select p.om_product_offeringscode, v.pocket_label, o.component_code, o.extra_value, p.value
from tm_om.om_product_attributes@deeppre p
left join tm_om.om_code_pocket_label@deeppre v
on lower(v.om_code) = lower(p.om_product_offeringscode)
left join tm_om.om_comp_registry@deeppre o
on lower(p.om_product_offeringscode) = lower(o.product_offer_code)
where (p.value like 'VOICE%'
and o.extra_value like 'P%')
and p.om_product_offeringscode not in ('S_0_WITHIN_THE_NETWORK',
'S_1000_MIN_OTHER_NET',
'S_300_MIN_OTHER_NET',
'S_500_MIN_OTHER_NET',
'S_FAVORITE_NUMBER_OMO',
'S_FRIENDSFAMILY')) g, table(snaddon.get_ussd_balance(t1.account_id)) u
where lower(g.pocket_label) = lower(u.label_id)



___________________________________________________________________________________
select p.om_product_offeringscode, v.pocket_label, o.component_code, o.extra_value, p.value
from tm_om.om_product_attributes@deeppre p
left join tm_om.om_code_pocket_label@deeppre v
on lower(v.om_code) = lower(p.om_product_offeringscode)
left join tm_om.om_comp_registry@deeppre o
on lower(p.om_product_offeringscode) = lower(o.product_offer_code)
where (p.value like 'VOICE%'
and o.extra_value like 'P%') or (lower(v.pocket_label) like '%pl_all_in_one%' and p.value = 'SERVICE')

