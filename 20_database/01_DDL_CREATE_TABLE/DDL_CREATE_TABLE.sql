/* *************************
데이타 정의어
- DDL(Data Definition Language) : 데이타를 정의하는 언어
- CREATE(생성), DROP(삭제), ALTER(수정)
- {}반복가능, []생략가능, | 또는(선택)
CREATE TABLE 테이블명 (
    {컬럼명 데이타타입
        [NOT NULL | UNIQUE | DEFAULT 기본값 | CHECK 체크조건]
    }
    [PRIMARY KEY 컬럼명]
    {[FOREIGN KEY 컬럼명 REFERENCES 테이블명(컬럼명)]
    [ON DELETE [CASCADE | SET NULL]
    }
);
-----------------------------------------------
<제약조건 5종류>
- NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
-----------------------------------------------
컬럼의 기본 데이타 타입(문자열, 숫자, 날짜)
- VARCHAR2(n) : 문자열 가변길이
- CHAR(n) : 문자열 고정길이
- NUMBER(p, s) : 숫자타입 p:전체길이, s:소수점이하 자리수
    예) (5,2) : 정수부 3자리, 소수부 2자리 - 전체 5자리
- DATE : 날짜형 년,월,일 시간 값 저장

문자열 처리 : UTF-8 형태로 저장
- 숫자, 알파벳 문자, 특수문자 : 1 byte 처리(키보드 자판 글자들)
- 한글 : 3 byte 처리
***************************/
/******************************************
제약조건 (Constraint) 
- 올바른 데이터만 들어오게 해주기 위해 사용(잘못된 데이터는 못들어 차단-에러발생)
- 데이터의 정확성과 일관성을 보장하기 위해 각 칼럼에 정의하는 규칙
- 딕셔너리에 저장됨
- 테이블 생성시 무결성 제약조건을 정의하여 프로그래밍 과정을 단순화
- 데이터베이스 서버에 의해 무결성 제약조건이 관리되어 데이터 오류 발생 가능성을 줄여줌
- 일시적으로 활성화(ENABLE) 또는 비활성화(DISABLE) 할 수 있다.

<제약조건 5종류>
- NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
1. NOT NULL : Null값 포함할수 없음
2. UNIQUE : 중복되는 값 오면 안됨
    (중복되는 것 없어야 하므로, 서버프로세스가 기존 데이터를 찾아야 한다. 오래걸림 - 해결 : 인덱스)
3. CHECK : 해당 칼럼에 저장 가능한 데이터 값의 범위나 조건 지정
4. PRIMARY KEY(기본키) : 고유 값 (NOT NULL + 유니크)
5. FOREIGN KEY(외래키-참조) : 해당 칼럼 값은 참조되는 테이블의 칼럼 값 중 하나와 일치하거나 Null을 가짐
    - 자식 테이블 : 다른 테이블의 값을 참조하는 테이블
    - 외래키(foreign key): 부모테이블의 값을 참조하는 자식테이블의 칼럼
    - 부모 테이블 : 다른 테이블에 의해 참조되는 테이블
    - 참조키(reference : 자식 테이블에서 참조하는 부모 테이블의 칼럼
************************************************/
--한줄 주석 부호
/* 
여러줄 주석 부호
*/
--데이터 저장공간 테이블 정의
--DDL
CREATE TABLE MEMBER (
    ID VARCHAR2(20) PRIMARY KEY, --NOT NULL + UNIQUE
    NAME VARCHAR2(30) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(300)
);
----
--DML
INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('HONG', '홍길동', '1234');
--DCL
COMMIT;
ROLLBACK; --임시 처리된 작업 취소

INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('HONG2', '홍길동2', '1234');
COMMIT;

--키중복입력시 : ORA-00001: unique constraint (MYSTUDY.SYS_C006999) violated
INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('HONG2', '홍길동2', '1234');

--NOT NULL 데이터 미입력 오류 : ORA-01400: cannot insert NULL into ("MYSTUDY"."MEMBER"."PASSWORD")
INSERT INTO MEMBER (ID, NAME)
VALUES ('HONG3', '홍길동3');
----------------------------------------
SELECT * FROM MEMBER;
SELECT ID, PASSWORD, NAME, PHONE FROM MEMBER;
---
--입력 : 컬럼명을 명시적으로 쓰지 않고 INSERT문 작성
--테이블에 있는 모든 컬럼사용 + 컬럼순서대로 데이터 입력
INSERT INTO MEMBER 
VALUES ('HONG3', '홍길동3', '1234', '010-1111-1111', '서울시');
COMMIT;

