--1. 2021-02-05로 바꾸자

SELECT TO_CHAR(PRO_INDATE,'YYYY-MM-DD') AS INDATE
FROM PRODUCTS_TBL; 

--2. 2021년 월별 총 판매금액()

    SELECT B.N_DATE,  NVL(SUM(A.B_PRICE * A.B_QTY),0) AS N_PRICE  FROM
    (
        SELECT TO_CHAR(B_INDATE,'YYYYMM') AS INDATE, B_PRICE, B_QTY 
        --SUM(B_PRICE *B_QTY) AS A_SUM 
        FROM BUY_TBL
        --GROUP BY TO_CHAR(B_INDATE,'YYYYMM')
        ORDER BY TO_CHAR(B_INDATE,'YYYYMM')
    )A,
    (
        SELECT TO_CHAR(TO_DATE('2021-01-01'),'YYYYMM')  + (LEVEL-1) AS N_DATE
        FROM DUAL
        CONNECT BY LEVEL <= 12
    )B
    WHERE A.INDATE(+) = B.N_DATE
    GROUP BY B.N_DATE
    ORDER BY B.N_DATE
;

SELECT TO_DATE(SYSDATE)
FROM DUAL
;
-----------------------------------------------------------------------------------------------------------------------
SELECT TO_DATE(SYSDATE,'YYYY-MM-DD')
FROM DUAL
;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD')
FROM DUAL
;
--TO_DATE(A,B)의 B자리인 'YYYY-MM-DD'는 내가 보고 싶은 형식을 보여달라는게 아니고 A자리에 있는 값에 형식을 준 것이다.
--문법상으로 보면 똑같이 적어주는게 맞다. 저런 형식으로 보여달라는 의미로 쓰는 건 틀린 코딩임
--TO_DATE('2021-04-' || '16', 'YYYY-MM-DD') 라고 문자열로 붙일 때, 간혹 오류가 나는 경우가 있어서 '문법'상 안전하게 다 써주는 것이다.
--문법이다 문법~~~~~ 문법~~~~~~~~ 저런 형식으로 보여달라고하는건 TO_CHAR

SELECT TO_DATE('2021-04-' || '16', 'YYYY-MM-DD')
FROM DUAL
;
-----------------------------------------------------------------------------------------------------------------------

SELECT *
FROM BUY_TBL
;

--3.2021년 주차 총구매금액
SELECT TO_CHAR(B_INDATE,'FMWW') ||'주차' AS INDATE, SUM(B_PRICE*B_QTY)
FROM BUY_TBL
GROUP BY TO_CHAR(B_INDATE,'FMWW')
ORDER BY TO_NUMBER(TO_CHAR(B_INDATE,'FMWW'))
;

SELECT TO_CHAR(TO_DATE('2021-01-01'),'WW') FROM DUAL;
SELECT TO_CHAR(TO_DATE('2021-12-31'),'WW') FROM DUAL;
--꼭 확인을 먼저 해봐야한다. 1/1~12/31 사이에 53주차가 존재한다(년도마다 달라질 수 있음)
SELECT TO_CHAR(TO_DATE('2021-12-31'),'WW') - TO_CHAR(TO_DATE('2021-01-01'),'WW') + 1 FROM DUAL; 

--올해의 12월 31일을 뽑고싶다고 가정했을 때
SELECT TO_DATE(TO_CHAR(SYSDATE,'YYYY') || '-12-31', 'YYYY-MM-DD')
FROM DUAL;

SELECT TRUNC(
                TO_DATE(TO_CHAR(SYSDATE,'YYYY') +1 || TO_CHAR(SYSDATE,'MM') || TO_CHAR(SYSDATE,'DD'),'YYYYMMDD'),'YEAR'
            ) -1
FROM DUAL;

--올해 마지막 주차를 알고 싶을 때
SELECT TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYY') || '-12-31', 'YYYY-MM-DD'),'WW')
FROM DUAL;

--올해 첫째주차
SELECT TO_CHAR(TRUNC(SYSDATE,'YEAR'),'WW')
FROM DUAL;

