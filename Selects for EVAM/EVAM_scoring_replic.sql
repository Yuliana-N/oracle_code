select count(1), date_calc from stage.scoring#scor_bill_scores_all
group by date_calc
select * from stage.scoring#scor_limits
select * from stage.scoring#scor_exclude_subscribers
select * from stage.scoring#scor_pers_all_limits_orig
select identification_code from stage.bas#account_ex_tbl

select * from stage.scoring#scor_bill_scores_all
where id_private = '3100782K034PB2'


(select c.private_id, bill.score from stage.scoring#scor_exclude_subscribers c left join stage.scoring#scor_bill_scores_all bill on c.private_id = bill.id_private) t

select GET_SCOR_BILL_SCORES (1766265) scor from dual

select nvl(max(limit_),0) from table (GET_SCOR_BILL_SCORES(1766265))
select  nvl(max(score),0) from table (GET_SCOR_BILL_SCORES(p_account_id =>28077568 ))
