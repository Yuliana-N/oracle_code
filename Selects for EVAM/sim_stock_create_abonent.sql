ALTER SESSION SET TIME_ZONE = '+03:00';
TRUNCATE TABLE change_tp;
SELECT * FROM change_tp;

INSERT INTO change_tp(msisdn, imsi, iccid, pin1, pin2, puk1, puk2, eki, kind, category, access_group, start_from_step, type)
SELECT ss.msisdn, ss.imsi, ss.iccid, ss.gsm_pin1, ss.gsm_pin2, ss.gsm_puk1, ss.gsm_puk2, ss.ki1, '1', 'Voice 2 BASIC', '0000000', NULL, 'MULTIPLE'
  FROM sim_stock.ss_sim_card ss--, fios
 WHERE ss.msisdn = '375257113955'
--   AND ss.iccid = fios.contract;--(SELECT msisdn FROM fios)--

SELECT * FROM change_tp WHERE msisdn IN ('375257113955');--(SELECT msisdn FROM msisdn_list)--

INSERT INTO mes.q_installation_tbl(msisdn, imsi, iccid, pin1, pin2, puk1, puk2, eki, kind, category, access_group, start_from_step, type)
SELECT ct.msisdn, ct.imsi, ct.iccid, ct.pin1, ct.pin2, ct.puk1, ct.puk2, ct.eki, ct.kind, ct.category, ct.access_group, ct.start_from_step, ct.type
  FROM change_tp ct
 WHERE ct.msisdn IN ('375257113955');--(SELECT msisdn FROM msisdn_list)--

COMMIT;

SELECT * FROM mes.q_installation_tbl it 
 WHERE it.msisdn IN ('375256257444')--(SELECT msisdn FROM fios)--
 ORDER BY TO_NUMBER(it.code) DESC;
