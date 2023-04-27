select * from tm_om.om_code_pocket_label a
where a.om_code like '%XS%'


-- OM code pocket label
 update tm_om.OM_CODE_POCKET_LABEL k set k.POCKET_LABEL='TL_XS' where k.OM_CODE='XS' and k.pocket_label != 'TL_O_V1';
  if (SQL%ROWCOUNT) = 0 then
  insert into tm_om.OM_CODE_POCKET_LABEL(k.OM_CODE,k.POCKET_LABEL) values('XS','TL_XS');
 end if;

-- add service path with pnl

--update
declare
  v_result number := -1;
begin
    update tm_om.om_code_pocket_label set om_code_pocket_label.pocket_label='TL_XS' where om_code_pocket_label.pocket_label='TL_XS' and om_code_pocket_label.om_code='XS';
    v_result := SQL%ROWCOUNT;
      if v_result = 0 then
      insert into tm_om.om_code_pocket_label (om_code_pocket_label.om_code,om_code_pocket_label.pocket_label)
      values ('XS','TL_XS');
      v_result := SQL%ROWCOUNT;
    elsif v_result > 1 then raise_application_error(-20099, 'Error happened during update: duplicate rows in tm_om.om_code_pocket_label');
    end if;
end;
--select * from tm_om.OM_CODE_POCKET_LABEL where OM_CODE_POCKET_LABEL.OM_CODE='XS' 
/
