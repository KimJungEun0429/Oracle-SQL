-------------동선이 가장 많이 나온 확진자-------------------------------------------------------------------------------------
        SELECT E.CON_ID, E.P_ID, E.P_NAME, E.ALL_SUM, E.RNK
        FROM
        (
            SELECT D.CON_ID,C.P_ID, C.P_NAME, C.ALL_SUM
                ,RANK() OVER(ORDER BY C.ALL_SUM DESC) AS RNK
            FROM
            (
                SELECT A.P_ID, A.P_NAME, NVL(A.V_CNT,0) + NVL(B.G_CNT,0) AS ALL_SUM
                FROM
                (
                    SELECT T1.P_ID, T2.P_NAME, COUNT(T1.VISIT_ID) AS V_CNT
                    FROM VISIT_TBL T1, PEOPLE_TBL T2
                    WHERE T1.P_ID = T2.P_ID
                    GROUP BY T1.P_ID, T2.P_NAME
                )A,
                (
                    SELECT T1.P_ID, T2.P_NAME, COUNT(T1.GET_IN_ID) AS G_CNT
                    FROM GET_IN_TBL T1, PEOPLE_TBL T2
                    WHERE T1.P_ID = T2.P_ID
                    GROUP BY T1.P_ID, T2.P_NAME
                )B
                WHERE A.P_ID = B.P_ID(+)
            )C, ALL_CONTAGION_TBL D
            WHERE C.P_ID = D.P_ID OR C.P_ID = D.G_P_ID
        )E
        WHERE E.RNK = 1
        ;
        
            
-------------------------------------------------------------------------------------------------------------------------    

----------------------자가격리자 대상자(주소 추가)------------------------------------
                
                SELECT AVG(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(TO_CHAR(A.P_BIRTH,'YYYY'))) AS AVG_AGE
                FROM
                    (
                        SELECT T3.P_ID, T3.P_NAME, T3.P_TEL, T3.P_GENDER, T3.P_BIRTH, T3.P_ADD
                        FROM SEND_MSG_TBL T1, VISIT_TBL T2, PEOPLE_TBL T3, CHECK_UP_TBL T4
                        WHERE T1.VISIT_ID = T2.VISIT_ID
                        AND T2.P_ID = T3.P_ID
                        AND  T4.SM_ID = T1.SM_ID 
                        AND T4.C_YN = 'Y'
                        
                  
                    UNION ALL
                
                        SELECT T3.P_ID,T3.P_NAME, T3.P_TEL, T3.P_GENDER, T3.P_BIRTH, T3.P_ADD
                        FROM SEND_MSG_TBL T1, GET_IN_TBL T2, PEOPLE_TBL T3, CHECK_UP_TBL T4
                        WHERE T1.GET_IN_ID = T2.GET_IN_ID
                        AND T2.P_ID = T3.P_ID
                        AND  T4.SM_ID = T1.SM_ID 
                        AND T4.C_YN = 'Y'
                  
                  ;
                  
    
                  
                    
                    
    
            ---------------------------------------------------------------------------------

                SELECT DISTINCT A1.P_NAME, A1.P_TEL, A1.P_GENDER, A1.P_BIRTH, A2.SI, A2.GU, A2.DONG
                FROM
                    (
                        SELECT T3.P_ID, T3.P_NAME, T3.P_TEL, T3.P_GENDER, T3.P_BIRTH, T3.P_ADD
                        FROM SEND_MSG_TBL T1, VISIT_TBL T2, PEOPLE_TBL T3
                        WHERE T1.VISIT_ID = T2.VISIT_ID
                        AND T2.P_ID = T3.P_ID
                        --ORDER BY T1.SM_ID
                    )A1,--건물 관련 자가격리자 
                    (
                        SELECT T3.A_ID,T1.A_VAL AS SI, T2.A_VAL AS GU, T3.A_VAL AS DONG
                        FROM ADDRESS_TBL T1 , ADDRESS_TBL T2, ADDRESS_TBL T3
                        WHERE T1.A_ID = T2.A_PARENT_ID
                        AND T2.A_ID = T3.A_PARENT_ID
                    )A2--주소 계층쿼리
                    WHERE A1.P_ADD = A2.A_ID
                    
                
                UNION ALL
                
                SELECT DISTINCT A1.P_NAME, A1.P_TEL, A1.P_GENDER, A1.P_BIRTH, A2.SI, A2.GU, A2.DONG
                FROM
                (
                    SELECT T3.P_ID,T3.P_NAME, T3.P_TEL, T3.P_GENDER, T3.P_BIRTH, T3.P_ADD
                    FROM SEND_MSG_TBL T1, GET_IN_TBL T2, PEOPLE_TBL T3
                    WHERE T1.GET_IN_ID = T2.GET_IN_ID
                    AND T2.P_ID = T3.P_ID
                    ORDER BY T1.SM_ID
                )A1,--교통수단 관련 자가격리자 
                (
                    SELECT T3.A_ID,T1.A_VAL AS SI, T2.A_VAL AS GU, T3.A_VAL AS DONG
                    FROM ADDRESS_TBL T1 , ADDRESS_TBL T2, ADDRESS_TBL T3
                    WHERE T1.A_ID = T2.A_PARENT_ID
                    AND T2.A_ID = T3.A_PARENT_ID
                )A2--주소 계층쿼리
                WHERE A1.P_ADD = A2.A_ID
                ;
                
                
                SELECT T1.MSG_ID,COUNT(T2.MSG_ID) AS CNT
                FROM MSG_TBL T1, SEND_MSG_TBL T2
                WHERE T1.MSG_ID  = T2.MSG_ID(+)
                AND T1.MSG_ID = 'MSG03'
                GROUP BY T1.MSG_ID
                ;
                
                SELECT * FROM SEND_MSG_TBL
                WHERE SM_ID IN ('SM00001','SM00003','SM00011');