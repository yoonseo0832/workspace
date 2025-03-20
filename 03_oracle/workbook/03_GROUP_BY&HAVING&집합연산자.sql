/*
    GROUP BY절
    : 그룹 기준을 제시할 수 있는 구문
    : 여러 개의 값들을 하나의 그룹으로 묶어서 처리하는 목적으로 사용
*/
-- 전체사원의 총 급여
SELECT SUM(SALARY) FROM EMPLOYEE;
-- 부서별 총 급여
SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE;
-- 부서별 사원의 인원
SELECT  DEPT_CODE, COUNT(*) FROM EMPLOYEE GROUP BY DEPT_CODE;
-- 부서코드 
SELECT  DEPT_CODE "부서코드",SUM(SALARY)"급여 총합",COUNT(DEPT_CODE)"사원 수"
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D1', 'D6','D9')
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE; --오름차순으로 정렬
--직급별 통 사원수, 보너스 받는 사원수, 급여합, 평균ㄱ브, 최속브, 최대급, 직급코드 오름차순으로 정렬
SELECT JOB_CODE,COUNT(*)"총 사원수",COUNT(BONUS)"보너스 받는 사원 수",SUM(SALARY)"급여 합", ROUND(AVG(SALARY))"평균 급여", MIN(SALARY)"최소 급여", MAX(SALARY)"최대 급여"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;
-- 남/여 사원수 조회
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') 성별, COUNT(*)"사원 수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
-- 부서 내 직급 별 사원수, 급여 총합 조회

SELECT DEPT_CODE, JOB_CODE, COUNT(*)"사원 수", SUM(SALARY)"급여 총합"
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE -- 부서코드 기준으로 그룹화하고 그룹 내에서직급코드 기준으로 세부그룹화함
ORDER BY DEPT_CODE;
---------------------------------------------------------------------------------
/*
    HAVING 절 : 그룹에 대한 조건을 제시할 때 사용하는 구문
*/
SELECT DEPT_CODE, ROUND(AVG(SALARY)) 평균급여
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- 300이상인 부서만 나오도록

SELECT DEPT_CODE, ROUND(AVG(SALARY)) 평균급여
FROM EMPLOYEE
WHERE ROUND(AVG(SALARY))>=3000000
GROUP BY DEPT_CODE;
-- 실행 순서를 생각하면 그룹화 안되서 WHERE 안나옴, 부서별 평균 급여가 아닌 사원의 개별 평균 급여를 의미해서 안도ㅠㅣㅁ

SELECT DEPT_CODE, ROUND(AVG(SALARY)) 평균급여
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY)>=3000000;
-- 부서별 보너스 안받는 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) =0;

SELECT BONUS FROM EMPLOYEE WHERE DEPT_CODE='D2';