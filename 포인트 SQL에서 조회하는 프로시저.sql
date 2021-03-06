CREATE OR REPLACE PROCEDURE PROC_INS_CUS_POINT

(
            IN_C_ID     IN VARCHAR2,
            O_CUR       OUT SYS_REFCURSOR
)
AS

BEGIN

OPEN O_CUR FOR
SELECT A.C_ID, A.C_NAME, ROUND(SUM(A.CUS_POINT), 0) AS TLT_POINT FROM

(
    SELECT T3.C_ID, T3.C_NAME, T2.PRO_ID, T2.PRO_NAME, 
    SUM(T1.S_PRICE * T1.S_QTY * (T2.PRO_POINT / 100)) AS CUS_POINT
    FROM SALES_TBL T1, PRODUCTS_TBL T2, CUSTOMER_TBL T3
    WHERE T1.PRO_ID = T2.PRO_ID
    AND T1.C_ID = T3.C_ID
    GROUP BY T3.C_ID, T3.C_NAME, T2.PRO_ID, T2.PRO_NAME
    ORDER BY T3.C_NAME, T2.PRO_NAME ASC
) A
WHERE A.C_ID = IN_C_ID
GROUP BY A.C_ID, A.C_NAME;

END PROC_INS_CUS_POINT;

SELECT * FROM CUSTOMER_TBL;
SELECT * FROM PRODUCTS_TBL;
SELECT * FROM SALES_TBL;