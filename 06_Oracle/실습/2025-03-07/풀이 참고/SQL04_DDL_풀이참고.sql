-- SQL04_DDL.pdf

-- 1. �迭 ������ ������ ī�װ� ���̺��� ���� (DDL - CREATE)
CREATE TABLE TB_CATEGORY (
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

-- 2. ���� ������ ������ ���̺��� ���� (DDL - CREATE)
CREATE TABLE TB_CLASS_TYPE (
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

-- 3. TB_CATEGORY ���̺��� NAME �÷��� PRIMARY KEY�� ����. --> �������� �߰� (DDL - ALTER)
ALTER TABLE TB_CATEGORY
        ADD CONSTRAINT TB_CATEGORY_NAME_PK PRIMARY KEY (NAME);
        -- ADD CONSTRAINT PRIMARY KEY (NAME);

-- 4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ� ����
--      --> �������� �߰� (DDL - ALTER)
ALTER TABLE TB_CLASS_TYPE
        MODIFY NAME NOT NULL;


-- 5. �� ���̺��� �÷� ���� NO�� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10����
--                �÷� ���� NAME�� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20���� ����
--    --> �÷��� ������Ÿ�� ���� (DDL - ALTER)
ALTER TABLE TB_CATEGORY
        MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE
        MODIFY NO VARCHAR2(10)
        MODIFY NAME VARCHAR2(20);

-- 6. �� ���̺��� NO�÷��� NAME�÷��� �̸��� ���� TB_�� ������ ���̺� �̸��� �տ� �ٴ� ���·� ����
ALTER TABLE TB_CATEGORY
            RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
            RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE            
            RENAME COLUMN NAME TO CLASS_TYPE_NAME;
--> �÷��� ������ ���� �����Ͽ� ����� �� ����! (���� �߻�)


-- 7. TB_CATEGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ���� �����Ͻÿ�.
--    PK_�÷��̸�
ALTER TABLE TB_CATEGORY
            RENAME CONSTRAINT TB_CATEGORY_NAME_PK TO PK_CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
            RENAME CONSTRAINT SYS_C008497 TO PK_CLASS_TYPE_NO;


-- 8. INSERT�� ����
INSERT INTO TB_CATEGORY VALUES ('����', 'Y');
INSERT INTO TB_CATEGORY (CATEGORY_NAME) VALUES ('�ڿ�����');
INSERT INTO TB_CATEGORY (CATEGORY_NAME) VALUES ('����');
INSERT INTO TB_CATEGORY (CATEGORY_NAME) VALUES ('��ü��');
INSERT INTO TB_CATEGORY (CATEGORY_NAME) VALUES ('�ι���ȸ');
COMMIT;


-- 9. TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY���̺��� CATEGORY_NAME �÷���
--    �θ����� �����ϵ��� FOREIGN KEY �� �����Ͻÿ�.  --> �������� �߰�
--    KEY �̸��� FK_���̺��̸�_�÷��̸� --> �������Ǹ�
ALTER TABLE TB_DEPARTMENT
            ADD CONSTRAINT FK_DEPARTMENT_CATEGORY
                FOREIGN KEY (CATEGORY) REFERENCES TB_CATEGORY (CATEGORY_NAME);


-- 10. �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW ����
-- VIEW ���� ���� �ο� (GRANT)
GRANT CREATE VIEW TO C##WORKBOOK;       -- ������ �������� ����*

CREATE VIEW VW_�л��Ϲ�����
AS ( SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�, STUDENT_ADDRESS �ּ�
     FROM TB_STUDENT );

CREATE OR REPLACE VIEW VW_�л��Ϲ����� (�й�, �л��̸�, �ּ�)
AS ( SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS FROM TB_STUDENT );

SELECT * FROM VW_�л��Ϲ�����;


-- 11. 1�⿡ �� ���� �а����� �л��� ���������� ���� ����� ����
--      �л��̸�, �а��̸�, ��米���̸����� ������ VIEW ����
--      �̶�, ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ�.
--        ��, �� VIEW�� �ܼ� ��ȸ(SELECT)�� �� ��� �а����� ���ĵǾ� ����������...
CREATE VIEW VW_������� (�л��̸�, �а��̸�, ���������̸�)
AS
    SELECT STUDENT_NAME, DEPARTMENT_NAME, NVL(PROFESSOR_NAME, '�������� ����')
      FROM TB_STUDENT
           LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
           LEFT JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
    ORDER BY 2; -- DEPARTMENT_NAME

SELECT * FROM VW_�������;


-- 12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ִ� VIEW ����
CREATE VIEW VW_�а����л��� (DEPARTMENT_NAME, STUDENT_COUNT)
AS
    SELECT DEPARTMENT_NAME, COUNT(*)
      FROM TB_DEPARTMENT
           JOIN TB_STUDENT USING(DEPARTMENT_NO)
     GROUP BY DEPARTMENT_NAME;

SELECT * FROM VW_�а����л���;


-- 13. �л��Ϲ����� VIEW�� ���ؼ� �й��� A213046�� �л��� �̸��� ���� �̸����� ����
--      ������ ����-> DML(UPDATE)

SELECT * FROM VW_�л��Ϲ����� WHERE �й� = 'A213046'; -- ������ �л�

UPDATE VW_�л��Ϲ�����
   -- SET �л��̸� = '�Ӽ���'
   SET �л��̸� = '������' -- �Ʒ� 14�� ��ɹ� ��� �� ���� �� ���� �߻�!!(�ɼ��� �� �����)
 WHERE �й� = 'A213046';

-- 14. �並 ���ؼ� ������ ������ ���� ���� �� ���� ��� => WITH READ ONLY
CREATE OR REPLACE VIEW VW_�л��Ϲ����� (�й�, �л��̸�, �ּ�)
AS ( SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS FROM TB_STUDENT )
WITH READ ONLY;


-- 15. �ų� ������û �Ⱓ�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ������.
--     �ֱ� 3�� ���� �����ο��� ���� ���Ҵ� 3������ ã�� ������ �ۼ� ( 2005 ~ 2009�� )
SELECT �����ȣ, �����̸�, "������������(��)"
FROM (
        SELECT CLASS_NO �����ȣ, CLASS_NAME �����̸�, COUNT(*) "������������(��)"
          FROM TB_GRADE
               JOIN TB_CLASS USING (CLASS_NO)
         WHERE TERM_NO LIKE '2005%'
               OR TERM_NO LIKE '2006%'
               OR TERM_NO LIKE '2007%'
               OR TERM_NO LIKE '2008%'
               OR TERM_NO LIKE '2009%'
         GROUP BY CLASS_NO, CLASS_NAME
         ORDER BY 3 DESC )      --> FROM���� ���� ���������� "�ζ��� ��"��� ǥ����!
WHERE ROWNUM <= 3;
