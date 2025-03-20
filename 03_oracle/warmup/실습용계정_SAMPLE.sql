-- TEST 테이블 생성
CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);
--권한이 불충분합니다

SELECT * FROM TEST;

-- 샘플 데이터 추가 
INSERT INTO TEST VALUES (100, '테스트1');
--테이블스페이스 'USERS'에 대한 권한이 없습니다.
COMMIT;