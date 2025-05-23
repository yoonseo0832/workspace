-- 1.
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

-- 2.
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) <> 3;

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE NOT PROFESSOR_NAME LIKE '___';


-- 3.
SELECT PROFESSOR_NAME 교수이름
   , EXTRACT(YEAR FROM SYSDATE) 
        - TO_NUMBER('19'||SUBSTR(PROFESSOR_SSN, 1, 2)) "나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 2;

-- 4.
SELECT SUBSTR(PROFESSOR_NAME, 2) 이름
FROM TB_PROFESSOR;

-- 5.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - TO_NUMBER('19' || SUBSTR(STUDENT_SSN, 1, 2)) = 20;

-- 6.
SELECT TO_CHAR(TO_DATE('201225'), 'DAY') "2020년 크리스마스" FROM DUAL;

-- 7. 
SELECT TO_DATE('99/10/11', 'YY/MM/DD')  -- 2099/10/11
    , TO_DATE('49/10/11', 'YY/MM/DD')   -- 2049/10/11
    , TO_DATE('99/10/11', 'RR/MM/DD')   -- 1999/10/11
    , TO_DATE('49/10/11', 'RR/MM/DD')   -- 2049/10/11
FROM DUAL;

-- 8.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9.
SELECT ROUND(AVG(POINT), 1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10.
SELECT DEPARTMENT_NO 학과번호, COUNT(*) "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 11.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12.
SELECT SUBSTR(TERM_NO, 1, 4) 년도, ROUND(AVG(POINT), 1) "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4);

-- 13.
SELECT DEPARTMENT_NO 학과코드명
    , COUNT(DECODE(ABSENCE_YN, 'Y', 1)) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 14. 
SELECT STUDENT_NAME 동일이름, COUNT(*) "동명이인 수"
FROM TB_STUDENT 
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY 1;

-- 15.
SELECT SUBSTR(TERM_NO, 1, 4) "년도", SUBSTR(TERM_NO, 5, 2) "학기"
    , ROUND(AVG(POINT), 1) "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
ORDER BY 1, 2;