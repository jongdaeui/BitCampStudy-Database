INSERT INTO MEMBER VALUES ('hong', '홍길동', 'hong1234', '010-1111-1111', 'hong@test.com');
INSERT INTO MEMBER VALUES ('kim', '김유신', 'kim1234', '010-2222-2222', 'kim@test.com');
INSERT INTO MEMBER VALUES ('kang', '강감찬', 'kang1234', '010-3333-3333', 'kang@test.com');
INSERT INTO MEMBER VALUES ('jong', '종대의', 'jong1234', '010-4444-4444', 'jong@test.com');
INSERT INTO MEMBER VALUES ('hiro', '히로', 'hiro1234', '010-5555-5555', 'hiro@test.com');

SELECT * FROM MEMBER;

INSERT INTO BOARD VALUES (0001, '제목1', '내용1', 'hong', SYSDATE);
INSERT INTO BOARD VALUES (0002, '제목2', '내용2', 'hong', SYSDATE);

SELECT * FROM BOARD;

UPDATE MEMBER SET PHONE = '010-2222-1234' WHERE ID = 'kim';
UPDATE MEMBER SET EMAIL = 'kim@mystudy.com' WHERE ID = 'kim';

SELECT * FROM MEMBER;  

DELETE FROM MEMBER WHERE ID = 'jong';
DELETE FROM MEMBER WHERE ID = 'hiro';

SELECT * FROM MEMBER;  

/*********************************
<MEMBER>
MEMBER_ID_PK	      Primary_Key	
MEMBER_NAME_NN        "NAME" IS NOT NULL
MEMBER_PASSWORD_NN    "PASSWORD" IS NOT NULL

<BOARD>
BOARD_BNO_PK	          Primary_Key	
BOARD_CONTENT_NN	     "CONTENT" IS NOT NULL
BOARD_ID_FK	Foreign_Key	
BOARD_ID_NN	             "ID" IS NOT NULL
BOARD_REGDATE_NN	     "REGDATE" IS NOT NULL
BOARD_TITLE_NN           "TITLE" IS NOT NULL
*******************************************/

CREATE INDEX MEMBER_IDX_NAME ON MEMBER (NAME);

CREATE OR REPLACE VIEW VIEW_MEMBER_BOARD
AS
SELECT M.ID, M.NAME, M.PHONE, M.EMAIL,
       B.BNO, B.TITLE, B.CONTENT, B.REGDATE
FROM MEMBER M, BOARD B
WHERE M.ID = B.ID(+)
;

SELECT * FROM VIEW_MEMBER_BOARD;

SELECT NAME, TITLE, REGDATE
FROM VIEW_MEMBER_BOARD
WHERE ID = 'hong'
ORDER BY REGDATE
;   