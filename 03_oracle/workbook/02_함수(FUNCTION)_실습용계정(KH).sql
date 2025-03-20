/*
    함수(FUNCTION)
    : 전달된 컬럼 값을 읽어서 함수를 실행한 결과를 반환
    - 단일행 함수 : 여러개의 값을 읽어서 여러개의 결과값을 리턴 => 행마다 함수를 실행한 결과를 반환 
    - 그룹 함수 :  여러개의 값을 읽어서 한개의 결과값을 리턴 => 그룹을 지어 그룹별로 함수를 실행한 결과를 반환
    
    SELECT절에 단일함수와 그룹함수는 동시에 사용 불가
    => 결과 행의 개수가 다르기 때문에
    
    함수식을 사용하는 위치: SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
*/
--================================단일 함수======================================
/*
    문자타입의 데이터 처리 함수
    -> VARCHAR2 (n), CHAR (n)
    1. LENGTH(컬럼명 또는 리터럴값 = '문자열') :  해당 문자열의 글자수 반환
    2. LENGTHB(컬럼명 또는 '문자열'): 해당 문자열의 바이트수를 반환 (데이터 저장 단위)
    
    => 오라클에서 영문자, 숫자, 특수문자 : 글자당 1바이트로 처리 
                 한글:  글자당 3바이트씩 처리
*/
--오라클 단어의 글자수와 바이트수 반환
SELECT LENGTH('오라클') 글자수, LENGTHB('오라클') 바이트수
FROM DUAL; -- LENGTH: 3 , LENGTHB: 3*3

SELECT LENGTH('ORACLE') 글자수, LENGTHB('ORACLE') 바이트수
FROM DUAL; -- LENGTH: 6 , LENGTHB: 6

-- 사원정보 이름,=> 글자수 , 바이트수 / 이메일=> 글자수, 바이트수
SELECT EMP_NAME,LENGTH(EMP_NAME),LENGTHB(EMP_NAME), EMAIL,LENGTH(EMAIL),LENGTHB(EMAIL)
FROM EMPLOYEE;
--==============================================================================
/*
    INSTR  : 문자열로부터 특정 문자의 시작위치 반환
    [표현법] INSTR (컬럼 또는 '문자열' , '찾고자하는 문자'[, 찾을 위치의 시작값, 순법])
        => 함수 실행 결과값은 숫자타입으로
*/
SELECT INSTR ('AABAACAABBAA', 'B') FROM DUAL; -- 앞에서부터 첫번째 B의 위치: 3
SELECT INSTR ('AABAACAABBAA', 'B', 1) FROM DUAL; -- 시작 위치의 기본값은 1임
SELECT INSTR ('AABAACAABBAA', 'B', -1) FROM DUAL; 
-- 시작 위치를 음수값을 전달하면 => 뒤에서부터 찾아서 문자

 -- 앞에서부터 두번째 B의 위치: 9 앞에서 순번 2
SELECT INSTR ('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR ('AABAACAABBAA', 'B', -1, 2) FROM DUAL;

--사원 이메일 '_'의 첫번째 위치, 이메일'@' 첫번째 위치
SELECT EMAIL, INSTR (EMAIL, '_', 1, 1) "_ 위치", INSTR (EMAIL, '@', 1, 1) "@ 위치"
FROM EMPLOYEE;
--==============================================================================
/*
    SUBSTR : 문자열에서 특정 문자열을 추출해서 반환
    [표현법]
        SUBSTR('문자열' 또는 컬럼, 시작위치, 길이 개수)
        => 길이 생략하면 시작위치에서부터 끝까지 추출
*/
SELECT SUBSTR('ORACLE SQL DEVELOPER', 10) FROM DUAL;
SELECT SUBSTR('ORACLE SQL DEVELOPER', 12) FROM DUAL;
-- SQL만 추출
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL; -- 뒤에 원하는 글의 개수
SELECT SUBSTR('ORACLE SQL DEVELOPER', -9) FROM DUAL; -- 9부터 시작하는데 뒤에서부터 
SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL;  --3글자만 

-- 사원들 중 여사원들만 이름, 주민번호
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1)='2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');
-- 사원들 중 남사원들만 이름, 주민번호 => 이름을 기준으로 오름차순
SELECT EMP_NAME 직원명, EMP_NO
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1)='2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3')
ORDER BY 직원명 ASC; -- 순번으로도 가능, 컬럼명도 가능, 별칭도 가능

