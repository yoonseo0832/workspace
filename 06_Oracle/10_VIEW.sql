/*
    * VIEW (��)
      : SELECT���� ���� ����� ������� �����ص� �� �ִ� ��ü
        => ���� ���Ǵ� �������� �����صθ� �Ź� �ٽ� �ش� �������� ����� �ʿ䰡 ����!
        
      : �ӽ����̺�� ���� ���� ( ���� �����͸� �����ϴ� �� �ƴ϶�, �������θ� ����Ǿ� ����! )
*/
-- * ��� (EMPLOYEE) / �μ� (DEPARTMENT) / ���� (LOCATION) / ���� (NATIONAL) * --

-- �ѱ����� �ٹ��ϴ� ��� ���� ��ȸ (���, �̸�, �μ���, �޿�, �ٹ�������)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE
       JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
       JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
       JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME = '�ѱ�';

-- ���þƿ��� �ٹ��ϴ� ��� ���� ��ȸ (���, �̸�, �μ���, �޿�, �ٹ�������)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE
       JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
       JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
       JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME = '���þ�';

-- �Ϻ����� �ٹ��ϴ� ��� ���� ��ȸ (���, �̸�, �μ���, �޿�, �ٹ�������)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE
       JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
       JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
       JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME = '�Ϻ�';
--------------------------------------------------------------------------------
/*
    * VIEW �����ϱ�
    
    CREATE VIEW ���
    AS ��������
    
    => �������
        ��ü�� �̸��� �ۼ��� ��,
        ���̺� : TB_XXX
        ��    : VW_XXX
*/
CREATE VIEW VW_EMPLOYEE
AS ( SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
       FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
        JOIN NATIONAL USING (NATIONAL_CODE) );


-- * �並 ������ �� �ִ� ������ �ο� (=> ������ ����(����)���� ����)
-- GRANT CREATE VIEW TO C##KH;

SELECT * FROM VW_EMPLOYEE;

--> �����δ� �Ʒ��� ���� ����� ����!
SELECT *
  FROM ( SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
           FROM EMPLOYEE
                JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
                JOIN NATIONAL USING (NATIONAL_CODE) );

-- �並 ����Ͽ� '�ѱ�'���� �ٹ����� ��� ���� ��ȸ
SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME = '�ѱ�';

-- '���þ�'���� �ٹ����� ��� ���� ��ȸ
SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME = '���þ�';

-- * ���� �������� ������(������) �� ��� ��ȸ
SELECT * FROM USER_VIEWS;
--> TEXT �÷��� ����� �������� ������ ����!


CREATE OR REPLACE VIEW VW_EMPLOYEE
AS ( SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
       FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
        JOIN NATIONAL USING (NATIONAL_CODE) );
--------------------------------------------------------------------------------
-- * ���, �����, ���޸�, ����(��|��), �ٹ���� ������ ��ȸ
--      => �ٹ���� : ���� ���� - �Ի� ����
--      => ����    : �ֹι�ȣ �÷��� 8��°�ڸ� ������ �з�. 1: ��, 2: ��
SELECT EMP_ID, EMP_NAME, JOB_NAME 
        , DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��')
        , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE);

-- ������ ��ȸ�� �������� �信 ���� (VW_EMP_JOB) --> �並 ����
CREATE OR REPLACE VIEW VW_EMP_JOB
AS (
    SELECT EMP_ID, EMP_NAME, JOB_NAME 
            , DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��')
            , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE)
);
--> ���� �߻�! �Լ��� �Ǵ� ������� ����� ��� ��Ī�� �ο������ �䰡 �� ������!

CREATE OR REPLACE VIEW VW_EMP_JOB
AS (
    SELECT EMP_ID, EMP_NAME, JOB_NAME 
            , DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') ����
            , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "�ٹ����"
    FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE)
);

-- * ��� �÷����� ������� ��� ���� �����Ͽ� �ۼ� ����!
CREATE OR REPLACE VIEW VW_EMP_JOB (���, �̸�, ���޸�, ����, �ٹ����)
AS (
    SELECT EMP_ID, EMP_NAME, JOB_NAME 
            , DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��')
            , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE)
);

SELECT * FROM VW_EMP_JOB;

-- * ���� ����� ���� ��ȸ
SELECT * FROM VW_EMP_JOB WHERE ���� = '��';

-- * 20�� �̻� �ٹ��� ����� ���� ��ȸ
SELECT * FROM VW_EMP_JOB WHERE �ٹ���� >= 20;

-- �� ����
--          DROP VIEW ���;
DROP VIEW VW_EMP_JOB;
---------------------------------------------
/*
    * ������ �並 ���ؼ� DML(INSERT/UPDATE/DELETE)�� ����غ���
    
      --> �並 ���ؼ� DML�� �ۼ��ϰ� �Ǹ�, ���� �����Ͱ� ����Ǿ� �ִ� ���̺� �ݿ���!
*/
-- JOB ���̺��� ��� ����
CREATE VIEW VW_JOB
AS ( SELECT JOB_CODE, JOB_NAME FROM JOB );

