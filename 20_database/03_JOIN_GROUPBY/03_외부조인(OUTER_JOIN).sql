-- (번외) 고객 중 한 권도 구입 안한 사람은 누구??
---- CUSTOMER 테이블에는 있고, ORDERS 테이블에는 없는 사람
---------------------
-- (방법 1) 서브쿼리 (SUB QUERY)
SELECT CUSTID
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS) -- ORDERS : 1,2,3,4
ORDER BY CUSTID
;
------------------
-- (방법 2) MINUS : 차집합 처리
SELECT CUSTID FROM CUSTOMER -- 1, 2, 3, 4, 5
MINUS
SELECT CUSTID FROM ORDERS;-- 1, 1, 2, 3, 4, 1.......
----------------
-- (방법 3) 외부조인 (OUTER JOIN)
-- 내부조인(INNER JOIN) - 동등 조인 (동일하게 있는)
SELECT DISTINCT C.CUSTID, C.NAME
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID -- 동등 조인
;
-- 외부조인 (좌측 기준)
SELECT C.*
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID(+) -- 좌측기준 조인
AND O.ORDERID IS NULL
;
---------------------------
-- ANSI 표준 SQL (좌측 기준)
SELECT C.*
FROM CUSTOMER C LEFT OUTER JOIN ORDERS O
ON C.CUSTID = O.CUSTID
WHERE O.ORDERID IS NULL
;

-- ANSI 표준 SQL (우측 기준)
SELECT C.*
FROM ORDERS O RIGHT OUTER JOIN CUSTOMER C
ON C.CUSTID = O.CUSTID
WHERE O.ORDERID IS NULL
;

-- 외부 조인 (우측기준)
SELECT *
FROM ORDERS O, CUSTOMER C -- 순서는 상관없음
WHERE O.CUSTID(+) = C.CUSTID -- 우측이 기준
AND O.ORDERID IS NULL
;
---------------------
-- 조인 (JOIN, INNER JOIN) : 조인테이블 모두에 존재하는 데이터 검색
-- 외부조인 (OUTER JOIN) : 어느 한 쪽 테이블에 데이터가 존재하지 않는 데이터 검색
---- 모든 데이터를 표시하고, 일치하지 않는 데이터를 찾을 때 사용
-----------------------------------

CREATE TABLE DEPT (
ID VARCHAR2(10) PRIMARY KEY,
NAME VARCHAR2(30)
);

INSERT INTO DEPT VALUES ('10', '총무부');
INSERT INTO DEPT VALUES ('20', '급여부');
INSERT INTO DEPT VALUES ('30', 'IT부');
COMMIT;
-------------------
CREATE TABLE DEPT_1 (
    ID VARCHAR2(10) PRIMARY KEY,
NAME VARCHAR2(30)
);

INSERT INTO DEPT_1 VALUES ('10', '총무부');
INSERT INTO DEPT_1 VALUES ('20', '급여부');
COMMIT;
--------------------------------------------
CREATE TABLE DEPT_2 (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);

INSERT INTO DEPT_2 VALUES ('10', '총무부');
INSERT INTO DEPT_2 VALUES ('30', 'IT부');
COMMIT;

---------------------------------
SELECT * FROM DEPT;
SELECT * FROM DEPT_1;
SELECT * FROM DEPT_2;
------------------------------------
-- DEPT = DEPT_1
SELECT *
FROM DEPT D, DEPT_1 D1
WHERE D.ID = D1.ID -- 동등조건 (양쪽에 동시에 존재하는 것 만 검색)
;
--------------------
-- DEPT = DEPT_2
SELECT *
FROM DEPT D, DEPT_2 D2
WHERE D.ID = D2.ID -- 동등조건 (양쪽에 동시에 존재하는 것 만 검색)
;
--------------------
-- DEPT 에는 있고, DEPT_1에는 없는 데이터 조회
-- LEFT OUTER JOIN : 좌측 테이블 기준
-- 전체 데이터 표시하고, 우측에 없으면 NULL 표시
SELECT *
FROM DEPT D, DEPT_1 D1
WHERE D.ID = D1.ID(+) -- 조인조건 (좌측 기준)
;
----------------------
-- 좌측에만 있는 데이터 찾기
SELECT D.*
FROM DEPT D, DEPT_1 D1
WHERE D.ID = D1.ID(+) -- 조인조건 (좌측 기준)
AND D1.ID IS NULL
;
--- ANSI 표준 SQL : LEFT OUTER JOIN - 좌측 테이블 기준
SELECT *
FROM DEPT D LEFT OUTER JOIN DEPT_1 D1 -- 조인 방식 (좌측 기준 외부 조인)
ON D.ID = D1.ID
WHERE D1.ID IS NULL
;
------------------------
--RIGHT OUTER JOIN : 우측 테이블 기준
SELECT *
FROM DEPT_1 D1, DEPT D
WHERE D1.ID(+) = D.ID
;
-------------------
-- 표준 SQL : RIGHT OUTER JOIN
SELECT D.*
FROM DEPT_1 D1 RIGHT OUTER JOIN DEPT D
ON D1.ID = D.ID
WHERE D1.ID IS NULL
;
---------------------------------------
-- 1. DEPT_1 에는 있고, DEPT_2 테이블에는 없는 데이터 찾기 (LEFT OUTER JOIN)
SELECT D1.*
FROM DEPT_1 D1 LEFT OUTER JOIN DEPT_2 D2
ON D1.ID = D2.ID
WHERE D2.ID IS NULL
;
--
SELECT D1.*
FROM DEPT_1 D1, DEPT_2 D2
WHERE D1.ID = D2.ID(+) -- LEFT OUTER JOIN (좌측 기준)
AND D2.ID IS NULL
;

-- 2. DEPT_2 에는 있고, DEPT_1 테이블에는 없는 데이터 찾기 (RIGHT OUTER JOIN)
SELECT D2.*
FROM DEPT_1 D1 RIGHT OUTER JOIN DEPT_2 D2
ON D1.ID = D2.ID
WHERE D1.ID IS NULL
;
--
SELECT D2.*
FROM DEPT_1 D1, DEPT_2 D2
WHERE D1.ID(+) = D2.ID -- RIGHT OUTER JOIN (우측 기준)
AND D1.ID IS NULL
;
--=================================
-- FULL OUTER JOIN : 양쪽 모두 데이터 조회 (없는 부분은 NULL)
SELECT *
FROM DEPT_1 D1 FULL OUTER JOIN DEPT_2 D2
ON D1.ID = D2.ID
WHERE D2.ID IS NULL
;
--------------------------
SELECT *
FROM DEPT_1 D1 FULL OUTER JOIN DEPT_2 D2
ON D1.ID = D2.ID
WHERE D1.ID IS NULL
;

