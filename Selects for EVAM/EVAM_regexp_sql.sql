
select count(1) from usage_.imei_device_info t -- orig
where regexp_like (lower(t.marketing_name),  '\apple iphone (se|11|xs|xr)\') or regexp_like (lower(t.marketing_name), '\galaxy (z flip|s20|note20 ultra)\') or regexp_like (lower(t.marketing_name),  '\pixel (3|4)\') or regexp_like (lower(t.marketing_name), 'ipad (air |mini )+\(a2| ipad pro (11|12)')

select count(*) from usage_.imei_device_info t--1968 (это основной!!!!)
where regexp_like (lower(t.marketing_name), 'ipad (air |mini )+\(a2| ipad pro (11|12)|pixel (3|4)|apple iphone (se|11|xs|xr)|galaxy (z flip|s20|note20 ultra)|galaxy (fold|foldable)$')

--'\ipad air (a2\' -- как если like '%ipad air (a2%'
^ -- строка начинается на
$ --строка заканчивается на
--http://www.sqlbooks.ru/readarticle.aspx?part=03&file=sqloracle03
--https://oracleplsql.ru/regexp_like-function.html


select * from usage_.imei_device_info t -- 605
--where regexp_like (lower(t.marketing_name), 'galaxy (fold|foldable)$')
where regexp_like (lower(t.marketing_name), 'galaxy (fold|foldable)$')

--regexp_like (lower(t.marketing_name), 'ipad ((air |mini )+\(a2)| ipad pro (11|12)\')
regexp_like (lower(t.marketing_name), 'ipad (air |mini )+\(a2| ipad pro (11|12)')
/*and lower(MARKETING_NAME) !='galaxy fold'
and lower(MARKETING_NAME) !='galaxy foldable'
and lower(MARKETING_NAME) like 'ipad mini%'
and*/ lower(MARKETING_NAME) like '%ipad air (a2%'
or lower(MARKETING_NAME) like '%ipad pro 11%'
or lower(MARKETING_NAME) like '%ipad pro 12%'
or lower(MARKETING_NAME) like '%ipad mini (a2%'

--pixel (3|4) --56
--ipad (air |mini )+\(a2| ipad pro (11|12)') --103
--apple iphone (se|11|xs|xr) --1149





-----------------------------------
select count(1) from usage_.imei_device_info t
where lower(t.marketing_name) like '%galaxy foldable' or lower(t.marketing_name) like '%galaxy s20%' or lower(t.marketing_name) like '%galaxy note20 ultra%'

select * from usage_.imei_device_info t
where lower(t.marketing_name) like '%galaxy foldable' or lower(t.marketing_name) like '%iphone 11%' or lower(t.marketing_name) like '%iphone xs%' or lower(t.marketing_name) like '%iphone xr%'

--------------------------

select * from usage_.subs_using_devices_rb_by_days using_
where using_.servedimei is not null -- 1243697332

select ACCOUNT_FK,servedimei,tac,info.model_name from usage_.subs_using_devices_rb_by_days subs, usage_.imei_device_info info
where subs.servedimei = info.tac
and 


---------------------------------------------------------------
/*докинуть в запрос
%samsung note 20%


%huawei p40
%huawei p40 pro%
%nuu x5%

%lenovo youga 630%
%hp spectre folio%

%gemini pda%
*/
