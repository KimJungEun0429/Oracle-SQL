--회원별로 CUSTOMER_TBL에 C_POINT 값을 입력하는 프로시저 만들기(POINT_TBL에 INSERT하기)//UPDATE가 어려운 이유
        SELECT T2.C_ID, SUM((T1.PRO_POINT/100) * ((T2.S_PRICE * T2.S_QTY) * T2.S_IDX)) AS POINT
        FROM PRODUCTS_TBL T1, SALES_TBL T2
        WHERE T1.PRO_ID = T2.PRO_ID(+)
        GROUP BY T2.C_ID
        ORDER BY T2.C_ID
        ;
SELECT * FROM CUSTOMER_TBL;
SELECT * FROM PRODUCTS_TBL;
SELECT * FROM SALES_TBL;
SELECT * FROM POINT_TBL;
DROP TABLE POINT_TBL;

SELECT T1.PRO_ID, T1.PRO_NAME, (T1.PRO_POINT/100) * ((T2.S_PRICE * T2.S_QTY) * T2.S_IDX) AS POINT , T3.C_ID, T3.C_NAME, T3.C_POINT 
FROM PRODUCTS_TBL T1, SALES_TBL T2, CUSTOMER_TBL T3
WHERE T1.PRO_ID = T2.PRO_ID
AND T3.C_ID = T2.C_ID
;


        SELECT *
        FROM PRODUCTS_TBL T1, SALES_TBL T2, CUSTOMER_TBL T3
        WHERE T1.PRO_ID = T2.PRO_ID(+)
        AND T2.C_ID = T3.C_ID(+)
        --GROUP BY T2.C_ID,T2.PROID
        ORDER BY T2.C_ID
        ;
        
        SELECT B.C_ID, NVL(SUM((A.S_PRICE * A.S_QTY) *(A.PRO_POINT/100)),0) AS POINT
        FROM
        (
        SELECT T1.PRO_ID, T1.PRO_NAME,T1.PRO_POINT, T2.S_PRICE, T2.S_QTY, T2.C_ID
        FROM PRODUCTS_TBL T1, SALES_TBL T2
        WHERE T1.PRO_ID = T2.PRO_ID
        --GROUP BY T2.C_ID,T2.PROID
        --ORDER BY T2.C_ID
        )A, CUSTOMER_TBL B
        WHERE A.C_ID(+) = B.C_ID
        GROUP BY B.C_ID
        ;
-----------------------------------------------한꺼번에 넣는 방법
CREATE OR REPLACE PROCEDURE PRO_INS_POINT

AS
            
BEGIN
        
        INSERT INTO POINT_TBL
        SELECT T2.C_ID, SUM((T1.PRO_POINT/100) * ((T2.S_PRICE * T2.S_QTY) * T2.S_IDX)) AS POINT
        FROM PRODUCTS_TBL T1, SALES_TBL T2
        WHERE T1.PRO_ID = T2.PRO_ID(+)
        GROUP BY T2.C_ID
        ORDER BY T2.C_ID
        ;
END PRO_INS_POINT;
------------------------------------------------------------------------------------ 매개변수를 주는 방법
CREATE OR REPLACE PROCEDURE PRO_INS_POINT2
(
            IN_C_ID         IN          VARCHAR2
)
AS
            
BEGIN
        
        INSERT INTO POINT_TBL
        SELECT T3.C_ID, SUM((T1.PRO_POINT/100) * ((T2.S_PRICE * T2.S_QTY) * T2.S_IDX)) AS POINT
        FROM PRODUCTS_TBL T1, SALES_TBL T2, CUSTOMER_TBL T3
        WHERE T1.PRO_ID = T2.PRO_ID(+)
        AND T3.C_ID = T2.C_ID(+)
        AND T3.C_ID = IN_C_ID
        GROUP BY T3.C_ID
        ORDER BY T3.C_ID
        ;
END PRO_INS_POINT2;
-------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRO_INS_POINT3
(
            IN_C_ID         IN          VARCHAR2
)
AS
            V_C_ID          CHAR(6);
            V_C_POINT       NUMBER(10);
