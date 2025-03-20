/*
    트리거(TRIGGER)
    : 지정한 테이블에 [이벤트 발생]=변경사항(DML : INSERT/UPDATE/UPDATE)이 있을때 자동으로 매번 실행할 내용을 미리 정의해두는 것 (객체와 같은)
    EX) 회원 탈퇴 시 기존 회원테이블 삭제(DELETE),
        탈퇴 회원 테이블에 데이터 추가(INSERT) 자동으로 실행...
    EX) 신고 횟수가 특정 값을 넘기면 블랙리스트로 처리(UPDATE)
*/
/*
    트리거 종류
    
    - SQL문의 실행 시기에 따른 분류
        * BEFORE TRIGGER: 지정한 테이블에 이벤트가 발생하기 전에 트리거 실행
        * AFTER TRIGGER: 지정한 테이블에 이벤트가 발생한 후에 트리거 실행
        
    - SQL문에 의해 영향을 받는 각 행에 따른 분류
        * 문장 트리거 : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 발생
        * 행 트리거 : 해당 SQL문이 실행될 때마다 매번 트리거 실행
                - FOR EACH ROW 옵션 설정해야 함
                
            : OLD - BEFORE UPDATE(수정전 데이터), BEFORE DELETE(삭제전 데이터)
            : NEW - AFTER INSERT(추가된 데이터), AFTER UPDATE(수정된 데이터)
*/
/*
    트리거 생성
    
    CREATE TRIGGER 트리거명                         -- 트리거의 기본정보
    BEFORE|AFTER INSERT|UPDATE|DELETE ON 테이블명   -- 이벤트 관련 정보
    [FOR EACH ROW]                                 -- 매번 트리거 발생 시킬 경우 작성
    [DECLARE ]              - 변수/상수 선언 및 초기화
    BEGIN                   - 실행부(SQL문, 조건문, 반복문...)
                            - 이벤트 발생 시 자동으로 처리하고자 하는 구문
    [EXCEPTION]             - 예외처리부
    END;
*/
--EMPLOYEE 테이블에 데이터가 추가될 때마다 '신입사원님 환영합니다'
CREATE TRIGGER TRG_EMP01
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN 
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다');
END;
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)VALUES(SEQ_EID.NEXTVAL, '홍길동', '456522-3543676', 'J6', SYSDATE);
-------------------------------------------------------------------------------
-- 상품 입고, 출고 관련, TB_PTRODUCT 테이블 생성
CREATE TABLE TB_PTRODUCT(
    PNO NUMBER PRIMARY KEY,     -- 상품번호
    PNAME VARCHAR2(30) NOT NULL, -- 상품명
    BRAND VARCHAR2(30) NOT NULL, -- 브랜드정보
    PRICE NUMBER DEFAULT 0,         -- 가격
    STOCK NUMBER DEFAULT 0          -- 재고 수량
);
-- SEQ_PNO 시퀀스 생성
CREATE SEQUENCE SEQ_PNO
START WITH 200
INCREMENT BY 5
NOCACHE;

-- 샘플 데이터 추가
INSERT INTO TB_PTRODUCT(PNO, PNAME, BRAND) VALUES (SEQ_PNO.NEXTVAL, '조립식PC', '삼성');
INSERT INTO TB_PTRODUCT VALUES (SEQ_PNO.NEXTVAL, '아이폰14', '애플', 13000000, 50);
INSERT INTO TB_PTRODUCT VALUES (SEQ_PNO.NEXTVAL, '앤디아폰1', '앤비디아', 10000000, 4);

SELECT * FROM TB_PTRODUCT;
COMMIT;
----------------------------------------------------
CREATE TABLE TB_PDETAIL(
    DNO NUMBER PRIMARY KEY,
    PNO NUMBER REFERENCES TB_PTRODUCT, --상품 번호
    DDATE DATE DEFAULT SYSDATE,        -- 입출고 날짜
    AMOUNT NUMBER NOT NULL,            -- 입출고 수량
    DTYPE CHAR(10) CHECK(DTYPE IN ('입고', '출고')) -- 입출고 종류
);
CREATE SEQUENCE SEQ_DNO -- 시작값1, 증가값1
NOCACHE;
------------*
--205번 상품, 오늘 5개 출고
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 205, DEFAULT, 5, '출고');
---* 
UPDATE TB_PTRODUCT
    SET STOCK = STOCK -5
    WHERE PNO=205;

SELECT * FROM TB_PDETAIL;
SELECT * FROM TB_PTRODUCT;

COMMIT;

-- 200Q 10개
INSERT INTO TB_PDETAIL VALUES(SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '입고');
UPDATE TB_PTRODUCT
    SET STOCK =STOCK +10
    WHERE PNO=200;
    
--------------------------------------------------------------------------------
/*
    TB_PDETAIL (입출고내역) : 테이블에 데이터가 추가되었을때
    TB_PTRODUCT (상품) : 테이블에 해당 데이터의 재고 수량을 갱신 및 업데이트 해야함
    
    -UPDATE 조건-
        상품이 입고된 경우 -> 해당 상품을 찾아서 재고 수량을 증가
        UPDATE TB_PTRODUCT
            SET STOCK = STOCK + 입고된 수량(TB_PDETAIL.AMOUNT) ==> NEW.AMOUNT
            WHERE PNO = 입고된상품번호(TB_PDETAIL.PNO)          ==> NEW.PNO
            
        상품이 출고된 경우 -> 해당 상품을 찾아서 재고 수량을 감소
        UPDATE TB_PTRODUCT
            SET STOCK = STOCK - 출고된 수량(TB_PDETAIL.AMOUNT) ==> :NEW.AMOUNT
            WHERE PNO = 출고된상품번호(TB_PDETAIL.PNO)          ==> :NEW.PNO
*/
--CREATE TRIGGER TRG_02
--------*선생님 버전
CREATE TRIGGER TRG_02
AFTER INSERT ON TB_PDETAIL
FOR EACH ROW
BEGIN
    IF :NEW.DTYPE='입고'  --> 새로 추가된 데이터(:NEW) 중 DTYPE 컬럼의 값이 입고인 경우
    THEN 
        UPDATE TB_PTRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PNO = :NEW.PNO;
    ELSE 
        UPDATE TB_PTRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PNO = :NEW.PNO;
    END IF;
END;

DROP TRIGGER TRG_02;
SELECT * FROM TB_PTRODUCT;
SELECT * FROM TB_PDETAIL;

INSERT INTO TB_PDETAIL VALUES(SEQ_DNO.NEXTVAL, 210, DEFAULT, 7, '입고');
INSERT INTO TB_PDETAIL VALUES(SEQ_DNO.NEXTVAL, 205, DEFAULT, 3, '출고');

COMMIT;