/*
    DDL : 데이터 정의 언어
    
    오라클에서 제공하는 객체를 새로 만들고 (CREATE)
                            변경하고   (ALTER)
                            삭제       (DROP) 하는 언어
    ==> 실제 데이터가 아닌 규칙/구조를 정의하는 언어
    
    * 오라클에서의 객체(구조) : 테이블, 뷰, 시퀀스, 인덱스, 패키지, 트리거,
                            프로시저, 함수, 동의어, 사용자....
*/

/*
    CREATE : 객체를 새로 생성하는 구문/명령어
    [테이블 생성] 
        - 테이블 : 행과 열로 구성되는 가장 기본적인 데이터베이스의 객체
                    모든 데이터들을 테이블을 통해 저장
        - 표현법
            CREATE TABLE 테이블명(
                컬럼명 자료형(크기), 
                컬럼명 자료형,
                컬럼명 자료형, 
                컬럼명 자료형, ...
            );
        - 자료형 종류
            -문자 => 반드시 크기 지정해야함     
                + CHAR(바이트 단위로 크기 지정) -- 고정길이 [고정된 길이의 데이터 담는 경우]
                    -> 지정 길이보다 작은 길이 값 저장하면 나머지 고정된 길이는 공백으로 채워짐 ==> 최대 2000바이트까지 지정가능
                + VARCHAR2(바이트 단위로 크기 지정) -- 가변길이 [데이터 길이 지정 안된 경우]
                    -> 저장된 길이만큼 공간 사용                                           ==> 최대 4000바이트까지 지정가능
            -날짜     : DATE
*/
-- 회원 정보를 저장할 테이블 생성
-- 테이블명 : MEMBER 
/*
    컬럼 정보
    - 회원번호          숫자 : NUMBER 
    - 회원 아이디       문자 : VARCHAR2(20)
    - 회원 비밀번호     문자 : VARCHAR2(20)
    - 회원 이름         문자: VARCHAR2(20)
    - 성별            문자: '남'/'여' CHAR(3) --한글은 3바이트
    - 연락처          문자: '010-XXXX-XXXX CHAR(13) -- 숫자/영문는 1바이트
    - 이메일           문자 : VARCHAR(50)
    - 가입일           날짜 ; DATE
*/
CREATE TABLE MEMBER( -- 컬럼명 데이터타입
    MEM_NO NUMBER, 
    MEM_ID VARCHAR(20), 
    MEM_PWD VARCHAR(20), 
    MEM_NAME VARCHAR(20),
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR(50),
    ENROLLDATE DATE
);
SELECT * FROM MEMBER;

