/*
    D: DATA  :  L : LANGUAGE 
    DQL(QUERY, 데이터 조회) : SELECT(조회) 
    DML(MANIPULATION, 데이터 조작) : INSERT(추가/삽입), DELETE(삭제), UPDATE(수정)
    DDL(DEFINITION, 데이터 정의) : CREATE(생성), ALTER(변경), DROP(삭제)
    DCL(CONTROL, 데이터 정의) : GRANT, REVOKE
    TCL(TRANSACTION CONTROL, 트랜잭션 제어) : COMMIT, ROLLBACK
*/
/*
    DML(MANIPULATION, 데이터 조작 언어)  
        INSERT(추가/삽입), DELETE(삭제), UPDATE(수정) 하기 위한 언어
*/
-- INSERT : 테이블에 새로운 행을 추가하는 구문
/*
    표현법
       (1) INESERT INTO 테이블명 VALUES (값, 값, 값,.....);
        -> 테이블의 모든 컬럼에 대한 모든 값을 직접 제어하여 행을 추가하고, 컬럼 순서와 해당 컬럼의 데이터 타입에 맞게 제시해야함
        
        - 값이 부족 => NOT ENOUGH VALUE 오류
        - 값이 넘침 => TOO MANY VALUE 오류
*/
SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE VALUES(900, '서태현', '951109-1437890','taehyun034@gmail.com', '01034569876', 'D4', 'J4', 3000000, 0.3, NULL, SYSDATE, NULL, 'N' );
------------------------------------------------------------------------------------------------------------------------------------------------
/*    
        (2) INESERT INTO 테이블명 (컬럼명, 컬럼명,....) VALUES(값, 값, 값,...);
        -> 컬럼을 직접 제시해 해당 컬럼에 값만 추가
        
        제시되지 않은 컬럼에 대한 값은 기본적으로 NULL, 말고 다른 것으로 저장하려면 DEFAULT 수정, 
        만약 NOT NULL이면 반드시 값을 직접 제시
*/
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, JOB_CODE) VALUES (901, '신지우', '991229-2021290', 'japdef@gmail.com', 'J7');
/*    
        (2) INESERT INTO 테이블명 (서브쿼리);
        -> VALUES로 값을 직접 명시 아닌 서브쿼리로 조회된 결과값을 통채로 INSERT하는 방법(여러 행을 추가하는 방식)
*/
CREATE TABLE EMP01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP01;
--전체 사원 사번, 사원명, 부서명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- 기준이 되는 것 말고 상대것에 (+) OR LEFT JOIN

INSERT INTO EMP01 (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID);
--------------------------------------------------------------------------------
/*
    (4) INSERT ALL
        : 두 개 이상의 테이블에 각각 데이터를 추가할 때 사용되는 서브쿼리가 동일한 경우 사용되는 방법
        [표현법]
            INSERT ALL 
                INTO 테이블명1 VALUES (컬럼명, 컬럼명...)
                INTO 테이블명2 VALUES (컬럼명, 컬럼명...)
                ...
                서브쿼리;
*/
CREATE TABLE EMP_DEPT AS (SELECT EMP_ID,EMP_NAME,DEPT_CODE,HIRE_DATE FROM EMPLOYEE WHERE 1=0);

SELECT EMP_ID,EMP_NAME,DEPT_CODE,HIRE_DATE FROM EMPLOYEE WHERE 1=0; -- 1=0은 결과적으로 FALSE값을 가지게 되서 정보 없이 컬럼정보만 복제하기 위한 조건식 
SELECT * FROM EMP_DEPT;

CREATE TABLE EMP_MANAGER AS (SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE WHERE  1=0);

SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE WHERE  1=0;
SELECT * FROM EMP_MANAGER;

-- 부서코드 'D1' 사번, 이름, 부서코드, 사수번호, 입사일 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE ='D1';

