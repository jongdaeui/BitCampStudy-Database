/* ********* 역할(롤 ROLE) ***********
역할(롤, ROLE) : DB 객체 및 시스템에 대한 권한을 모아둔 집합을 의미
역할 생성 : CREATE ROLE 역할이름
역할 제거 : DROP ROLE 역할이름
역할에 권한 부여 : GRANT 권한 [ON 객체] TO 역할이름
역할의 권한 회수 : REVOKE 권한 [ON 객체] FROM 역할이름
사용자에게 역할 부여 : GRANT 역할이름 TO 사용자

<역할 생성부터 사용자 추가까지의 단계>
CREATE ROLE - 역할생성
GRANT - 만들어진 역할에 권한 부여
GRANT - 사용자에게 역할 부여
-->>역할 제거할 경우 반대로 수행
DROP ROLE - 역할 삭제(사용자에게 부여된 역할에 대한 권한 역시 제거됨)
***************************************/
-- 사용자 계정에서 검색 역할 (롤) 조회
SELECT * FROM USER_ROLE_PRIVS;

-- (DBA 계정 - SYSTEM) CONNECT, RESOURCE 롤에 대한 권한 확인
SELECT* FROM DBA_SYS_PRIVS
WHERE GRANTEE IN ('CONNECT', 'RESOURCE')
ORDER BY GRANTEE, PRIVILEGE
;
-- (SYSTEM) 롤(ROLE) 생성 : PROGRAMMER (개발자) 라는 역할 (롤,ROLE) 생성
CREATE ROLE PROGRAMMER;
-- (SYSTEM) PROGRAMMER 롤에 (역할)에 테이블, 뷰(VIEW) 생성 권한 담기
GRANT CREATE ANY TABLE, CREATE ANY VIEW TO PROGRAMMER;
--========================================
-- (SYSTEM) MDGUEST 유저에게 PROGRAMMER 롤 (ROLE) 부여
CREATE USER MDGUEST IDENTIFIED BY mdguest
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;
-- (SYSTEM) MDGUEST 유저에게 권한 부여
GRANT CONNECT, RESOURCE TO MDGUEST;
---------------------------------
-- (SYSTEM) MDGUEST에게 PROGRAMMER 롤 부여
GRANT PROGRAMMER TO MDGUEST;
-- (MDGUEST) 테이블 생성 권한 사용
CREATE TABLE MADANG.AAA (TEST VARCHAR2(30)); -- OK
CREATE TABLE MADANG.BBB (BBB NUMBER); -- OK
SELECT * FROM MADANG.AAA; --ORA-01031: insufficient privileges 01031. 00000 -  "insufficient privileges"

-- (SYSTEM) 롤(권한) 회수
REVOKE PROGRAMMER FROM MDGUEST; -- 부여된 롤 취소

-- (SYSTEM) 롤 삭제
DROP ROLE PROGRAMMER;