/*
    컬럼에 설명 추가하기
    [표현법]
        COMMEMT ON COLUMN 테이블명.컬러명 IS '설명';
    => 잘못 작성하면 다시 작성해 덮어쓰기 가능
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.GENDER IS '성별';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.ENROLLDATE IS '가입일';

-- 테이블 삭제하기 : DROP TABLE 테이블명;
DROP TABLE MEMBER;

-- 테이블에 데이터 추가하기 : INSERT INTO 테이블명 VALUES(값, 값, 값, ....);
INSERT INTO MEMBER VALUES(1, 'yoonseo', 1234, '이윤서', '여', '010-1234-1234', 'yoonseo@gmail.com', SYSDATE);
SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(2, 'DNA', 123423, '진', '남', NULL, NULL, SYSDATE);
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL );

COMMIT; -- > 변경사항 적용
--------------------------------------------------------------------------------
/*
    제약 조건 : 원하는 데이터 값만 유지하기 위해서 특정 컬럼에 설정하는 제약
                데이터 무결성을 보장하기 위한 목적
        - 설정 방식 컬럼레벨방식 / 테이블레벨방식 
        - 종류: NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/
/*
    NOT NULL
    : 해당 컬럼에 반드시 값이 존재해야 하는 경우
    => 절대 NULL 값이 저장되면 안됨
    * 데이터 추가/삽입/수정 시 NULL값 허용 안함
    - 컬럼 레벨 방식으로만 설정 가능
*/
-- NOT NULL 제약 조건 추가한 회원 테이블
-- 테이블명 : MEMBER_NOTNULL
--단,  데이터 NULL값 허용 안함
CREATE TABLE MEMBER_NOTNULL(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR(20) NOT NULL, 
    MEM_PWD VARCHAR(20) NOT NULL, 
    MEM_NAME VARCHAR(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR(50),
    ENROLLDATE DATE
);
SELECT * FROM MEMBER_NOTNULL;
INSERT INTO  MEMBER_NOTNULL VALUES(1, 'KING', 12345, '김나나', '여', '010-1234-5784', 'KINGFD@NACE.COM', SYSDATE);
INSERT INTO  MEMBER_NOTNULL VALUES(2, 'MYDAY', 0257, '마이민', NULL, NULL, NULL, NULL);
INSERT INTO  MEMBER_NOTNULL VALUES(3, NULL, 0257, '마이민', NULL, NULL, NULL, NULL);
-- > 제약조건으로 인해 회원아이디가 NULL이라서 오류 발생!, 제약조건에 위배됨
INSERT INTO  MEMBER_NOTNULL VALUES(1, 'KING', 12345, '김나나', '여', '010-1234-5784', 'KINGFD@NACE.COM', SYSDATE);
--> 중복되는 데이터가 있는데도 추가됨, 제약 조건으로 막아보자
-------------------------------------------------------------------------------\
/*
    UNIQUE : 해당 컬럼에 중복된 값이 있을 경우 제한하는 제약임
    => 데이터 추가/삽입/수정 기존에 있는 데이터 값이 중복 시 오류 발생
*/
-- UNIQUE 제약조건 추가한 테이블 추가
CREATE TABLE MEMBER_UNIQUE(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR(20) NOT NULL UNIQUE, -- NOT NULL과 UNIQUE 컬럼레벨방식으로 설정
    MEM_PWD VARCHAR(20) NOT NULL, 
    MEM_NAME VARCHAR(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR(50),
    ENROLLDATE DATE
    --, UNIQUE(MEM_ID) -- 테이블 레벨 방식 방법
);
INSERT INTO  MEMBER_UNIQUE VALUES(1, 'KING', 12345, '김나나', '여', '010-1234-5784', 'KINGFD@NACE.COM', SYSDATE);
INSERT INTO MEMBER_UNIQUE VALUES(1, 'yoonseo', 1234, '이윤서', '여', '010-1234-1234', 'yoonseo@gmail.com', SYSDATE);
INSERT INTO MEMBER_UNIQUE VALUES(2, 'yoonseo', 3232, '윤나나', '여', '010-5468-7485', 'FDGF@gmail.com', SYSDATE);
-- 오류 내용에서 제약조건명으로 알려줨     => ORA-00001: 무결성 제약 조건(C##KH.SYS_C008422)에 위배됩니다
--> 제약조건 설정 시 제약조건명 지정하지 않으면 => 시스템이 자동으로 만듬
/*
    제약 조건명 설정하기 
    1. 컬럼 레벨 방식
        CREATE TABLE 테이블명 (
            컬럼명 자료형 [ CONSTRAINT 제약조건명 ] 제약조건
        );
    2. 테이블 레벨 방식
        CREATE TABLE 테이블명 (
            컬럼명 자료형,
            컬럼명 자료형,
            컬럼명 자료형,
            컬럼명 자료형,
            ....
            [ CONSTRAINT 제약조건명 ] 제약조건 컬럼명
        );
*/
-- MEMBER_UNIQUE 테이블 삭제
DROP TABLE MEMBER_UNIQUE;
-- 제약조건명을 설정해 다시 생성
CREATE TABLE MEMBER_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL, 
    MEM_ID VARCHAR(20) CONSTRAINT MEMID_NT NOT NULL,
    MEM_PWD VARCHAR(20) CONSTRAINT MEMPWD_NT NOT NULL, 
    MEM_NAME VARCHAR(20) CONSTRAINT MEMNAME_NT NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR(50),
    ENROLLDATE DATE
    ,CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) -- 테이블 레벨 방식 방법
);

INSERT INTO  MEMBER_UNIQUE VALUES(1, 'KING', 12345, '김나나', '여', '010-1234-5784', 'KINGFD@NACE.COM', SYSDATE);
INSERT INTO MEMBER_UNIQUE VALUES(1, 'yoonseo', 1234, '이윤서', '여', '010-1234-1234', 'yoonseo@gmail.com', SYSDATE);
INSERT INTO MEMBER_UNIQUE VALUES(2, 'yoonseo', 3232, '윤나나', '여', '010-5468-7485', 'FDGF@gmail.com', SYSDATE);
--ORA-00001: 무결성 제약 조건(C##KH.MEMID_UQ)에 위배됩니다
INSERT INTO MEMBER_UNIQUE VALUES(3, NULL, NULL, NULL, NULL, NULL,NULL,NULL );

/*
    CHECK (조건식)
        : 해당 컬럼에 저장할 수 있는 값에 대한 조건을 제시
            조건에 만족하는 값만을 저장할 수 있음
            => 정해진 값만을 저장할때 사용
*/
-- CHECK 제약 조건을 추가한 테이블 생성
-- 테이블명 : MEMBER_CHECK
CREATE TABLE MEMBER_CHECK(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR(20) NOT NULL,
    MEM_PWD VARCHAR(20) NOT NULL, 
    MEM_NAME VARCHAR(20)  NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR(50),
    ENROLLDATE DATE
    --,UNIQUE(MEM_ID) -- 테이블 레벨 방식 방법
    --,CHECK(GENDER IN ('남', '여')) -- 테이블 레벨 방식 방법
);
SELECT * FROM MEMBER_CHECK;
INSERT INTO  MEMBER_CHECK VALUES(1, 'JOYKING', 890809, '조이킹', '여',NULL, NULL, SYSDATE);
INSERT INTO  MEMBER_CHECK VALUES(2, 'HAPPNIESS', 12458, '해피니스', 'RRR',NULL, NULL, SYSDATE);
INSERT INTO  MEMBER_CHECK VALUES(2, 'HAPPNIESS', 12458, '해피니스', NULL,NULL, NULL, SYSDATE);
-- NULL 값 불가하고 싶으면 NOT NULL 제약조건을 추가하면 된다

/*
    PRIMARY KEY 기본키 (NOT NULL + UNIQUE)
    : 테이블에서 각 행을 식병하기 위해 사용되는 컬럼에 부여하는 제약조건
    - 테이블 당 오직 한개만 설정 가능
*/
CREATE TABLE MEMBER_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, 
    MEM_ID VARCHAR(20) NOT NULL,
    MEM_PWD VARCHAR(20) NOT NULL, 
    MEM_NAME VARCHAR(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR(50),
    ENROLLDATE DATE
);

INSERT INTO MEMBER_PRI VALUES(1, 'JOYKING', 890809, '조이킹', NULL ,NULL, NULL, SYSDATE);
INSERT INTO  MEMBER_PRI VALUES(1, 'HAPPNIESS', 12458, '해피니스', NULL,NULL, NULL, SYSDATE);
-- 회원번호 컬럼에 중복된 값이 저장되려고 해서 오류 발생
--ORA-00001: 무결성 제약 조건(C##KH.MEMNO_PK)에 위배됩니다
--------------------------------------------------------------------------------------------
-- 두개의 컬럼으로 기본키를 설정하여 테이블 생성
-- 테이블명 ㅣ MEMBER_PRI2
-- 회원번호/아이디 기본키로 설정
CREATE TABLE MEMBER_PRI2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR(20) NOT NULL,
    MEM_PWD VARCHAR(20) NOT NULL, 
    MEM_NAME VARCHAR(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR(50),
    ENROLLDATE DATE
    , CONSTRAINT MEMNO_PK2 PRIMARY KEY(MEM_NO, MEM_ID)
);
INSERT INTO MEMBER_PRI VALUES(1, 'APPLE', 1234, '애플', NULL ,NULL, NULL, SYSDATE);
INSERT INTO  MEMBER_PRI VALUES(1, 'HAPPNIESS', 12458, '해피니스', NULL,NULL, NULL, SYSDATE);

---------------------------------------------------------------------------------
/*
    FOREGIN KEY : 외래키
    : 다른 테이블에서 존재하는 값을 저장하고자 할때 사용
    -> 다른 테이블을 참조 표현
    -> 주로 외래키를 통해 테이블간 관계 형성
    - 컬럼레벨 방식
        컬럼명 자료형 REFERENCES 참조할테이블명 (참조할 컬럼명)<-- 생략 가능
    - 테이블레벨 방식
        FOREGIN KEY (컬럼명) REFERENCES 참조할테이블명 (참조할 컬럼명)
    => 참조할 컬럼명 생략시 참조하는 테이블의 기본키 컬럼이 매칭
*/
-- 회원등급 정보 저장테이블
CREATE TABLE MEMBER_GRADE(
    GRADE_NO NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);
SELECT * FROM MEMBER_GRADE;
INSERT INTO MEMBER_GRADE VALUES(100, '일반회원');
INSERT INTO MEMBER_GRADE VALUES(200, 'VIP회원');
INSERT INTO MEMBER_GRADE VALUES(300, 'VVIP회원');

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR(20)  NOT NULL, 
    MEM_NAME VARCHAR(20)  NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남', '여')),
    ENROLLDATE DATE,
    -- 컬럼 레벨 방식
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO)
    -- 테이블 레벨 방식
    --FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_NO)
);

