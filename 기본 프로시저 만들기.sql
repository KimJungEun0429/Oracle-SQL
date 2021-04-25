SELECT * FROM PRODUCTS_TBL;
SELECT * FROM WHOLESALE_TBL;
SELECT * FROM BUY_TBL;
SELECT * FROM CUSTOMER_TBL;
SELECT * FROM SALES_TBL;
SELECT * FROM REGION_TBL;

CREATE OR REPLACE PROCEDURE PROC_INSERT_PRODUCT
(
    --IN_PRO_ID       IN          VARCHAR2,
    IN_PRO_NAME     IN          VARCHAR2,
    IN_PRO_COMPANY  IN          VARCHAR2,
    IN_PRO_VOL      IN          VARCHAR2
   -- IN_PRO_INDATE   IN          DATE
)
AS
            V_PRO_ID        CHAR(6);
BEGIN
        
        SELECT 'P'||TO_CHAR(TO_NUMBER(SUBSTR(MAX(PRO_ID),2)) +1,'FM00000')
        INTO V_PRO_ID
        FROM PRODUCTS_TBL;
      
        
        INSERT INTO PRODUCTS_TBL
        (PRO_ID,PRO_NAME,PRO_COMPANY,PRO_VOL ,PRO_INDATE)
        VALUES
        (V_PRO_ID,IN_PRO_NAME,IN_PRO_COMPANY,IN_PRO_VOL ,SYSDATE);
        
END PROC_INSERT_PRODUCT;

CREATE OR REPLACE PROCEDURE PROC_WHOLESALE_TBL
(
    IN_W_NAME         IN          VARCHAR2,
    IN_W_REGION        IN          VARCHAR2,
    IN_W_YEAR          IN          VARCHAR2
)
AS
        V_W_ID          CHAR(6);
        V_W_RID         CHAR(9);
BEGIN
        SELECT TO_CHAR(TO_NUMBER(SUBSTR(MAX(W_ID),2)) + 1, 'FM00000')
        INTO V_W_ID
        FROM WHOLESALE_TBL;
        
        SELECT R_ID
        INTO V_W_RID
        FROM REGION_TBL
        WHERE R_NAME = IN_W_REGION;
        
        INSERT INTO WHOLESALE_TBL
        (W_ID,W_NAME,W_REGION,W_YEAR)
        VALUES
        (V_W_ID,IN_W_NAME,IN_W_REGION,IN_W_YEAR);
END;

CREATE OR REPLACE PROCEDURE PROC_INSERT_BUY_TBL
(
    IN_PRO_ID                  IN              VARCHAR2,
    IN_W_ID                    IN              VARCHAR2,
    IN_B_PRICE                 IN              NUMBER,
    IN_B_QTY                   IN              NUMBER,
    IN_B_CONTENT               IN              VARCHAR2
)
AS
        V_B_IDX             CHAR(6);
BEGIN
        SELECT TO_NUMBER(MAX(B_IDX))+1
        INTO V_B_IDX
        FROM BUY_TBL
        WHERE IN_PRO_ID = PRO_ID AND IN_W_ID = W_ID ;
        
        INSERT INTO BUY_TBL
        (PRO_ID, W_ID,B_IDX,B_PRICE,B_QTY,B_INDATE,B_CONTENT)
        VALUES
        (IN_PRO_ID, IN_W_ID, V_B_IDX, IN_B_PRICE, IN_B_QTY,SYSDATE,IN_B_CONTENT);
END;

CREATE OR REPLACE PROCEDURE PROC_REGION_TBL
(
    IN_R_NAME       IN      VARCHAR2
)
AS
        V_R_ID          CHAR(6);
BEGIN

SELECT 'R'||TO_CHAR(TO_NUMBER(SUBSTR(MAX(R_ID),2))+1,'FM00000')
INTO V_R_ID
FROM REGION_TBL
;

INSERT INTO REGION_TBL
(R_ID, R_NAME)
VALUES
(V_R_ID,IN_R_NAME);

END;

SELECT * FROM CUSTOMER_TBL;
SELECT * FROM SALES_TBL;
SELECT * FROM REGION_TBL;

CREATE OR REPLACE PROCEDURE PROC_CUSTOMER_TBL
(
        IN_C_NAME          IN          VARCHAR2,
        IN_C_BIRTH         IN          DATE,
        IN_C_REGION        IN          VARCHAR2,
        IN_C_GENDER        IN          VARCHAR2
)
AS
        V_C_ID      CHAR(6);
        V_C_REGION  CHAR(6);
BEGIN
        SELECT 'C'||TO_CHAR(TO_NUMBER(SUBSTR(MAX(C_ID),2)+1),'FM00000')
        INTO V_C_ID
        FROM CUSTOMER_TBL
        ;
        
        SELECT R_ID
        INTO V_C_REGION
        FROM REGION_TBL
        WHERE R_NAME = IN_C_REGION
        ;
        
        INSERT INTO CUSTOMER_TBL
        (C_ID, C_NAME, C_BIRTH, C_REGION, C_GENDER)
        VALUES
        (V_C_ID, IN_C_NAME, IN_C_BIRTH, V_C_REGION, IN_C_GENDER);
END;

DELETE FROM CUSTOMER_TBL WHERE C_ID = '00009';

CREATE OR REPLACE PROCEDURE PROC_SALES_TBL
(
    IN_C_ID         IN          VARCHAR2,
    IN_PRO_ID       IN          VARCHAR2,
    --IN_S_IDX        IN          VARCHAR2,
    IN_S_PRICE      IN          NUMBER,
    IN_S_QTY        IN          NUMBER,
    IN_S_OUTDATE    IN          DATE
    
)
AS
        V_S_IDX         CHAR(6);
BEGIN
        
        SELECT TO_NUMBER(MAX(S_IDX))+1
        INTO V_S_IDX
        FROM SALES_TBL
        WHERE IN_C_ID = C_ID AND IN_PRO_ID = PRO_ID
        ;
        
        INSERT INTO SALES_TBL
        (C_ID, PRO_ID,S_IDX,S_PRICE,S_QTY,S_OUTDATE)
        VALUES
        (IN_C_ID,IN_PRO_ID,V_S_IDX,IN_S_PRICE,IN_S_QTY,IN_S_OUTDATE);

END;