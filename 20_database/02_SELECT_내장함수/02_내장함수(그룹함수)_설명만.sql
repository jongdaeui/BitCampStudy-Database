--﻿내장함수 : 오라클 DBMS에서 제공하는 함수(FUNCTION)
--그룹함수 : 하나 이상의 행을 그룹으로 묶어서 연산
--COUNT(*) : 데이터 갯수 조회(전체 컬럼에 대하여)
--COUNT(컬럼명) : 데이터 갯수 조회(지정된 컬럼만 대상으로)
--SUM(컬럼명) : 합계값 구하기
--AVG(컬럼명) : 평균값 구하기
--MAX(컬럼명) : 최대값 구하기
--MIN(컬럼명) : 최소값 구하기
--******************************/
SELECT COUNT(*) FROM BOOK; -- 테이블 데이터 건수 확인
SELECT * FROM CUSTOMER;
SELECT COUNT(*) FROM CUSTOMER;
SELECT COUNT(PHONE) FROM CUSTOMER; -- NULL값은 제외됨
SELECT COUNT(*) FROM CUSTOMER WHERE PHONE IS NOT NULL; -- 명시적으로 NULL값을 제외함
---------------------------
--SUM(컬럼명) : 합계값 구하기
SELECT * FROM BOOK;
SELECT SUM(PRICE) FROM BOOK; -- 144500
-- 대한미디어, 이상미디어 출판사에서 출판한 모든 책의 금액 합계
SELECT SUM(PRICE) FROM BOOK WHERE PUBLISHER IN ('대한미디어', '이상미디어'); -- 90000

--AVG(컬럼명) : 평균값 구하기
SELECT AVG(PRICE) FROM BOOK; -- 14450
-- 대한미디어, 이상미디어 출판사에서 출판한 모든 책의 평균 금액
SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER IN ('대한미디어', '이상미디어'); -- 22500

--MAX(컬럼명) : 최대값 구하기
--MIN(컬럼명) : 최소값 구하기
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK;
-- (실습) 굿스포츠에서 출판한 책중 최고가, 최저가 구하기
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK WHERE PUBLISHER = '굿스포츠';
---------------------------------------------------
--(실습)
-- 1. 출판된 책 전체 조회(정렬 : 출판사, 금액 순으로 정렬)
SELECT * FROM BOOK ORDER BY PUBLISHER, PRICE DESC;

-- 2. 굿스포츠에서 출판한 책을 책제목 순으로 조회
SELECT * FROM BOOK WHERE PUBLISHER = '굿스포츠' ORDER BY BOOKNAME;
-- 3. 출판된 책 중에서 10000원 이상인 책(큰 금액순으로 정렬)
SELECT * FROM BOOK WHERE PRICE >= 10000 ORDER BY PRICE DESC;
-- 4. 박지성의 총 구매액
SELECT SUM(SALEPRICE) FROM ORDERS WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성');
-- 5. 박지성이 구매한 도서의 수
SELECT COUNT(*) FROM ORDERS WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성');
-- 6. 성이 '김'씨인 고객의 이름과 주소 찾기
SELECT NAME, ADDRESS FROM CUSTOMER WHERE NAME LIKE '김%';
-- 7. 성이 '박'이고 이름이 '성'으로 끝나는 고객의 이름과 주소 찾기
SELECT NAME, ADDRESS FROM CUSTOMER WHERE NAME LIKE '박%성';
-- 8. 책 제목이 '야구' 부터 '축구'까지를 검색 (단, '역도' 관련 도서는 제외) 책 제목으로 정렬
SELECT BOOKNAME FROM BOOK WHERE BOOKNAME BETWEEN '야구' AND '축구' AND BOOKNAME NOT LIKE '%역도%' ORDER BY BOOKNAME; 
