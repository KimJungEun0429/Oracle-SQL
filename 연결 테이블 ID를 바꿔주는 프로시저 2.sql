--REGION 테이블에 R_ID를 수정하고 싶어요

SELECT * FROM REGION_TBL;
SELECT * FROM WHOLESALE_TBL;

CREATE OR REPLACE PROCEDURE PROC_UPDATE_REGION_TBL
(
    IN_R_ID         IN          VARCHAR2,
    O_MSG           OUT         VARCHAR2
)

AS
        V_R_ID              CHAR(6);
        V_R_CNT             CHAR(6);
BEGIN

    SELECT COUNT(*)
    INTO V_R_CNT
    FROM REGION_TBL
    WHERE R_ID = IN_R_ID
    ;
    
    IF V_R_CNT = 1 THEN 
    
    SELECT 'R' || TO_CHAR(TO_NUMBER(SUBSTR(MAX(R_ID),2)) +1 ,'FM0000')
    INTO V_R_ID
    FROM REGION_TBL
    ;
    
    UPDATE REGION_TBL
    SET R_ID = V_R_ID
    WHERE R_ID = IN_R_ID
    ;
    
    UPDATE WHOLESALE_TBL
    SET W_REGION = V_R_ID
    WHERE W_REGION = IN_R_ID
    ;
    
    UPDATE CUSTOMER_TBL
    SET C_REGION = V_R_ID
    WHERE C_REGION = IN_R_ID
    ;
    ELSE
    O_MSG := '아이디가 없습니다';
    END IF;

END PROC_UPDATE_REGION_TBL;

