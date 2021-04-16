--1. 2021-02-05�� �ٲ���

SELECT TO_CHAR(PRO_INDATE,'YYYY-MM-DD') AS INDATE
FROM PRODUCTS_TBL; 

--2. 2021�� ���� �� �Ǹűݾ�()

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
--TO_DATE(A,B)�� B�ڸ��� 'YYYY-MM-DD'�� ���� ���� ���� ������ �����޶�°� �ƴϰ� A�ڸ��� �ִ� ���� ������ �� ���̴�.
--���������� ���� �Ȱ��� �����ִ°� �´�. ���� �������� �����޶�� �ǹ̷� ���� �� Ʋ�� �ڵ���
--TO_DATE('2021-04-' || '16', 'YYYY-MM-DD') ��� ���ڿ��� ���� ��, ��Ȥ ������ ���� ��찡 �־ '����'�� �����ϰ� �� ���ִ� ���̴�.
--�����̴� ����~~~~~ ����~~~~~~~~ ���� �������� �����޶���ϴ°� TO_CHAR

SELECT TO_DATE('2021-04-' || '16', 'YYYY-MM-DD')
FROM DUAL
;
-----------------------------------------------------------------------------------------------------------------------

SELECT *
FROM BUY_TBL
;

--3.2021�� ���� �ѱ��űݾ�
SELECT TO_CHAR(B_INDATE,'FMWW') ||'����' AS INDATE, SUM(B_PRICE*B_QTY)
FROM BUY_TBL
GROUP BY TO_CHAR(B_INDATE,'FMWW')
ORDER BY TO_NUMBER(TO_CHAR(B_INDATE,'FMWW'))
;

SELECT TO_CHAR(TO_DATE('2021-01-01'),'WW') FROM DUAL;
SELECT TO_CHAR(TO_DATE('2021-12-31'),'WW') FROM DUAL;
--�� Ȯ���� ���� �غ����Ѵ�. 1/1~12/31 ���̿� 53������ �����Ѵ�(�⵵���� �޶��� �� ����)
SELECT TO_CHAR(TO_DATE('2021-12-31'),'WW') - TO_CHAR(TO_DATE('2021-01-01'),'WW') + 1 FROM DUAL; 

--������ 12�� 31���� �̰�ʹٰ� �������� ��
SELECT TO_DATE(TO_CHAR(SYSDATE,'YYYY') || '-12-31', 'YYYY-MM-DD')
FROM DUAL;

SELECT TRUNC(
                TO_DATE(TO_CHAR(SYSDATE,'YYYY') +1 || TO_CHAR(SYSDATE,'MM') || TO_CHAR(SYSDATE,'DD'),'YYYYMMDD'),'YEAR'
            ) -1
FROM DUAL;

--���� ������ ������ �˰� ���� ��
SELECT TO_CHAR(TO_DATE(TO_CHAR(SYSDATE,'YYYY') || '-12-31', 'YYYY-MM-DD'),'WW')
FROM DUAL;

--���� ù°����
SELECT TO_CHAR(TRUNC(SYSDATE,'YEAR'),'WW')
FROM DUAL;

--���α��� �ɾ ���� �̾Ƴ���
SELECT A.INWEEK || '����', TO_CHAR(NVL(SUM(B_PRICE * B.B_QTY),0),'FM999,999,999')
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



--4.2021�� �б⺰ �ѱ��űݾ�
SELECT TO_CHAR(B_INDATE,'Q') AS INDATE, SUM(B_PRICE*B_QTY)
FROM BUY_TBL
GROUP BY TO_CHAR(B_INDATE,'Q')
ORDER BY TO_CHAR(B_INDATE,'Q')
;



--5.2021�� 3�� 2�������� ���� ���Ÿ� ������ ����

    SELECT TO_CHAR(B_INDATE,'FMMM')|| '��' || TO_CHAR(B_INDATE,'FMW') ||'����' AS INDATE, SUM(B_PRICE*B_QTY)
        ,RANK() OVER(ORDER BY SUM(B_PRICE*B_QTY)) AS RNK
    FROM BUY_TBL
    WHERE TO_CHAR(B_INDATE,'MM') = '03'
    GROUP BY TO_CHAR(B_INDATE,'FMMM')|| '��' || TO_CHAR(B_INDATE,'FMW') ||'����'
;

SELECT TO_CHAR(B_INDATE,'MM')
FROM BUY_TBL
WHERE TO_CHAR(B_INDATE,'MM') = '03'
;  
--�̷��� 3�� ã�°� �� ����!

SELECT TO_CHAR(B_INDATE,'MONTH')
FROM BUY_TBL
WHERE TO_CHAR(B_INDATE,'MONTH') = '3�� '
;   
--MONTH�� ���� ���� ������ 3���� ã���� �ǰڴٰ� ������ ������ �ڼ��� ���� '3��V' �̶�� �ڿ� ������ �پ ����
--WHERE������ �ѱ۷� ã�� �ʴ°� ����.
--���� N���̶�� ����� ���� ���� �� TO_CHAR(B_INDATE,'MM')�� ã�Ƽ� ���ڿ� ����� || '��' ���̱�.
------------------------------------------------------------------------------
SELECT INDATE, B_SUM
FROM
(    
SELECT TO_CHAR(B_INDATE,'FMMM')|| '��' || TO_CHAR(B_INDATE,'FMW') ||'����' || TO_CHAR(B_INDATE,'DAY') AS INDATE , SUM(B_QTY) AS B_SUM
    ,RANK() OVER(ORDER BY SUM(B_QTY) DESC) AS RNK
FROM BUY_TBL
WHERE SUBSTR(B_INDATE,5,1) = '3' AND TO_CHAR(B_INDATE,'FMW')='2'
GROUP BY TO_CHAR(B_INDATE,'FMMM')|| '��' || TO_CHAR(B_INDATE,'FMW') ||'����' || TO_CHAR(B_INDATE,'DAY')
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
