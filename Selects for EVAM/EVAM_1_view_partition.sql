------------------------ SC48 (для входного ивента ee_sc48)
create or replace view vw_first_authorization_lifego as
select p.account_id, p.added, p.first_authoriz
from (select s.account_id, s.added, count(s.account_id) over (partition by s.account_id
order by s.account_id)first_authoriz
from STAGE.LIFEGO#PROMO_USERS s order by s.account_id) p
where p.added > sysdate-10*1/24/60 and p.first_authoriz < 2;