BEGIN
        
        SELECT T3.C_ID, SUM((T1.PRO_POINT/100) * ((T2.S_PRICE * T2.S_QTY) * T2.S_IDX)) AS POINT
        INTO V_C_ID , V_C_POINT
        FROM PRODUCTS_TBL T1, SALES_TBL T2, CUSTOMER_TBL T3
        WHERE T1.PRO_ID = T2.PRO_ID(+)
        AND T3.C_ID = T2.C_ID(+)
         AND T3.C_ID = IN_C_ID 
        GROUP BY T3.C_ID
        ORDER BY T3.C_ID
        ;
        
        INSERT INTO POINT_TBL
        (C_ID, C_POINT)
        VALUES
        (V_C_ID,V_C_POINT)
        ;
        
END PRO_INS_POINT3;


 -------------------------------------------------------------------------------------아우터 조인 질문(어려운 조인 ^---^,,,,)     
        SELECT T3.C_ID, T3.C_NAME, T1.PRO_NAME, T2.C_ID,T2.PRO_ID,T2.S_IDX
        FROM PRODUCTS_TBL T1, SALES_TBL T2, CUSTOMER_TBL T3
        WHERE T1.PRO_ID = T2.PRO_ID
        AND T3.C_ID = T2.C_ID
        ORDER BY T3.C_ID
        ;--특정 고객이 특정 물건을 구매한 데이터
        
        SELECT T3.C_ID, T3.C_NAME, T1.PRO_NAME, T2.C_ID,T2.PRO_ID,T2.S_IDX
        FROM PRODUCTS_TBL T1, SALES_TBL T2, CUSTOMER_TBL T3
        WHERE T1.PRO_ID = T2.PRO_ID(+)
        AND T3.C_ID = T2.C_ID(+)
        ORDER BY T3.C_ID
        ;--특정 고객이 한번도 구매하지 않은 구체적인 상품들
        
        
        SELECT T3.C_ID, T3.C_NAME,T2.C_ID,T2.PRO_ID,T2.S_IDX
        FROM SALES_TBL T2, CUSTOMER_TBL T3
        WHERE T3.C_ID = T2.C_ID(+)
        ;--한번도 안 산 고객
        
        SELECT T1.PRO_ID,T2.PRO_ID,T2.S_IDX
        FROM PRODUCTS_TBL T1, SALES_TBL T2
        WHERE T1.PRO_ID = T2.PRO_ID(+)
        ;--한번도 안팔린 상품
        
        ---------------------------------------------------------------

    SELECT R_ID
       -- INTO  V_R_ID
        FROM REGION_TBL
        WHERE R_NAME = '부산';
        
        
        
        CREATE OR REPLACE PROCEDURE PROC_EVENT_TBL
(
        IN_C_NAME          IN          VARCHAR2,
        IN_C_BIRTH         IN          VARCHAR2,
        IN_C_REGION        IN          VARCHAR2,
        IN_C_GENDER        IN          VARCHAR2,
        IN_C_PWD           IN          VARCHAR2
)
AS
        V_C_ID          CHAR(6);
        V_R_ID          VARCHAR(30);
       
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
        (C_ID,C_NAME,C_BIRTH,C_REGION,C_GENDER,C_PWD)
        VALUES
        (V_C_ID,IN_C_NAME,TO_DATE(IN_C_BIRTH,'YYYYMMDD'),V_R_ID,IN_C_GENDER,IN_C_PWD)
        ;
        
        /*
        INSERT INTO SALES_TBL
        (C_ID, PRO_ID, S_IDX, S_PRICE, S_QTY, S_OUTDATE)
        VALUES
        (V_C_ID,'P00001',1,0,5,SYSDATE);
        */

END PROC_EVENT_TBL;
-----------------------------------

        SELECT T3.C_ID, T3.C_NAME, T1.PRO_NAME, T2.C_ID,T2.PRO_ID,T2.S_IDX
        FROM PRODUCTS_TBL T1, SALES_TBL T2, CUSTOMER_TBL T3
        WHERE T1.PRO_ID = T2.PRO_ID
        AND T3.C_ID = T2.C_ID
        ORDER BY T3.C_ID