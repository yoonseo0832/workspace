-- TEST ��� �̸��� ���̺� �߰�
CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);

SELECT * FROM TEST;

-- ���� ������ �߰�
INSERT INTO TEST VALUES (100, '�׽�Ʈ1');

COMMIT;