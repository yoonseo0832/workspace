/*
    아래 쿼리문의 실행 순서는?   2 > 3 > 4 > 5 > 1 > 6
    
    SELECT 컬럼명                            -- 1
    FROM 테이블명                             -- 2
    WHERE 조건                               -- 3
    GROUP BY 그룹화기준                       -- 4
    HAVING 그룹 조건                          -- 5
    ORDER BY 정렬 기준                        -- 6
*/

--=========================================================================
--     수업용 계정(C##KH) 로그인 후 아래 정보를 조회할 수 있는 쿼리문을 작성해주세요
--=========================================================================
-- 이메일의 아이디 부분에(@ 앞부분) k가 포함된 사원 정보 조회
SELECT * FROM EMPLOYEE
-- WHERE SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) LIKE '%k%';
WHERE EMAIL LIKE '%k%@%';

-- 연락처 앞자리가 010, 011로 시작하는 사원 수 조회
SELECT COUNT(*) "사원 수" FROM EMPLOYEE
-- WHERE PHONE LIKE '010%' OR PHONE LIKE '011%';
WHERE SUBSTR(PHONE, 1, 3) IN ('010', '011');

-- 생일이 7월이후인 사원들의 입사월별 사원 수 조회 (아래와 같이 출력)
/*
------------------------------------------------------------
    생월     |   입사월   |   입사 사원수|
         7월 |       4월 |          2명|
         7월 |       9월 |          1명|
         ...
         9월 |       6월 |          1명|
------------------------------------------------------------
*/
SELECT LPAD(SUBSTR(EMP_NO, 3, 2), 6) || '월' AS "생월"
        , LPAD(EXTRACT(MONTH FROM HIRE_DATE), 6) || '월' AS "입사월" 
        , LPAD(COUNT(*), 6) || '명' AS "입사 사원수"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 3, 2) >= 7
GROUP BY SUBSTR(EMP_NO, 3, 2), EXTRACT(MONTH FROM HIRE_DATE)
ORDER BY 생월, 2;

-- 영업부서 사원의 사번, 사원명, 부서명, 직급명 조회
--  사원, 부서, 직급
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;   -- 국내영업부 / 해외영업 1,2,3부
SELECT * FROM JOB;
-- ** 오라클 구문 **
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_TITLE 부서명, JOB_NAME 직급명
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID           -- EMPLOYEE 테이블 + DEPARTMENT 테이블
    AND E.JOB_CODE = J.JOB_CODE     -- EMPLOYEE 테이블 + JOB 테이블
    AND DEPT_TITLE LIKE '%영업%';     -- 영업 관련 부서에 대한 조건

-- ** ANSI 구문 **
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_TITLE 부서명, JOB_NAME 직급명
FROM EMPLOYEE E
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID  -- EMPLOYEE 테이블 + DEPARTMENT 테이블
    -- JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
    JOIN JOB USING (JOB_CODE)               -- EMPLOYEE 테이블 + JOB 테이블
WHERE DEPT_TITLE LIKE '%영업%';


-- 사수가 없는 사원 정보 조회 (부서명, 사번, 사원명 조회)
--  사원, 부서
-- ** 오라클 구문 **
SELECT DEPT_TITLE 부서명, EMP_ID 사번, EMP_NAME 사원명
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND MANAGER_ID IS NULL;

-- ** ANSI 구문 **
SELECT DEPT_TITLE 부서명, EMP_ID 사번, EMP_NAME 사원명
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE MANAGER_ID IS NULL;


-- 부서별 사수가 없는 사원 수 조회 (부서명, 사원수 조회)
-- ** 오라클 구문 **
SELECT DEPT_TITLE 부서명, COUNT(*) 사원수
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND MANAGER_ID IS NULL
GROUP BY DEPT_TITLE;


-- ** ANSI 구문 **
SELECT DEPT_TITLE 부서명, COUNT(*) 사원수
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE MANAGER_ID IS NULL
GROUP BY DEPT_TITLE;




