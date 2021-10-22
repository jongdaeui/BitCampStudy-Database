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
    - 외래키(foreign key): 부모  테이블의 값을 참조하는 자식테이블의 칼럼
    - 부모 테이블 : 다른 테이블에 의해 참조되는 테이블
    - 참조키(reference) : 자식 테이블에서 참조하는 부모 테이블의 칼럼
    
 /* 제약조건 옵션
CASCADE : 부모테이블(parent)의 제약조건을 비활성화(삭제) 시키면서
    참조하고 있는 자녀(chile) 테이블의 제약조건까지 비활성화(삭제)
   
************************************************/
-- 테이블 생성시 제약조건 설정
-- 컬럼을 정의하면서 컬럼레벨에서 제약조건 지정
--- 외래키 (FOREIGN KEY) 지정으로 관계설정
--- 형태 : 컬럼정의 REFERENCES 대상 테이블 (대상 컬럼)
SELECT * FROM DEPT;
-- 컬럼레벨에서 제약 조건 (외래키) 설정
CREATE TABLE EMP01(
    EMPNO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10) REFERENCES DEPT (ID) -- 외래키 설정 (컬럼레벨)
);
SELECT * FROM EMP01;
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');  -- 입력 성공
COMMIT;
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', '40'); -- 입력 실패 (PARENT KEY NOT FOUND) DEPT 테이블에 없는 데이터 '40'

--===========================
-- 테이블 레벨에서 제약조건 지정
CREATE TABLE EMP02(
    EMPNO NUMBER,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    PRIMARY KEY (EMPNO), -- 기본키 설정 (PRIMARY KEY) 설정
    FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID) -- 외래키 (FOREIGN KEY) 설정
);
SELECT * FROM EMP01;

INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');  -- 입력 성공
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', '40'); -- 입력 실패 (PARENT KEY NOT FOUND) DEPT 테이블에 없는 데이터 '40'
COMMIT;

--========================================
-- 제약조건명을 명시적으로 선언해서 사용
-- 형태 : CONSTRAINT 제약조건명 적용
CREATE TABLE EMP03(
    EMPNO NUMBER,
    ENAME VARCHAR2(30) CONSTRAINT EMP03_ENAME_NN NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
   CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY (EMPNO), -- 기본키 설정 (PRIMARY KEY) 설정
   CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID) -- 외래키 (FOREIGN KEY) 설정
);
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');  -- 입력 성공
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', '40'); -- 입력 실패 (PARENT KEY NOT FOUND) DEPT 테이블에 없는 데이터 '40'

--================================================== 
/* *** 테이블에 제약조건 추가,  삭제 *****
-- 제약조건 추가
ALTER TABLE 테이블 명 ADD CONSTRAINT 제약조건명 적용할 제약조건(형태);
-- 제약조건 삭제
ALTER TABLE 테이블 명 DROP CONSTRAINT 제약조건명;
*************************************/
-- EMP01 테이블의 PRIMARY KEY 삭제 : SYS_C007059
ALTER TABLE EMP01 DROP CONSTRAINT SYS_C007059;

-- EMP01 테이블의 PRIMARY KEY 추가
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);
---------------------
-- PK 설정 상태 - 동일데이터 입력 (중복되는 데이터)
SELECT * FROM EMP01;
INSERT INTO EMP01 VALUES (1111, '홍길동2', '직무1', '10'); -- ORA-00001: unique constraint (MADANG.EMP01_EMPNO_PK) violated

ALTER TABLE EMP01 DROP CONSTRAINT EMP01_EMPNO_PK;

-- PK 삭제 후
SELECT * FROM EMP01;
INSERT INTO EMP01 VALUES (1111, '홍길동2', '직무1', '10'); 
COMMIT;

-----------------------------------------------------------
-- 제약 조건 설정시 데이터 상태에 따라 적용 여부 결정
-- 중복된 데이터가 들어있는 상태에서 PRIMARY KEY, UNIQUE 설정 안됨
-- NOT NULL 설정하려는 컬럼에 NULL 데이터가 하나라도 있으면 안됨
-- NULL데이터를 제거하거나 중복데이터를 UNIQUE 하게 수정해야 함
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);
--ORA-02437: cannot validate (MADANG.EMP01_EMPNO_PK) - primary key violated

-- (실습) EMP02 외래키 (FOREIGN KEY) 이름 변경 처리
ALTER TABLE EMP02 DROP CONSTRAINT SYS_C007061;
ALTER TABLE EMP02 ADD CONSTRAINT EMP02_ENAME_NN NOT NULL (ENAME);

ALTER TABLE EMP02 DROP CONSTRAINT SYS_C007062;
ALTER TABLE EMP02 ADD CONSTRAINT EMP02_EMPNO_PK PRIMARY KEY (EMPNO);

ALTER TABLE EMP02 DROP CONSTRAINT SYS_C007063;
ALTER TABLE EMP02 ADD CONSTRAINT EMP02_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID);

--------------------------------------------------------------
-- 제약조건 활성화 / 비활성화
-- 제약조건 설정되어 있는 것을 적용 또는 적용해제
-- ALTER TABLE 테이블명 DISABLE CONSTRAINT 제약이름;
-- ALTER TABLE 테이블명 ENABLE CONTSTRAINT 제약이름;

--==========================================================
-- 데이터사전 테이블 :
SELECT * FROM user_cons_columns;
SELECT * FROM USER_CONSTRAINTS;

SELECT A.OWNER, A.TABLE_NAME, A.COLUMN_NAME, A.CONSTRAINT_NAME,
        B.CONSTRAINT_TYPE,
        DECODE (B.CONSTRAINT_TYPE,
            'P', 'PRIMARY KEY',
            'U', 'UNIQUE',
            'C', 'CHECK OR NOT NULL',
            'R', 'FOREIGN KEY') CONSTRAINT_TYPE_DESC
    FROM USER_CONS_COLUMNS A, USER_CONSTRAINTS B
    WHERE A.TABLE_NAME = B.TABLE_NAME
    AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME
;