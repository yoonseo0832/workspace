-------C##INDEXTEST 계정 생성 후 아래 스크립트 실행
CREATE USER C##INDEXTEST IDENTIFIED BY INDEXTEST;
GRANT CONNECT, RESOURCE TO C##INDEXTEST;

ALTER USER C##INDEXTEST QUOTA 100M ON USERS;


-- JDBC용_계정 생성 : C##JDBC | JDBC
CREATE USER C##JDBC IDENTIFIED BY JDBC; -- 계정생성
GRANT CONNECT, RESOURCE TO C##JDBC;     -- 권한부여

ALTER USER C##JDBC QUOTA UNLIMITED ON USERS;    -- 테이블 스페이스 설정

-------------------------------------
-- 회원정보를 저장할 테이블 (MEMBER)
DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEMBERNO NUMBER PRIMARY KEY,            -- 회원번호
    MEMBERID VARCHAR2(20) NOT NULL UNIQUE,  -- 회원 아이디
    MEMBERPW VARCHAR2(20) NOT NULL,         -- 회원 비번
    GENDER CHAR(1) CHECK (GENDER IN ('M', 'F')), -- 성별 ('M', 'F')
    AGE NUMBER,                             -- 나이
    EMAIL VARCHAR2(30),                     -- 이메일
    ADDRESS VARCHAR2(100),                  -- 주소
    PHONE VARCHAR2(13),                     -- 연락처(000-0000-0000)
    HOBBY VARCHAR2(50),                     -- 취미
    ENROLLDATE DATE DEFAULT SYSDATE NOT NULL-- 가입일    
);

-- 시퀀스 생성 회원 번호에 사용할 객체 생성 (DROP으로 있는지 여부 확인후 없으면 생성)
DROP SEQUENCE SEQ_MNO;
CREATE SEQUENCE SEQ_MNO
NOCACHE;

-- 샘플 데이터 추가 (2개)
INSERT INTO MEMBER VALUES(SEQ_MNO.NEXTVAL, 'admin', '1234', 'M', 23, 'admin@kh.or.kr', '서울', '010-1234-1234', NULL, '2020/03/12');
INSERT INTO MEMBER VALUES(SEQ_MNO.NEXTVAL, 'yoon', '1235', 'F', 22, 'yoon@kh.or.kr', '경기', '010-4541-6666', '게임하기', DEFAULT);
COMMIT;
----------------------------------------------------------------------------------
-- 테스트용 테이블 (TEST)
CREATE TABLE TEST(
    TNO NUMBER,
    TNAME VARCHAR2(30),
    TDATE DATE
);
INSERT INTO TEST VALUES(1, '홍길동', SYSDATE);
COMMIT;

SELECT * FROM TEST; -- java에서 추가한 데이터가 sql에 추가됨 -
---------------------------------------------------------------------------------
INSERT INTO MEMBER VALUES(SEQ_MNO.NEXTVAL, '회원아이디', '회원비밀번호', '성별', 나이, '이메일', '주소', '연락처', '취미', SYSDATE);

INSERT INTO MEMBER VALUES(SEQ_MNO.NEXTVAL, tony23', tony'회원비밀번호', F'성별', 23나이, null'이메일', null'주소', null'연락처', null'취미', SYSDATE)

SELECT * FROM MEMBER;