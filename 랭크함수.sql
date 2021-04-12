--��ũ�Լ�

--����ȭ�Ǿ� �ִ� ���̺�
CREATE TABLE SALLARY
(
    IDX     NUMBER(5)       NOT NULL    PRIMARY KEY,
    PART    VARCHAR2(30)    NOT NULL,
    ENAME   VARCHAR2(30)    NOT NULL,
    PRICE   NUMBER(10)      NOT NULL
);

INSERT INTO SALLARY VALUES(1,'�λ��','ȫ�浿','5000000');
INSERT INTO SALLARY VALUES(2,'�λ��','����ġ','4000000');
INSERT INTO SALLARY VALUES(3,'�λ��','�谩��','5000000');
INSERT INTO SALLARY VALUES(4,'�ѹ���','�谩��','7000000');
INSERT INTO SALLARY VALUES(5,'�ѹ���','�ڿ��','2000000');
INSERT INTO SALLARY VALUES(6,'�ѹ���','�赹��','3500000');
INSERT INTO SALLARY VALUES(7,'�����','�赿��','6400000');
INSERT INTO SALLARY VALUES(8,'�����','�̰ǵ�','5500000');
INSERT INTO SALLARY VALUES(9,'���ź�','�����','1500000');
INSERT INTO SALLARY VALUES(10,'���ź�','�����','4500000');

UPDATE SALLARY SET PRICE = 5500000
WHERE IDX = 10
;
--ROLLBACK;
--COMMIT;

SELECT * FROM SALLARY;

--ROW_NUMBER()
--����Ŭ,TIBERO������ ��밡��

SELECT 
    IDX, PART, ENAME, PRICE 
    ,ROW_NUMBER() OVER(ORDER BY PRICE ASC) AS ROW_NUM
    ,RANK() OVER(ORDER BY PRICE ASC) AS RNK
    ,DENSE_RANK() OVER(ORDER BY PRICE ASC) AS DENSERNK
FROM SALLARY
ORDER BY IDX ASC
;
--RANK�� ����
--ROW_NUMBER�� �������̴�� ���������� ����Ŭ�� �Ǵ��Ͽ� ������ �ִ� ��. �׷��� ����� �ǵ� ���ڸ� �˾Ƽ� �� ROW�� ��� �Ǵ��Ҷ� ���
--DENSE_RANK ���� ���� ������ ��, �װ��� �������� �ʰ� �׳� ����(������������ ������ ����)
--ROW_NUMBER() OVER(ORDER BY PRICE ASC)��� �־��� ��, ROW��� ������� PRICE��� �ʵ��� ���� ���� ������ ���ش�.

SELECT * FROM SALLARY
ORDER BY PART ASC, ENAME ASC
;
--���źθ� ã�� ������ ���ź� ������ �ٽ� ASC�� �����Ѵ�.

--�� �μ����� ���� RANK�� ������
SELECT PART, SUM(PRICE), AVG(PRICE),
       RANK() OVER(ORDER BY SUM(PRICE) DESC) AS RNK,
       RANK() OVER(ORDER BY AVG(PRICE) DESC) AS P_AVG
FROM SALLARY
GROUP BY PART
;

SELECT PART, ENAME, PRICE,
   ROUND(AVG(PRICE) OVER(PARTITION BY PART),2)
   ,RANK() OVER(ORDER BY PRICE DESC) AS RNK
FROM SALLARY
ORDER BY PART ASC
;
--�����Լ��� �� �� �ִ� ��.
--ROUND(AVG(PRICE) OVER(PARTITION BY PART),2) �� RANK() OVER(ORDER BY PRICE DESC) AS RNK�� ������ �ʵ� ���� ���� ����
--������ �Ǵ� ������ �տ� PART,ENAME ���� ROW�� �ƹ������ ����.

--1. ��ü ��� ���ް� 10���� ������ ���ް��� ���̸� �����ּ���
    
   SELECT T2.ENAME, T2.PRICE , T1.AVER, T1.AVER - T2.PRICE FROM
    (
    SELECT AVG(PRICE) AS AVER
    FROM SALLARY
    )T1
    ,
    (
    SELECT ENAME, PRICE 
    FROM SALLARY    
    )T2
    ;
    --��� �����Ͱ� �ϳ��ϱ� �ٷ� ũ�ν��������� ����

    

--2. �� �μ��� ��տ����� ������ �����ּ���
--1�����
    SELECT PART, AVG(PRICE) AS AVER
    ,RANK() OVER(ORDER BY AVG(PRICE) ASC) AS AVER
    FROM SALLARY
    GROUP BY PART
    ;
    
--2�����
    SELECT PART, AVER, RANK() OVER(ORDER BY AVER DESC) AS RNK 
    FROM
    (
        SELECT PART, AVG(PRICE) AS AVER
        FROM SALLARY
        GROUP BY PART
    )
    ;

--3. ��� ������ 3���� �μ��� ���޺��� ���� ������ �ް� �ִ� ������� �����ּ���

    SELECT * FROM SALLARY
    WHERE PRICE >
    (
    SELECT AVER FROM
    (
    SELECT PART, AVG(PRICE) AS AVER,
    RANK() OVER(ORDER BY AVG(PRICE) ASC) AS RNK
    FROM SALLARY
    GROUP BY PART
    )--��տ��޷�ŷ
    WHERE RNK = 3--��ŷ�� 3���� �ݾ�
    )
    ;--��ŷ�� 3������ ���� ������ �޴� ���
    

--����
--1.DATE ��¥�� ���� ����
--2.RANK, DENSE_RANK, ROW_NUMVER ORDER BY PARTITION BY(�����Ѱ� ����)
--3.NVL, DECODE, CASE WHEN THEN(�����ϱ�)
    
--GROUP BY Ȱ�뵵

SELECT ENAME, COUNT(*) 
FROM SALLARY
GROUP BY ENAME
HAVING COUNT(*) > 1
;

INSERT INTO SALLARY VALUES(11, '���ź�', 'ȫ�浿', 4000000);

--COMMIT;