/* ************************
뷰(VIEW) : 하나 또는 둘 이상의 테이블로 부터
   데이터의 부분집합을 테이블인 것처럼 사용하는 객체(가상테이블)
--뷰(VIEW) 생성문
CREATE [OR REPLACE] VIEW 뷰이름 [(컬럼별칭1, 컬럼별칭2, ..., 컬럼별칭n)]
AS
SELECT 문장
[옵션];

--읽기전용 옵션 : WITH READ ONLY

--뷰(VIEW) 삭제
DROP VIEW 뷰이름;
***************************/
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';
--- 뷰 (VIEW) 만들기 ---
CREATE OR REPLACE VIEW VW_BOOK
AS
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%'
WITH READ ONLY; -- 읽기 전용

-- 뷰 사용해서 데이터 검색
SELECT * FROM VW_BOOK; -- 아래와 동일한 문장
SELECT * FROM (SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%');

SELECT * FROM VW_BOOK WHERE PUBLISHER = '굿스포츠';
SELECT * FROM (SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%') WHERE PUBLISHER = '굿스포츠';

------------------------------------
CREATE VIEW VW_BOOK2
    (BID, BNAME, PUB, PRICE)
AS
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%'
WITH READ ONLY
;
SELECT * FROM VW_BOOK2 WHERE PUB = '굿스포츠';
----------------------------
CREATE VIEW VW_BOOK3
    (BNAME, PUB, PRICE)
AS
SELECT BOOKNAME, PUBLISHER, PRICE
FROM BOOK
WHERE BOOKNAME LIKE '%축구%'
;

----------------
CREATE OR REPLACE VIEW VW_ORDERS
AS
SELECT O.ORDERID, O.CUSTID, O.BOOKID,  
        C.NAME, C.PHONE, C.ADDRESS,
        B.BOOKNAME, B.PUBLISHER, B.PRICE,
        O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
ORDER BY O.ORDERID
WITH READ ONLY
;
----------------------------------------------
-- (뷰사용) 박지성, 김연아가 구입한 책제목, 구입금액, 구입일자
SELECT NAME, BOOKNAME, SALEPRICE, ORDERDATE
FROM VW_ORDERS
WHERE NAME IN ('박지성', '김연아')
;
-- 뷰 삭제
DROP VIEW VW_ORDERS;

--============================
--(실습) 뷰를 생성, 조회, 삭제
--1. 뷰생성 - 뷰명칭 : VW_ORD_ALL
---- 주문(판매)정보, 책정보, 고객정보 모두 조회할 수 있는 형태 뷰 

CREATE OR REPLACE VIEW VW_ORD_ALL
AS
SELECT O.ORDERID O_ORDER_ID, O.CUSTID O_CUST_ID, O.BOOKID O_BOOK_ID, O.SALEPRICE, O.ORDERDATE, 
        C.CUSTID C_CUST_ID, C.NAME, C.PHONE, C.ADDRESS,
        B.BOOKID B_BOOK_ID, B.BOOKNAME, B.PUBLISHER, B.PRICE
FROM ORDERS O RIGHT OUTER JOIN CUSTOMER C ON O.CUSTID = C.CUSTID
     RIGHT OUTER JOIN BOOK B ON B.BOOKID = O.BOOKID

ORDER BY O.ORDERID
WITH READ ONLY
;

--2. 이상미디어에서 출판한 책중 판매된 책제목, 판매금액, 판매일 조회
SELECT *
FROM VW_ORD_ALL
WHERE 
--3. 이상미디어에서 출판한 책 중에서 추신수, 장미란이 구매한 책 정보 조회
---- 출력항목 : 구입한 사람이름, 책제목, 출판사, 원가(정가), 판매가, 판매일자
---- 정렬 : 구입한 사람이름, 구입일자 최근순
--4. 판매된 책에 대하여 구매자별 건수, 합계금액, 평균금액, 최고가, 최저가 조회
--(최종) 뷰삭제 : VW_ORD_ALL 삭제 처리
DROP VIEW VW_ORD_ALL;
--================================

--================================
-- FORCE : SELECT 문의 테이블이 없어도 뷰(VIEW)를 강제로 생성
CREATE OR REPLACE FORCE VIEW VW_AAA
AS
SELECT ID, NAME, PHONE FROM AAA; -- AAA테이블이 없을 때 컴파일 오류와 함께 뷰 생성






