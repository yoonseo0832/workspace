/*
* DQL (Data Query Language) - 데이터 검색 언어
  - SELECT 명령어 사용
  - 표현법 및 실행 순서 표시
		키워드 => FROM ORDER BY SELECT WHERE
SELECT 컬럼, 연산식, 함수식, 전체 컬럼    --(3) 별칭 사용 가능
FROM 테이블명                           --(1)
WHERE 조건식                            --(2) 
ORDER BY 정렬 기준이 되는 컬럼;           --(4) 별칭 사용 가능
ORDER BY --> 정렬 기본값 ASC 오름차순 NULLS LAST
                DESC 내림차순 NULLS FIRST

* 함수 (FUNCTION)
	- [  단일 행 함수 ] : N개의 값으로 N개의 결과값을 반환 (매 행마다 함수 실행 결과 반환)
	- [  그룹 함수  ] : N개의 값으로 1개의 결과값을 반환 (그룹으로 묶어 함수 실행 결과 반환)  
  
*/  
---------------------------------------------
-- === 아래 내용을 조회할 수 있는 SQL문을 작성 ===
-- 사원 정보 중 사원번호, 이름, 월급을 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;
-- 부서코드가 'D9'인 사원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPPLYEE 
WHERE DEPT_CODE = 'D9';
-- 연락처의 4번째자리가 7인 직원의 이름, 연락처 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
--WHERE SUBSTR(PHONE, 4, 1) = '7';
WHERE PHONE LIKE '___7%';
-- 직급코드가 'J7'인 직원 중 급여가 200만원 이상인 직원의 이름, 급여, 직급코드 조회
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J7' AND SALARY >= 2000000;
-- 전체 사원 정보를 최근 입사일 기준으로 정렬하여 조회
SELECT *
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;
-- 여사원들중 60년대생 직원들의 이름, 주민번호, 이메일, 연락처 조회
-- (단, 주민번호의 경우 7자리까지만 표시하고 나머지는 *로 표시)
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*'), EMAIL, PHONE
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4') AND SUBSTR(EMP_NO, 1,2) BETWEEN 60 AND 69; -- 문자안에 숫자만 있으면 자동으로 형변환됨

-- 사원들 중 입사한 달에 생일인 사원의 사번, 사원명, 고용일, 생년월일을 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SUBSTR(EMP_NO, 1, 6) BIRTH
FROM EMPLOYEE
WHERE EXTRACT(MONTH FROM HIRE_DATE) = SUBSTR(EMP_NO, 3, 2);