-- 이메일에서 @ 앞까지 추출
SELECT EMP_NAME 이름, EMAIL 이메일,SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) 아이디
FROM EMPLOYEE;
--==============================================================================
/*
    LPAD | RPAD : 문자열을 조회할 때 통일감있게 조회하고자 할때 사용
    [표현법]
        LPAD(문자열 또는 컬럼, 총 길이, ['덧붙일 문자']) -- 오른쪽에 덧붙일 문자를 사용해 채움 L ==> 왼쪽 정렬
        RPAD(문자열 또는 컬럼, 총 길이, ['덧붙일 문자']) -- 왼쪽에 덧붙일 문자를 사용해 채움 R ==> 왼쪽 정렬
        => 덧붙일문자를 생략할 경우 공백으로 채움
*/
-- 사원 정보 사원명 외쪽에 공백 20길이 조회
SELECT EMP_NAME, LPAD (EMP_NAME, 20) "사원명"
FROM EMPLOYEE;
-- 사원 정보 사원명  오른쪽에 공백 20길이 조회
SELECT EMP_NAME, RPAD (EMP_NAME, 20) "사원명"
FROM EMPLOYEE;

-- 사원 정보 이름, 이메일 조회
SELECT EMP_NAME NAME, LPAD (EMAIL, 20) EMAIL
FROM EMPLOYEE;

-- 사원 정보 이름, 이메일 조회
SELECT EMP_NAME NAME, RPAD (EMAIL, 20) EMAIL
FROM EMPLOYEE;

-- 사원 정보 이름, 이메일 조회,  #으로 공백 채우기
SELECT EMP_NAME NAME, RPAD (EMAIL, 20, '#') EMAIL
FROM EMPLOYEE;
-- 사원 정보 이름, 이메일 조회,  #으로 공백 채우기
SELECT '000201-1', RPAD('000201-1', 14, '*')
FROM DUAL;

-- 사원 이름, 주민번호
SELECT EMP_NAME,RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')    
FROM EMPLOYEE;
--==========================================================
/*
    LTRIM | RTRIM : 문자열에서 특정 문자를 제거한 후 나머지를 반환
    [표현법]
        LTRIM|RTRIM(문자열 꼬는 컬럼, ['제거할 문자들'])
        => 제거할 문자를 제시하지 않으면 공백으로 채움
*/
SELECT LTRIM('     HI') -- 왼쪽부터 다른문자가 나올때까지 공백 제거
FROM DUAL;

SELECT RTRIM('HI     ') -- 오른쪽부터 다른문자가 나올때까지 공백 제거
FROM DUAL;

SELECT LTRIM('123123H123', '123')
FROM DUAL;

SELECT LTRIM('123123H123', '321')
FROM DUAL;

SELECT LTRIM('KKHHII', '321')
FROM DUAL;

