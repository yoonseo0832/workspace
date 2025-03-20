-- * JDBC 용 계정 : C##JDBC / JDBC  ---> 관리자 계정으로 실행

CREATE USER C##JDBC IDENTIFIED BY JDBC; -- * 계정 생성
GRANT CONNECT, RESOURCE TO C##JDBC;     -- * 권한 부여
ALTER USER C##JDBC QUOTA UNLIMITED ON USERS;    -- * 테이블 스페이스 설정

--------------------------------------------
---> C##JDBC 계정으로 실행
-- 회원 정보를 저장할 테이블 (MEMBER)
DROP TABLE MEMBER;
CREATE TABLE MEMBER (
    MEMBERNO NUMBER PRIMARY KEY,                -- 회원 번호
    MEMBERID VARCHAR2(20) NOT NULL UNIQUE,      -- 회원 아이디
    MEMBERPW VARCHAR2(20) NOT NULL,             -- 회원 비밀번호
    GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')), -- 성별 ('M', 'F')
    AGE NUMBER,                                 -- 나이
    EMAIL VARCHAR2(30),                         -- 이메일
    ADDRESS VARCHAR2(100),                      -- 주소
    PHONE VARCHAR2(13),                         -- 연락처 (XXX-XXXX-XXXX)
    HOBBY VARCHAR2(50),                         -- 취미
    ENROLLDATE DATE DEFAULT SYSDATE NOT NULL    -- 가입일
);

-- 회원 번호에 사용할 시퀀스 객체 생성
DROP SEQUENCE SEQ_MNO;
CREATE SEQUENCE SEQ_MNO
NOCACHE;

-- 샘플데이터 추가 (2개)
INSERT INTO MEMBER
    VALUES (SEQ_MNO.NEXTVAL, 'admin', '1234', 'M', 20, 'admin@kh.or.kr', '서울', '010-0000-0000', NULL, '2020/03/12');
INSERT INTO MEMBER
    VALUES (SEQ_MNO.NEXTVAL, 'sjlim', '1234', 'F', 20, 'sjlim@kh.or.kr', NULL, '010-0000-0000', NULL, DEFAULT);

COMMIT;
--------------------------------------------------------------------------------

-- 테스트용 테이블 (TEST)
CREATE TABLE TEST (
    TNO NUMBER,
    TNAME VARCHAR2(30),
    TDATE DATE
);

INSERT INTO TEST VALUES (1, '홍길동', SYSDATE);

COMMIT;

--------------------------------------------------------------------------------