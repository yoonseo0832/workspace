 /*
    SELECT : 데이터를 조회 / 추출
        [표현식] SELECT 조회하고자 하는 정보 FROM 테이블 정보;
        SELECT 컴럼명 ...
        FROM 테이블명;
         전체를 보고자 할때  => SELECT * FROM 테이블명;
*/
-- 모든 사원의 정보 조회
SELECT * FROM EMPLOYEE;

-- 모든 사원의 이름, 주민번호, 연락처 조회
SELECT EMP_NAME, EMP_NO, PHONE  -- (2) EMPLOYEE 테이블에서 EMP_NAME, EMP_NO, PHONE 컬럼에 대한 데이터만 추출
FROM EMPLOYEE;                  -- (1) EMPLOYEE 테이블 조회

-- 모든 직급의 정보 조회
SELECT * FROM JOB;

-- 직급 정보중 직급명만 조회
SELECT JOB_NAME
FROM JOB;

-- 사원 테이블에서 모든 사원의 사원명, 이메일, 연락처, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    컴럼명에 산술 연산 추가하기
    => SELECT절에 컬럼명 작성부분에 산술 연산 가능
*/
-- 사원명 연봉 정보 => 연봉 SALARY *12 
SELECT EMP_NAME 사원명, SALARY*12 연봉
FROM EMPLOYEE;

-- 사원명, 급여, 보너스, 연봉, 보너스 포함 연봉 조회
SELECT EMP_NAME, SALARY, BONUS, SALARY*12,  (SALARY + (SALARY*BONUS))*12
FROM EMPLOYEE;

/*
    컬럼에 별칭 부여하기 => ㅇ녀산식을 사용한 경우 의미 파악 쉽고 명확하게 하기 위해 (3,4) <= 공백이 있는 별칭에 쓰임
    [표현식] (1) 컬럼명 별칭        (2) 컬럼명 AS 별칭       (3) 컬럼명 "별칭"        (4) 컬럼명 AS "별칭"
*/

-- 사원명, 급여, 보너스, 연봉, 보너스 포함 연봉 조회(별칭을 부여한것)
SELECT EMP_NAME 사원명, SALARY 급여, BONUS 보너스, SALARY*12 연봉,  (SALARY + (SALARY*BONUS))*12 "보너스 포함 연봉"
FROM EMPLOYEE;

/*
    - 현재 날짜 시간 정보 : SYSDATE
    - 가상 테이블(임시 테이블 제공) : DUAL
*/

-- 현재 날짜시간 정보 조회
SELECT SYSDATE FROM DUAL; -- YY/MM/DD 형식

-- 모든 사원명, 입사일, 근무일수 조회
SELECT EMP_NAME 사원명, HIRE_DATE 입사일, round(SYSDATE-HIRE_DATE -1) "근무일수"
FROM EMPLOYEE;

--DATE 타입 - DATE 타입 => 일(하루) 단위로 표시됨

/*
    리터럴(값 자체_) : 임의로 지정한 값을 문자열('') 표현 또는 숫자로 표현
    -> SELECT 절에 사용하는 경우 조회된 결과(Result Set)에 반복적으로 표시
*/

-- 사원명, 급여, '원' 조회 별칭으로
SELECT EMP_NAME 사원명, SALARY 급여, '원' 원
FROM EMPLOYEE; -- 테이블명 

-- 연결 연산자 : || 두개의 컬럼 또는 값과 컬럼을 연결해주는 연산자
SELECT EMP_NAME 사원명, SALARY|| '원' 급여        -- 한 컬럼안에 하나의 별칭만 가능
FROM EMPLOYEE;

-- 사번, 이름, 급여
SELECT EMP_ID || EMP_NAME || SALARY 사번_이름_급여
FROM EMPLOYEE;

-- "XXX의 급여는 XXX입니다. 형식으로 조회
SELECT EMP_NAME || '의 급여는 ' || SALARY || '원입니다.' AS 급여정보
FROM EMPLOYEE;

/* 
    중복 제거 : DISTINCT
    => 중복된 결과값이 있는 경우 조회 결과를 하나로 표시해줌
    [표현식] 
    DISTINCT 컬럼명..
*/
-- 사원테이블 직급코드만 조회
SELECT JOB_CODE FROM EMPLOYEE;
-- 사원테이블 직급코드만 조회 <중복 제외>
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;
-- 사원 테이블에서 부서코드 조회 중복없이
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

-- SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE FROM EMPLOYEE;
-- SELECT정에서 DISTINCT는 한번만 사용 가능

-- DEPT_CODE, JOB_CODE를 한 쌍으로 묶어서 중복으 제거 같은 직급의 같은 부서인 경우만 중복으로 제거됨
SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE;