/*
    TRIM : 문자열 앞/뒤/양쪽에 있는 지정한 문자들을 제가한 후 나마지 값으 반환
    [표현법]
        TRIM([LEADING | TRAILING | BOTH] [제거할문자=생략가능 FROM 문자열 또는 컬럼]) 옵션 생략시 DEFAULT BOTH, 제거할 문자 생략시 공백 제거
*/
SELECT TRIM('    H   I    ') FROM DUAL;
SELECT TRIM('L' FROM 'LLLLLHLILLLL') FROM DUAL;
SELECT TRIM(BOTH 'L' FROM 'LLLLLHLILLLL') FROM DUAL; -- 기본값
SELECT TRIM(LEADING 'L' FROM 'LLLLLHLILLLL' )값 FROM DUAL; -- 왼쪽 LTRIM 과 유사
SELECT TRIM(TRAILING 'L' FROM 'LLLLLHLILLLL') FROM DUAL; -- 오른쪽 RTRIM 과 유사
--================================================================================
/*
    LOWER | UPPER | INITCAP
        - LOWER     문자열을 모두 소문자로 변경하여 결과 반환
        - UPPER     문자열을 모두 대문자로 변경하여 결과 반환
        - INITCAP   띄어쓰기를 기준으로 첫글자마다 대문자로 변경하여 결과 반환
*/
SELECT LOWER('Oh my god') FROM DUAL; -- 모두 소문자로
SELECT UPPER('Oh my god') FROM DUAL; -- 모두 대문자로
SELECT INITCAP('Oh my god') FROM DUAL; -- 시작하는 첫글자를 대문자로

SELECT 'KH', 'A강의장' FROM DUAL;
SELECT 'KH '|| 'A강의장' FROM DUAL;
SELECT CONCAT('KH ', 'A강의장') FROM DUAL;

-- 사원명 조회 사원명님 형식 조회
SELECT CONCAT(EMP_NAME, '님') 사원명  FROM EMPLOYEE;
SELECT EMP_NAME ||'님' 사원명 FROM EMPLOYEE;

SELECT CONCAT(EMP_ID, CONCAT(EMP_NAME, '님')) 사원정보  FROM EMPLOYEE;
--==============================================================================
/*
    REPLACE : 문자열에서 특정 부분을 제시한 문자열 또는 문자로 교체하여 반환 (문자 타입으로)
    [표현법]
        REPLACE( 컬럼/문자열, 찾을 문자열, 변경할 문자열(내용) )
*/
SELECT REPLACE('서울시 강남구', '강남', '종로') FROM DUAL;

SELECT EMAIL 이메일, REPLACE(EMAIL, '@kh.or.kr', '@gmail.com')  "변경 이메일" FROM EMPLOYEE;
--================================================================================
/*
    숫자 타입의 함수
        ABS : 숫자의 절대값을 구하는 함수
        
*/
SELECT ABS(-10.00) FROM DUAL;
/*
    MOD : 두 수를 나눈 나머지 값을 구해주는 함수
    MOD(숫자1, 숫자2) => 숫자1 % 숫자2
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
--=============================================================================
/*
    ROUND : 반올림한 값을 구해주는 함수
    ROUND(숫자, [위치]) => 소수점위치까지 반올림한 값을 구해줌
                        생략시 첫번째위치에서 반올림
*/
SELECT ROUND(123.456) FROM DUAL; -- .4위치에서 반올림 123
SELECT ROUND(123.456, 1) FROM DUAL; --._5위치에서 반올림 123.5
SELECT ROUND(123.456, 2) FROM DUAL; --.__6위치에서 반올림 123.46

SELECT ROUND(123.456, -1) FROM DUAL; -- 120 12_에서 반올림해서 소수점 위에서 
/*
    CEIL : 올림처리흫 한 결과를 반환해주는 함수
*/
SELECT CEIL(123.456) FROM DUAL;
/*
    FLOOR : 버림처리한 결과를 반환하는 함수
*/
SELECT FLOOR(123.456) FROM DUAL;
/*
    TRUNC : 버림처리한 결과를 반환해주는 함수, 위치지정 가능
*/
SELECT TRUNC(123.456, -1) FROM DUAL;
--==============================================================================
/*
    날짜 타입 관련 함수
*/
-- SYSDATE : 시스템의 현재 날짜 및 시간을 반환
SELECT SYSDATE FROM DUAL;
/*
    MONTHS_BETWEEN : 두 날짜 사이의 개월 수를 반환
    [표현식]
        MONTHS_BETWEEN(날짜1, 날짜2) : 날짜1 -날짜2 => 개월 수 반환
*/
SELECT CEIL (MONTHS_BETWEEN(SYSDATE ,'24/12/26')) || '개월차' FROM DUAL;