SELECT * FROM VW_JOB;   -- ������ ���̺�
--> SELECT * FROM ( SELECT * FROM JOB );
SELECT * FROM JOB;

-- * VW_JOB �̶�� �並 ����Ͽ� �����͸� �߰� (DML-INSERT)
INSERT INTO VW_JOB VALUES ('J8', '����');

-- * VW_JOB �並 ����Ͽ� �����͸� ���� (DML-UPDATE)
UPDATE VW_JOB
   SET JOB_NAME = '�˹�'
 WHERE JOB_CODE = 'J8';

-- * VW_JOB �並 ����Ͽ� �����͸� ���� (DML-DELETE)
DELETE FROM VW_JOB WHERE JOB_CODE = 'J8';
------------------------------------------------
/*
    * DML ��ɾ�� ������ �Ұ����� ��찡 ����!
    
    1) �信 ���ǵ��� ���� �÷��� �����Ϸ��� ���
    2) �信 ���ǵǾ� ���� �ʰ� ���̺� NOT NULL ���� ������ �����Ǿ� �ִ� ���
    3) �������� �Ǵ� �Լ������� ���ǵǾ� �ִ� ���
    4) DISTINCT ������ ���ԵǾ� �ִ� ���
    5) JOIN�� �̿��Ͽ� ���� ���̺��� ������ ���
    
    ==> ��� ��κ� ��ȸ�� �뵵�� ����Ѵ�. ����, �ǵ����̸� DML�� ������� ����!
*/
-----------------------------------------------
/*
    * VIEW ���� �ɼ� *
    
    CREATE [OR REPLACE] [FORCE|(NOFORCE)] VIEW ���
    AS ��������
    [WITH CHECK OPTION]
    [WITH READ ONLY]
    
    - OR REPLACE : ������ ������ �̸��� �䰡 ���� ��� �����ϰ�, ���� ��� ���� ����
    - FORCE | NOFORCE
        * FORCE   : ���������� �ۼ��� ���̺��� �������� �ʾƵ� �並 ����
        * NOFORCE : ���������� �ۼ��� ���̺��� �����ϴ� ��쿡�� �並 ���� (�⺻��)
    - WITH CHECK OPTION : DML ��� �� ���������� �ۼ��� ���ǿ� �´� �����θ� ����ǵ��� �ϴ� �ɼ�
    - WITH READ ONLY : �並 ��ȸ�� �����ϵ��� �ϴ� �ɼ�
*/
-- * FORCE | NOFORCE
-- CREATE NOFORCE VIEW VW_TEMP
CREATE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTENT
     FROM TT;
--> TT ��� ���̺��� �������� �ʱ� ������ �䵵 ���� �Ұ�

CREATE FORCE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTENT
     FROM TT;
--> ��� ������!

SELECT * FROM VW_TEMP;
--> �ٸ�, �信 ������ �ִٰ� ����� Ȯ�ε�! (=> ���̺��� �������� �ʴ´ٰ� ��)

CREATE TABLE TT (
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(100)
);

SELECT * FROM VW_TEMP;
--> ���̺� ���� �� �� ���۵�.


-- * WITH CHECK OPTION *

-- �ɼ� ���� �޿��� 300���� �̻��� ����� ������ �� ����
CREATE VIEW VW_EMP
AS ( SELECT * FROM EMPLOYEE WHERE SALARY >= 3000000 );

SELECT * FROM VW_EMP;

-- 204�� ����� �޿��� 200�������� ���� (�並 ���, �� ���� �� ���ǿ� ���� �ʴ� ���� ���)
UPDATE VW_EMP
   SET SALARY = 2000000
 WHERE EMP_ID = 204;

ROLLBACK;

-- �ɼ� �߰��Ͽ� �ٽ� ���� 
CREATE OR REPLACE VIEW VW_EMP
AS ( SELECT * FROM EMPLOYEE WHERE SALARY >= 3000000 )
WITH CHECK OPTION;

SELECT * FROM VW_EMP;

UPDATE VW_EMP
   SET SALARY = 2000000
 WHERE EMP_ID = 204;
--> ���������� �ۼ��ߴ� ���ǿ� ���յ��� �ʱ� ������ ���� �Ұ� (=> ���� �߻�!)

UPDATE VW_EMP
   SET SALARY = 4000000
 WHERE EMP_ID = 204;
--> ���������� �ۼ��ߴ� ���ǿ� ���յǱ� ������, �� ���� ���� ����


-- * WITH READ ONLY *
CREATE OR REPLACE VIEW VW_EMP
AS SELECT * FROM EMPLOYEE WHERE SALARY >= 3000000
WITH READ ONLY;

SELECT * FROM VW_EMP;

DELETE FROM VW_EMP WHERE EMP_ID = 200;
--> READ ONLY �ɼǿ� ���Ͽ� DML ��� �Ұ�! (�����߻�)