INSERT INTO MEMBER VALUES (1, 'YOONSEO', 1245435, '윤서', '여',SYSDATE ,100);
INSERT INTO MEMBER VALUES (2, 'YOOSANG', 2356573, '유상', '남',SYSDATE ,200);
INSERT INTO MEMBER VALUES (3, 'TAEHYUN', 2354222, '태현', '남',SYSDATE ,NULL);
INSERT INTO MEMBER VALUES (4, 'IU', 123564, '아이유', '여',SYSDATE ,400);
--ORA-02291: 무결성 제약조건(C##KH.SYS_C008457)이 위배되었습니다- 부모 키가 없습니다

--> 부모테이블에서 일반회우너 등급을 삭제한다면 
--> 데이터 삭제 DELETE FROM 테이블명 WHERE 조건;
-- 등급 테이블에서 등급번호 100인 데이터 삭제
DELETE FROM MEMBER_GRADE WHERE GRADE_NO =100; -- 자식 테이블인 MEMBER테이블이 100이라는 값을 사용중이라 삭제 불가
--ORA-02292: 무결성 제약조건(C##KH.SYS_C008457)이 위배되었습니다- 자식 레코드가 발견되었습니다
DELETE FROM MEMBER_GRADE WHERE GRADE_NO =300; 
-- 자식테이블에서 이미 사용하고 있는 값이 있을 경우 -> 부모 테이블로부터 무조건 삭제되지 않는 "삭제옵션"
ROLLBACK;  -- 변경사항을 취소하는 것
------------------------------------------------------------------------------
/*
    외래키 제약 조건 - 삭제 옵션
    : 부모테이블의 데이터 삭제 시 해당 데이터를 사용하고 있는 자식테이블의 값을 어떻게 할 것인지의 옵션
    
    - ON DELETE RESTRICTED : (기본값) 자식테이블에서 데이터 사용 시 부모테이블에서 삭제 불가
    - ON DELETE SET NULL   : 부모테이블에 있는 데이터 삭제 시 -> 해당 데이터 사용하는 자식 테이블 값을 NULL로 변경
    - ON DELETE CASCADE    : 부모테이블에 있는 데이터 삭제 시 -> 해당 데이터 사용하는 자식 테이블 값 삭제

*/
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR(20)  NOT NULL, 
    MEM_NAME VARCHAR(20)  NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남', '여')),
    ENROLLDATE DATE,
    -- 컬럼 레벨 방식
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL
    -- 테이블 레벨 방식
    --FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_NO)
);