INSERT INTO MEMBER 
VALUES ('HONG4', '홍길동4', '1234', '서울시', '010-2222-2222');
-----------------------
-- 컬럼을 명시적으로 작성시 해당 컬럼에 1 대 1 매칭되어 데이터 입력
INSERT INTO MEMBER (ID, NAME, PASSWORD, ADDRESS, PHONE)
VALUES ('HONG5', '홍길동5', '1234', '서울시', '010-2222-2222');
COMMIT;
SELECT * FROM MEMBER;
--------------------------------------
-- 수정 : HONG4 전화번호 '010-2222-2222'로 변경
-- 수정 : HONG4 주소 '서울시'로 변경
SELECT * FROM MEMBER WHERE ID = 'HONG4';
UPDATE MEMBER SET PHONE = '010-2222-2222' WHERE ID = 'HONG4';
UPDATE MEMBER SET ADDRESS = '서울시' WHERE ID = 'HONG4';
UPDATE MEMBER
   SET PHONE = '010-2222-2222', ADDRESS = '서울시'
 WHERE ID = 'HONG4';
COMMIT;
---------------------------------
--삭제 : HONG5 데이터 삭제
SELECT * FROM MEMBER WHERE ID = 'HONG5';
DELETE FROM MEMBER WHERE ID = 'HONG5';
COMMIT;
--삭제 : 이름이 홍길동인 사람 삭제
SELECT * FROM MEMBER WHERE NAME = '홍길동';
DELETE FROM MEMBER WHERE NAME = '홍길동';
COMMIT;
--=====================================
/* (실습) 입력, 수정, 삭제, 조회(검색)
입력 : 아이디-HONG8, 이름:홍길동8, 암호-1111, 주소-서울시 마포구
조회(검색) : 이름이 '홍길동8'인 사람의 아이디, 이름, 주소, 전화번호 조회
수정 : 아이디가 HONG8 사람의
    전화번호 : 010-8888-8888
    암호 : 8888
    주소 : 서울시 강남구
삭제 : 아이디가 HONG2 인 사람    
********************************/
--입력
SELECT * FROM MEMBER WHERE ID = 'HONG8';
INSERT INTO MEMBER (ID, NAME, PASSWORD, ADDRESS)
VALUES ('HONG8', '홍길동8', '1111', '서울시 마포구');
COMMIT;
--조회(검색)
SELECT ID, NAME, ADDRESS, PHONE FROM MEMBER WHERE NAME = '홍길동8';
--수정
SELECT * FROM MEMBER WHERE ID = 'HONG8';
UPDATE MEMBER
   SET PHONE = '010-8888-8888', 
       PASSWORD = '8888', 
       ADDRESS = '서울시 강남구'
 WHERE ID = 'HONG8'
;
COMMIT;
-- 삭제
SELECT * FROM MEMBER WHERE ID = 'HONG2';
DELETE FROM MEMBER WHERE ID = 'HONG2';
COMMIT;

