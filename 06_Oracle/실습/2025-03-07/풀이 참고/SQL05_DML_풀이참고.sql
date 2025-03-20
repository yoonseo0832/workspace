-- SQL05_DML.pdf

-- 1. 과목 유형 테이블에 데이터 추가 (DML - INSERT)
SELECT * FROM TB_CLASS_TYPE;

INSERT INTO TB_CLASS_TYPE VALUES ('01', '전공필수');
INSERT INTO TB_CLASS_TYPE VALUES ('02', '전공선택');
INSERT INTO TB_CLASS_TYPE VALUES ('03', '교양필수');
INSERT INTO TB_CLASS_TYPE VALUES ('04', '교양선택');
INSERT INTO TB_CLASS_TYPE VALUES ('05', '논문지도');
COMMIT;


-- 2. 학생들의 정보가 포함되어 있는 학생일반정보 테이블 생성 (서브쿼리 이용) (DDL - CREATE)
CREATE TABLE TB_학생일반정보
AS ( SELECT STUDENT_NO 학번, STUDENT_NAME 학생이름, STUDENT_ADDRESS 주소 FROM TB_STUDENT );

SELECT * FROM TB_학생일반정보;


-- 3. 국어국문학과 학생들의 정보만이 포함되어 있는 학과정보 테이블 생성 (DDL - CREATE)
CREATE TABLE TB_국어국문학과 
AS ( SELECT STUDENT_NO 학번, STUDENT_NAME 학생이름
          , TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 2), 'RR'), 'YYYY') 출생년도
          , PROFESSOR_NAME 교수이름
       FROM TB_STUDENT S
            LEFT JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO 
            -- JOIN TB_DEPARTMENT D USING (DEPARTMENT_NO) 
            --> DEPARTMENT_NO 컬럼이 TB_STUDENT 테이블에도 존재하고, TB_PROFESSOR 테이블에도 존재함!
            JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO            
        WHERE DEPARTMENT_NAME = '국어국문학과' );

SELECT * FROM TB_국어국문학과;


-- 4. 현 학과들의 정원을 10% 증가시키고자 한다. 단, 반올림을 사용하여 소수점 자릿수는 생기지 않도록 한다.
UPDATE TB_DEPARTMENT
   SET CAPACITY = ROUND(CAPACITY * 1.1);


-- 5. 학번이 'A413042'인 박건우 학생의 주소가 '서울시 종로구 숭인동 181-21'로 변경되었다고 한다.
SELECT * FROM TB_STUDENT WHERE STUDENT_NAME = '박건우' AND STUDENT_NO = 'A413042';

UPDATE TB_STUDENT
   SET STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21'
 WHERE STUDENT_NAME = '박건우' AND STUDENT_NO = 'A413042';


-- 6. 주민등록번호 보호법에 따라 학생정보 테이블에서 주민번호 뒷자리를 저장히지 않도로 결정되었다. 
UPDATE TB_STUDENT
   SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);
   
SELECT * FROM TB_STUDENT WHERE LENGTH(STUDENT_SSN) <> 6;
--> 반영되지 않은 데이터가 있는 지 조회**


-- 7. 의학과 김명훈 학생은 2005년 1학기에 자신이 수강한 '피부생리학'점수가 잘못되었다는 것을
--    발견하고 정정 요청을 하였다. 해당 과목의 학점을 3.5로 변경하라
SELECT POINT, STUDENT_NAME, DEPARTMENT_NAME, TERM_NO, CLASS_NAME 
  FROM TB_GRADE 
       JOIN TB_STUDENT USING (STUDENT_NO)
       JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
       JOIN TB_CLASS USING (CLASS_NO)
 WHERE DEPARTMENT_NAME = '의학과' 
       AND STUDENT_NAME = '김명훈'
       AND TERM_NO = '200501' AND CLASS_NAME = '피부생리학';

UPDATE TB_GRADE 
   SET POINT = 3.5
 WHERE STUDENT_NO = ( SELECT STUDENT_NO
                        FROM TB_STUDENT
                             JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
                       WHERE DEPARTMENT_NAME = '의학과'
                             AND STUDENT_NAME = '김명훈' )
       AND CLASS_NO = ( SELECT CLASS_NO
                          FROM TB_CLASS
                         WHERE CLASS_NAME = '피부생리학' )
       AND TERM_NO = '200501';
       
COMMIT;


-- 8. 성적 테이블에서 휴학생들의 성적항목을 제거
SELECT COUNT(*) FROM TB_GRADE JOIN TB_STUDENT USING (STUDENT_NO)
    WHERE ABSENCE_YN = 'Y';

DELETE FROM TB_GRADE
 WHERE STUDENT_NO IN ( SELECT STUDENT_NO FROM TB_STUDENT WHERE ABSENCE_YN = 'Y' );

COMMIT;