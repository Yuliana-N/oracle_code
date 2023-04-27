--������� ��������� ���������� �����
SELECT ex.account_fk
      ,ex.mobile_no
      ,ex.line_lvl
      ,ex.category AS mid
      ,lc.lc_state || ' / ' || lc.lc_sub_state_code_id AS lc_state
      ,lc.lc_reason_code_id AS reason
      ,DECODE(lc.lc_state || ' / ' || lc.lc_sub_state_code_id
             ,'DPL / STD',   '����������� ���������'
             ,'DPL / HOLD',  '���������'
             ,'DPL / PRE',   '������������������'
             ,'ACT / STD',   '��������'
             ,'ACT / BAR',   '������������ �� ��������'
             ,'ACT / SUSPW', '������������� �� �������'
             ,'ACT / SUSPF', '������������� �� �������������'
             ,'ACT / SUSPD', '������������� �� �������������'
             ,'ACT / SUSPL', '������������� �� ����� ���'
             ,'ACT / SUSP',  '�������������'
             ,'ACT / SUSPCH','������������� ��� ����� ���������'
             ,'ACT / SAVE',  '���������� ������'
             ,'ACT / SUSPQ', '��������'
             ,'TWL / STD',   '�������� � ������'
             ,'TRM / STD',   '��������'
                            ,'����������� ��������� - ' || lc.lc_state || ' / ' || lc.lc_sub_state_code_id) AS status
      ,TO_CHAR(lc.lc_date_from,'dd.mm.yyyy hh24:mi:ss') AS �
      ,TO_CHAR(lc.lc_date_to,'dd.mm.yyyy hh24:mi:ss') AS ��
  FROM baspre.lc_account_tbl lc
      ,baspre.account_ex_tbl ex
 WHERE ex.account_fk = lc.account_fk
--   AND ex.mobile_no = '375257155276'
   AND ex."ACCOUNT_FK" = '44159'
   AND lc.lc_date_from between to_date('28.08.2018 15:00:00','dd.mm.yyyy hh24:mi:ss') and to_date('30.08.2018 18:00:00','dd.mm.yyyy hh24:mi:ss')
 ORDER BY 2               ASC
         ,lc.lc_date_from ASC