--조인까지 걸어서 주차 뽑아내기
SELECT A.INWEEK || '주차', TO_CHAR(NVL(SUM(B_PRICE * B.B_QTY),0),'FM999,999,999')
FROM
(
    SELECT TO_CHAR(SYSDATE,'YYYY') || '-' || TO_CHAR(LEVEL, 'FM00') AS INWEEK
    FROM DUAL
    CONNECT BY LEVEL <=
        (
            SELECT 
            TO_NUMBER(TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYY') || '-12-31', 'YYYY-MM-DD'),'WW'))
            -
            TO_NUMBER(TO_CHAR(TRUNC(SYSDATE,'YEAR'),'WW'))
            +1
            FROM DUAL
        )
)A,
(
SELECT TO_CHAR(B_INDATE,'YYYY') || '-' || TO_CHAR(B_INDATE, 'WW') AS INWEEK
        ,B_PRICE, B_QTY
FROM BUY_TBL
)B
WHERE A.INWEEK = B.INWEEK(+)
GROUP BY A.INWEEK
ORDER BY A.INWEEK
;



--4.2021년 분기별 총구매금액
SELECT TO_CHAR(B_INDATE,'Q') AS INDATE, SUM(B_PRICE*B_QTY)
FROM BUY_TBL
GROUP BY TO_CHAR(B_INDATE,'Q')
ORDER BY TO_CHAR(B_INDATE,'Q')
;



--5.2021년 3월 2주차에서 가장 구매를 많이한 요일

    SELECT TO_CHAR(B_INDATE,'FMMM')|| '월' || TO_CHAR(B_INDATE,'FMW') ||'주차' AS INDATE, SUM(B_PRICE*B_QTY)
        ,RANK() OVER(ORDER BY SUM(B_PRICE*B_QTY)) AS RNK
    FROM BUY_TBL
    WHERE TO_CHAR(B_INDATE,'MM') = '03'
    GROUP BY TO_CHAR(B_INDATE,'FMMM')|| '월' || TO_CHAR(B_INDATE,'FMW') ||'주차'
;

SELECT TO_CHAR(B_INDATE,'MM')
FROM BUY_TBL
WHERE TO_CHAR(B_INDATE,'MM') = '03'
;  
--이렇게 3월 찾는게 더 좋음!

SELECT TO_CHAR(B_INDATE,'MONTH')
FROM BUY_TBL
WHERE TO_CHAR(B_INDATE,'MONTH') = '3월 '
;   
--MONTH를 쓰면 월이 나오니 3월로 찾으면 되겠다고 생각을 하지만 자세히 보면 '3월V' 이라고 뒤에 공백이 붙어서 나옴
--WHERE절에서 한글로 찾지 않는게 좋다.
--차라리 N월이라고 결과를 보고 싶을 땐 TO_CHAR(B_INDATE,'MM')로 찾아서 문자열 연결로 || '월' 붙이기.
------------------------------------------------------------------------------
SELECT INDATE, B_SUM
FROM
(    
SELECT TO_CHAR(B_INDATE,'FMMM')|| '월' || TO_CHAR(B_INDATE,'FMW') ||'주차' || TO_CHAR(B_INDATE,'DAY') AS INDATE , SUM(B_QTY) AS B_SUM
    ,RANK() OVER(ORDER BY SUM(B_QTY) DESC) AS RNK
FROM BUY_TBL
WHERE SUBSTR(B_INDATE,5,1) = '3' AND TO_CHAR(B_INDATE,'FMW')='2'
GROUP BY TO_CHAR(B_INDATE,'FMMM')|| '월' || TO_CHAR(B_INDATE,'FMW') ||'주차' || TO_CHAR(B_INDATE,'DAY')
)
WHERE RNK = 1
;

----------------------------------------------------------

SELECT TO_DATE('2021-01-01') + (LEVEL-1)
FROM DUAL
CONNECT BY LEVEL <= 365
;

SELECT *  FROM BUY_TBL;

SELECT TO_CHAR(TO_DATE('2021-01-01')+ (LEVEL-1),'YYYYMM')
FROM    DUAL
CONNECT BY LEVEL <= 12
;
