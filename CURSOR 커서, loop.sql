--2.Ŀ��

SET SERVEROUTPUT ON;
 DECLARE
        --���� �����
    BEGIN
        --������
       FOR CUR IN
       (
                SELECT * FROM SALES_TBL
                WHERE C_ID = 'C00001'
       )
       LOOP
       
            IF CUR.S_PRICE * CUR.S_QTY > 5000 THEN 
           DBMS_OUTPUT.PUT_LINE(CUR.C_ID || '-' || CUR.S_PRICE * CUR.S_QTY);
           END IF
           ;
    END LOOP
    ;
    END;
    
    ------------------------------------------------------------------------------------
    
    DECLARE
        NUM                 NUMBER(5)  :=1;
    BEGIN
      
      WHILE(NUM<=100)
      LOOP
      
      NUM := NUM +1;
      --100������ ������ ���ؼ� �ִ� ����
      
      END LOOP;
      
      ------------------------------------------------------------------------------
      DECLARE
      
      BEGIN
      
        FOR I IN 1..1000
        LOOP
       
            DBMS_OUTPUT.PUT_LINE(I);
        
        END LOOP
        ;
        
    END;
    