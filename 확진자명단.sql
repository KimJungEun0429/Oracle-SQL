--확진자 명단    
    
    --건물 방문 확진자
        SELECT T1.CON_ID,T5.P_ID, T5.P_NAME, T5.P_GENDER
        FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3, VISIT_TBL T4, PEOPLE_TBL T5
        WHERE T1.CHK_ID = T2.CHK_ID
        AND T2.SM_ID = T3.SM_ID
        AND T3.VISIT_ID = T4.VISIT_ID
        AND T4.P_ID = T5.P_ID
    
        UNION
        
        --교통수단 이용 확진자
        SELECT T1.CON_ID,T5.P_ID, T5.P_NAME, T5.P_GENDER
        FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3, GET_IN_TBL T4, PEOPLE_TBL T5
        WHERE T1.CHK_ID = T2.CHK_ID
        AND T2.SM_ID = T3.SM_ID
        AND T3.GET_IN_ID = T4.GET_IN_ID
        AND T4.P_ID = T5.P_ID
    )
;

        SELECT *
        FROM
        (
            SELECT B.P_ID
            FROM
            (
                SELECT T1.CON_ID, T3.VISIT_ID
                FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3
                WHERE T1.CHK_ID = T2.CHK_ID
                AND T2.SM_ID = T3.SM_ID
            )A, VISIT_TBL B
            WHERE A.VISIT_ID = B.VISIT_ID
        )C,
        (
            SELECT P_ID, B_ID
            FROM VISIT_TBL
        )D
        WHERE C.P_ID = D.P_ID
        ;
        
        
        
        SELECT *
        FROM
        (
            SELECT B.P_ID
            FROM
            (
                SELECT T1.CON_ID, T3.GET_IN_ID
                FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3
                WHERE T1.CHK_ID = T2.CHK_ID
                AND T2.SM_ID = T3.SM_ID
            )A, GET_IN_TBL B
            WHERE A.GET_IN_ID = B.GET_IN_ID
        )C,
        (
            SELECT P_ID, T_ID
            FROM GET_IN_TBL
        )D
        WHERE C.P_ID = D.P_ID
        ;