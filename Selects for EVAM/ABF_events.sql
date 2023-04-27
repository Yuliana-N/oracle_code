--Final Select for ABF events
SELECT a.oid,/*st_event_affected_balance*/
b.account_id,
b.event_start,--начало события (звонка, сесии) REG.*_02 :1510 152515.251
--b.starttime,
b.report_create_time, --сформировался ивент
--a.EVENT_AMOUNT,
--d.quantity,
b.service_path,
--b.annotation,
--b.oid,/*st_event*/
b.creid,
b.tid, /*<transaction id> */
--b.root_account_id,
--b.tax_calculated_inf,

/* information about balance*/
c.balance,
a.before,
a.after,
a.amount,
a.pocket_start,
a.pocket_end,
d.rule,
/* for usage events - moc, mtc, gprs, roaming */
b.event_duration, /* длительность события ( в сек, */
b.served_party, -- msisdn 
b.other_party,
b.served_zone,
b.other_zone,
b.ggsn_id,
b.location_id,
b.cell,
b.is_cdr,
/**/

b.tariff_type,
b.line_lvl

FROM 
abf.st_event b, /*stores the imported events*/
abf.st_event_affected_balance a, /*table stores the total balances for the imported events*/ 
abf.dict_balance c, /* balances names */
abf.st_event_rule d /*stores the individual balance changes for the imported events based on service options and rules */
where /* */ a.event_id = b.oid and a.balance_id = c.oid /* */ and a.oid = d.EVENT_AFFECTED_BALANCE_ID

and b.account_id = '62906'
--and b.service_path like /*'%TPR_SHK%'*/'%GPRS%'/*'%MOC%'*/
--and b.service_path = 'ROOT/USAGE_EVENT/VOICE/MOC/MOC_OnNet'
--and c.balance = 'Bundle_GPRS_Digital_Lifebox' 
--and b.tariff_type = 'TP_DL006' 
--and a.before > 0 /* Balance-Amount before the event */
--and a.after = '0' /* Balance-Amount after the event */
--and b.tid = 'XYiKX.BNH.iQQWG.EH' 
--and a.balance_id = 85 
--and b.starttime > sysdate - 20
--and a.after in ('5','6') 
--and b.event_start between to_date('22.10.2018 00:00:00','dd.mm.yyyy hh24:mi:ss') and to_date('22.10.2018 16:00:00','dd.mm.yyyy hh24:mi:ss')
--and b.annotation = 'sfsfsg' 
--and a.oid = '12551212'
order by event_start desc; --8074847, 7855685, 7689823, 6894849 

--OTHER SELECTs
--select * from abf.st_event_rule where EVENT_AFFECTED_BALANCE_ID = '12551212'; Select st.OID, ST.ACCOUNT_ID, ST.STARTTIME, ST.SERVICE_PATH, ST.BALANCE_ID, ST.AMOUNT, ST.EVENT_AMOUNT, RL.QUANTITY from INT.ABF_STEVENTAFFECTEDBALANCE st join INT.ABF_STEVENTRULE rl on st.OID = rl.EVENT_AFFECTED_BALANCE_ID where st.OID in (6467874992, 6467874233, 6468457518) order by ST.OID; */ 
--select * from abf.st_event_rule r where r.event_affected_balance_id in ('18800007','18800008') - 
--select b.msc from abf.st_event b where b.account_id = '24760' and b.service_path like '%USAGE_EVENT/GPRS/GPRS_INTERNET%' 
--select * from abf.st_event_affected_balance -- total balances for the imported events (reservation)
--select * from abf.st_event_rule where cre_service_option_id like '%486%' - рулы

/*
select * from abf.st_event_rule where EVENT_AFFECTED_BALANCE_ID = '12551212';
Select st.OID,
ST.ACCOUNT_ID,
ST.STARTTIME,
ST.SERVICE_PATH,
ST.BALANCE_ID,
ST.AMOUNT,
ST.EVENT_AMOUNT,
RL.QUANTITY
from INT.ABF_STEVENTAFFECTEDBALANCE st
join INT.ABF_STEVENTRULE rl
on st.OID = rl.EVENT_AFFECTED_BALANCE_ID
where st.OID in (6467874992, 6467874233, 6468457518)
order by ST.OID;
*/