INSERT ALL 
    INTO EMP_DEPT VALUES (EMP_ID,EMP_NAME,DEPT_CODE,HIRE_DATE )
    INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
    (
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE 
    FROM EMPLOYEE 
    WHERE DEPT_CODE ='D1'
    );
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;
--------------------------------------------------------------------------------
/*
    UPDATE : 테이블에 저장되어 있는 기존의 데이터 값을 변경
    
    [표현법]
        UPDATE 테이블명 SET 컬럼명 = 변경할 값,
                           컬럼명 = 변경할 값,
                           ...
                        [WHERE 조건식]
        -> SET 절에는 여러 개의 컬럼의 값을 동시에 변경 가능(, 로 나열해야함)
        -> WHERE 절 생략 시 테이블의 모든 행의 데이터가 변경됨(주의 요망)
        
        데이터를 업데이트 제약조건을 잘 확인해야함
*/
-- 데이터 있이 DEPT_TABLE에 DEPARTMENT의 데이터 복제함
DROP TABLE DEPT_TABLE;
CREATE TABLE DEPT_TABLE
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_TABLE;
-- 부서코드 D1인 부서의 이름 = 인사팀으로 변경
UPDATE DEPT_TABLE SET DEPT_TITLE = '인사팀' WHERE DEPT_ID='D1';

UPDATE DEPT_TABLE SET DEPT_TITLE = '전략기획팀' WHERE DEPT_ID='D9';
-- 사원 테이블 EMP_TABLE로 복제
CREATE TABLE EMP_TABLE AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE;
SELECT * FROM EMP_TABLE;
-- 사번 900 사원 급여 100만원 인상
UPDATE EMP_TABLE SET SALARY = 4000000 WHERE EMP_ID =900;
SELECT * FROM EMP_TABLE WHERE EMP_ID = 900;
UPDATE EMP_TABLE SET SALARY = 5000000 , BONUS = 0.2 WHERE EMP_NAME='대북혼';
SELECT * FROM EMP_TABLE WHERE EMP_NAME='대북혼';

UPDATE EMP_TABLE SET SALARY = SALARY*1.1;
SELECT * FROM EMP_TABLE;
------------------------------------------------------------------------------
/*
UPDATE문 서브쿼리 사용
    UPDATE 테이블명
        SET 컬럼명 = (서브쿼리)
        WHERE 조건식
*/
UPDATE EMP_TABLE SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME='유재식') WHERE EMP_NAME ='방명수' ;

SELECT * FROM EMP_TABLE WHERE EMP_NAME='유재식' OR EMP_NAME= '방명수';
-- ASIA 지역 정보 조회
SELECT * FROM LOCATION WHERE LOCAL_NAME LIKE 'ASIA%';
-- AISA 지역 부서 정보 조회
SELECT *
FROM DEPARTMENT 
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME LIKE 'ASIA%';
-- 아시아 지역 속한 직원 정보(사번)
SELECT EMP_ID 
FROM EMP_TABLE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME LIKE 'ASIA%';
---> 다중행 서브쿼리 (N행 1열)
UPDATE EMP_TABLE 
    SET BONUS = 0.3 
    WHERE EMP_ID IN (SELECT EMP_ID FROM EMP_TABLE 
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
        WHERE LOCAL_NAME LIKE 'ASIA%'
        );
SELECT * FROM EMP_TABLE;
COMMIT;
----------------------------------------------------------------------------------
/*
    DELETE : 테이블에 저장되어 있는 데이터를 삭제할 때 사용되는 구문
    [표현법]
        DELETE FROM 테이블명
        [WHERE 조건식]
*/
DELETE FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;
ROLLBACK; -- 마지막 커밋까지 돌아감

-- 901 테이터 삭제
DELETE FROM EMPLOYEE WHERE EMP_ID = 901;
DELETE FROM EMPLOYEE WHERE EMP_NAME = '서태현';

DELETE FROM DEPARTMENT WHERE DEPT_ID = 'D1';
SELECT * FROM DEPARTMENT;
-- 외래키가 설정되어 있는 경우 사용중인 데이터가 있을시 불가능
/*
    TRUNCATE : 테이블의 전체 행을 삭제 시 사용, DELETE 보다 빠른 수행 속도, 별도 조건 지정 불가고 ROLLBACK 안됨
    [표현법]
        TRUNCATE TABLE 테이블명;
*/


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;










