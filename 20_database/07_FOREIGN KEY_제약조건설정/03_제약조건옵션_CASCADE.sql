/* 제약조건 옵션
CASCADE : 부모테이블 (PARENT)의 제약조건을 비활성화 (삭제) 시키면서
        참조하고 있는 자여(CHILD) 테이블의 제약조건까지 비활성화
*****************************/

SELECT * FROM DEPT;
SELECT * FROM EMP01;

-- 부모테이블 데이터 삭제 - 다른 테이블에서 참고하고 있으면 삭제 불가
-- 방법1 : 자녀테이블 참조키 모두 삭제 또는 비활성화
--ORA-02292: integrity constraint (MADANG.SYS_C007060) violated - child record found
--DELETE FROM DEPT WHERE ID = 10;
ALTER TABLE EMP01 DISABLE CONSTRAINT SYS_C007060;
ALTER TABLE EMP02 DISABLE CONSTRAINT EMP02_DEPTNO_FK;
ALTER TABLE EMP03 DISABLE CONSTRAINT EMP03_DEPTNO_FK;

ALTER TABLE EMP01 ENABLE CONSTRAINT SYS_C007060;
ALTER TABLE EMP02 ENABLE CONSTRAINT EMP02_DEPTNO_FK;
ALTER TABLE EMP03 ENABLE CONSTRAINT EMP03_DEPTNO_FK;
-- 방법2 : DEPT 테이블의 PK를 비활성화 시키면서
---- 참조하고 있는 테이블 EMP01, EMP02, EMP03 함께 비활성화 처리
---- CASCADE 옵션 사용 : 부모테이블 PK + 자녀테이블 FK 동시에 비활성화 처리
ALTER TABLE DEPT DISABLE PRIMARY KEY CASCADE;
--DELETE FROM DEPT WHERE ID = 10;

--=====================================
/* 제약조건 옵션 : ON DELETE CASCADE
테이블간의 관계에서 부모테이블 데이터 삭제시
자녀테이블 데이터도 함께 삭제처리
**********************************/

CREATE TABLE C_TEST_MAIN (
    MAIN_PK NUMBER PRIMARY KEY,
    MAIN_DATA VARCHAR2(30)
);
CREATE TABLE C_TEST_SUB (
    SUB_PK NUMBER PRIMARY KEY,
    SUB_DATA VARCHAR2(30),
    SUB_FK NUMBER,
    CONSTRAINT C_TEST_SUB_FK FOREIGN KEY (SUB_FK)
    REFERENCES C_TEST_MAIN (MAIN_PK) ON DELETE CASCADE
);
----
INSERT INTO C_TEST_MAIN VALUES (1111, '1번 메인 데이터');
INSERT INTO C_TEST_MAIN VALUES (2222, '2번 메인 데이터');
INSERT INTO C_TEST_MAIN VALUES (3333, '3번 메인 데이터');
COMMIT;
INSERT INTO C_TEST_SUB VALUES (1, '1번 서브 데이터', 1111);
INSERT INTO C_TEST_SUB VALUES (2, '2번 서브 데이터', 2222);
INSERT INTO C_TEST_SUB VALUES (3, '3번 서브 데이터', 3333);
INSERT INTO C_TEST_SUB VALUES (4, '4번 서브 데이터', 3333);
COMMIT;
SELECT * FROM C_TEST_MAIN;
SELECT * FROM C_TEST_SUB;
-- 메인테이블 데이터 삭제
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 1111;
SELECT * FROM C_TEST_MAIN;
SELECT * FROM C_TEST_SUB;
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 3333;

--==============================================================
-- 테이블 삭제 : 부모-자녀 관계 설정된 부모테이블 삭제
DROP TABLE C_TEST_MAIN;--ORA-02449: unique/primary keys in table referenced by foreign keys

-- 방법 1 : 서브테이블 모두 삭제하고 부모테이블 삭제
DROP TABLE C_TEST_SUB;
DROP TABLE C_TEST_MAIN;

-- 방법 2 : 서브테이블에 있는 FK 설정을 모두 삭제 후 부모 테이블 삭제
---- FK 비활성화 (DISABLE) 설정으로는 불가함
ALTER TABLE C_TEST_SUB DROP CONSTRAINT C_TEST_SUB_FK;
DROP TABLE C_TEST_MAIN; 

-- 방법 3 : 부모테이블 삭제시 CASCADE CONTRAINT 옵션 사용
---- 서브테이블의 제약조건 (FK) 삭제 후 부모테이블 (MAIN) 삭제처리
DROP TABLE C_TEST_MAIN CASCADE CONSTRAINTS;