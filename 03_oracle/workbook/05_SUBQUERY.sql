/*
    서브쿼리
    : 하나의 쿼리문 내에 포함된 또 다른 쿼리문
    : 메인 역할을 하는 쿼리문을 위해 보조 역할을 하는 쿼리문
*/
-- 노옹철 사원과 같은 부서에 속한 사원 정보 조회
SELECT DEPT_CODE 
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 부서코드가 'D9'인 사원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

SELECT ROUND(AVG(SALARY))FROM EMPLOYEE;
-- 평균 급여 더 많은 급여 받는 사람 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY >= (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE);

/*
    서브쿼리의 종류
    서브쿼리를 수행한 결과값이 몇행 몇열로 나오냐에 따라 분류
    - 단일행 서브쿼리 : 서브쿼리의 결과가 오로지 1개일 때 1행 1열
    - 다중행 서브쿼리 : 서브쿼리의 결과가 여러 행일때 N행 1열
    - 다중열 서브쿼리 : 서브쿼리의 결과가 한 행이고 여러 열일때 1행 N열
    - 다중행 다중열 서브쿼리 : 서브쿼리의 결과가 여러 행 여러 열(컬럼)일때 N행 N열
    >>> 종류에 따라 서브쿼리 앞에 붙는 연산자 다름
   
    EX) SELECT EMP_NAME, EMP_NO, EMAIL FROM EMPLOYEE
*/
--  1. 단일행 서브쿼리
--  >> 일반적인 비교연산자 사용 가능 : > < >= <= !=
-- 전 사원의 평균 급여보다 작게 받는 사원명, 직급 코드, 급여 [서브쿼리 결과가 하나 여서 비교연산자 가능]
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE);
-- 급여 가장 작은 코드
SELECT MIN(SALARY) FROM EMPLOYEE;

SELECT EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY =  (SELECT MIN(SALARY) FROM EMPLOYEE);
-- 노옹철 보다 많이 받는 
SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='노옹철';
-- 부서코드, 급여, 이름
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='노옹철');
-- 부서코드 아닌 부서명으로 조회하려면 
-- 오라클 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='노옹철');
-- ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='노옹철');
-- 부서별 급여 합 가장 큰 부서의 부서코드, 급여합 조회

SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE;
--> 부서졀 급여 합가장 큰 값 MAX
SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE;
-- 2) 부서코드, 급여
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;
-- 서브쿼리 사용
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);
-- 전지연 사원 같은 부서, 사번, 사원명, 연락처, 입사일, 부서명 조회, 전지연 제외하고
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME='전지연';
 -- 오라클 구문
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_CODE =(SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME='전지연') AND EMP_NAME <> '전지연';
--  AND EMP_NAME <> '전지연' 전지연 사원을 제외하고 조회하는 방법

 -- ANSI 구문
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE =(SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME='전지연') AND EMP_NAME != '전지연';

/*
    다중행 서브쿼리 : 서브쿼리 결과가 행이 여러 개 1개의 열(컬럼이 하나)
    IN (서브쿼리) : 여러개의 결과값 중 하나라도 일치하는 값이 있을 경우 조회 (포함하는지)
    
    > ANY (서브쿼리) 대소비교 가능 | 여러개의 결과값 중에서 하나라도 큰 경우 있다면 조회  작을경우에도 같은 조건임 < ANY
        * 비교대상 > 결과값1 OR 비교대상 > 결과값2 OR 비교대상 > 결과값3....
        
    > ALL 모든 결과값 보다 모든 클 경우 || < ALL 모든 결과값 보다 모든 작을 경우  ==> AND와 비슷
*/
-- 유재식 또는 윤은해 같은 직급 사법/사원명/직급코드/급여
SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME IN ('유재식', '윤은해');
-- 서브쿼리 사용
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY 
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME IN ('유재식', '윤은해'));
-- 대리직급 사원 중 과장 직급의 최소 급여보다 많이 받는 사원 조회
SELECT SALARY FROM EMPLOYEE WHERE JOB_CODE = 'J5';
SELECT SALARY FROM EMPLOYEE WHERE JOB_CODE = 'J6';

SELECT SALARY
FROM EMPLOYEE JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME ='과장';

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY 
FROM EMPLOYEE JOIN JOB USING (JOB_CODE)
WHERE SALARY > ANY (3760000, 2200000, 2500000) AND JOB_NAME = '대리';
/*
    다중열 서브쿼리 : 서브쿼리 결과 1개 행, 여러 열인 경우
*/
-- 하이유 사원과 같은 부서, 직급인 사원 조회
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유';

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE =(SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유') AND JOB_CODE =(SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유');