SELECT CEIL (MONTHS_BETWEEN('25/06/18', SYSDATE )) || '개월' FROM DUAL;
-- 사원명, 입사일, 근속개월수
SELECT EMP_NAME 사원명, HIRE_DATE 입사일, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))||'일' 근속개월수
FROM EMPLOYEE
WHERE ENT_YN='N';
---------------------------------------------------------------------------------
/*
    ADD_MONTHS ; 특정 날짜에 N개월 수를 더해서 반환
    [표현법] 
        ADD_MONTHS(날짜, 더할개월수)
*/
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) "3개월 이후" FROM DUAL;
-- 사원명, 입사일, 수습종료일
SELECT EMP_NAME 사원명, HIRE_DATE 입사일, ADD_MONTHS(HIRE_DATE, 3) 수습기간 FROM EMPLOYEE;
-----------------------------------------------------------------------------
/*
    NEXT_DAY : 특정 날짜 이후 지정한 요일의 가장 가까운 날짜를 반환
    [표현법]
        NEXT_DAT(날짜, 요일) => 요일(숫자(1: 일, 2:월,,.7: 토) | 문자)
*/
ALTER SESSION SET NLS_LANGUAGE=KOREAN;
SELECT  NEXT_DAY(SYSDATE, 1) FROM DUAL;
SELECT  NEXT_DAY(SYSDATE, '일') FROM DUAL;
SELECT  NEXT_DAY(SYSDATE, '일요일') FROM DUAL; -- 언어설정이 한국어로 되어있어서 영어로 SUNDAY하면 안됌
--언어 설정 ; AMERICAN  수정함
ALTER SESSION SET NLS_LANGUAGE=AMERICAN;
SELECT  NEXT_DAY(SYSDATE, 'SUN') FROM DUAL;
/*
    LAST_DAY : 해당 월의 마지막 날짜를 반환
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;
--사원명, 입사일, 입사한 마지막 달, 입사한 달의 근무일수
SELECT EMP_NAME 사원명, HIRE_DATE 입사일, LAST_DAY(HIRE_DATE) AS "입사월 마지막 날",  LAST_DAY(HIRE_DATE)-HIRE_DATE +1||'일' 근무일수
FROM EMPLOYEE;
---------------------------------------------------------------------------------
/*
    EXTRACT : 특정 날짜로부터 연도/월/일을 추출하여 반환해주는 함수
    [표현법]
        EXTRACT(YEAR FROM 날짜): 해당 날짜의 연도만 추출
        EXTRACT(MONTHS FROM 날짜): 해당 날짜의 월만 추출
        EXTRACT(DAY FROM 날짜): 해당 날짜의 일만 추출
*/
SELECT SYSDATE,
    EXTRACT(YEAR FROM SYSDATE) "연도",
    EXTRACT(MONTHS FROM SYSDATE)"월", 
    EXTRACT(DAY FROM SYSDATE)"일"
FROM DUAL;

SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) 연도,EXTRACT(MONTHS FROM HIRE_DATE) 월, EXTRACT(DAY FROM HIRE_DATE) 일
FROM EMPLOYEE
ORDER BY EXTRACT(YEAR FROM HIRE_DATE), EXTRACT(MONTHS FROM HIRE_DATE),EXTRACT(DAY FROM HIRE_DATE);
--ORDER BY 2, 3, 4;
-- 별칭으로도 가능 
-------------------------------------------------------------------------------
/*
    형변환 함수  :데이터 타입을 변경해주는 함수
            -> 문자, 숫자, 날짜
        TO_CHAR : 숫자 또는 날짜 타입의 값을 문자 타입으로 변경해주는 함수
        [표현법]
            TO_CHAR(숫자 또는 날짜[, 포맷])
*/
SELECT 1234 "숫자타입의 데이터", TO_CHAR(1234) "문자 타입으로 변환한 숫자" FROM DUAL;
SELECT TO_CHAR(1234) "타입 변경만 한 데이터", TO_CHAR(1234, '999999') "포맷지정데이터" FROM DUAL;
SELECT TO_CHAR(1234) "타입 변경만 한 데이터", TO_CHAR(1234, '000000') "포맷지정데이터" FROM DUAL;
SELECT  TO_CHAR(1234, 'L999999') FROM DUAL; -- L: 현재 설정된 언어ㅡ이 로컬 화페 단위를 표시함 
SELECT  TO_CHAR(10000000, 'L99,999,999') FROM DUAL; -- L: 현재 설정된 언어ㅡ이 로컬 화페 단위를 표시함 

