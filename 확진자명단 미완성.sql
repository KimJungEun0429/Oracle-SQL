--확진자 명단


SELECT G.P_ID,G.CON_ID,G.P_NAME,G.N_BTID,G.A_IN,G.A_OUT,G.AL_P_ID,G.B_IN,G.B_OUT,G.N_NAME, G.VT_ID
FROM 
(
    SELECT E.P_ID,F.AL_P_ID,E.P_NAME,F.N_NAME,F.VT_ID, E.AL_BTID,F.AL_BTID AS N_BTID, F.D, E.D /*E.A_IN, E.A_OUT,F.B_IN,F.B_OUT*/
    FROM
    (
        SELECT C.CON_ID, C.P_ID, C.VI_ID, C.D, C.CHECK_IN, C.CHECK_OUT, C.AL_BTID, D.P_NAME, D.P_GENDER, D.P_TEL, D.P_BIRTH, D.P_ADD
        FROM
        (
            ---------------------확진자-------------------------------------------
            SELECT A1.CON_ID, A1.P_ID, A1.VISIT_ID AS VI_ID, A1.D, A1.CHECK_IN, A1.CHECK_OUT,A1.AL_BTID
            FROM
            (
            SELECT T1.CON_ID,T4.P_ID,T4.VISIT_ID, T4.CHECK_IN AS D,T4.CHECK_IN, T4.CHECK_OUT, T4.B_ID AS AL_BTID 
            FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3, VISIT_TBL T4
            WHERE T1.CHK_ID = T2.CHK_ID
            AND T2.SM_ID = T3.SM_ID
            AND T3.VISIT_ID = T4.VISIT_ID
            )A1, VISIT_TBL A2
            WHERE A1.P_ID = A2.P_ID
            
            
            UNION ALL
            
            
            SELECT B1.CON_ID, B1.P_ID, B1.GET_IN_ID AS VI_ID, B1.D, B1.CHECK_IN, B1.CHECK_OUT,B1.AL_BTID
            FROM
            (
                SELECT T1.CON_ID,T4.P_ID,T4.GET_IN_ID, T4.CHECK_IN AS D, T4.CHECK_IN, T4.CHECK_OUT, T4.T_ID AS AL_BTID 
                FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3, GET_IN_TBL T4
                WHERE T1.CHK_ID = T2.CHK_ID
                AND T2.SM_ID = T3.SM_ID
                AND T3.GET_IN_ID = T4.GET_IN_ID
            )B1, GET_IN_TBL B2
            WHERE B1.P_ID = B2.P_ID
            ------------------------------------------------------------------------------------------------------------
        )C, PEOPLE_TBL D
        WHERE C.P_ID = D.P_ID --확진자 정보, 체크인 체크아웃 시간,방문동선
    )E,
    
    
    (
        SELECT T1.P_ID AS AL_P_ID,T1.B_ID AS AL_BTID, T1.CHECK_IN AS D, T1.CHECK_IN AS B_IN, T1.CHECK_OUT AS B_OUT,T2.P_ID,T2.P_NAME AS N_NAME, T1.VISIT_ID AS VT_ID
        FROM VISIT_TBL T1, PEOPLE_TBL T2
        WHERE T1.P_ID = T2.P_ID
        
        
        UNION ALL
        
        SELECT T1.P_ID AS AL_P_ID,T1.T_ID AS AL_BTID ,T1.CHECK_IN AS D, T1.CHECK_IN AS B_IN, T1.CHECK_OUT AS B_OUT,T2.P_ID,T2.P_NAME AS N_NAME, T1.GET_IN_ID AS VT_ID
        FROM GET_IN_TBL T1, PEOPLE_TBL T2
        WHERE T1.P_ID = T2.P_ID  --모든 명단, 체크인 체크아웃 시간
    )F
    --WHERE E.AL_BTID = F.AL_BTID -- 확진자와 모든사람 같은 건물, 같은 교통수단 이용 내역
    WHERE TO_CHAR(E.D, 'YYYYMMDD') = TO_CHAR(F.D, 'YYYYMMDD')
    AND E.AL_BTID = F.AL_BTID
    --AND E.P_ID != F.AL_P_ID
    --ORDER BY F.AL_BTID
    
)G
WHERE ((B_IN <= A_IN AND B_OUT >= A_OUT) OR 
                                ((B_IN <= A_IN AND A_IN < B_OUT) AND (A_IN < B_OUT AND B_OUT <= A_OUT)) OR
                                ((A_IN <= B_IN AND B_IN < A_OUT) AND (B_IN < A_OUT AND A_OUT <= B_OUT)) OR 
                                (A_IN <= B_IN AND B_OUT <= A_OUT))
   ;