-- =========================================================================================
/*
    *WHERE절: 조회하고자 하는 데이터를 특정 조건에 따라 추출하고자 할 때 사용
    [표현식]
        SELECT 컬럼명, 컬럼 또는 데이터 기준 연산식
        FROM 테이블명;
        WHERE 조건;
        
    - 비교 연산자
    1) 대소비교: > < >= <=
    2) 동등비교
        - 같은지 비교: =
        - 다른 지 비교: != <> ^=
*/
-- 사원 테이블에서 부서코드가 'D9'인 사우너들 조회
SELECT *                --(3) 전체 컬럼의 데이터 조회
FROM EMPLOYEE           --(1) EMPLOYEE 테이블에서
WHERE DEPT_CODE = 'D9'; --(2) DEPT_CODE 컬럼 값이 'D9'인

-- 사원 정보중 부서코드가 'D1'인 사원명, 급여, 부서코드를 조회
SELECT EMP_NAME 사원명, SALARY 급여, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 사원 정보중 부서코드가 'D1'가 아닌 사원명, 급여, 부서코드를 조회
SELECT EMP_NAME 사원명, SALARY 급여, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1'; -- 모두 다른 지 비교[ != | <> | ^= ]

-- 급여가 400 이상인 사원의 사원명, 부서코드, 급여정보를 조회
SELECT EMP_NAME 사원명, DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- 급여가 400 이하인 사원의 사원명, 부서코드, 급여정보를 조회
SELECT EMP_NAME 사원명, DEPT_CODE 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE SALARY <= 4000000;

-- ====================================================================
-- =========================실습 문제 ==================================
-- 단, 연봉 계산 시 보너스 제외
-- [1] 급여가 300 이상 사원명, 급여, 입사일, 연봉 별칭으로
-- [2] 연봉 5000 이상인 사원들 사원명, 급여, 연봉, 부서코드 별칭으로
-- [3] 직급 코드 'J5'아닌 사번, 사원명, 직급코드, 퇴사여부 별칭으로
-- [4] 급여 350 이상 600 이하 사원명, 사번, 급여 조회 병칭으로

SELECT EMP_NAME 사원명, SALARY 급여, HIRE_DATE 입사일, SALARY*12 연봉
FROM EMPLOYEE
WHERE SALARY >=3000000;

SELECT EMP_NAME 사원명, SALARY 급여, SALARY*12 연봉, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE SALARY*12 >=50000000;

SELECT EMP_NO 사번, EMP_NAME 사원명, JOB_CODE 직급코드, ENT_YN 퇴사여부 
FROM EMPLOYEE
WHERE JOB_CODE !='J5';

SELECT EMP_NAME 사원명,EMP_NO 사번, SALARY 급여
FROM EMPLOYEE
WHERE SALARY >=3500000 AND SALARY <=6000000;
--===========================================================================
/*
    BETWEEN AND : 조건식에서 사용되는 구문
    => ~ 이상, ~ 이하인 범위에 대한 조건을 제시하는 구문 
    [표현식] 
        컬럼명 BETWEEN A AND B
        - 컬럼명: 비교 대상컬럼
        - A : 최솟값
        - B : 최댓값
        => 해당 컬럼의 값이 최솟값 이상이고 최댓값 이하인 경우
*/
SELECT EMP_NAME 사원명,EMP_NO 사번, SALARY 급여
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 급여 350 미만 또는 600 초과 사원명, 사번, 급여 조회 병칭으로
SELECT EMP_NAME 사원명,EMP_NO 사번, SALARY 급여
FROM EMPLOYEE
WHERE SALARY < 3500000 OR  SALARY > 6000000;

-- 부정연산자 : NOT

-- 급여 350 미만 또는 600 초과 사원명, 사번, 급여 조회 병칭으로
SELECT EMP_NAME 사원명,EMP_NO 사번, SALARY 급여
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