-- 사원명, 월급, 연봉
SELECT EMP_NAME 사원명, TO_CHAR(SALARY, 'L99,999,999') 급여, TO_CHAR(SALARY*12, 'L9,999,999,999') 연봉
FROM EMPLOYEE;

--=================================================================================
-- 날짜 타입-> 문자타입으로 
SELECT SYSDATE, TO_CHAR(SYSDATE)
FROM DUAL;
-- =============================================================================
-- 시간 관련 패턴
-- HH HOUR 시 정보 --> 12시간제
-- HH24 --> 24시간제
-- MI 분 정보(MINITE) 
-- SS 초 정보(SECOND)

SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL; -- 12시간제
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; -- 24시간제

SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS') FROM DUAL; -- 24시간제
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- 24시간제
-- AM, PM 오전인지 오후인지 표시해주는 것
/*
    요일 관련 패턴
    -DAY : X요일 => 월요일, 화요일,,,,
    -DY : 월, 화, 수..
    - D: 숫자 타입으로 표시 (1 =일, 2=월, 7=토)
*/
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'D') FROM DUAL;
/*
    월 관련 패턴
     MON, MONTH : X월 표시
     MM : 월 정보를 2자리로 표현
*/
SELECT TO_CHAR(SYSDATE, 'MON MONTH') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MM') FROM DUAL;
/*
    일에 대한 패턴
    DD ; 일정보를 2자리로 표현
    DDD ; 해당 날짜의 해당 년도 기준 몇번째 일수 인지 표시
*/
SELECT TO_CHAR(SYSDATE, 'DD')"두자리 표현", TO_CHAR(SYSDATE, 'DDD')"몇번째 일수" FROM DUAL;
/*
    년도 관련 패턴
    YYYY : 년도를 4자리로 표현
    YY   : 두자리로 표현
    
    => 입력된 연도가 00~49일때 
        현재 연도의 끝 두자리가 00 ~ 49 -> 변환된 연도의 앞 두자리가 현재 연도와 동일
        현재 연도의 끝 두자리가 50 ~ 99 -> 변환된 연도의 앞 두자리가 현재 연도의 앞 두 자리의 +1
        
    => 입력된 연도가 50 ~ 99일때 
        현재 연도의 끝 두자리가 00 ~ 49 -> 변환된 연도의 앞 두자리가 현재 연도의 앞 두 자리의 -1
        현재 연도의 끝 두자리가 00 ~ 49 -> 변환된 연도의 앞 두자리가 현재 연도와 동일
    RRRR : 년도를 4자리로 표현
    RR   : 두자리로 표현
*/
SELECT TO_CHAR(TO_DATE('250304', 'RRMMDD'), 'YYYY')"RR사용(50미만)", TO_CHAR(TO_DATE('550304', 'RRMMDD'), 'YYYY')"RR사용(50이상)", TO_CHAR(TO_DATE('250304', 'YYMMDD'), 'YYYY')"YY사용(50미만)", TO_CHAR(TO_DATE('550304', 'YYMMDD'), 'YYYY')"YY사용(50이상)"
FROM DUAL;
-- 사원명, 입사날짜 조회 단, 입사날짜 형식을 XXXX년XX월XX일 형식으로
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') "입사날짜"
FROM EMPLOYEE;
/*
    TO_DATE : 숫자타입 또는 문자타입을 날짜 타입으로 변경해주는 함수
    [표현법]
        TO_DATE(숫자, 문자, [패턴])
*/
SELECT TO_DATE(20250304) FROM DUAL;
SELECT TO_DATE(250304) FROM DUAL; --> 50년 미만 자동으로 20XX 로 변경
SELECT TO_DATE(550304) FROM DUAL; --> 50년 이상은 자동으로 19XX로 설정

