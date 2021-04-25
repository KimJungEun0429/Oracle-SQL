CREATE TABLE PROFIT_RBL
(
        PR_ID           NUMBER(5)           NOT NULL    PRIMARY KEY,
        PR_YYYYMM       CHAR(6)             NOT NULL,
        TLT_PRICE       NUMBER(10)          NOT NULL
);

SELECT * FROM PROFIT_RBL;
DROP TABLE PROFIT_RBL;

INSERT INTO PROFIT_RBL VALUES ('','','');

--202101 ��
--202102 ��
--202103 ��
--202104 ��
--4�޿� ���� �� �ݾ��� ���� ���ν����� ������


        SELECT ROW_NUMBER() OVER(ORDER BY B.N_DATE ASC) AS N_ID,
            B.N_DATE, NVL(S_SUM,0) AS ALL_SUM
        FROM
        (
        SELECT TO_CHAR(S_OUTDATE,'YYYYMM') AS S_DATE, SUM(S_PRICE * S_QTY) AS S_SUM
        FROM SALES_TBL
        GROUP BY TO_CHAR(S_OUTDATE,'YYYYMM')
        )A,
        (
        SELECT TO_NUMBER(TO_CHAR(TRUNC(SYSDATE,'YEAR'),'YYYYMM')) + (LEVEL-1) AS N_DATE
        FROM DUAL
        CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(SYSDATE,'MM'))
        )B
        WHERE A.S_DATE(+) = B.N_DATE
        --AND B.N_DATE = IN_PR_YYYYMM
        ORDER BY B.N_DATE ASC
        ;
        


SELECT B.N_DATE, NVL(S_SUM,0) AS ALL_SUM
FROM
(
SELECT TO_CHAR(S_OUTDATE,'YYYYMM') AS S_DATE, SUM(S_PRICE * S_QTY) AS S_SUM
FROM SALES_TBL
GROUP BY TO_CHAR(S_OUTDATE,'YYYYMM')
)A,
(
SELECT TO_NUMBER(TO_CHAR(TRUNC(SYSDATE,'YEAR'),'YYYYMM')) + (LEVEL-1) AS N_DATE
FROM DUAL
CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(SYSDATE,'MM'))
)B
WHERE A.S_DATE(+) = B.N_DATE
ORDER BY B.N_DATE
;
-------------------------------------------------------------ù��° ���, ���� ������ ���θ� �Ѳ����� �ִ� ��
CREATE OR REPLACE PROCEDURE PROC_INS_PROFIT_RBL_1

AS
      
BEGIN
        
        INSERT INTO PROFIT_RBL
        SELECT ROW_NUMBER() OVER(ORDER BY B.N_DATE ASC) AS N_ID,
            B.N_DATE, NVL(S_SUM,0) AS ALL_SUM
        FROM
        (
        SELECT TO_CHAR(S_OUTDATE,'YYYYMM') AS S_DATE, SUM(S_PRICE * S_QTY) AS S_SUM
        FROM SALES_TBL
        GROUP BY TO_CHAR(S_OUTDATE,'YYYYMM')
        )A,
        (
        SELECT TO_NUMBER(TO_CHAR(TRUNC(SYSDATE,'YEAR'),'YYYYMM')) + (LEVEL-1) AS N_DATE
        FROM DUAL
        CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(SYSDATE,'MM'))
        )B
        WHERE A.S_DATE(+) = B.N_DATE
        ORDER BY B.N_DATE ASC
        ;
        
END PROC_INS_PROFIT_RBL_1;

--------------------------------------------------------------------------�ι�° ���, Ư�� ��¥�� �Է��ؼ� �ִ� ���
CREATE OR REPLACE PROCEDURE PROC_INS_PROFIT_RBL_2
(
        IN_PR_YYYYMM        IN         VARCHAR2
)

AS
        V_PR_ID         CHAR(6);
      
BEGIN
        
        SELECT NVL(MAX(PR_ID),0) +1
        INTO  V_PR_ID
        FROM PROFIT_RBL
        ;
        
        INSERT INTO PROFIT_RBL
        SELECT V_PR_ID,B.N_DATE, NVL(S_SUM,0) AS ALL_SUM
        FROM
        (
        SELECT TO_CHAR(S_OUTDATE,'YYYYMM') AS S_DATE, SUM(S_PRICE * S_QTY) AS S_SUM
        FROM SALES_TBL
        GROUP BY TO_CHAR(S_OUTDATE,'YYYYMM')
        )A,
        (
        SELECT TO_NUMBER(TO_CHAR(TRUNC(SYSDATE,'YEAR'),'YYYYMM')) + (LEVEL-1) AS N_DATE
        FROM DUAL
        CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(SYSDATE,'MM'))
        )B
        WHERE A.S_DATE(+) = B.N_DATE
        AND B.N_DATE = IN_PR_YYYYMM
        ORDER BY B.N_DATE ASC
        ;
        
END PROC_INS_PROFIT_RBL_2;
-----------------------------------------------------------------����° ���, ���� 3���� �̿��ϴ� ���

CREATE OR REPLACE PROCEDURE PROC_INS_PROFIT_RBL_3
(
    IN_PR_YYYYMM    IN  VARCHAR2
)
AS
        V_PR_ID         NUMBER(6);
        V_PR_YYYYMM     VARCHAR2(30);
        V_TLT_PRICE     NUMBER(10);
BEGIN
 
        SELECT NVL(MAX(PR_ID),0) +1
        INTO  V_PR_ID
        FROM PROFIT_RBL
        ;

        SELECT B.N_DATE, NVL(S_SUM,0) AS ALL_SUM
        INTO V_PR_YYYYMM, V_TLT_PRICE
        FROM
        (
        SELECT TO_CHAR(S_OUTDATE,'YYYYMM') AS S_DATE, SUM(S_PRICE * S_QTY) AS S_SUM
        FROM SALES_TBL
        GROUP BY TO_CHAR(S_OUTDATE,'YYYYMM')
        )A,
        (
        SELECT TO_NUMBER(TO_CHAR(TRUNC(SYSDATE,'YEAR'),'YYYYMM')) + (LEVEL-1) AS N_DATE
        FROM DUAL
        CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(SYSDATE,'MM'))
        )B
        WHERE A.S_DATE(+) = B.N_DATE
        AND B.N_DATE = IN_PR_YYYYMM
        ORDER BY B.N_DATE ASC
        ;

END PROC_INS_PROFIT_RBL_3;
