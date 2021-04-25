CREATE OR REPLACE PROCEDURE PROC_UPDATE_REGION_TBL
(
    IN_OLD_R_ID       IN          VARCHAR2,
    IN_NEW_R_ID       IN          VARCHAR2,
    O_MSG           OUT         VARCHAR2
)
--1.OLD_ID�� �����ϴ��� Ȯ��
--2.OLD_ID�� �����Ѵٸ� NEW_ID�� �ߺ����� �ʴ��� Ȯ��
--3.�ߺ����� ������ �׳� ����
--4.�ߺ��� �ȴٸ� ���ο� ���̵�� �����ϰ� �˷��ִ� ����


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
    --���� ���̵��� REGION_TBL�� �����
    O_MSG := '�Է��Ͻ� '|| IN_OLD_R_ID || ' ���� �������� �ʽ��ϴ�';
    
    ELSE
    --���̵� �����Ѵ�. --> �ߺ�üũ
    SELECT COUNT(*)
    INTO V_NEW_CNT
    FROM REGION_TBL
    WHERE R_ID = IN_NEW_R_ID
    ;
    
    IF V_NEW_CNT = 0 THEN
    --�ߺ� �ƴϸ�  UPDATE
    --1.REGION_TBL ������Ʈ
    
    UPDATE REGION_TBL
    SET R_ID = IN_NEW_R_ID
    WHERE R_ID = IN_OLD_R_ID
    ;
    
    --2.CUSTOMER_TBL ������Ʈ
    
    UPDATE CUSTOMER_TBL
    SET C_REGION = IN_NEW_R_ID
    WHERE C_REGION = IN_OLD_R_ID
    ;
    --3.WHOLESALE_TBL ������Ʈ
    
    UPDATE WHOLESALE_TBL
    SET W_REGION = IN_NEW_R_ID
    WHERE W_REGION = IN_OLD_R_ID
    ;
    
    ELSE
    
    --�ߺ��Դϴ�
    --1.���ο� ���̵� �����
    SELECT 'R' || TO_CHAR(TO_NUMBER(SUBSTR(MAX(R_ID),2)) +1 ,'FM0000')
    INTO V_NEW_ID
    FROM REGION_TBL
    ;
    --1.REGION_TBL ������Ʈ
    
    UPDATE REGION_TBL
    SET R_ID = V_NEW_ID
    WHERE R_ID = IN_OLD_R_ID
    ;
    
    --2.CUSTOMER_TBL ������Ʈ
    
    UPDATE CUSTOMER_TBL
    SET C_REGION = V_NEW_ID
    WHERE C_REGION = IN_OLD_R_ID
    ;
    --3.WHOLESALE_TBL ������Ʈ
    
    UPDATE WHOLESALE_TBL
    SET W_REGION = V_NEW_ID
    WHERE W_REGION = IN_OLD_R_ID
    ;
    O_MSG := '�Է��Ͻ� ���̵�'|| IN_OLD_R_ID || ' �ߺ��Ǿ' || V_NEW_ID || '�� ���� �Ǿ����ϴ�';
    END IF;
    
END PROC_UPDATE_REGION_TBL;