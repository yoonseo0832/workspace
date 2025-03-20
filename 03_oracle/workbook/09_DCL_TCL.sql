--09_DCL/TCL
/*
    - 시스템 권한 : DB에 접근하는 권한, 객체를 생성하는 권한
    - 객체 접근 권한 : 특정 객체들을 조작할 구 있는 권한
*/
/*
    계정 생성
        CREATE USER 계정명 INDENTIFIED BY 비밀번호;
        
    권한 부여 
        GRANT CONNECT, RESOURCE TO 계정명;
        
        - 시스템 권한 종류 -
            + CREATE SESSION : 접속 권한
            + CREATE TABLE   : 테이블 생성 권한
            + CREATE VIEW    : 뷰 생성 권한
            + CREATE SEQUENCE: 시퀀스 생성 권한
*/
-- SAMPLE/SAMPLE 계정 생성
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;
-- 접속 권한
GRANT CREATE SESSION TO C##SAMPLE;
-- 테이블 생성 권한
GRANT CREATE TABLE TO C##SAMPLE;
-- 테이블 스페이스 할당
ALTER USER C##SAMPLE QUOTA 2M ON USERS;
--------------------------------------------------------------------------------
/*
    객체 접근 권한 종류
    종류      |       접근 객체
    ========================================
    SELECT   | TABLE, VIEW, SEQUENCE -- 조회
    INSERT   | TABLE, VIEW           -- 추가
    UPDATE   | TABLE, VIEW           -- 수정
    DELETE   | TABLE, VIEW           -- 삭제
    ========================================
    
    GRANT 권한종류 ON 특정객체 지정 TO 계정명;
    EX) TEST 계정에 KH계정의 EMPLOYEE 테이블 조회 권한 부여
    GRANT SELECT ON C##KH.EMPLOYEE TO C##TEST;
    
    *권한 회수*
        REVOKE 회수할권한 FROM 계정명;
    EX) REVOKE SELECT ON KH.EMPLOYEE FROM TEST;
*/
/*
    ROLE (롤, 규칙) : 특정 권한들을 하나의 집합으로 모아놓는 곳
        - CONNECT   : 접속 권한 (CREATE SESSION)
        - RESOURCE : 자원 관리. 특정 객체 생성 관리
*/
-- 롤 정보 조회
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE');
-- 많은 권한을 가지고 있음 - 일반사용자에게는 주지 말것
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('DBA');
--------------------------------------------------------------------------------
/*
    TCL (Transaction Control Language)
    
    - 트랜잭션 : 데이터베이스의 논리적 연산단위 데이터의 변경사항들(DML사용시 생기는 내용들)
                하나의 묶음처럼 트랜잭션에 모아둠
                DML문 한개를 수행할 때 트랜잭션이 존재하면 트랜잭션에 모아서 처리
                                    트랜잭션이 존재 안하면 만들어서 묶음
                COMMIT 사용하기 전까지 변경사항들을 하나의 트랜잭션으로 담음
                    ->트랜잭션 대상: INSERT/UPDATE/DELETE
    - 트랜잭션의 종류
        COMMIT : 변경사항적용 -> 트랜잭션에 담아 있는 변경사항을 실제 데이터베이스에 적용
        ROLLBACK : 변경사항 취소 -> 트랜잭션에 담아 있는 변경사항을 취소, 마지막 COMMIT 위치로 돌아감
        SAVEPOINT 포인트명; :현재 시점에 변경사항들을 임시로 저장해주는것을 의미 ROLLBACK 시 전체 변경 사항 삭제 않고, 해당 위치까지만 취소 가능 => ROLLBACK 포인트명;
*/
-- 테이블 삭제
DROP TABLE EMP01;
-- EMP01 테이블 생성
CREATE TABLE EMP01 AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID);

-- FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE=DEPT_ID

SELECT * 
FROM EMP01 
ORDER BY EMP_ID;

DELETE FROM EMP01 WHERE EMP_ID IN ('217', '214');
ROLLBACK; -- 마지막 커밋 시점으로 돌아감
COMMIT; -- 변경사항을 적용 실제 DB에
------------------------------------------------------------------------------
DELETE FROM EMP01 WHERE EMP_ID IN ('208', '209', '210');
SAVEPOINT SP;

-- 500 사원 추가
INSERT INTO EMP01 VALUES (500, '전한길', '인사관리부');
-- 211 사원 삭제
DELETE FROM EMP01 WHERE EMP_ID='211';

ROLLBACK TO SP;
COMMIT; --SP시점으로 돌아가 COMMIT
------------------------------------------------------------------------
SELECT * 
FROM EMP01 
ORDER BY EMP_ID;

DELETE FROM EMP01  WHERE EMP_ID = 221;

CREATE TABLE TEST (TID NUMBER);

ROLLBACK; -- DDL문 (CREATE | ALTER | DROP) 변경사항 이후 사용시 기존 트랜잭션에 저장된 변경사항들은 무조건 반영
-- DDL 사용 전 DML(INSET | UPDATE | DELETE) 로 작성된 쿼리 -> 확실히 트랜잭션 (COMMIT | ROLLBACK) 처리 후 DDL 사용하는 것이 좋음