--========================================================
--컬럼 특성을 확인하기 위한 테이블
CREATE TABLE TEST (
    NUM NUMBER(5,2), --숫자타입 전체자리수 5, 정수부 3, 소수부 2
    STR1 CHAR(10), --고정길이 문자열
    STR2 VARCHAR2(10), --가변길이 문자열
    DATE1 DATE -- 날짜데이터 : 년월일시분초
);
INSERT INTO TEST VALUES (100.454, 'ABC', 'ABC', SYSDATE);
INSERT INTO TEST VALUES (100.455, 'ABC', 'ABC', SYSDATE);
INSERT INTO TEST VALUES (100.456, 'ABC', 'ABC', SYSDATE);
-- 오류발생 : 정수부 3자리 저장 가능한데, 4자리 저장 시도 
--INSERT INTO TEST VALUES (1234.456, 'ABC', 'ABC', SYSDATE);
COMMIT;
SELECT * FROM TEST;
INSERT INTO TEST VALUES (100.455, 'ABCDE', 'ABCDE', SYSDATE);
SELECT '-' || STR1 || '-', '-' || STR2 || '-' FROM TEST;
SELECT STR1, LENGTHB(STR1), STR2, LENGTHB(STR2) FROM TEST;
----------------------------
SELECT * FROM TEST WHERE STR1 = STR2; -- 조회된 데이터 없음
SELECT * FROM TEST WHERE STR1 = 'ABC'; --오라클에서는 조회됨
SELECT * FROM TEST WHERE STR1 = 'ABC       '; --모든 DB 적용
SELECT * FROM TEST WHERE STR1 = 'ABC  '; --오라클에서는 조회됨
--------------------
--숫자타입
SELECT * FROM TEST WHERE NUM = 100.45; -- NUMBER VS NUMVER
SELECT * FROM TEST WHERE NUM = '100.45'; --오라클 조회됨 NUMBER VS 문자
SELECT * FROM TEST WHERE NUM = '100.45A'; --ORA-01722: invalid number
----------------------
INSERT INTO TEST (STR1, STR2) VALUES ('1234567890', '1234567890');
SELECT * FROM TEST WHERE STR1 = STR2;
SELECT '-' || STR1 || '-', '-' || STR2 || '-' FROM TEST;
------------------------------------------------
-- 날짜타입 DATE는 내부에 년월일시분초 데이터 저장
SELECT DATE1, TO_CHAR(DATE1, 'YYYY-MM-DD HH24:MI:SS') FROM TEST;
SELECT DATE1, TO_CHAR(DATE1, 'YYYY/MM/DD HH24:MI:SS') FROM TEST;
SELECT DATE1, TO_CHAR(DATE1, 'YYYY.MM.DD HH24:MI:SS') FROM TEST;
-----------------------
-- 한글데이터 처리(UTF-8) : ASCII 코드 1byte, 한글 1글자 3byte 사용
SELECT * FROM TEST;
INSERT INTO TEST (STR1, STR2) VALUES('ABCDEFGHIJ', 'ABCDEFGHIJ') ;
INSERT INTO TEST (STR1, STR2) VALUES('ABCDEFGHIJ', '홍길동'); --한글 3글자 * 3 = 9
INSERT INTO TEST (STR1, STR2) VALUES('ABCDEFGHIJ', '대한민국');--한글 4글자 * 3 = 12
----------------------------------------

/* ****** NULL(널)의 특성 *********
--NULL(널) : 데이터가 없는 상태
--NULL은 비교처리가 안됨 : =, <>, !=, >, <, >= , <= 비교처리 의미 없음
--NULL 과의 연산결과는 항상 NULL(연산 의미 없음)
--NULL 값에 대한 조회는 IS NULL, IS NOT NULL 키워드로 처리
*********************************/
SELECT * FROM TEST WHERE NUM = NULL; --조회안됨(NULL 비교연산 의미없음, 하지말것)
SELECT * FROM TEST WHERE NUM IS NULL; --비교연산 하지말고 IS NULL로 검색

SELECT * FROM TEST WHERE NUM <> NULL; --조회안됨
SELECT * FROM TEST WHERE NUM IS NOT NULL; -- IS NOT NULL 검색
--------------------------
-- NULL 과의 연산 결과 ->  NULL과의 연산결과는 항상 NULL
SELECT * FROM DUAL;  --DUAL 테입블 일명 DUMMY 테입블(오라클에서 제공)
SELECT 100 + 200, 111 + 222 FROM DUAL;
SELECT 100 + NULL, 100 - NULL, 100 * NULL, 100 / NULL FROM DUAL; --결과 NULL
SELECT * FROM TEST;
SELECT NUM, NUM + 100 FROM TEST; 
-------------------
-- 정렬시 NULL
SELECT * FROM TEST ORDER BY STR2; --기본 오름차순 정렬, ASC 키워드 생략가능
SELECT * FROM TEST ORDER BY STR2 DESC; --DESC : 내림차순 정렬

-- 정렬시 오라클에서는 NULL값을 가장 큰값으로 처리(맨 마지막 출력)
-- NULL 값 조회 순서 조정 : NULLS FIRST, NULLS LAST
SELECT * FROM TEST ORDER BY NUM; 
SELECT * FROM TEST ORDER BY NUM DESC; 
SELECT * FROM TEST ORDER BY NUM NULLS FIRST; --NULL값을 맨처음 선택
SELECT * FROM TEST ORDER BY NUM DESC NULLS LAST; -- NULL값을 마지막에 선택
--------------
--NULL 값 처리
SELECT NUM, NUM + 100 FROM TEST; 
-- NULL 처리 내장함수 NVL(컬럼, 설정값) : 컬럼값이 NULL이면 설정값으로 변환(대체)
SELECT NUM, NUM + 100, NVL(NUM, 0), NVL(NUM, 0) + 100 FROM TEST;
----------------------------------------
INSERT INTO TEST(NUM, STR1, STR2) VALUES (200, '', NULL);
SELECT * FROM TEST WHERE STR1 = ''; --데이터 조회안됨. '' -> NULL 처리됨(오라클)
SELECT STR1, STR1 || '-테스트', NVL(STR1, '내용없음') || '-테스트' FROM TEST;
--===================