SELECT TO_DATE(020222) FROM DUAL; --> 숫자는 0으로 시작 불가
SELECT TO_DATE('020222') FROM DUAL; --> 0으로 시작하는 경우 문자타입으로 제시하면 됨   '' 

SELECT TO_DATE('20250304 104230')FROM DUAL; -- 시간 포함하는 경우 패턴을 지정해야함
SELECT TO_DATE('20250304 104230', 'YYYYMMDD HH24MISS')FROM DUAL;

/*
    TO_NUMBER : 문자타입의 데이터를 숫자타입으로 변경해주는 함수
    -> 기호 포함되거나 화폐 단위를 포함하는 경우 패턴 지정
*/
SELECT TO_NUMBER('0123456789') FROM DUAL;
SELECT '10000'+ '500' FROM DUAL;
SELECT '10000'+ '500' FROM DUAL;
SELECT TO_NUMBER('10,000', '99,999')+TO_NUMBER('500', '999') FROM DUAL;
--===============================================================================
/*
    null 처리 함수
    NVL  ; 해당 컬럼의 값이 NULL인 경우 다른 값으로 사용할 수 있도록 변경해주는 함수
    [표현법] 
        NVL(컬럼명, 해당컬럼의 값이 NULL인 경우 사용할 값)
*/
--사원명, 보너스 정보 조회
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;
-- 사원명, 연봉, 보너스 포함 연봉
SELECT EMP_NAME, NVL(BONUS, 0)"보너스", SALARY*12 "연봉", (SALARY + (SALARY * NVL(BONUS, 0)))*12 "보너스 포함 연봉"
FROM EMPLOYEE
ORDER BY "보너스 포함 연봉" DESC;
/*
    NVL2 : 해당 컬럼의 값이 NULL인 경우 표시할 값 지정, NULL아닌 경우 표시할 값도 지정 가능 => 데이터 있는 경우
    [표현법]
        NVL2(컬럼명, 데이터기 존재하는 경우 사용할 값, NULL인 경우 사용할 값)
*/
-- 사원명, 보너스 있는지 없는지 여부 조회
SELECT EMP_NAME,BONUS, NVL2(BONUS, 'O', 'X') "보너스 유무" FROM EMPLOYEE;
-- 사원명, 부서코드, 부서배치여부
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '배정완료', '미배정')"부서 배치여부"
FROM EMPLOYEE;
/*
    NULLIF : 두 값이 일치하면 NULL, 일치하지 않는다면 비교대상 첫번째 항목을 반환
    [표현법]
        NULLIF(비교대상1, 비교대상2 ) IF 노일치 => 비교대상1 리턴
*/
SELECT NULLIF('999', '999') FROM DUAL; -- NULL
SELECT NULLIF('999', '000') FROM DUAL; -- 999
--===============================================================================
/*
    선택함수
    DECODE(비교대상, 비교값1,비교값2, 결과값2,..... )
    --> 자바 switch(비교대상){
        case 비교값1 : 결과값1;
        case ...
    }
*/
-- 사번, 사원며명, 주민번호ㅡ 성별
SELECT EMP_ID, EMP_NAME, EMP_NO 주민번호, 
DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여', '알수없음') 성별
FROM EMPLOYEE;
-- 사원명, 기존급여, 인상된 급여
/*
J7 => 10% , J6 => 15%, J5 => 20%, 그외 5%
*/
SELECT EMP_NAME, JOB_CODE,SALARY,
    DECODE(JOB_CODE, 
        'J7', SALARY*1.1, 
        'J6',SALARY*1.15,
        'J5',SALARY*1.2,  
        SALARY*1.05) "인상된 급여" 
