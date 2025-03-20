/*
    시퀀스 SEQUENCE 
    : 자동으로 번호를 발생시켜주는 역할을 하는 객체
      정수를 순차적으로 일정한 값마다 증가시키면서 생성
      
      EX) 사번, 회원번호, 도서번호,,, -> 기본키로 사용했던 컬럼들
*/
/*
    시퀀스
    [표현법]
        CREATE SEQUENCE 시퀀스명
        [옵션: 모두 생략 가능]
        START WITH 숫자       -> 처음 발생시킬 시작값 지정 가능, 생략시 기본값 1
        INCREMENT BY 숫자     -> 얼마만큼씩 증가시킬 것인지에 대한 값을 지정, 생략시 기본값 1
        MAXVALUE 숫자         -> 최대값 생략시 기본값 ...엄청큼(샐수 없을 만큼)
        MINVALUE 숫자         -> 최소값, 생략시 기본값 1
        CYCLE | NOCYCLE      -> 값의 순환여부 (기본값 = NOCYCLE)
                            CYCLE : 시퀀스 값이 최대값에 도달하면 최소값으로 다시 순환하도록 설정
                            NOCYCLE : 시퀀스 값이 최대값에 도달하면 더 이상 증가시키지 않도록 설정
        NOCACHE | CACHE 숫자  -> 캐시메모리 항달 여부 (기본값 CACHE 20)
                                * 캐시메모리: 미리 발생될 값들을 생성해서 저장해두는 공간
                                매번 호출될 때마다 새로 번호를 생성하는 것이 아니라 캐시메모리라는 공간에 미리 생성해둔 값을
                                가져다가 사용(속도가 빠름)
        참고 {이름 지어주기 규칙}
            - 테이블 : TB_
            - 뷰 : VW_
            - 시퀀스 : SEQ_
            - 트리거 : TRG_
*/
-- 시퀀스 생성 : SEQ_TEST라는 이름으로
CREATE SEQUENCE SEQ_TEST;
-- 현재 계정에 생성된 시퀀스 조회
SELECT * FROM USER_SEQUENCES;

-- SEQ_EMPNO 시퀀스 생성
-- 시작번호 300, 증가값 5, 최대값 310, 순환 안함, 캐시메모리 없음
CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE -- 생략가능
NOCACHE;
------------------------------------------------------------------------------
/*
    시퀀스 사용
    
    - 시퀀스명.CURRVAL : 현재 시퀀스 값, 마지막으로 성공한 NEXTVAL의 수행한 값
    - 시퀀스명.NEXTVAL : 시퀀스 값에 일정 값을 증가시켜 발생한 결과값
                        현재 시퀀스 값에서 INCREMENT BY 에 설정된 값만큼 증가된 값
*/
-- SEQ_EMPNO 시퀀스의 현재 시퀀스 값 조회
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- NEXTVAL 이후는 300 조회 가능
-- 시퀀스 SEQ_EMPNO.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다
-- select NEXTVAL from the sequence before selecting CURRVAL
-- NEXTVAL을 한번도 수행하지 않은 시퀀스는 CURRVAL을 사용 불가
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- NEXTVAL 의 경우 생성 후 처음 수행 시 시작 값을 확인 가능 : 300
--시퀀스 SEQ_EMPNO.NEXTVAL exceeds MAXVALUE은 사례로 될 수 없습니다 설정된 최대값 310을 초과해서 오류 발생!
/*
    시퀀스 변경
        ALTER SEQUENCE 시퀀스명
        [옵션]
        INCREMENT BY 숫자     
        MAXVALUE 숫자        
        MINVALUE 숫자        
        CYCLE | NOCYCLE                 
        NOCACHE | CACHE 숫자 
        
        *시작값 외에는 모두 변경 가능하다, 시작값 = START WITH 는 변경이 불가능하다*
*/
ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --310
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --310 + 10 = 320

/*
    시퀀스 삭제
    
    DROP SEQUENCE 시퀀스명;
*/
DROP SEQUENCE SEQ_EMPNO;

SELECT * FROM USER_SEQUENCES;
------------------------------------------------------------------------------
/*
    EMPLOYEE 테이블에 시퀀스 적용해보기
    => EMP_ID에 사용 (사번)
*/
--시퀀스 생성(SEQ_EID) 300 부터 시작, 캐시메모리 없음, 증가값1씩, 
CREATE SEQUENCE SEQ_EID
START WITH 300
NOCACHE;
-- 시작값 : 300 | 증가값 : 1 | 순환여부 : NOCYCLE | 최대값 : 엄청큰 값
-- 시퀀스 사용 : EMPLOYEE 테이블에 데이터가 추가될때
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
        VALUES (SEQ_EID.NEXTVAL, '이윤서', '023155-425644', 'J5', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
        VALUES (SEQ_EID.NEXTVAL, '김윤서', '023155-425644', 'J5', SYSDATE);

SELECT * FROM EMPLOYEE;

ROLLBACK;   -- 임시데이터 추가 취소