-- SQL04_DDL.pdf

-- 1. 계열 정보를 저장할 카테고리 테이블을 생성 (DDL - CREATE)
CREATE TABLE TB_CATEGORY (
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

-- 2. 과목 구분을 저장할 테이블을 생성 (DDL - CREATE)
CREATE TABLE TB_CLASS_TYPE (
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

-- 3. TB_CATEGORY 테이블의 NAME 컬럼에 PRIMARY KEY를 생성. --> 제약조건 추가 (DDL - ALTER)
ALTER TABLE TB_CATEGORY
        ADD CONSTRAINT TB_CATEGORY_NAME_PK PRIMARY KEY (NAME);
        -- ADD CONSTRAINT PRIMARY KEY (NAME);

-- 4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성 변경
--      --> 제약조건 추가 (DDL - ALTER)
ALTER TABLE TB_CLASS_TYPE
        MODIFY NAME NOT NULL;


-- 5. 두 테이블에서 컬럼 명이 NO인 것은 기존 타입을 유지하면서 크기는 10으로
--                컬럼 명이 NAME인 것은 마찬가지로 기존 타입을 유지하면서 크기 20으로 변경
--    --> 컬럼의 데이터타입 변경 (DDL - ALTER)
ALTER TABLE TB_CATEGORY
        MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE
        MODIFY NO VARCHAR2(10)
        MODIFY NAME VARCHAR2(20);

-- 6. 두 테이블의 NO컬럼과 NAME컬럼의 이름을 각각 TB_를 제외한 테이블 이름이 앞에 붙는 형태로 변경
ALTER TABLE TB_CATEGORY
            RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
            RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE            
            RENAME COLUMN NAME TO CLASS_TYPE_NAME;
--> 컬럼명 변경할 때는 결합하여 사용할 수 없음! (오류 발생)


-- 7. TB_CATEGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이 변경하시오.
--    PK_컬럼이름
ALTER TABLE TB_CATEGORY
            RENAME CONSTRAINT TB_CATEGORY_NAME_PK TO PK_CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
            RENAME CONSTRAINT SYS_C008497 TO PK_CLASS_TYPE_NO;


-- 8. INSERT문 수행
INSERT INTO TB_CATEGORY VALUES ('공학', 'Y');
INSERT INTO TB_CATEGORY (CATEGORY_NAME) VALUES ('자연과학');
INSERT INTO TB_CATEGORY (CATEGORY_NAME) VALUES ('의학');
INSERT INTO TB_CATEGORY (CATEGORY_NAME) VALUES ('예체능');
INSERT INTO TB_CATEGORY (CATEGORY_NAME) VALUES ('인문사회');
COMMIT;


-- 9. TB_DEPARTMENT 의 CATEGORY 컬럼이 TB_CATEGORY테이블의 CATEGORY_NAME 컬럼을
--    부모값으로 참조하도록 FOREIGN KEY 를 지정하시오.  --> 제약조건 추가
--    KEY 이름은 FK_테이블이름_컬럼이름 --> 제약조건명
ALTER TABLE TB_DEPARTMENT
            ADD CONSTRAINT FK_DEPARTMENT_CATEGORY
                FOREIGN KEY (CATEGORY) REFERENCES TB_CATEGORY (CATEGORY_NAME);


-- 10. 학생들의 정보만이 포함되어 있는 학생일반정보 VIEW 생성
-- VIEW 생성 권한 부여 (GRANT)
GRANT CREATE VIEW TO C##WORKBOOK;       -- 관리자 계정으로 실행*

CREATE VIEW VW_학생일반정보
AS ( SELECT STUDENT_NO 학번, STUDENT_NAME 학생이름, STUDENT_ADDRESS 주소
     FROM TB_STUDENT );

CREATE OR REPLACE VIEW VW_학생일반정보 (학번, 학생이름, 주소)
AS ( SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS FROM TB_STUDENT );

SELECT * FROM VW_학생일반정보;


-- 11. 1년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행
--      학생이름, 학과이름, 담당교수이름으로 구성된 VIEW 생성
--      이때, 지도 교수가 없는 학생이 있을 수 있음을 고려하시오.
--        단, 이 VIEW는 단순 조회(SELECT)만 할 경우 학과별로 정렬되어 보여지도록...
CREATE VIEW VW_지도면담 (학생이름, 학과이름, 지도교수이름)
AS
    SELECT STUDENT_NAME, DEPARTMENT_NAME, NVL(PROFESSOR_NAME, '지도교수 없음')
      FROM TB_STUDENT
           LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
           LEFT JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
    ORDER BY 2; -- DEPARTMENT_NAME

SELECT * FROM VW_지도면담;


-- 12. 모든 학과의 학과별 학생 수를 확인할 수 있는 VIEW 생성
CREATE VIEW VW_학과별학생수 (DEPARTMENT_NAME, STUDENT_COUNT)
AS
    SELECT DEPARTMENT_NAME, COUNT(*)
      FROM TB_DEPARTMENT
           JOIN TB_STUDENT USING(DEPARTMENT_NO)
     GROUP BY DEPARTMENT_NAME;

SELECT * FROM VW_학과별학생수;


-- 13. 학생일반정보 VIEW를 통해서 학번이 A213046인 학생의 이름을 본인 이름으로 변경
--      데이터 변경-> DML(UPDATE)

SELECT * FROM VW_학생일반정보 WHERE 학번 = 'A213046'; -- 서가람 학생

UPDATE VW_학생일반정보
   -- SET 학생이름 = '임수진'
   SET 학생이름 = '서가람' -- 아래 14번 명령문 사용 후 실행 시 오류 발생!!(옵션이 잘 적용됨)
 WHERE 학번 = 'A213046';

-- 14. 뷰를 통해서 데이터 변경을 막기 위한 뷰 생성 방법 => WITH READ ONLY
CREATE OR REPLACE VIEW VW_학생일반정보 (학번, 학생이름, 주소)
AS ( SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS FROM TB_STUDENT )
WITH READ ONLY;


-- 15. 매년 수강신청 기간만 되면 특정 인기 과목들에 수강 신청이 몰린다.
--     최근 3년 기준 수강인원이 가장 많았던 3과목을 찾는 구문을 작성 ( 2005 ~ 2009년 )
SELECT 과목번호, 과목이름, "누적수강생수(명)"
FROM (
        SELECT CLASS_NO 과목번호, CLASS_NAME 과목이름, COUNT(*) "누적수강생수(명)"
          FROM TB_GRADE
               JOIN TB_CLASS USING (CLASS_NO)
         WHERE TERM_NO LIKE '2005%'
               OR TERM_NO LIKE '2006%'
               OR TERM_NO LIKE '2007%'
               OR TERM_NO LIKE '2008%'
               OR TERM_NO LIKE '2009%'
         GROUP BY CLASS_NO, CLASS_NAME
         ORDER BY 3 DESC )      --> FROM절에 사용된 서브쿼리를 "인라인 뷰"라고 표현함!
WHERE ROWNUM <= 3;
