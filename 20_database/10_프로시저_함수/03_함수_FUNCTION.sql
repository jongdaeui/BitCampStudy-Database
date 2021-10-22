/* *** 함수 (FUNCTION)
CREATE OR REPLACE FUNCTION FUNCTION1
(
  PARAM1 IN VARCHAR2 -- 작성영역
)
RETURN VARCHAR2 -- 리턴 데이터 타입선언
AS 
BEGIN
  RETURN NULL;
END;

-------
-- 리턴할 데이터에 대한 선언 필요
RETURN 데이터 유형 (타입)
-- 프로그램 마지막에 값 리턴하는 문장 필요
RETURN 리턴값;
***************************/
-- BOOKID로 책 제목 확이나는 함수 (파라미터 값 : BOOKID, RETURN값 : BOOKNAME
CREATE OR REPLACE FUNCTION GET_BOOKNAME (
  IN_ID IN VARCHAR2 
) RETURN VARCHAR2 -- 리턴할 타입 지정
AS
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
BEGIN
    SELECT BOOKNAME INTO V_BOOKNAME
    FROM BOOK
    WHERE BOOKID = IN_ID;
    
    RETURN V_BOOKNAME; -- 리턴 값 전달
END;
-----------
-- 함수 (FUNCTION)이 사용
-- SELECT 절에 사용
SELECT BOOKID, BOOKNAME, GET_BOOKNAME(BOOKID)
FROM BOOK;
--------------------
SELECT O.*, GET_BOOKNAME(BOOKID)
  FROM ORDERS O;
----------------------------
-- WHERE 절에서 함수 사용
SELECT O.*, GET_BOOKNAME(BOOKID)
  FROM ORDERS O
 WHERE GET_BOOKNAME(BOOKID) = '야구를 부탁해'
;
------------------------------------
-- 고객ID 값을 받아서 고객명을 돌려주는 함수 작성 (CUSTOMER 테이블 사용)
-- 함수명 : GET_CUSTNAME
-- 함수를 사용해서 ORDERS 테이블 데이터 조회 
---- GET_BOOKNAME, GET_CUSTNAME 함수 사용 주문 (판매) 정보와 책제목, 고객명 조회
-------------------------------------
SELECT O.*, GET_CUSTNAME(O.CUSTID) AS CUSTOMER, GET_BOOKNAME(O.BOOKID) AS BOOKNAME
FROM ORDERS O;

