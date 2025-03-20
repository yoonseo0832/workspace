--  한줄 주석
/*
    여러줄 주석 , 파일명이 기울어지면 저장하지 않은 상태
*/
-- 현재 모든 계정들을 대하여 조회하는 명령문
SELECT * FROM DBA_USERS; -- 실행하면 질의결과가 나옴, 한 행이 한 세트임
-- 명령문(sql) 실행: 재생버튼 클릭 또는 Ctrl + Enter 키보드 입력

-- 일반 사용자 계정 생성 구문  => 관리자 계정으로만 일반 계정 만들수 있음
-- [표현법] CREATE USER [계정명=사용자명] IDENTIFIED BY 비밀번호;
-- * 12c 버전부터는 계정명 앞에 C##을 붙여줘야함

-- (1) * 사용자명 KH 비밀번호 KH 인 계정을 추가
CREATE USER C##KH  IDENTIFIED BY KH; -- C##을 계정명 앞에 붙여야함
CREATE USER C##TEST250305 IDENTIFIED BY test0305;
-- 계정 생성 시 C## 을 제외하고 이전 방식처럼 하고자 할때
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- *위의 명령문을 SQL Developer 실행할 때마다 명령문 실행해야함
-- CREATE USER KHTEST IDENTIFIED BY KHTEST; -- 테스트용 추가

-- (2) * 권한 부여 
-- 생성한 사용자에게 최소한의 권한을 부여(접속, 객체 생성 권한)
-- [표현법] GRANT 권한1, 권한2,.. TO 계정명;
GRANT CONNECT, RESOURCE TO C##KH;
GRANT CONNECT, RESOURCE TO C##TEST250305;
-- CONNECT 권한 : 연결 권한 
-- RESOURCE 권한 데이터 관리, DB에서 객체(테이블, 시퀀스, 프로시저, 트리거 등) 생성 권한

-- 테이블 스페이스 관련 설정 | 스크립트 실행 오류 방지용
ALTER USER C##KH DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
ALTER USER C##TEST250305 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

CREATE USER C##TEST0228 IDENTIFIED BY TEST0228;
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
GRANT CONNECT, RESOURCE TO C##TEST0228;
ALTER USER  C##TEST0228 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;






