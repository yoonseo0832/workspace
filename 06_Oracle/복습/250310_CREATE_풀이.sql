/*
    빈칸에 적절한 단어를 작성하시오.
    (DDL) : CREATE, ALTER, DROP
        - 데이터 정의 언어 : 구조를 정의. 객체 생성/수정/제거
    
    (DML) : INSERT, DELETE, UPDATE
        - 데이터 조작 언어 : 데이터를 추가/삭제/수정
    
    (DQL) : SELECT
        - 데이터 질의 언어 : 데이터를 조회
*/

/*
-- 다음 사용자 계정 접속 후 아래 내용을 작성해주세요.
-- ID/PW  :  TEST250305 / test0305
    * 사용자 계정 추가(생성)
        CREATE USER C##TEST250305 IDENTIFIED BY test0305;
        
    * 최소한의 권한 부여 (CONNECT, RESOURCE)
        GRANT CONNECT, RESOURCE TO C##TEST250305;

-- 아래 내용을 추가하기 위한 테이블을 생성해주세요.
-- 각 컬럼별 설명을 추가해주세요.
-- 샘플 데이터를 추가하기 위한 삽입 쿼리문을 작성해주세요. --> INSERT
--  ex) 제목: 삼국지, 저자: 지연, 출판일: 14/02/14, ISBN : 9780394502946
------------------------------------------------------------
*/
/*
	- 도서 정보 테이블 : BOOK
	- 제약 조건
	  - 제목과 저자명은 NULL값을 허용하지 않는다.  --> NOT NULL
	  - ISBN 번호는 중복을 허용하지 않는다.       --> UNIQUE
	- 저장 데이터
	  + 도서 번호 ex) 1, 2, 3, ...             --> PK(기본키)
	  + 제목 ex) '삼국지', '어린왕자', '코스모스', ...
	  + 저자 ex) '지연', '생텍쥐페리', '칼 세이건', ...
	  + 출판일 ex) '14/02/14', '22/09/19', ...
	  + ISBN번호 ex) '9780394502946', '978-0152048044', ...
*/
-- 테이블 --> 데이터베이스 객체 중 하나
CREATE TABLE BOOK (
    BK_NO NUMBER PRIMARY KEY, -- 도서번호
    BK_TITLE VARCHAR2(200) NOT NULL, -- 제목
    BK_AUTHOR VARCHAR2(200) NOT NULL, -- 저자
    PUB_DATE DATE,  -- 출판일
    ISBN VARCHAR2(20) CONSTRAINT ISBN_UQ UNIQUE -- ISBN
);
-- 컬럼에 대한 설명 추가
COMMENT ON COLUMN BOOK.BK_NO IS '도서번호';
COMMENT ON COLUMN BOOK.BK_TITLE IS '도서명';
COMMENT ON COLUMN BOOK.BK_AUTHOR IS '저자명';
COMMENT ON COLUMN BOOK.PUB_DATE IS '출판일';
COMMENT ON COLUMN BOOK.ISBN IS 'ISBN';
-- 샘플 데이터 추가 --> INSERT (DML)
INSERT INTO BOOK VALUES (1, '삼국지', '지연', '14/02/14', '9780394502946');

-- 기본키 제약조건 확인
INSERT INTO BOOK VALUES (NULL, '삼국지', '지연', '14/02/14', '9780394502946');
--  * NOT NULL 체크
INSERT INTO BOOK VALUES (1, '삼국지', '지연', '14/02/14', '9780394502946');
--  * UNIQUE 체크

-- NOT NULL 제약조건 확인 (제목, 저자)
INSERT INTO BOOK VALUES (2, NULL, '지연', '14/02/14', '9780394502946');
INSERT INTO BOOK (BK_NO, BK_AUTHOR, PUB_DATE, ISBN)
        VALUES (2, '지연', '14/02/14', '9780394502946');
        --> 제목(BK_TITLE)에 대한 컬럼을 지정하지 않으면, NULL값이 저장됨!
INSERT INTO BOOK VALUES (2, '삼국지', NULL, '14/02/14', '9780394502946');        

-- UNIQUE 제약조건 확인 (ISBN)
INSERT INTO BOOK VALUES (2, '어린왕자', '생텍쥐베리', '22/09/19', '9780394502946');
--> 이미 저장되어 있는 ISBN번호는 추가할 수 없음!

-- 데이터 조회 (DQL)
SELECT * FROM BOOK;

------------------------------------------------------------





