
SELECT TO_DATE('2021-01' + (LEVEL-1) ,'YYYY-MM') AS BB
FROM DUAL
CONNECT BY LEVEL <= 12
;

SELECT TO_DATE('2021-01' ,'YYYY-MM') + (LEVEL-1) AS BB
FROM DUAL
CONNECT BY LEVEL <= 12
;

SELECT TO_DATE('2021-01','YYYY-MM')
FROM DUAL
;

----------------------------------------------------------
SELECT TO_DATE('202101' + (LEVEL-1) ,'YYYYMM') AS BB
FROM DUAL
CONNECT BY LEVEL <= 12
;

SELECT TO_DATE('202101' + (LEVEL-1) ,'YYYY-MM') AS BB
FROM DUAL
CONNECT BY LEVEL <= 12
;
--숫자로 인식해서 더해줘서
----------------------------------------------------------
SELECT TO_DATE('202101','YYYYMM')
FROM DUAL
;

SELECT TO_DATE('2021-01-01' ,'YYYY-MM') + (LEVEL-1) AS BB
FROM DUAL
CONNECT BY LEVEL <= 12
;

SELECT TO_DATE('2021-01-01' ,'YYYY-MM-DD') + (LEVEL-1) AS BB
FROM DUAL
CONNECT BY LEVEL <= 12
;
