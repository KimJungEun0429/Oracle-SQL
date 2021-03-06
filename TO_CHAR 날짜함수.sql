--TO_CHAR 함수
--데이터베이스 - 데이터타입이 존재 - 숫자타입, 문자타입, 날짜타입

SELECT '1234' AS TEST FROM DUAL; -- 문자
SELECT 1234 AS TEST FROM DUAL; -- 숫자

SELECT '1234' + 1234 FROM DUAL; -- 문자 + 숫자지만 결과는 나온다
SELECT '1234A' + 1234 FROM DUAL; -- 근데 찐문자가 하나라도 들어가면 계산 안됨

SELECT TO_DATE('2021-04-16') + 2 AS DT FROM DUAL;
--이렇게 만들어놓으면 '2021-04-16'을 컴퓨터는 숫자값으로 가지고 있다.

SELECT '2021-04-16' + 2 FROM DUAL; --이건 안돼
SELECT '20210416' + 2 FROM DUAL; --이건 또 가넝,,ㅎㅎ

--1. TO_CHAR로 날짜 활용
SELECT SYSDATE FROM DUAL;

--1.1 날짜표시
SELECT TO_CHAR(SYSDATE,'YYYYMMDD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY/MM/DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

SELECT TO_CHAR('2021-05-05','YYYYMMDD');--이렇게 쓰면 안된다. (A,B)에서 A자리에 데이트 타입이 와야가능하기때문이고 TO_DATE를 안주면 그냥 문자열이다
SELECT TO_CHAR(TO_DATE('2021-05-05'),'YYYYMMDD');

--2.소수점 표시
SELECT TO_CHAR('123456','999,999,999') FROM DUAL;--소수점 처리해줄 숫자보다 자리수를 나타내는 숫자 수가 길어야 된다
SELECT TO_CHAR('123456','FM999,999,999') FROM DUAL;--처리해줄 숫자가 작으면 자리수만큼 공백이 생기는데 그럴 땐, FM을 붙여주면 공백이 처리가 된다
SELECT TO_CHAR('123456','FML999,999,999') FROM DUAL;--돈단위마다 명령어는 다른데 한화는 L을 주면 됨.

--3. 000표시(0001,0002,0003,0004 ~ 017,018,019 ~ 123 124 125
SELECT TO_CHAR(77,'0000') FROM DUAL;
SELECT TO_CHAR(77,'FM0000') FROM DUAL; -- 공백사라지게 하려면 FM 붙인다
SELECT TO_CHAR(89087) FROM DUAL; -- 숫자 890870을 문자 89087로 바꾸기
SELECT TO_CHAR(89087) || '원' FROM DUAL;-- 문자끼리 붙여줄 때 활용 가능

--4. 2021년 04월 16일
SELECT TO_CHAR(SYSDATE, 'YYYY') || '년' || TO_CHAR(SYSDATE, 'MM') || '월' || TO_CHAR(SYSDATE, 'DD') || '일' 
FROM DUAL
;

--4-1. 2021년 4월 16일
SELECT TO_CHAR(SYSDATE, 'YYYY') || '년' || TO_CHAR(SYSDATE, 'FMMM') || '월' || TO_CHAR(SYSDATE, 'DD') || '일' FROM DUAL;
--FM을 붙이면 공백도 제거해주지만 날짜에서 0도 제거해준다. 날짜일경우!

--5. 요일반환
SELECT TO_CHAR(SYSDATE, 'D') FROM DUAL; -- 1:일요일 ~ 7:토요일
SELECT TO_CHAR(SYSDATE, 'DY') FROM DUAL; -- 한글 한글자로 요일을 표시
SELECT TO_CHAR(SYSDATE, 'DAY') FROM DUAL; -- 요일을 한글로 표시

--6. 1년기준으로 (2021-01-01을 기준으로) 오늘이 며칠째이지?
SELECT TO_CHAR(SYSDATE,'DDD') FROM DUAL;
--6-1. 1년기준으로 (2021-01-01을 기준으로) 오늘이 1년 단위로 몇주째이지?
SELECT TO_CHAR(SYSDATE,'WW') FROM DUAL;
--6-2. 1년기준으로 (2021-01-01을 기준으로) 오늘이 1월 단위로 몇주째이지?
SELECT TO_CHAR(SYSDATE,'W') FROM DUAL;
--6-3. 1년기준으로 (2021-01-01을 기준으로) 오늘이 몇분기째이지?
SELECT TO_CHAR(SYSDATE,'Q') FROM DUAL;

--7.
SELECT TO_CHAR(SYSDATE, 'MON') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DL') FROM DUAL;

--8. NN세기
SELECT TO_CHAR(SYSDATE,'CC') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'SCC') FROM DUAL;

--9. 서기, 기원전
SELECT TO_CHAR(SYSDATE,'AD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'BC') FROM DUAL;

SELECT TO_CHAR(SYSDATE,'DS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'RM') FROM DUAL; -- 달을 로마자로

--둘의 결과는 같으나 차이가 약간 있음 차이는 찾아보는걸로,,,
SELECT TO_CHAR(SYSDATE,'YYYY') FROM DUAL; 
SELECT TO_CHAR(SYSDATE,'RRRR') FROM DUAL;

SELECT TO_CHAR(SYSDATE,'DDSP') FROM DUAL; 
SELECT TO_CHAR(SYSDATE,'MMSP') FROM DUAL; 
SELECT TO_CHAR(SYSDATE,'YYYYSP') FROM DUAL; 
SELECT TO_CHAR(SYSDATE,'DDTHSP') FROM DUAL; 




