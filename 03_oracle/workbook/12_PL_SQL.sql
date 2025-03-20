/*
    PL/SQL : PROCEDURE LANGUAGE EXTENSION TO SQL
    
    오라클 자체 내장되어 있는 절차적 언어
    SQL 문장 내에서 변수 정의, 조선문, 반복문 등을 지원 -> SQL 단점 보안
    다수의 SQL문을 한번에 실행 가능
    
    *구조*        -- [] 생략 가능
        [선언부]   : DECLARE 로 시작. 변수나 상수를 초기화하는 부분
        실행부     : BEGIN 으로 시작, SQL문 또는 제어문(조건문, 반복문) 등의 로직을 작성하는 부분
        [예외처리부]: EXCEPTION 으로 시작. 예외 발생 시 해결 및 처리하기 위한 부분
*/
-- 화면에 표시하기 위한 설정
SET SERVEROUTPUT ON;
-- 화면에 출력하고자 할때 =>  DBMS_OUTPUT.PUT_LINE('출력할 내용 작성'); , BEGIN으로 시작/END;로 끝나도록
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
---------------------------------------------------------------------------------
/*
    선언부(DECLARE)
    : 변수 또는 상수를 선언하는 부분 (선언과 도이셍 초기화 가능)
    
    - 데이터 타입 선언 종류
        * 일반 타입
        * 레퍼런스 타입
        * ROW 타입
*/
/*
    - 일반 타입 변수 - 
    
    변수명 [CONSTANT(상수)] 자료형 [:= 대입할 값]
    
    - 상수 선언 시 CONSTANT를 추가
    - 초기화 시 := 기호를 사용
*/
-- EID NUMBER 타입의 변수 선언
-- ENAME VARCHAR2(20) 
-- PI 상수타입 NUMBER 타입 선언 3.14로 값 초기화
DECLARE 
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    -- 변수에 값 대입
    EID := 100;           --EID 변수에 100이라는 값 대입
    ENAME := '이윤서';     -- ENAME 본인 이름 대입
    
    -- 각 변수와 상수가 저장된 값을 화면에 출력
    DBMS_OUTPUT.PUT_LINE('EID: ' ||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME: ' ||ENAME);
    DBMS_OUTPUT.PUT_LINE('PI: ' ||PI);
--  => 특정 문자와 값(변수)을 연결하고자 할 경우 연결 연산자인 || 을 사용
END;
/

DECLARE 
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN 
    ENAME :='이윤서';
    EID := &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('EID: ' ||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME: ' ||ENAME);
    DBMS_OUTPUT.PUT_LINE('PI: ' ||PI);
END;
/
----------------------------------------------------------------------------
/*
    *레퍼런스 타입 변수*
        :어떤 테이블의 어떤 컬럼의 데이터 타입을 차봊하여 해당 타입으로 변수를 선언
        
    [표현법]
        변수명 테이블명.컬럼명%TYPE
*/
-- EID 변수 EMPLOYEE테이블의 EMP_ID 컬럼을 참조 
-- ENAME 변수 EMPLOYEE테이블의 EMP_NAME 컬럼을 참조
-- SAL 변수 EMPLOYEE테이블의 SALARY 컬럼을 참조
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL    -- 각 컬럼에 대한 값을 변수에 저장 및 대입
    FROM EMPLOYEE 
    --WHERE EMP_ID =300;
    WHERE EMP_ID = &사번; --사번을 입력 받아 사번에의 사원 정보를 조회
    
    DBMS_OUTPUT.PUT_LINE('EID: ' ||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME: ' ||ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL: ' ||SAL);
END;
/
-------* 문제 -----------------------------------------------------
/*
    레퍼런스 타입 변수 EID, ENAME, JCODE, SAL, DTITLE 선언
    각 자료형을 EMPLOYEE 컬럼과 DEPARTMENT 컬럼 참조하도록 한뒤 사용자가 입력한 사번의 사원 정보를 출력
    => 출력 형식, 사번, 이름, 직급코드, 급여, 부서명
*/
DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE JOB.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO  EID, ENAME, JCODE, SAL, DTITLE 
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID = &사번;
    DBMS_OUTPUT.PUT_LINE(EID||', '||ENAME||', '||JCODE||', '||SAL||', '||DTITLE);
END;
/
SELECT * FROM EMPLOYEE WHERE EMP_ID =213;
-----------------------------------------------------------------------------------
/*
    ROW 타입 변수 
        테이블의 한 행에 대한 모든 컬럼의 값을 한번에 담을 수 있는 변수
        
    [표현법]
        변수명 테이블명%ROWTYPE;
*/
-- E 변수 EMPLOYEE 테이블의 ROW 타입 변수 선언
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN 
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID =&사번;
    
    DBMS_OUTPUT.PUT_LINE('사원명: '||E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여: '||E.SALARY);
    --DBMS_OUTPUT.PUT_LINE('보너스: '||E.BONUS);
    DBMS_OUTPUT.PUT_LINE('보너스: '||NVL(E.BONUS, 0)); -- 보너스가 NULL인 경우 0으로 표시하기 위해 NVL(BONUS, 0)을 사용
    -- 소수점 표기 패턴 , TO_CHAR(NVL(BONUS, 0), '0.0')
END;
/
----------------------------------------------------------------------------------
/*
    실행부 ( BEGIN )
    
    ** 조건문 **
        - 단일 IF문    : IF 조건식 THEN 실행내용 END IF;
       
        - IF/ELSE문    : IF 조건식 THEN 조건에 만족할때실행내용 
                        ELSE 조건식 만족 안할때 실행할 내용 END IF;
        
        - IF/ELSIF      : IF 조건식1 THEN 조건식1을 만족할때 실행할 내용
                        ELSIF 조건식2 THEN 조건식2을 만족할때 실행할 내용
                        ELSIF 조건식3 THEN 조건식3을 만족할때 실행할 내용
                        ...
                        ELSE 모든 조건을 만족하지 않을때 실행할 내용 => 생략 가능
                        END IF;
        
        - CASE/WHEN/THEN문: 
            CASE 비교대상 WHEN 비교값1 THEN 결과값1
                         WHEN 비교값2 THEN 결과값2
                         ...
                         ELSE 결과값N  -- 모든 비교값들이 비교대상과 모두 다른 경우  => 생략 가능
            END;
*/
------------
/*
    사용자에게 사번을 입력받아 사번, 이름, 급여, 보너스 정보 조회출력
    각 데이터 변수 : EID, ENAME, SAL, BONUS
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID=&사번; 
    DBMS_OUTPUT.PUT_LINE('사번: '||EID);
    DBMS_OUTPUT.PUT_LINE('사원명: '||ENAME);
    DBMS_OUTPUT.PUT_LINE('급여: '||SAL);
    IF BONUS = 0 THEN DBMS_OUTPUT.PUT_LINE('보너스를 받지 않는 사원입니다');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스: '||BONUS);
    END IF;
END;
/
---------------------------------------------------
/*
    사용자로 사번을 입력 받아 사번, 이름, 부서명, 국가명 조회
    => 국가명 KO 인 경우 국내팀 이외 해외팀
*/
DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
BEGIN 
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
        JOIN NATIONAL USING (NATIONAL_CODE)
    WHERE EMP_ID=&사번; 
    
    DBMS_OUTPUT.PUT_LINE('사번: '||EID);
    DBMS_OUTPUT.PUT_LINE('이름: '||ENAME);
    DBMS_OUTPUT.PUT_LINE('부서: '||DTITLE);
    IF NCODE ='KO' 
        THEN TEAM :='국내팀';
    ELSE 
        TEAM :='해외팀';
    END IF;
    DBMS_OUTPUT.PUT_LINE('소속: '||TEAM);
END;
/
SELECT * FROM EMPLOYEE WHERE JOB_CODE ='J4';
-----------------------------------------------------------------
DECLARE
    SCORE NUMBER;
    GRADE CHAR(2);
BEGIN
    SCORE := &점수;
    IF SCORE >=95 THEN GRADE:='A+';
    ELSIF SCORE >=90 AND SCORE <95 
        THEN GRADE :='A';
    ELSIF SCORE >=85 AND SCORE <90 
        THEN GRADE :='B+';
    ELSIF SCORE >=80 AND SCORE <85 
        THEN GRADE :='B';
    ELSIF SCORE >=75 AND SCORE <80 
        THEN GRADE :='C+';
    ELSIF SCORE >=70 AND SCORE <75 
        THEN GRADE :='C';
    ELSIF SCORE >=60 
        THEN GRADE :='D';
    ELSE GRADE :='F';
    END IF;
    DBMS_OUTPUT.PUT_LINE('점수는 '||SCORE||'이고, 등급은 '||GRADE||'입니다');
    IF GRADE='F'
        THEN  DBMS_OUTPUT.PUT_LINE('재평가 대상입니다');
    END IF;
END;
/
---------------------------------------------------------------------------------
/*
    CASE WHEN THEN
    사번 입력 받아 부서코드를 기준으로 부서명 출력, JOIN 사용하지 말고
*/
DECLARE 
    EMP EMPLOYEE%ROWTYPE;
    DTITLE VARCHAR2(20);
BEGIN
    (SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_NO = &사번);
    
    -- 해당 사원의 부서코드를 기준으로 부서명 정보를 DTITLE에 저장
    DTITLE := CASE EMP.DEPT_CODE 
                WHEN 'D1' THEN '인사관리부'
                WHEN 'D2' THEN '회계관리부'
                WHEN 'D3' THEN '마케팅부'
                WHEN 'D4' THEN '국내영업부'
                WHEN 'D5' THEN '해외영업부1'
                WHEN 'D6' THEN '해외영업부2'
                WHEN 'D7' THEN '해외영업부3'
                WHEN 'D8' THEN '기술지원부1'
                WHEN 'D9' THEN '총무부1'
            END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME||' 사원의 소속 부서는 '||DTITLE||'입니다');                     
END;
/
-------------------------------------------------------------------------------
/*
    반복문
            - 기본 구문
                LOOP
                    반복할 구문
                    반복문을 종료할 구문
                END LOOP;
            
            반복문을 종료할 구문
            1) IF 조건식 
                    THEN EXIT;
                END IF;
                
            2) EXIT WHEN 조건식;
            
            - FOR LOOP문
                FOR 변수명 IN [REVERSE]초기값..최종값(끝값)
                LOOP
                     반복할 구문
                     [반복문을 종료할 구문: 특정 조건을 달성 시 종료하도록]
                END LOOP;
                
                * REVERSE : 최종값부터 초기값까지 반복(꺼꾸로)
            - WHILE LOOP문
                WHILE 조건식
                LOOP
                    반복할 구문
                    [반복문을 종료할 구문]
                END LOOP;
                
*/
DECLARE 
    N NUMBER :=1;
BEGIN
    LOOP 
        DBMS_OUTPUT.PUT_LINE('HELLO ORALCE!');
        N := N+1;
    
        IF N>5 THEN EXIT;
        END IF;
    END LOOP;
END;
----FOR LOOP-------------------------------------------------------------------------
BEGIN 
    FOR I IN REVERSE 1..5
    LOOP
         DBMS_OUTPUT.PUT_LINE(I||') HELLO ORALCE!');
    END LOOP;
END;
-------------------------------------------------------------------------------
DROP TABLE TEST;

CREATE TABLE TEST(
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);
CREATE SEQUENCE SEQ_TNO
INCREMENT BY 2
MAXVALUE 1000
NOCYCLE
NOCACHE;

BEGIN
    FOR I IN 1..100
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END;
/
SELECT COUNT(*) FROM TEST;
----------------------------------------------------------------
/*
    예외처리 (EXCEPTION)
        -> 실행 중 발생하는 오류
        
    [표현법]
        EXCEPTION 
            WHEN 예외명 THEN 예외처리구문;
            WHEN 예외명 THEN 예외처리구문;
            ...
            WHEN OTHERS THEN 예외처리구문;
            
        *오라클에서 미리 정의한 예외 -> 시스템 예외*
            - NO_DATA_FOUND : 조회된 데이터 없을때
            - TOO_MANY_ROWS : 조회된 결과가 여러 행 일때 => 변수 대입 시
            - ZERO_DIVIDE   : 0으로 값을 나누려고 할 때
            - DUP_VAL_ON_INDEX : UNIQUE 조건에 위배될 때 => 중복이 있는 경우
            ...
        * OTHERS : 어떤 예외든 발생했을때 처리할 수 있는 키값
*/
---------- 사용자에게 숫자 입력 받아 10을 나눈 결과 출력
DECLARE 
    NUM NUMBER;
BEGIN 
    NUM := &숫자;
    DBMS_OUTPUT.PUT_LINE(10/NUM);
EXCEPTION
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌수 없음');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌수 없음');
END;
/
------------EMPLOYEE 테이블 EMP_ID 컬럼 기본키로 설정 없으면 추가
--ALTER TABLE EMPLOYEE ADD PRIMARY KEY (EMP_ID)
-- PK(PRIMARY KEY) : NOT NULL + UNIQUE
-- 사용자한테 사번을 입력받아 노옹철 사원의 사번을 변경
BEGIN
    UPDATE EMPLOYEE
        SET EMP_ID = '&변경할_사번'
        WHERE EMP_NAME='노옹철';
    EXCEPTION 
        WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('중복된 사원번호 입니다');
END;
/
SELECT EMP_ID FROM EMPLOYEE WHERE EMP_NAME='노옹철';
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID=900;
-------------------------------------------------------------------------------------------
