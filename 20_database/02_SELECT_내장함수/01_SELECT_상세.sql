/* *************************
SELECT [* | DISTINCT] {컬럼명, 컬럼명, ...}
  FROM 테이블명
[WHERE 조건절]
[GROUP BY {컬럼명, ....}
    [HAVING 조건] ] --GROUP BY 절에 대한 조건
[ORDER BY {컬럼명 [ASC | DESC], ....}] --ASC : 오름차순(기본/생략가능)
                                      --DESC : 내림차순
***************************/
SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
---------------------------
SELECT * FROM BOOK ORDER BY BOOKNAME;
-- 출판사 기준 오름차순
SELECT * FROM BOOK ORDER BY PUBLISHER, BOOKNAME;
-- 출판사 기준 오름차순, 가격이 큰 것부터 (내림차순)
SELECT * FROM BOOK ORDER BY PUBLISHER, PRICE DESC;
-----------------------------
--  AND, OR, NOT
-- 출판사 대한미디어, 금액이 3만원 이상인 책 조회
SELECT *
    FROM BOOK
    WHERE PUBLISHER = '대한미디어' AND PRICE >= 30000
    ;
    
-- 출판사 대한미디어 또는 이상미디어에서 출판한 책 목록
SELECT *
FROM BOOK
WHERE PUBLISHER = '대한미디어' OR PUBLISHER = '이상미디어'
;
-- 출판사중에서 굿 스포츠가 아닌 것
SELECT *
FROM BOOK
WHERE PUBLISHER != '굿스포츠' -- <> : 다르다 ( != ) 사용가능
;

--------------------------------------
-- 굿 스포츠, 대한미디어 출판사가 아닌 도서 목록
SELECT * FROM BOOK
WHERE PUBLISHER != '굿스포츠' AND PUBLISHER != '대한미디어'
;
SELECT * FROM BOOK
WHERE NOT (PUBLISHER = '굿스포츠' OR PUBLISHER = '대한미디어')
;
-- IN : 내부에 포함되어 있는지 확인하는 키워드 (OR문을 단순화 할때 사용함)
-- 출판사 나무수, 대한미디어, 삼성당에서 출판한 도서 목록
SELECT * FROM BOOK
WHERE PUBLISHER = '나무수' OR PUBLISHER = '대한미디어' OR PUBLISHER = '삼성당'
;
SELECT * FROM BOOK -- IN키워드 사용 (여러개일 경우 ()필수)
WHERE PUBLISHER IN ('나무수', '대한미디어', '삼성당');

-- 출판사 나무수, 대한미디어, 삼성당에서 출판한 도서를 제외한 목록
SELECT * FROM BOOK
WHERE PUBLISHER != '나무수' AND PUBLISHER != '대한미디어' AND PUBLISHER != '삼성당'
;
SELECT * FROM BOOK -- IN키워드 사용 (여러개일 경우 ()필수)
WHERE PUBLISHER NOT IN ('나무수', '대한미디어', '삼성당');

--=====================================
-- 같다 (=), 크다 (>), 작다(<), 크거나 같다 (>=), 작거나 같다 (<=)
-- 같지 않다 / 다르다 : <>, !=
-- (실습) 출판된 책중에 8000원 이상이고, 22000원 이하인 책 (가격순 정렬)

SELECT * FROM BOOK
WHERE PRICE >= 8000 AND PRICE <= 22000 ORDER BY PRICE;
-- BETWEEN 값1 부터 값2 까지
SELECT * FROM BOOK -- BETWEEN 사용
WHERE PRICE BETWEEN 8000 AND 22000 ORDER BY PRICE;

SELECT * FROM BOOK -- NOT BETWEEN 사용
WHERE PRICE NOT BETWEEN 8000 AND 22000 ORDER BY PRICE;
-- 책 제목이 '야구' ~ '올림픽'
SELECT * FROM BOOK ORDER BY BOOKNAME;
SELECT * FROM BOOK 
WHERE BOOKNAME BETWEEN '야구' AND '올림픽'
ORDER BY BOOKNAME;
-------------
-- (실습 BETWEEN) 출판사 나무수 ~ 삼성당 출판사 책 (출판사명으로 정렬)
SELECT * FROM BOOK
WHERE PUBLISHER BETWEEN '나무수' AND '삼성당'
ORDER BY PUBLISHER;

-- (실습 IN) 대한미디어, 이상미디어에서 출판한 책 목록 (출판사명, 책제목 정렬)
SELECT * FROM BOOK
WHERE PUBLISHER IN ('대한미디어', '이상미디어')
ORDER BY PUBLISHER, BOOKNAME;

-- LIKE : '%', '_'  부호와 함께 사용
-- % : 전체를 의미
-- _ : 문자하나에 대하여 모든 것을 의미
---------------------------------
SELECT * FROM BOOK
WHERE PUBLISHER LIKE '%미디어' -- 출판사명이 '미디어'로 끝나는 출판사
ORDER BY PUBLISHER, BOOKNAME;

-- 야구로 시작하는 책 조회
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '야구%'; -- '야구' 로 시작하는 책

-- '단계'가 들어가 있는 책 제목 조회
SELECT *FROM BOOK
WHERE BOOKNAME LIKE '%단계%'; -- '단계'가 포함된 책 제목 전부 찾기

-- (실습) 책 제목에 '구' 문자가 있는 책 목록
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '%구%';  

-- (실습) 책 제목에 '구' 문자가 2번째에 있는 책 조회
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '_구%'; -- 위치에 반드시 1개 문자가 있어야 함

-- (실습) 책 제목에 '를' 문자가 3번째에 있는 책 조회
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '__를%'; -- 위치에 반드시 2개 문자가 있어야 함
----------------------------------------------------------------
--LIKE 사용시 동작 결과 확인
CREATE TABLE TEST_LIKE(
    ID NUMBER(2) PRIMARY KEY,
    NAME VARCHAR(30)
);
INSERT INTO TEST_LIKE VALUES (1, '홍길동');
INSERT INTO TEST_LIKE VALUES (2, '홍길동2');
INSERT INTO TEST_LIKE VALUES (3, '홍길동구');
INSERT INTO TEST_LIKE VALUES (4, '홍길동대문');
INSERT INTO TEST_LIKE VALUES (5, '홍길동2다');
INSERT INTO TEST_LIKE VALUES (6, '김홍길동');
INSERT INTO TEST_LIKE VALUES (7, '김홍길동만');
INSERT INTO TEST_LIKE VALUES (8, '김만홍길동');
INSERT INTO TEST_LIKE VALUES (9, '김만홍길동이다');
INSERT INTO TEST_LIKE VALUES (10, '김만홍길이다');
COMMIT;
--------
SELECT * FROM TEST_LIKE;
SELECT * FROM TEST_LIKE WHERE NAME = '홍길동';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '홍길동';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '홍길동%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '홍길동2%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '%홍길동'; 
SELECT * FROM TEST_LIKE WHERE NAME LIKE '%홍길동%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_홍길동_'; -- 반드시 5글자만 검색됨
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_홍길동_%'; -- 최소 5글자 이상
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_홍길동%'; -- 최소 4글자 이상
SELECT * FROM TEST_LIKE WHERE NAME LIKE '__홍길동%';
-----------------------------------------------------























