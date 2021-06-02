--2.커서

SET SERVEROUTPUT ON;
 DECLARE
        --변수 선언부
    BEGIN
        --로직부
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
      --100까지만 돌리기 위해서 주는 로직
      
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
    