create or replace view BTXPS_LABWARE_DEV.LABWARE_LIMS_DEV.BTXPS_LOT(
	LOT_NUMBER,
	LOT_NAME,
	PRODUCT,
	SYSTEM,
	SAP_ID,
	AXIS360_ID,
	ANDOVER_ID,
	SAP_MATERIAL
) as select LOT_NUMBER,LOT_NAME,PRODUCT,
case 
    when regexp_like(replace(lot_name,' ',''),'^\\d{2}-[A-Za-z]{2}-\\d{5}$') then 'AXIS360' 
     WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}\\[\\d\\]\\[-[A-Za-z]\\]$') THEN 'ANDOVER'
     WHEN (REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}-[A-Za-z]\\d{0,5}$')) THEN 'SAP'
     WHEN (REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}-[A-Za-z]{2}\\d{0,4}$')) THEN 'SAP'
     WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H-\\d{9}-[A-Za-z]{2}\\d{0,4}$') THEN 'SAP'
     WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^XH-\\d{9}-[A-Za-z]{2}\\d{0,4}$') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^XH\\d{9}-[A-Za-z]{2}\\d{0,4}$') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^XH\\d{9}-[A-Za-z]\\d{0,5}$') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}\\s[A-Za-z]\\d{5}$') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]{2}\\d{0,4}$') and length(lot_name) = 6 THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{0,5}$') and length(lot_name) = 6 THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}-\\d{6}$') THEN 'AXIS360'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}\\[\\d\\]\\([A-Za-z]\\d{5}\\)') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}\\([A-Za-z]\\d{5}\\)') THEN 'ANDOVER-SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}$') THEN 'ANDOVER'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}.$') THEN 'ANDOVER'    
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}-[A-Z]{2}$') THEN 'ANDOVER'            
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}-[A-Za-z]$') THEN 'ANDOVER'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{4}$')  THEN 'ANDOVER'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}\\([A-Za-z]{2}\\d{4}\\)$') THEN 'ANDOVER-SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}\\-.*') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}\\_.*') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^D\\d{7}_.*') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{5}S$') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]{2}\\d{4}S$') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]{2}\\d{4}-') THEN 'SAP' --tbd
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]{2}\\d{4}_') THEN 'SAP' --tbd
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]{2}\\d{4}\\(') THEN 'SAP' --tbd mycol,'[a-zA-z]\\\\d{1,}[\\\\s0-9a-zA-Z]*'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{5}-.*') THEN 'SAP' --tbd
    WHEN REGEXP_LIKE(lot_name, '^H\\d{9}\\s[A-Za-z]\\d{5}$') THEN 'SAP'
    --WHEN REGEXP_LIKE(replace(lot_name,' ',''), '[A-Za-z]\\d{5}', 'i') THEN 'SAP'
    WHEN REGEXP_LIKE(lot_name, '^[A-Za-z]\\d{5}', 'i') THEN 'SAP'
    WHEN REGEXP_LIKE(LOT_NAME, '[A-Za-z]{2}\\d{4}$', 'i') THEN 'SAP'
    WHEN REGEXP_LIKE(LOT_NAME, '[A-Za-z]{2}\\d{4}\\(.*', 'i') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{5}_.*') THEN 'SAP' --tbd
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{5}\\(.*') THEN 'SAP' --tbd
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^2001\\d{6}') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^C\\d-\\d{6}[A-Z]') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^AN32SQ\\d{4}') THEN 'SAP'
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^WOTL\\d{5}') THEN 'SAP'
    else 'UNKNOWN2'
end SYSTEM,

