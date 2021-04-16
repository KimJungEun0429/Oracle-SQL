--TO_CHAR �Լ�
--�����ͺ��̽� - ������Ÿ���� ���� - ����Ÿ��, ����Ÿ��, ��¥Ÿ��

SELECT '1234' AS TEST FROM DUAL; -- ����
SELECT 1234 AS TEST FROM DUAL; -- ����

SELECT '1234' + 1234 FROM DUAL; -- ���� + �������� ����� ���´�
SELECT '1234A' + 1234 FROM DUAL; -- �ٵ� ���ڰ� �ϳ��� ���� ��� �ȵ�

SELECT TO_DATE('2021-04-16') + 2 AS DT FROM DUAL;
--�̷��� ���������� '2021-04-16'�� ��ǻ�ʹ� ���ڰ����� ������ �ִ�.

SELECT '2021-04-16' + 2 FROM DUAL; --�̰� �ȵ�
SELECT '20210416' + 2 FROM DUAL; --�̰� �� ����,,����

--1. TO_CHAR�� ��¥ Ȱ��
SELECT SYSDATE FROM DUAL;

--1.1 ��¥ǥ��
SELECT TO_CHAR(SYSDATE,'YYYYMMDD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY/MM/DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

SELECT TO_CHAR('2021-05-05','YYYYMMDD');--�̷��� ���� �ȵȴ�. (A,B)���� A�ڸ��� ����Ʈ Ÿ���� �;߰����ϱ⶧���̰� TO_DATE�� ���ָ� �׳� ���ڿ��̴�
SELECT TO_CHAR(TO_DATE('2021-05-05'),'YYYYMMDD');

--2.�Ҽ��� ǥ��
SELECT TO_CHAR('123456','999,999,999') FROM DUAL;--�Ҽ��� ó������ ���ں��� �ڸ����� ��Ÿ���� ���� ���� ���� �ȴ�
SELECT TO_CHAR('123456','FM999,999,999') FROM DUAL;--ó������ ���ڰ� ������ �ڸ�����ŭ ������ ����µ� �׷� ��, FM�� �ٿ��ָ� ������ ó���� �ȴ�
SELECT TO_CHAR('123456','FML999,999,999') FROM DUAL;--���������� ��ɾ�� �ٸ��� ��ȭ�� L�� �ָ� ��.

--3. 000ǥ��(0001,0002,0003,0004 ~ 017,018,019 ~ 123 124 125
SELECT TO_CHAR(77,'0000') FROM DUAL;
SELECT TO_CHAR(77,'FM0000') FROM DUAL; -- ���������� �Ϸ��� FM ���δ�
SELECT TO_CHAR(89087) FROM DUAL; -- ���� 890870�� ���� 89087�� �ٲٱ�
SELECT TO_CHAR(89087) || '��' FROM DUAL;-- ���ڳ��� �ٿ��� �� Ȱ�� ����

--4. 2021�� 04�� 16��
SELECT TO_CHAR(SYSDATE, 'YYYY') || '��' || TO_CHAR(SYSDATE, 'MM') || '��' || TO_CHAR(SYSDATE, 'DD') || '��' 
FROM DUAL
;

--4-1. 2021�� 4�� 16��
SELECT TO_CHAR(SYSDATE, 'YYYY') || '��' || TO_CHAR(SYSDATE, 'FMMM') || '��' || TO_CHAR(SYSDATE, 'DD') || '��' FROM DUAL;
--FM�� ���̸� ���鵵 ������������ ��¥���� 0�� �������ش�. ��¥�ϰ��!

--5. ���Ϲ�ȯ
SELECT TO_CHAR(SYSDATE, 'D') FROM DUAL; -- 1:�Ͽ��� ~ 7:�����
SELECT TO_CHAR(SYSDATE, 'DY') FROM DUAL; -- �ѱ� �ѱ��ڷ� ������ ǥ��
SELECT TO_CHAR(SYSDATE, 'DAY') FROM DUAL; -- ������ �ѱ۷� ǥ��

--6. 1��������� (2021-01-01�� ��������) ������ ��ĥ°����?
SELECT TO_CHAR(SYSDATE,'DDD') FROM DUAL;
--6-1. 1��������� (2021-01-01�� ��������) ������ 1�� ������ ����°����?
SELECT TO_CHAR(SYSDATE,'WW') FROM DUAL;
--6-2. 1��������� (2021-01-01�� ��������) ������ 1�� ������ ����°����?
SELECT TO_CHAR(SYSDATE,'W') FROM DUAL;
--6-3. 1��������� (2021-01-01�� ��������) ������ ��б�°����?
SELECT TO_CHAR(SYSDATE,'Q') FROM DUAL;

--7.
SELECT TO_CHAR(SYSDATE, 'MON') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DL') FROM DUAL;

--8. NN����
SELECT TO_CHAR(SYSDATE,'CC') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'SCC') FROM DUAL;

--9. ����, �����
SELECT TO_CHAR(SYSDATE,'AD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'BC') FROM DUAL;

SELECT TO_CHAR(SYSDATE,'DS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'RM') FROM DUAL; -- ���� �θ��ڷ�

--���� ����� ������ ���̰� �ణ ���� ���̴� ã�ƺ��°ɷ�,,,
SELECT TO_CHAR(SYSDATE,'YYYY') FROM DUAL; 
SELECT TO_CHAR(SYSDATE,'RRRR') FROM DUAL;

SELECT TO_CHAR(SYSDATE,'DDSP') FROM DUAL; 
SELECT TO_CHAR(SYSDATE,'MMSP') FROM DUAL; 
SELECT TO_CHAR(SYSDATE,'YYYYSP') FROM DUAL; 
SELECT TO_CHAR(SYSDATE,'DDTHSP') FROM DUAL; 