FROM EMPLOYEE;
/*
    CASE WHEN THEN : 조건식에 따라 걀과값을 반환해주는 함수
    [표현식]
        CASE 
            WHEN 조건식1 THEN 결과값1
            WHEN 조건식2 THEN 결과값2
            ....
            ELSE 결과값
        END
        --> 자바의 IF~ELSE문 과 비슷
*/
-- 사원명, 급여, 급여에 따른 등급 500이상 고급, 350이상 중급 그외 초급
SELECT EMP_NAME, SALARY, 
    CASE 
        WHEN SALARY >=5000000 THEN '상급' 
        WHEN SALARY >=3500000 THEN '중급'
        ELSE '초급'
    END"급여에 따른 등급"
FROM EMPLOYEE;
--================================================================================
/*
    그룹함수
    SUM : 해당 컬럼의 값들의 총 합을 반환해주는 함수
    [표현법]
        SUM(숫자타입의 컬럼)
*/
-- 전체 사원 급여
SELECT SUM(SALARY) FROM EMPLOYEE;
-- XXX,XXX,XXX 형식으로 조회하여면 
SELECT TO_CHAR(SUM(SALARY), '999,999,999') FROM EMPLOYEE;
-- 남자 사원의 총 급여
SELECT SUM(SALARY)"남사원의 총 급여"  --3
FROM EMPLOYEE                       --1
WHERE SUBSTR(EMP_NO, 8, 1)='1';     --2
-- 여자 사원의 총 급여
SELECT SUM(SALARY)"남사원의 총 급여"  --3
FROM EMPLOYEE                       --1
WHERE SUBSTR(EMP_NO, 8, 1)='2';     --2
-- 부서코드 'D5' 사원의 총 연봉
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE ='D5';
--=============================================================================
/*
    AVG : 해당 컬럼의 값들의 평균을 반환하는 함수
*/
-- 전체 사원들 평균 급여 반올림해것
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;
--==============================================================================
/*
    MIN : 해당 컬럼의 값들 중 가장 작은 값을 반환해주는 함수
*/
SELECT MIN(EMP_NAME) "문자타입 최솟값", MIN(SALARY)"숫자타입 최솟값", MIN(HIRE_DATE)"날짜 타입 최솟값"
FROM EMPLOYEE;
/*
    MAX : 해당 컬럼의 값들 중 가장 큰 값을 반환해주는 함수
*/
SELECT MAX(EMP_NAME) "문자타입 최솟값", MAX(SALARY)"숫자타입 최솟값", MAX(HIRE_DATE)"날짜 타입 최솟값"
FROM EMPLOYEE;
/*
    COUNT : 행의 갯수를 반환해주는 함수 단, 조건이 있을 경우 해당 조건에 맞는 행의 갯수를 반환
    EX) COUNT (*) => 모든 행의 갯수를 반환, COUNT (컬럼) => 해당 컬럼의 값이 NULL아닌 행만 갯수 세어서 반환, COUNT (DISTINCT 컬럼) => 중복 제거시 NULL은 포함하지 않고 갯수를 셈
*/
SELECT COUNT(*)"전체사원수" FROM EMPLOYEE;
SELECT COUNT(*)"남직원수" 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) =1;
-- 여직우너수
SELECT COUNT(*)"여직원수" 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) =2;

--보너스를 받는 직우너수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
-- COUNT 원해 NUL제거하고 갯수셈
SELECT COUNT(BONUS)
FROM EMPLOYEE;

SELECT COUNT(DEPT_CODE)"부서배치 받은 사람 수"
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE)"소속사원이 있는 부서의 수"
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE "중복 제거, 부서배치 받은 사람 수"
FROM EMPLOYEE;