INSERT INTO MEMBER VALUES (1, 'YOONSEO', 1245435, '윤서', '여',SYSDATE ,100);
INSERT INTO MEMBER VALUES (2, 'YOOSANG', 2356573, '유상', '남',SYSDATE ,200);

DELETE FROM MEMBER_GRADE WHERE GRADE_NO =100;
SELECT * FROM MEMBER;
ROLLBACK;

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR(20)  NOT NULL, 
    MEM_NAME VARCHAR(20)  NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남', '여')),
    ENROLLDATE DATE,
    -- 컬럼 레벨 방식
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE
    -- 테이블 레벨 방식
    --FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_NO)
);

INSERT INTO MEMBER VALUES (1, 'YOONSEO', 1245435, '윤서', '여',SYSDATE ,100);
INSERT INTO MEMBER VALUES (2, 'YOOSANG', 2356573, '유상', '남',SYSDATE ,200);
INSERT INTO MEMBER VALUES (3, 'TAEHYUN', 2354222, '태현', '남',SYSDATE ,NULL);

SELECT * FROM MEMBER;
DELETE FROM MEMBER_GRADE WHERE GRADE_NO =100;
-- 삭제 옵션에 의해 자식테이블에서 100번을 사용하ㄷ너 데이터가 사라짐
------------------------------------------------------------------------------
/*
    기본값(DEFAULT)
    : 제약조건 아님
    컬럼을 제시하지 않고 데이터를 추가 시 NULL값이 추가되는데 이때 NULL값 말고 다른 값으로 저장하고자 할때 사용
*/
DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    AGE NUMBER,
    HOBBY VARCHAR2(30) DEFAULT '없음',
    ENROLLDATE DATE
);
INSERT INTO MEMBER VALUES (1, '민영', 24, '음악감상',SYSDATE);
INSERT INTO MEMBER VALUES (2, '윤서', 23, '게임',NULL);
INSERT INTO MEMBER VALUES (3, '성준', 26, NULL,SYSDATE);
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES (4, '원일');
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES (5, '하니');
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES (7, '우주');
------------------------------------------------------------------------------
/*
    테이블 복제 : CREATE TABLE 테이블명 AS 서브쿼리;
*/
CREATE TABLE MEMBER_COPY AS SELECT * FROM MEMBER;
SELECT * FROM MEMBER_COPY;
-----------------------------------------------------------------------------
/*
    테이블 변경사항을 적용할때 => ALTER TABLE
        ALTER TABLE 테이블명 변경할 내용
        
        [변경할 내용]
            NOT NULL :MODIFY 컬럼명 NOT NULL 
            UNIQUE : ADD UNIQUE 컬럼명
            CHECK : ADD CHECK 컬럼명
            PRIMAERY KEY : ADD PRIMAERY KEY (컬럼명)
            FOREIGN KEY : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할테이블 (참조할컬럼명);
            
            DEFAULT 옵션 : MODIFY 컬럼명 DEFAULT 기본값;
*/
ALTER TABLE MEMBER_COPY ADD PRIMARY KEY(MEM_NO);

ALTER TABLE MEMBER_COPY MODIFY HOBBY DEFAULT '-';
SELECT * FROM MEMBER_COPY;
INSERT INTO MEMBER_COPY(MEM_NO, MEM_NAME) VALUES (5, '하니');
INSERT INTO MEMBER_COPY(MEM_NO, MEM_NAME) VALUES (7, '우주');
