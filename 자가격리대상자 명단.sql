SELECT 'SM' || TO_CHAR(NVL(SUBSTR(MAX(SM_ID),3),0) +1,'FM00000')
    FROM SEND_MSG_TBL
    ;
    
    SELECT *
    FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3, VISIT_TBL T4
    WHERE T1.CHK_ID = T2.CHK_ID
    AND T2.SM_ID = T3.SM_ID
    AND T3.VISIT_ID = T4.VISIT_ID
    ;
    
    
    SELECT A.VI_P_ID, T3.P_ID
    FROM
    (
    SELECT T1.VISIT_ID, T1.P_ID AS VI_P_ID, T1.B_ID, T1.CHECK_IN, T1.CHECK_OUT, T1.V_TEM, T2.SM_ID, T2.MSG_ID, T2.GET_IN_ID
    FROM VISIT_TBL T1, SEND_MSG_TBL T2
    WHERE T1.VISIT_ID(+) = T2.VISIT_ID
    )A, GET_IN_TBL T3
    WHERE A.GET_IN_ID = T3.GET_IN_ID(+)
    ;--질문!
    
-----VISIT, GET_IN 통틀어서 확진된 사람 명단----------------------------------------------------------------------------------
    SELECT E.CON_ID, E.C_YN,E.P_ID, E.P_NAME,E.P_GENDER, F.P_ID AS G_P_ID, F.P_NAME AS G_P_NAME, F.P_GENDER AS G_GENDER
    FROM(
            SELECT C.CON_ID, C.C_YN, C.P_ID, C.GET_P_ID,D.P_NAME,D.P_GENDER
            FROM
            (
                SELECT A.CON_ID,A.C_YN,A.GET_IN_ID, A.P_ID,A.B_ID,A.CHECK_IN,A.CHECK_OUT,B.GET_IN_ID AS GET_ID ,B.P_ID AS GET_P_ID,B.CHECK_IN AS GET_CHK_IN ,B.CHECK_OUT AS GET_CHK_OUT
                FROM
               (
                    SELECT T1.CON_ID, T1.CHK_ID, T1.CON_DATE, T3.SM_ID, T2.C_YN, T4.VISIT_ID, T3.MSG_ID, T3.SM_DATE, T3.GET_IN_ID, T4.P_ID, T4.B_ID, T4.CHECK_IN, T4.CHECK_OUT, T4.V_TEM
                    FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3, VISIT_TBL T4
                    WHERE T1.CHK_ID = T2.CHK_ID
                    AND T2.SM_ID = T3.SM_ID
                    AND T3.VISIT_ID = T4.VISIT_ID(+)
                )A, GET_IN_TBL B
                WHERE A.GET_IN_ID = B.GET_IN_ID(+)
            )C, PEOPLE_TBL D
            WHERE  C.P_ID = D.P_ID(+)
        )E, PEOPLE_TBL F
        WHERE E.GET_P_ID = F.P_ID (+)
        ;
-------------------------------------------------------------------------------------------------------------------------    
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
-----자가격리자 대상자 명단--------------------------------------------------------------------------------------------------
    
       SELECT K.C_YN,K.VISIT_ID,K.P_ID, K.P_NAME, K.P_GENDER, K.P_TEL,K.P_BIRTH,K.P_ADD,L.P_NAME,L.P_GENDER,L.P_TEL,L.P_BIRTH,L.P_ADD
       FROM
       (
        SELECT I.C_YN, I.VISIT_ID, I.P_ID, I.G_P_ID,J.P_NAME,J.P_GENDER,J.P_TEL,J.P_BIRTH,J.P_ADD
        FROM
        (
            SELECT G.C_YN, G.VISIT_ID, G.P_ID, G.GET_IN_ID, H.P_ID AS G_P_ID
            FROM
            (
                SELECT  E.C_YN, E.VISIT_ID, E.P_ID, E.GET_IN_ID
                FROM 
                (
                    SELECT C.C_YN,D.VISIT_ID,D.P_ID,C.GET_IN_ID
                    FROM
                    (
                        SELECT A.C_YN, B.VISIT_ID, B.GET_IN_ID 
                        FROM
                            (
                                SELECT T2.CHK_ID, T2.SM_ID, T2.C_YN 
                                FROM CONTAGION_TBL T1, CHECK_UP_TBL T2 
                                WHERE T1.CHK_ID(+) = T2.CHK_ID
                            )A, SEND_MSG_TBL B
                        WHERE A.SM_ID = B.SM_ID
                    )C, VISIT_TBL D
                    WHERE C.VISIT_ID = D.VISIT_ID(+)
                )E, GET_IN_TBL F
                WHERE E.GET_IN_ID = F.GET_IN_ID(+)
            )G, GET_IN_TBL H
            WHERE G.GET_IN_ID = H.GET_IN_ID(+)
        )I, PEOPLE_TBL J
        WHERE I.G_P_ID = J.P_ID(+)
     )K, PEOPLE_TBL L
     WHERE K.P_ID = L.P_ID(+)
 ;
        