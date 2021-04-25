--구매하는 프로시저
--어떤 고객이 어떤물건을 얼마에 몇개 샀느냐

SELECT * FROM SALES_TBL;

CREATE OR REPLACE PROCEDURE PROC_INS_SALES
(
        IN_C_ID         IN          VARCHAR2,
        IN_PRO_ID       IN          VARCHAR2,
        IN_PRICE        IN          NUMBER,
        IN_QTY          IN          NUMBER
)
AS
    V_S_IDX                 NUMBER(3);
BEGIN
    --1. 같은고객, 같은 물건에 대한 IDX값 찾기
    SELECT MAX(S_IDX) +1
    INTO V_S_IDX
    FROM SALES_TBL
    WHERE C_ID = IN_C_ID AND PRO_ID = IN_PRO_ID
    ;
    
    --2. INSERT
    INSERT INTO SALES_TBL
    (C_ID, PRO_ID, S_IDX, S_PRICE, S_QTY, S_OUTDATE)
    VALUES
    (IN_C_ID, IN_PRO_ID, V_S_IDX, IN_PRICE, IN_QTY, SYSDATE);

END PROC_INS_SALES;