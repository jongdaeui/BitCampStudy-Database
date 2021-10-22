/************************************************
형변환 내장함수
TO_CHAR : 문자타입으로 전환(날짜 -> 문자, 숫자 -> 문자)
TO_NUMBER : 숫자타입으로 전환(문자 -> 숫자)
TO_DATE : 날짜타입으로 전환(문자 -> 날짜)

      <- TO_NUMBER(문자)  -> TO_DATE(문자)
숫자형   ----    문자형   ----     날짜형
      -> TO_CHAR(숫자)   <- TO_CHAR(날짜)
************************************************
--날짜 -> 문자
TO_CHAR(날짜데이터, '출력형식')
<출력형식>
년도(YYYY, YY), 월(MM), 일(DD)
시간 : HH, HH12(12 시간제), HH24(24 시간제)
분(MI), 초(SS)
오전, 오후: AM, PM
년월일시분초 작성예) YYYY-MM-DD HH24:MI:SS
************************************************/
--TO_CHAR : 문자타입으로 전환(날짜 -> 문자, 숫자 -> 문자)
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD (DAY)') FROM DUAL;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH12:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH12:MI:SS') FROM DUAL;

--==============================
/* TO_CHAR(숫자, '출력형식') : 숫자 -> 문자타입
<형식지정>
0(영) : 자리수를 나타내며, 자리수가 맞지 않는 경우 0을 표시
9(구) : 자리수를 나타내며, 자리수가 맞지 않는 경우 표시하지 않음
L : 지역 통화 문자 표시
.(점) : 소수점
,(콤마) : 1000단위 구분 표시 문자
**************************************/

SELECT 123000, TO_CHAR(123000) FROM DUAL;
SELECT '123000', TO_NUMBER('123000') FROM DUAL;

-- 묵시적 형변환 처리 : 문자타입이 숫자연산에 참여할 때 숫자 타입으로 형변환 처리된다.
SELECT 123000 + 10, TO_CHAR(123000) + 10 FROM DUAL; -- 오라클에서는 가능, 문자열에 숫자 연산 가능(문자열이 숫자로 연산이 가능한 경우

-----------------------
SELECT TO_CHAR(123456, 'L999,999,999'), TO_CHAR(123456, 'L000,000,000') FROM DUAL;

SELECT TO_CHAR(0, 'L999,999,999'), TO_CHAR(0, 'L000,000,000') FROM DUAL;

SELECT TO_CHAR(1230.5, 'L999,999,999'), TO_CHAR(1230.5, 'L000,000,000') FROM DUAL;

SELECT TO_CHAR(1230.5555, 'L999,999.999'), TO_CHAR(1230.5555, 'L000,000.000') FROM DUAL;

SELECT TO_CHAR(1230, 'L999,999.99'), TO_CHAR(1230, 'L000,000.00') FROM DUAL;

---------------------------------------------------
--TO_DATE(문자열, 형식문자) -> 날짜 타입
SELECT '2021-08-10', SYSDATE FROM DUAL;
SELECT SYSDATE + 1 FROM DUAL;
SELECT '2021-08-10' + 1 FROM DUAL; -- ORA-01722: invalid number
SELECT TO_DATE('2021-08-10','YYYY-MM-DD') + 1  FROM DUAL;

SELECT '2021-08-10 16:04:10', TO_DATE('2021-08-10 16:04:10', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
------------------------------------------------------------
SELECT '현재 날짜 시간', SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
-- 하루 뒤
SELECT TO_CHAR(SYSDATE + 1, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

-- 1시간 뒤
SELECT TO_CHAR(SYSDATE + 1/24, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
-- 3시간 뒤
SELECT TO_CHAR(SYSDATE + (1/24) * 3, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
-- 1분 뒤
SELECT TO_CHAR(SYSDATE + (1/24/60), 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
-- 1초 뒤
SELECT TO_CHAR(SYSDATE + (1/24/60/60), 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
---------------------------------------
SELECT SYSDATE, TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT TRUNC(SYSDATE), TO_CHAR (TRUNC(SYSDATE), 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(ROUND(SYSDATE), 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;