-------------------------------------------------------------------------------------------완성-------------------------------------------
            ---------------------확진자 동선-------------------------------------------  
            SELECT CON.P_ID, CON.P_NAME, CON.VI_ID, CON.D, CON.A_IN, CON.A_OUT, CON.AL_BTID, PEO.B_IN, PEO.B_OUT, PEO.N_NAME, PEO.VT_ID
            FROM
            (
                    SELECT B1.CON_ID, B1.P_ID, B1.P_NAME, B1.VISIT_ID AS VI_ID, B1.D, B1.CHECK_IN AS A_IN, B1.CHECK_OUT AS A_OUT, B1.AL_BTID
                    FROM
                    (
                        SELECT T1.CON_ID,T4.P_ID, T5.P_NAME, T4.VISIT_ID, T4.CHECK_IN AS D, T4.CHECK_IN, T4.CHECK_OUT, T4.B_ID AS AL_BTID 
                        FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3, VISIT_TBL T4, PEOPLE_TBL T5
                        WHERE T1.CHK_ID = T2.CHK_ID
                        AND T2.SM_ID = T3.SM_ID
                        AND T3.VISIT_ID = T4.VISIT_ID
                        AND T4.P_ID = T5.P_ID
                    )B1, VISIT_TBL B2
                    WHERE B1.P_ID = B2.P_ID
               
                UNION ALL
                
                    SELECT B1.CON_ID, B1.P_ID, B1.P_NAME, B1.GET_IN_ID AS VI_ID, B2.CHECK_IN AS D, B2.CHECK_IN, B2.CHECK_OUT,B2.T_ID AS AL_BTID
                    FROM
                    (
                        SELECT T1.CON_ID,T4.P_ID, T5.P_NAME, T4.GET_IN_ID, T4.CHECK_IN, T4.CHECK_OUT, T4.T_ID AS AL_BTID 
                        FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3, GET_IN_TBL T4, PEOPLE_TBL T5
                        WHERE T1.CHK_ID = T2.CHK_ID
                        AND T2.SM_ID = T3.SM_ID
                        AND T3.GET_IN_ID = T4.GET_IN_ID
                        AND T4.P_ID = T5.P_ID
                    )B1, GET_IN_TBL B2
                    WHERE B1.P_ID = B2.P_ID 
            )CON ,

            ---------------일반인 동선-----------------------------------------------------------------------------------------
            (
                    SELECT T1.P_ID AS AL_P_ID,T1.B_ID AS AL_BTID, T1.CHECK_IN AS D, T1.CHECK_IN AS B_IN, T1.CHECK_OUT AS B_OUT,T2.P_ID,T2.P_NAME AS N_NAME, T1.VISIT_ID AS VT_ID
                    FROM VISIT_TBL T1, PEOPLE_TBL T2
                    WHERE T1.P_ID = T2.P_ID
                
                
                UNION ALL
                
                    SELECT T1.P_ID AS AL_P_ID,T1.T_ID AS AL_BTID ,T1.CHECK_IN AS D, T1.CHECK_IN AS B_IN, T1.CHECK_OUT AS B_OUT,T2.P_ID,T2.P_NAME AS N_NAME, T1.GET_IN_ID AS VT_ID
                    FROM GET_IN_TBL T1, PEOPLE_TBL T2
                    WHERE T1.P_ID = T2.P_ID
            )PEO
            WHERE CON.AL_BTID = PEO.AL_BTID
            AND TO_CHAR(CON.D, 'YYYYMMDD') = TO_CHAR(PEO.D, 'YYYYMMDD')
            AND CON.P_ID != PEO.AL_P_ID
            AND ((B_IN <= A_IN AND B_OUT >= A_OUT) OR 
                                ((B_IN <= A_IN AND A_IN < B_OUT) AND (A_IN < B_OUT AND B_OUT <= A_OUT)) OR
                                ((A_IN <= B_IN AND B_IN < A_OUT) AND (B_IN < A_OUT AND A_OUT <= B_OUT)) OR 
                                (A_IN <= B_IN AND B_OUT <= A_OUT))
            ;
 ------------------------------------------------------------------------------------------------------------------완성           
            
            
            ----------------------자가격리자 대상자(주소 추가)------------------------------------
            
                SELECT T3.P_NAME, T3.P_TEL, T3.P_GENDER, T3.P_BIRTH, T3.P_ADD, T4.C_YN, T4.CHK_DATE
                FROM SEND_MSG_TBL T1, VISIT_TBL T2, PEOPLE_TBL T3, CHECK_UP_TBL T4
                WHERE T1.VISIT_ID = T2.VISIT_ID
                AND T2.P_ID = T3.P_ID
                AND T1.SM_ID = T4.SM_ID
                
                UNION ALL
                
                SELECT T3.P_NAME, T3.P_TEL, T3.P_GENDER, T3.P_BIRTH, T3.P_ADD, T4.C_YN, T4.CHK_DATE
                FROM SEND_MSG_TBL T1, GET_IN_TBL T2, PEOPLE_TBL T3, CHECK_UP_TBL T4
                WHERE T1.GET_IN_ID = T2.GET_IN_ID
                AND T2.P_ID = T3.P_ID
                AND T1.SM_ID = T4.SM_ID
                ;
            ---------------------------------------------------------------------------------
                
                        SELECT A.P_ID, A.P_NAME,A.NEW_NAME,A.AL_BTID, ((TO_CHAR(A_OUT,'HH24')* 60 + TO_CHAR(A_OUT,'MI')+TO_CHAR(A_OUT,'SS')*1/60) - (TO_CHAR(A_IN,'HH24')* 60 + TO_CHAR(A_IN,'MI')+TO_CHAR(A_IN,'SS')*1/60))/60 AS STAR_TIME
                        FROM
                        (
                            SELECT B3.P_ID, B3.P_NAME, B3.A_IN, B3.A_OUT, B4.B_NAME AS NEW_NAME, B3.AL_BTID
                            FROM
                            (
                                SELECT B1.CON_ID, B1.P_ID, B1.P_NAME, B1.VISIT_ID AS VI_ID, B1.CHECK_IN AS A_IN, B1.CHECK_OUT AS A_OUT, B1.AL_BTID
                                FROM
                                (
                                    SELECT T1.CON_ID,T4.P_ID, T5.P_NAME, T4.VISIT_ID, T4.CHECK_IN, T4.CHECK_OUT, T4.B_ID AS AL_BTID
                                    FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3, VISIT_TBL T4, PEOPLE_TBL T5
                                    WHERE T1.CHK_ID = T2.CHK_ID
                                    AND T2.SM_ID = T3.SM_ID
                                    AND T3.VISIT_ID = T4.VISIT_ID
                                    AND T4.P_ID = T5.P_ID
                                )B1, VISIT_TBL B2
                                WHERE B1.P_ID = B2.P_ID
                              )B3, BUILDING_TBL B4
                              WHERE B3.AL_BTID = B4.B_ID
                              
                            UNION ALL
                            
                            
                            SELECT B5.P_ID, B5.P_NAME, B5.A_IN ,B5.A_OUT, B6.VEHICLE_NAME AS NEW_NAME, B5.AL_BTID
                            FROM
                            (
                                SELECT B3.P_ID, B3.P_NAME, B3.A_IN, B3.A_OUT,B4.T_ID, B4.VEHICLE_ID, B3.AL_BTID
                                FROM
                                (
                                    SELECT B1.CON_ID, B1.P_ID, B1.P_NAME, B1.GET_IN_ID AS VI_ID, B2.CHECK_IN AS A_IN, B2.CHECK_OUT AS A_OUT,B2.T_ID AS AL_BTID
                                    FROM
                                    (
                                        SELECT T1.CON_ID,T4.P_ID, T5.P_NAME, T4.GET_IN_ID, T4.CHECK_IN, T4.CHECK_OUT, T4.T_ID AS AL_BTID 
                                        FROM CONTAGION_TBL T1, CHECK_UP_TBL T2, SEND_MSG_TBL T3, GET_IN_TBL T4, PEOPLE_TBL T5
                                        WHERE T1.CHK_ID = T2.CHK_ID
                                        AND T2.SM_ID = T3.SM_ID
                                        AND T3.GET_IN_ID = T4.GET_IN_ID
                                        AND T4.P_ID = T5.P_ID
                                    )B1, GET_IN_TBL B2
                                    WHERE B1.P_ID = B2.P_ID 
                               )B3, TIME_TBL B4
                               WHERE B3.AL_BTID = B4.T_ID
                            )B5, VEHICLE_TBL B6
                            WHERE B5.VEHICLE_ID = B6.VEHICLE_ID
                          )A
                          --GROUP BY A.P_ID, A.P_NAME,A.NEW_NAME,A.AL_BTID
                        ;
    
    SELECT TO_CHAR(CHECK_IN,'HH24:MI:SS')
    FROM VISIT_TBL
    ;