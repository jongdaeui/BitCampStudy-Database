/* (실습) TABLE 만들기 : TEST2
    NO : 숫자 5자리, PRIMARY KEY
    ID : 문자타입 10자리 (영문), NULL 허용안함
    NAME : 한글 10자리 저장 가능 하도록 설정, NULL 허용 안함
    EMAIL : 영문, 숫자, 특수문자 포함 30자리
    ADDRESS : 한글 100 글자
    INNUM : 숫자타입 (정수부 7자리, 소수부 3자리 EX)1234567.123)
    REGDATE : 날짜 타입
    *********************************/
    
CREATE TABLE TEST2 (
    NO NUMBER(5) PRIMARY KEY,
    ID VARCHAR2(10) NOT NULL,
    NAME VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR(30),
    ADDRESS VARCHAR (300),
    INNUM NUMBER(10,3),
    REGDATE DATE
);

INSERT INTO TEST2 VALUES (1001, 'jongdaeui', '종대의', 'jongdaeui@gmail.com', '서울시 강서구 화곡로 19길 6', 12345.34, SYSDATE);
INSERT INTO TEST2 VALUES (1002, 'kimjini', '김지니', 'kimjini@naver.com', '서울시 강서구 화곡로 19길 6', 1234567.98937, SYSDATE);
SELECT * FROM TEST2;
COMMIT;
--=====================================================
-- 특정 테이블의 데이터와 함께 테이블 구조를 함께 복사
CREATE TABLE TEST3 AS SELECT * FROM TEST2;
SELECT * FROM TEST3;

--------------------------------------------------------
-- 특정 테이블의 특정 컬럼과 특정 데이터만 복사해서 테이블 생성
CREATE TABLE TEST4
AS
SELECT NO, ID, NAME, EMAIL FROM TEST2 WHERE NO = 1001;

SELECT * FROM TEST4;
COMMIT;

----------------------------------------------------------
-- 특정 테이블의 구조만 복사 (데이터는 복사하지 않음)
CREATE TABLE TEST5
AS
SELECT * FROM TEST2 WHERE 1 = 2;
SELECT * FROM TEST5;
--============================================================
-- 테이블 데이터 전체 삭제
DELETE FROM TEST2; -- 모든 데이터 삭제
ROLLBACK;
---------------------------------------------------------
-- TRUNCATE 명령문 : 테이블 데이터 전체삭제 처리 (ROLLBACK 불가능)
--TRUNCATE TABLE TES2;

--=============================================================
/* 테이블을 삭제 : DROP TABLE - 데이터와 함께 테이블 구조 모두 삭제 처리
    DROP TABLE 유저명.테이블명;
    DROP TABLE 유저명.테이블명 CASCADE CONSTRAINTS PURGE;
    CASCADE CONSTRAINSTS : 참조 데이터가 있어도 삭제처리
    PURGR : 휴지통에 백업없이 완전히 삭제
*/

DROP TABLE TEST2;

--==========================================================
/* 테이블 수정 : 컬럼추가, 수정, 삭제
DDL : ALTER TABLE
 - ADD : 추가
 - MODIFY : 수정
 - DROP COLUMN : 삭제
********************************/
SELECT * FROM TEST3;
--컬럼추가 TEST3 테이블에 ADDCOL 컬럼추가
ALTER TABLE TEST3 ADD ADDCOL VARCHAR(20);

-- 컬럼수정 TEST3 테이블에 ADDCOL 추가 -> VARCHAR(20)
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(30);
UPDATE TEST3 SET ADDCOL = '123456789012345';
SELECT * FROM TEST3;

-- 컬럼수정 TEST3 테이블의 ADDCOL 크기 - VARCHAR2(15), VARCHAR(10)
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR(15); -- 가장큰 데이터 사이즈 15 : 변경

ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR(10); -- 가장큰 데이터 사이즈 10 : 오류발생 

-- 컬럼삭제 : DROP COLUMN
ALTER TABLE TEST3 DROP COLUMN ADDCOL;

----------------------------------------------------------
ALTER TABLE TEST3 MODIFY (TESTNUM NOT NULL);

ALTER TABLE "MYSTUDY"."TEST3" RENAME TO TEST333;
--====================================================================






