/*
    GROUP BY절
    : 그룹 기준을 제시할 수 있는 구문
    : 여러 개의 값들을 하나의 그룹으로 묶어서 처리하는 목적으로 사용
*/
-- 전체 사원 총 급여 조회
SELECT SUM(SALARY) FROM EMPLOYEE;

-- 부서별 총 급여 조회
SELECT DEPT_CODE, SUM(SALARY)  -- 3
FROM EMPLOYEE               -- 1
GROUP BY DEPT_CODE;         -- 2

-- 부서별 사원 수 조회
SELECT DEPT_CODE, COUNT(*)  -- 3
FROM EMPLOYEE               -- 1
GROUP BY DEPT_CODE;         -- 2

-- 부서코드가 'D1', 'D6', 'D9'인 각 부서별 급여 총합, 사원 수 조회
SELECT DEPT_CODE, SUM(SALARY) "급여 총합", COUNT(*) "사원 수"  -- 4
FROM EMPLOYEE                           -- 1
WHERE DEPT_CODE IN ('D1', 'D6', 'D9')   -- 2
GROUP BY DEPT_CODE                     -- 3
ORDER BY DEPT_CODE;                     -- 5

-- 각 직급 별 총 사원수, 보너스를 받는 사원수, 급여합, 평균급여, 최저급여, 최고급여 조회 (단, 직급코드 오름차순 정렬)
SELECT JOB_CODE, COUNT(*) "총 사원수", COUNT(BONUS) "보너스를 받는 사원수", 
        SUM(SALARY) "급여합", ROUND(AVG(SALARY)) "평균급여", MIN(SALARY) "최저급여", MAX(SALARY) "최고급여"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

-- 남자 사원수, 여자 사원수 조회 --> 주민번호 컬럼!
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') 성별, COUNT(*) "사원수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

-- 부서 내 직급별 사원수, 급여 총합 조회
SELECT DEPT_CODE, JOB_CODE, COUNT(*) "사원수", SUM(SALARY) "급여 총합"
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE  -- 부서코드 기준으로 그룹화하고, 그룹 내에서 직급코드 기준으로 세부그룹화를 함!
ORDER BY DEPT_CODE;
--------------------------------------------------------------------------------
/*
    * HAVING 절
     : 그룹에 대한 조건을 제시할 때 사용하는 구문 (보통, 그룹함수식을 사용하여 조건을 작성함!)
*/
-- 부서별 평균 급여 조회 (*반올림처리)
SELECT DEPT_CODE,ROUND( AVG(SALARY) ) "평균 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 평균 급여가 300만원 이상인 부서만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY)) "평균 급여"    -- 4
FROM EMPLOYEE                       -- 1
WHERE SALARY >= 3000000             -- 2 => 사원의 급여가 300만원 이상
GROUP BY DEPT_CODE;                 -- 3

SELECT DEPT_CODE, ROUND(AVG(SALARY)) "평균 급여"    -- 4
FROM EMPLOYEE                       -- 1
GROUP BY DEPT_CODE                  -- 2
HAVING AVG(SALARY) >= 3000000;      -- 3 => 부서별 평균 급여가 300만원 이상

-- 부서별 보너스를 받는 사원이 없는 부서의 부서코드 조회
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

SELECT BONUS FROM EMPLOYEE WHERE DEPT_CODE = 'D2';
--------------------------------------------------------------------------------
/*
    * ROLLUP, CUBE : 그룹 별 산출 결과 값의 집계 계산 함수
    
    - ROLLUP : 전달받은 그룹 중 가장 먼저 지정한 그룹 별로 추가적 집계 결과 반환
    - CUBE   : 전달받은 그룹들로 가능한 모든 조합 별 집계 결과 반환
*/
-- 각 부서 별 부서내 직급별 급여합, 부서 별 급여합, 전체 직원급여 총합 조회
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
-- GROUP BY DEPT_CODE, JOB_CODE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
-- GROUP BY DEPT_CODE, JOB_CODE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;
--------------------------------------------------------------------------------
/**
    * 실행 순서 *
    
    SELECT 조회하고자하는_컬럼 AS "별칭" 또는 * 또는 함수식 또는 연산식                -- 5
    FROM 조회하고자하는_테이블 또는 DUAL                                            -- 1
    WHERE 조건식 (연산자들을 활용하여 작성)                                          -- 2
    GROUP BY 그룹화 기준이 되는 컬럼 또는 함수식                                     -- 3
    HAVING 조건식 (그룹함수를 활용하여 작성)                                         -- 4
    ORDER BY 컬럼 또는 별칭 또는 컬럼순번 [ASC | DESC] [NULLS LAST | NULLS FIRST]   -- 6

    -----
    
    * 오라클에서는 순서(위치) 1부터 시작!!
**/
--------------------------------------------------------------------------------
/*
    * 집합 연산자 : 여러 개의 명령문(SQL문/쿼리문)을 하나의 명령문으로 만들어주는 연산자
    
    - UNION : 합집합 (두 명령문을 수행한 결과셋을 더해줌) --> OR 와 유사
    - INTERSECT : 교집합 (두 명령문을 수행한 결과셋의 중복된 부분을 추출해줌) --> AND 와 유사
    - UNION ALL : 합집합 + 교집합 (중복되는 부분이 두번 조회될 수 있음)
    - MINUS : 차집합 (선행 결과에서 후행 결과를 뺀 나머지)
*/
-- ** UNION **
-- 부서코드가 D5인 사원 또는 급여가 300만원을 초과하는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;
--> 12

-- 부서코드가 D5인 사원의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
--> 6

-- 급여가 300만원을 초과하는 사원의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
--> 8

-- UNION 연산자로 2개의 쿼리문을 합치기
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
------------------------------------------
-- ** INTERSECT **
-- 부서코드가 D5이고 급여가 300만원 초과인 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;
--> 2

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
--> 2
----------------------------------------------

-- ** UNION ALL **
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'      --> 6
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;     --> 8
--> 14 : UNION(12) + INTERSECT(2)
------------------------------------------
-- ** MINUS **
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
--> 4 : 선행 결과(6) - INTERSECT(2)
-------------------------------------------
/*
    * 집합 연산자 사용 시 주의사항 *
    
    1) 명령문들의 컬럼 개수가 동일해야 함
    2) 컬럼 자리마다 동일한 데이터타입으로 작성해야 함
    3) 정렬을 하고자 할 경우 ORDER BY절의 위치는 마지막에 작성해야 함
*/
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_ID;