--다중열 서브쿼리 사용하면
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) =(SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유');
-- 박나라 사원 직급 같고, 사수 동일한 사원명, 
SELECT DEPT_CODE, MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME='박나라';

SELECT EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME='박나라') AND EMP_NAME <> '박나라';
/*
    다중행 다중열 서브쿼리 : 서브쿼리의 결과 여러 행, 여러 열인 경우
*/
-- 각 직급 별 최소급여 받는 ㅜ사원 정보 조회
SELECT JOB_CODE, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE);
--------------------------------------------------------------------------------
/*
    인라인 뷰 : 서브쿼리를 FROM 절에 사용하는 것
            => 서브쿼리의 결과를 마치 테이블처럼 사용하는 것
*/
-- 사번, 이름, 보너스 포함 연봉(단, NULL아니고 3000만원 이상 사원만), 부서코드 조회
SELECT EMP_NAME, EMP_ID,(SALARY + (SALARY *NVL(BONUS, 0)))*12 "보너스 포함 연봉" FROM EMPLOYEE WHERE (SALARY + (SALARY *NVL(BONUS, 0)))*12 >=30000000 ORDER BY 3 DESC;
-- 상위 N개를 조회: TOP-N분석  => ROWNUM : 조회된 행에 대하여 순서대로 1부터 순번을 부여해주는 가상 컬럼ㄴ

SELECT ROWNUM, 사번, EMP_NAME, "보너스 포함 연봉", DEPT_CODE
FROM (
        SELECT EMP_ID 사번, EMP_NAME,(SALARY + (SALARY *NVL(BONUS, 0)))*12 "보너스 포함 연봉", DEPT_CODE
        FROM EMPLOYEE 
        WHERE (SALARY + (SALARY *NVL(BONUS, 0)))*12 >=30000000 
        ORDER BY 3 DESC
    )
WHERE ROWNUM <=5;

SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일 
FROM EMPLOYEE 
ORDER BY HIRE_DATE DESC;

SELECT 사번, 이름, 입사일
FROM (
        SELECT ROWNUM R, EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일 
        FROM EMPLOYEE 
        ORDER BY HIRE_DATE DESC
    )
WHERE R >=2 AND R <=5;
-- ROWNUM 중간 위치로 할며면 인라인뷰에 컬럼과 같이 작성후 사용해야 함
-----------------------------------------------------------------------------------
/*
    순서를 매기는 함수 WINDOW FUNCTION
    - RANK() OVER(정렬 기준)        : 동일한 순위 이후의 등수를 동일한 수 만큼 건너뛰고 순위 계산    => 상대평가
    - DENSE_RANK() OVER(정렬 기준)  : 동일한 순위 있더라도 그 다음 등수를 +1 해서 순위 계산         => 절대평가
    
    => SELECT절에서만 사용 가능
*/
-- 급여 높은 순서대로 조회
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) 순위 FROM EMPLOYEE; 
--공동 순위 19위 2명이 있고 그 뒤 순위는 21로 표시
SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위 FROM EMPLOYEE;
--공동 순위 19위 2명이 있으나 그 뒤 순위는 20로 표시
-- 상위 5명만 
SELECT *
FROM(
        SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위 FROM EMPLOYEE
    )
WHERE 순위 BETWEEN 3 AND 5;
--==========================QIUZ================================================
--1) ROWNUM 급여 높은 5명, 제데로 조회되지 않음
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <=5
ORDER BY SALARY DESC;
--문제점 
-- ROWNUM과 ORDER BY 를 같이 사용할 수 없다 , 정렬되기 전에 5명이 추려졌다, ROWNUM
--해결방안
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT ROWNUM, EMP_NAME, SALARY FROM EMPLOYEE ORDER BY SALARY DESC)
 WHERE ROWNUM <=5;
--2) 부서별 평균 급여 270만원 초과하는 부서의 부서코드, 부서별 총 급여합, 부서별 평균 급여, 부서별 사원 수 조회 안됨!!
SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS 평균, COUNT(*) 사원수
FROM EMPLOYEE
WHERE SALARY > 2700000 --> HAVING SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--문제점: 부서별 평균 급여가 아닌 사원 개개인의 급여를 조건으로 제시했다 
-- WHERE 의 조건은 개별로 인식해서 GROUP BY의 조건에 부합하지 않음, HAVING 절을 이용해야 그룹으로 묶인 조건을 사용 가능 
--
--해결방안
SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS 평균, COUNT(*) 사원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;

-- 또눈 서브쿼리 사용하는 방법
SELECT *
FROM (
        SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR(AVG(SALARY)) AS 평균, COUNT(*) 사원수
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
    )
WHERE 평균 > 2700000;





