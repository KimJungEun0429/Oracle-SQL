CREATE OR REPLACE PROCEDURE PROC_UPDATE_REGION_TBL
(
    IN_OLD_R_ID       IN          VARCHAR2,
    IN_NEW_R_ID       IN          VARCHAR2,
    O_MSG           OUT         VARCHAR2
)
--1.OLD_ID가 존재하는지 확인
--2.OLD_ID가 존재한다면 NEW_ID가 중복되지 않는지 확인
--3.중복되지 않으면 그냥 수정
--4.중복이 된다면 새로운 아이디로 수정하고 알려주는 로직


AS
        V_NEW_CNT              CHAR(6);
        V_OLD_CNT             NUMBER(6);
        V_NEW_ID                CHAR(6);
BEGIN

    SELECT COUNT(*)
    INTO V_OLD_CNT
    FROM REGION_TBL
    WHERE R_ID = IN_OLD_R_ID
    ;
    
    IF V_OLD_CNT = 0 THEN 
    --기존 아이디값이 REGION_TBL에 없어요
    O_MSG := '입력하신 '|| IN_OLD_R_ID || ' 값이 존재하지 않습니다';
    
    ELSE
    --아이디가 존재한다. --> 중복체크
    SELECT COUNT(*)
    INTO V_NEW_CNT
    FROM REGION_TBL
    WHERE R_ID = IN_NEW_R_ID
    ;
    
    IF V_NEW_CNT = 0 THEN
    --중복 아니면  UPDATE
    --1.REGION_TBL 업데이트
    
    UPDATE REGION_TBL
    SET R_ID = IN_NEW_R_ID
    WHERE R_ID = IN_OLD_R_ID
    ;
    
    --2.CUSTOMER_TBL 업데이트
    
    UPDATE CUSTOMER_TBL
    SET C_REGION = IN_NEW_R_ID
    WHERE C_REGION = IN_OLD_R_ID
    ;
    --3.WHOLESALE_TBL 업데이트
    
    UPDATE WHOLESALE_TBL
    SET W_REGION = IN_NEW_R_ID
    WHERE W_REGION = IN_OLD_R_ID
    ;
    
    ELSE
    
    --중복입니다
    --1.새로운 아이디를 만든다
    SELECT 'R' || TO_CHAR(TO_NUMBER(SUBSTR(MAX(R_ID),2)) +1 ,'FM0000')
    INTO V_NEW_ID
    FROM REGION_TBL
    ;
    --1.REGION_TBL 업데이트
    
    UPDATE REGION_TBL
    SET R_ID = V_NEW_ID
    WHERE R_ID = IN_OLD_R_ID
    ;
    
    --2.CUSTOMER_TBL 업데이트
    
    UPDATE CUSTOMER_TBL
    SET C_REGION = V_NEW_ID
    WHERE C_REGION = IN_OLD_R_ID
    ;
    --3.WHOLESALE_TBL 업데이트
    
    UPDATE WHOLESALE_TBL
    SET W_REGION = V_NEW_ID
    WHERE W_REGION = IN_OLD_R_ID
    ;
    O_MSG := '입력하신 아이디'|| IN_OLD_R_ID || ' 중복되어서' || V_NEW_ID || '로 수정 되었습니다';
    END IF;
    
END PROC_UPDATE_REGION_TBL;