/*
    IN : 비교대상컬럼의 값이 제시한 값들 둥에 일치하는 값이 있는 경우를 조회하는 구문
    [표현식]
        컬럼명 IN (값1, '문자', 숫자, 숫자...)
        <아래와 동일>
       컬럼명 = 값1 OR 컬럼명 = 값2 OR 컬럼명= 값3 
*/
-- 부서코드가 'D6' OR 'D5' 사원명, 부서코드, 급여 조회(IN 사용하지 않는 방법)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D6' OR DEPT_CODE='D8' OR DEPT_CODE='D5';
-- 부서코드가 'D6' OR 'D5' 사원명, 부서코드, 급여 조회(IN 사용하는 방법)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6','D8' ,'D5');
--==========================================================================
/*
    LIKE : 비교하고자 하는 컬럼의 값이 제시한 특정 패턴에 만족할 경우 조회
    비교대상컬럼 LIKE '패턴'
    => 특정 패턴 : '%', '_' 를 와일드 카드로 사용 
        => 역할 
            (1) % : 0 글자 이상
            EX1) 비교대상컬럼 LIKE '문자%' => 비교대상컬럼의 값이 해당 문자로 "시작"되는 것을 조회 NAME LIKE 'A%'; A로 시작 
            EX2) 비교대상컬럼 LIKE '%문자' => 비교대상컬럼의 값이 해당 문자로 "끝"나는 것을 조회 NAME LIKE '%나'; 나로 끝나는 컬럼 조회
            EX2) 비교대상컬럼 LIKE '%문자%'=> 비교대상컬럼의 값이 해당 문자가 "포함"된 것을 조회 NAME LIKE '%하나은행%'; 하나은행 포함된 컬럼 조회 <키워드 검색에 사용>
            
            (2) _ : 1 글자 의미
            >  비교대상컬럼 LIKE '_문자'
            >  비교대상컬럼 LIKE '문자_'
            >  비교대상컬럼 LIKE '_문자_'
*/
-- 사원중 "전"씨 성 사원의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';  --'전__'; 둘다 사용 가능
-- 사원중 "하"가 포함된 사원의 사원명, 주민번호,전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';
-- 사원명 가운데 글자가 "하"인 사원의 사원명, 주민번호,전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 사원중 연락처 3번째 자리가 1인 사원명, 연락처, 이메일 조회
SELECT EMP_ID,EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%'; -- 와일드 카드 여러개 사용 가능

-- 사원중 이메일 4번째 자리 _인 사원 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___%'; -- 원하는 결과 안나옴, 와일드카드로 사용되는 문자와 컬럼에 담긴 문자가 동일해 모두 와일드카드로 인식
-- 구분해줘야함 => 나만의 와일드카드 ESCAPE 옵션추가
-- [표현식] 비교대상컬럼 LIKE '패턴' ESCAPE '기호';
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#'; -- 와일드 카드만 가능 
--=============================================================================
/*
    IS NULL / IN NOT NULL 
    : 컬럼값에 NULL이 있는 경우 NULL값을 비교할 때 사용되는 연산자
    - IS NULL 컬럼 값이 NULL 값인지 비교
    - IS NOT NULL 컬럼 값이 NULL 값이 아닌지 비교
*/
-- 보너스 받지 않는 사원 사번, 사원명, 급여, 보너스
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;
-- 보너스 받는 사원 사번, 사원명, 급여, 보너스
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- 사수 없는 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE 
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 부서 배치받지 않았지만 보너스 받는 사원명, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
-- 직급코드 'J2' OR 'J7'인 사원중 급여 200만원 이상인 직원정보 조회
SELECT * 
FROM EMPLOYEE
--WHERE SALARY >=2000000 AND  JOB_CODE ='J7' OR JOB_CODE ='J2'
WHERE JOB_CODE IN ('J7','J2') AND SALARY >=2000000;
--WHERE (JOB_CODE ='J7' OR JOB_CODE ='J2') AND SALARY >=2000000;
/*
    연산자 우선순위
        (0) ( )
        (1) 산술연산자 : * / + -
        (2) 연결연산자 : ||
        (3) 비교연산자 : > < >= <= != <> ^= =
        (4) IS NULL / LIKE '패턴' / IN
        (5) BETWEEN AND
        (6) NOT
        (7) AND
        (8) OR
*/
--=============================================================================
/*
    정렬: ORDER BY
            => SELECT문에서 가장 마지막 줄에 작성
            => 실행 순서 또한 마지막에 실행
            SELECT 컬럼
            FROM 테이블명
            WHERE 조건식
            ORDER BY 정렬기준이 되는 컬럼|별칭|컬럼순법 [ASC 오름차순 | DESC 내림차순 ] [NULL FIRST | NULL LAST];
            
            ASC : 오름차순 기본값
            DESC: 내림차순 정렬
            
            NULLS FIRST 정렬하고자 하는 컬럼의 값이 NULL인 경우 맨 앞 배치 <DESC 경우 기본값> 
            NULLS LAST 정렬하고자 하는 컬럼의 값이 NULL인 경우 뒤 앞 배치 <ASC 경우 기본값>
            --> NULL 값은 큰값으로 분류하여 정렬
*/
SELECT EMP_NAME 사원명, SALARY*12 연봉
FROM EMPLOYEE -- 조건식 없으니 WHERE 생략
--ORDER BY 연봉 DESC;
ORDER BY 2 DESC;  -- 컬럼의 순번은 오라클에서는 순서 1번 부터 시작함

SELECT *
FROM EMPLOYEE
ORDER BY BONUS DESC NULLS LAST; 

SELECT *
FROM EMPLOYEE
ORDER BY BONUS DESC, SALARY ASC;
-- 보너스 컬럼을 내림차순 정렬, 급여를 올림차순으로 정렬
-- 보너스 값을 내림차순 정렬하는데 보너스 값이 같은 값인 경우 급여의 값을 오름차순 정렬

