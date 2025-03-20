/*
    DDL : 데이터 정의 언어
    
    객체들을 생성(CREATE) , 변경(ALTER), 삭제(DROP)하는 구문
*/
-----------------------------------------------------------------------------
/*
    ALTER : 객체 변경하는 구문
    
    - 테이블에 대한 변경
    [표현법]   
        ALTER 종류[TABLE] 테이블명 변경할 내용
    
    변경되는 내용
        - 컬럼  추가/수정/삭제
        - 제약조건 추가/삭제  -> 수정 불가(수정하려면 삭재 후 다시 추가)
        - 컬럼명, 제약조건명, 테이블명 변경 가능
*/
-------------------------------------------------------------------------------
/*
    컬럼 추가/수정/삭제
    
    - 컬럼 추가
        ADD 컬럼명 데이터타입 [DEFAULT 기본값] [제약조건];
*/
-- DEPT_TABLE CNAME VARCHAR2(20) 컬럼 추가
ALTER TABLE DEPT_TABLE ADD CNAEM VARCHAR2(20);

SELECT * FROM DEPT_TABLE;
-- 위와 동일하지만 , NULL이 아닌 지정한 가본값으로 채워져서 추가됨
ALTER TABLE DEPT_TABLE ADD LNAME VARCHAR2(20) DEFAULT '한국';
--------------------------------------------------------------------------------
/*
    컬럼 수정 (MODIFY)
        - 데이터 타입 수정 : MODIFY 컬럼명 변경할 데이터타입;
        - 기본값 수정     : MODIFY 컬럼명 DEFAULT 변경할 기본값;
*/
-- DEPT_TABLE DEPT_ID 컬럼 변경 CHAR 2-> 5
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5);
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID NUMBER;
-- 데이터 유형을 변경할 열은 비어 있어야 합니다
ALTER TABLE DEPT_TABLE MODIFY DEPT_TABLE DEFAULT NULL;
ROLLBACK;

ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(10);
--  저장된 데이터의 일부 값이 너무 커서 열 길이를 줄일 수 없음

ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(50);

ALTER TABLE EMP_TABLE MODIFY SALARY VARCHAR(50);
-- 데이터 유형을 변경할 열은 비어 있어야 합니다

-- 여러 개의 컬럼 변경 가능
-- DEPT_TABLE 테이블의 DEPT_TITLE 컬럼은 VARCHAR2(55), LNAME 컬럼의 기본값을 KOREA로 변경
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCAHR2(55) MODIFY LNAME DEFAULT '코리아';
----------------------------------------------------------------------------------
/*
    - 컬럼 삭제
         DROP COLUMN 컬럼명
*/
-- DEPT_TABLE COPY 테이블 새엇ㅇ
CREATE TABLE EMP_COPY AS (SELECT * FROM EMP_TABLE);
CREATE TABLE DEPT_COPY AS (SELECT * FROM DEPT_TABLE);
SELECT * FROM EMP_COPY;
ALTER TABLE EMP_COPY ADD LNAME VARCHAR2(20);
ALTER TABLE EMP_COPY MODIFY LNAME DEFAULT '코리아';

ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
---------------------------------------------------------------------------------
/*
    제약 조건 추가/삭제 : 수정은 삭제 -> 추가
    
    - 제약 조건 추가
        기본키 (PRIMARY KEY) : ADD PRIMARY KEY (컬럼명);
        외래키 (FORRIGN KEY) : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명 [(참조할컬럼명)]; -- 생략되면 기본키를 참조
        UNIQUE              : ADD UNIQUE (컬럼명); => 중복을 허용하지 않는다
        CHECK               : ADD CHECK (컬럼에 대한 조건식); -> 특정 값들만 지정하고자 할때 사용 NULL값도 저장 가능
        NOT NULL            : MODIFY 컬럼명 NOT NULL|NULL; => NULL 허용 할지 말지
    제약조건명을 지정하고자 한다면 : "CONSTRAINT 제약조건명" 제약조건
*/
ALTER TABLE DEPT_TABLE 
        ADD CONSTRAINT DT_PK PRIMARY KEY(DEPT_ID)
        ADD CONSTRAINT DT_UQ UNIQUE (DEPT_TITLE)
        MODIFY LNMAE NOT NULL;
SELECT * FROM DEPT_TABLE;

ALTER TABLE DEPT_TABLE ADD CONSTRAINT DT_UQ UNIQUE (DEPT_TITLE);
----------------------------------------------------------------------------------
/*
    - 제약조건 삭제
        DROP CONSTRAINT 제약조건명
        MODIFY 컬럼명 NULL (NOT NULL 제약을 NULL로 변경)
*/
ALTER TABLE DEPT_TABLE DROP CONSTRAINT DT_PK; 
ALTER TABLE DEPT_TABLE DROP CONSTRAINT DT_UQ MODIFY LNAME NULL;
-------------------------------------------------------------------------------
/*
    컬럼명, 제약조건명, 테이블명 변경 (RENAME)
*/
-- 1. 컬럼명 변경 ; RENAME COLUMN 기본컬러명 TO 변경할 컬럼명;
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO  DEPT_NAME;

-- 2. 제약조건명 변경 : RENAME CONSTRAINT 기본제약명 TO 변경할제약명;
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C008502 TO DT_DEPTID_NN;

-- 3. 테이블명 변경 : RENAME TO 변경할테이블명;
ALTER TABLE DEPT_TABLE RENAME TO DEPT_END;
------------------------------------------------------------------------------
/*
    DROP : 객체를 삭제 사용 구문
    - 테이블 삭제 
        DROP TABLE 테이블명;
*/
DROP TABLE DEPT_END;
--> 어딘가에 참조되고 있는 부모테이블의 경우 삭제되지 않음
--> 지울려면 1) 참조하고 있는 자식테이블을 먼저 삭제 후 부모테이블을 삭제하는 방법
--          2) 부모테이블만 삭제, 제약조건도 삭제
--          DROP TABLE 테이블명 CASCADE CONSTRAINT 