CASE 
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}-[A-Za-z]\\d{0,5}$') OR REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}-[A-Za-z]\\d{0,5}.*') 
    OR REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}\\_.*')
    THEN SUBSTR(LOT_NAME,12,6)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}-[A-Za-z]{2}\\d{0,4}$') THEN SUBSTR(LOT_NAME,12,6)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H-\\d{9}-[A-Za-z]{2}\\d{0,4}$') THEN SUBSTR(LOT_NAME,13,7)
    WHEN REGEXP_LIKE(lot_name, '^H\\d{9}\\s[A-Za-z]\\d{5}$') THEN substr(lot_name,regexp_instr(lot_name, ' ')+1,6)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]{2}\\d{0,4}$') and length(lot_name) = 6 THEN REGEXP_SUBSTR(lot_name, '^[A-Za-z]{2}\\d{0,4}$')
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{0,5}$') and length(lot_name) = 6 THEN REGEXP_SUBSTR(lot_name, '^[A-Za-z]\\d{0,5}$')
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}\\[\\d\\]\\([A-Za-z]\\d{5}\\)')
                        THEN regexp_substr(replace(lot_name,' ',''),9,12)--THEN REGEXP_SUBSTR(lot_name, '\\((\\w+)\\)', 1, 1, NULL, 1)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^XH\\d{9}-[A-Za-z]{2}\\d{0,4}$') OR REGEXP_LIKE(replace(lot_name,' ',''), '^XH\\d{9}-[A-Za-z]\\d{0,5}$') 
        THEN SUBSTR(replace(LOT_NAME,' ',''),13,7)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}\\([A-Za-z]{2}\\d{4}\\)$') THEN SUBSTR(replace(lot_name,' ',''),12,6)
    --THEN REGEXP_SUBSTR(replace(lot_name,' ',''), '\\((\\w+)\\)', 1, 1, NULL, 1)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}\\([A-Za-z]\\d{5}\\)')
      THEN SUBSTR(replace(lot_name,' ',''),12,6)--REGEXP_SUBSTR(replace(lot_name,' ',''), '\\((\\w+)\\)', 1, 1, NULL, 1)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}-[A-Za-z]\\d{5}-.*$') 
      THEN SUBSTR(lot_name, regexp_instr(lot_name, '-') + 1, regexp_instr(lot_name, '-', regexp_instr(lot_name, '-') + 1) - regexp_instr(lot_name, '-') - 1)
    WHEN REGEXP_LIKE(REPLACE(lot_name, ' ', ''), '^XH\\d{9}-[A-Za-z]{2}\\d{4}$') 
      THEN SUBSTR(lot_name, regexp_instr(lot_name, '-') + 1, regexp_instr(lot_name, '-', regexp_instr(lot_name, '-') + 1) - regexp_instr(lot_name, '-') - 1) 
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}-') or REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}_') THEN SUBSTR(replace(lot_name,' ',''),12,6)
    --WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}_') THEN SUBSTR(replace(lot_name,' ',''),12,6)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}') THEN SUBSTR(replace(lot_name,' ',''),11,7)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^D\\d{7}_.*') THEN SUBSTR(replace(lot_name,' ',''),10,6)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{5}S$')  OR REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]{2}\\d{4}S$') 
    THEN SUBSTR(replace(lot_name,' ',''),0,7)
    --WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]{2}\\d{4}S$') THEN SUBSTR(replace(lot_name,' ',''),0,7)
    --WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]{2}\\d{4}') THEN SUBSTR(LOT_NAME,0,6)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{5}$') OR REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{5}-.*') 
    OR REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{5}_.*')THEN SUBSTR(replace(lot_name,' ',''),0,6)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^2001\\d{6}') THEN replace(lot_name,' ','')
    --WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^C\\d-\\d{6}[A-Z]') THEN replace(lot_name,' ','')
    WHEN REGEXP_LIKE(lot_name, '^AN32SQ\\d{4}') OR REGEXP_LIKE(replace(lot_name,' ',''), '^C\\d-\\d{6}[A-Z]') OR REGEXP_LIKE(replace(lot_name,' ',''), '^WOTL\\d{5}') 
        THEN  replace(lot_name,' ','')
    -- WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^WOTL\\d{5}') THEN replace(lot_name,' ','')
    --WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{5}-') THEN SUBSTR(replace(lot_name,' ',''),0,6)
    --WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{5}_') THEN SUBSTR(replace(lot_name,' ',''),0,6)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]\\d{5}\\(.*') OR REGEXP_LIKE(replace(lot_name,' ',''), '^[A-Za-z]{2}\\d{4}\\(.*')
    THEN SUBSTR(replace(lot_name,' ',''),0,6)
    WHEN REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}-[A-Za-z]\\d{5}_.*$') 
        THEN SUBSTR(lot_name, regexp_instr(lot_name, '_') + 1, regexp_instr(lot_name, '_', regexp_instr(lot_name, '-') + 1) - regexp_instr(lot_name, '-') - 1)

     END SAP_ID
    
, iff(regexp_like(replace(lot_name,' ',''),'^\\d{2}-[A-Za-z]{2}-\\d{5}$'),REGEXP_SUBSTR(replace(lot_name,' ',''),'^\\d{2}-[A-Za-z]{2}-\\d{5}$'),
iff(REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}-\\d{6}$'),REGEXP_SUBSTR(replace(lot_name,' ',''), '^\\d{2}-\\d{6}$'),NULL)) AXIS360_ID,

iff(REGEXP_LIKE(replace(lot_name,' ',''), '^\d{2}[A-Za-z]\d{3}[A-Za-z]\d{3}\([A-Za-z]\d{5}\)'), SUBSTR(LOT_NAME,0,10),
iff(REGEXP_LIKE(replace(replace(lot_name,' ',''),' ',''), '^\d{2}[A-Za-z]\d{3}[A-Za-z]\d{3}\([A-Za-z]{2}\d{4}\)$') , SUBSTR(LOT_NAME,0,10),
IFF(REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}$'),LOT_NAME,
IFF(REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}.$'),SUBSTR(LOT_NAME,0,11),
iff(REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}-[A-Z]{2}$'),lot_name,
iff(REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}-[A-Za-z]$'),lot_name,
IFF(REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}\\([A-Za-z]{2}\\d{4}\\)$'),SUBSTR(replace(lot_name,' ',''),0,10),
IFF(REGEXP_LIKE(replace(lot_name,' ',''), '^\\d{2}[A-Za-z]\\d{3}[A-Za-z]\\d{3}\\([A-Za-z]\\d{5}\\)'), SUBSTR(replace(lot_name,' ',''),0,10),
NULL)))))))) ANDOVER_ID,
 iff(REGEXP_LIKE(replace(lot_name,' ',''), '^H\\d{9}.*'),SUBSTR(replace(lot_name,' ',''),0,10) ,
 IFF(REGEXP_LIKE(replace(lot_name,' ',''), '^XH\\d{9}-[A-Za-z]\\d{0,5}$'),SUBSTR(replace(lot_name,' ',''),0,11),NULL)) SAP_MATERIAL

from BTXPS_LABWARE_DEV.LABWARE_LIMS_DEV.LOT L1 
--WHERE LOT_NAME='H000016193_X43334-EL*DONT USE*'
--where  LOT_NAME ='XH000004510-H73255'

--REGEXP_LIKE(replace(LOT_NAME,' ',''), '^[A-Za-z]{2}\\d{4}$')
--REGEXP_LIKE(replace(LOT_NAME,' ',''), '^[A-Za-z]{2}\\d{4}\\\\(\\\\[A-Za-z]{2}\\d{7}\\\\)')
--lot_name = 'FG7638(PU1240407)'
--limit 10

/*

*/;