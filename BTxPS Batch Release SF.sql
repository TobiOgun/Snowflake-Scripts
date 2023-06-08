SELECT
    'PS_LIMS' AS LIMS_SOURCE,
    'Pharm_Sci' AS LIMS_INSTANCE,
    L1.LOT_NUMBER AS LIMS_LOT_NUMBER,
    L1.LOT_NAME AS LIMS_LOT_NAME,
    SAP_ID AS SAP_BATCH,
    --future logic to parse out SAP batch from LOT_NAME
    sap_material AS SAP_MATERIAL,
    --future logic to parse out SAP batch from LOT_NAME
    axis360_id AS AX360_BATCH,
    --future logic to parse out Axis360 BATCH id from LOT_NAME
    ITEMID AS AX360_MATERIAL,
    --future logic to parse out Axis360 ITEM id from LOT_NAME
    L1.DESCRIPTION AS LIMS_LOT_DESCRIPTION,
    L1.PRODUCT AS LIMS_PRODUCT,
    L1.PRODUCT_VERSION AS LIMS_PRODUCT_VERSION,
    null AS MATERIAL_TYPE_KEY,
    --future logic to pull from SAP if this maps to an SAP Material
    null AS MATERIAL_CATEGORY,
    --future logic to pull from SAP if this maps to an SAP Material
    P1.X_PRODUCT_TYPE AS PS_MATERIAL_CATEGORY,
    null AS MATERIAL_MANUFACTURING_PLANT,
    --future logic to pull from SAP if this maps to an SAP Material
    null AS MATERIAL_DESTINATION_MARKET,
    --future logic to pull from SAP if this maps to an SAP Material
    null AS DESTINATION_MARKET_DESCRIPTION,
    --future logic to pull from SAP if this maps to an SAP Material
    null AS GRP_CODE,
    --future logic to pull from SAP if this maps to an SAP Material
    null AS ACTIVE_INGREDIENT1,
    --future logic to pull from SAP if this maps to an SAP Material
    C1.NAME AS COMPOUND_ID,
    null AS COMPOSITE_BATCH,
    --concept does not exist is PS LIMS
    null AS DISPOSITION_CODE,
    --future logic to get from SAP or AXIS360
    null AS DISPOSITION_DATE,
    --future logic to get from SAP or AXIS360
    L1.EXPIRY_DATE AS EXPIRY_DATE,
    --potentially check value in SAP batch master as NVL(bm.shelf_life_expiration_date, li.expiry_date)
    null AS QUANTITY_MANUFACTURED,
    --future logic to get from SAP or AXIS360
    null AS QTY_BASE_UNIT_OF_MEASURE,
    --future logic to get from SAP or AXIS360
    L1.CHANGED_ON AS LIMS_LOT_CHANGED_ON
FROM
    BTXPS_LABWARE_DEV.LABWARE_LIMS_DEV.X_COMPOUNDS C1
    LEFT OUTER JOIN BTXPS_LABWARE_DEV.LABWARE_LIMS_DEV.LOT L1 ON L1.X_COMPOUND_ID = C1.COMPOUND_ID
    LEFT OUTER JOIN BTXPS_LABWARE_DEV.LABWARE_LIMS_DEV.PRODUCT P1 ON P1.NAME = L1.PRODUCT
    AND P1.VERSION = L1.PRODUCT_VERSION
    LEFT OUTER JOIN BTXPS_LABWARE_DEV.LABWARE_LIMS_DEV.BTXPS_LOT L2 ON L1.LOT_NUMBER = L2.LOT_NUMBER
    LEFT OUTER JOIN BTXPS_AXIS360_DEV.AXIS360_DEVBOX11_DAU_DEMO.AXS_BATCH B ON L1.LOT_NAME = CAST(B.INVENTBATCHID AS STRING)
WHERE
    L1.TEMPLATE in ('LOT_ALL', 'BIOSIMILAR')
    and axis360_id is not null AND B.ITEMID IS NOT NULL
   -- and C1.NAME = 'PF-06741086' --marstacimab
    -- and L1.LOT_NAME = 'GT4721'
LIMIT
    1000;