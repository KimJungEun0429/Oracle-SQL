--고객 아이디 입력하면 고객이름과 판매리스트

SELECT *
FROM SALES_TBL
;


SELECT *
FROM SALES_TBL T1, CUSTOMER_TBL T2, PRODUCTS_TBL T3
WHERE T1.C_ID = T2.C_ID
AND T2.C_ID = 'C00001'
ORDER BY S_OUTDATE
;

--SELECT * FROM SALES_TBL;
--SELECT * FROM PRODUCTS_TBL;
--새롭게 회원으로 가입하면 농심라면 5개를 무료로 준다.


CREATE OR REPLACE PROCEDURE PROC_EVENT_TBL
(
        IN_C_NAME          IN          VARCHAR2,
        IN_C_BIRTH         IN          NUMBER,
        IN_C_REGION        IN          VARCHAR2,
        IN_C_GENDER        IN          VARCHAR2,
        IN_C_PWD           IN          VARCHAR2
)
AS
        V_C_ID          CHAR(6);
        V_R_ID          CHAR(6);
       
BEGIN

        SELECT 'C' || TO_CHAR(TO_NUMBER(SUBSTR(NVL(MAX(C_ID),0),2)) +1,'FM00000')
        INTO V_C_ID
        FROM CUSTOMER_TBL
        ;
        
        SELECT R_ID
        INTO  V_R_ID
        FROM REGION_TBL
        WHERE R_NAME = IN_C_REGION
        ;
        
        INSERT INTO CUSTOMER_TBL
        (C_ID,C_NAME,C_REGION,C_GENDER,C_PWD)
        VALUES
        (V_C_ID,IN_C_NAME,V_R_ID,IN_C_GENDER,IN_C_PWD)
        ;
        
        
        INSERT INTO SALES_TBL
        (C_ID, PRO_ID, S_IDX, S_PRICE, S_QTY, S_OUTDATE)
        VALUES
        (V_C_ID,'P00001',1,0,5,SYSDATE);
        

END PROC_EVENT_TBL;

        