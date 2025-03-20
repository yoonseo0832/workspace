/*
    SELECT : ������ ��ȸ(����)
    
        [ǥ����]
        
            SELECT ��ȸ�ϰ��� �ϴ� ���� FROM ���̺��;
            
            SELECT �÷���1, �÷���2, .. �Ǵ� * FROM ���̺��;
*/
-- ��� ����� ������ ��ȸ
SELECT * FROM EMPLOYEE;

-- ��� ����� �̸�, �ֹι�ȣ, ����ó�� ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE  -- (2) EMPLOYEE ���̺��� EMP_NAME, EMP_NO, PHONE �÷��� ���� �����͸� ����
FROM EMPLOYEE;                  -- (1) EMPLOYEE ���̺��� ��ȸ

-- ��� ������ ������ ��ȸ
SELECT * FROM JOB;

-- ���� ���� �� ���޸� ��ȸ
SELECT JOB_NAME
FROM JOB;

-- ��� ���̺��� ��� ����� �����, �̸���, ����ó, �Ի���, �޿� ��ȸ
-- EMPLOYEE ���̺��� EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY �÷��� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    �÷��� ��� ���� �߰��ϱ�
    => SELECT���� �÷��� �ۼ��κп� ��� ������ �� �� ����!
*/
-- �����, ���� ���� ��ȸ
--   ���� = �޿� * 12
--          SALARY �÷� �����Ϳ� 12�� ���Ͽ� ����� ǥ��
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- �����, �޿�, ���ʽ�, ����, ���ʽ� ���� ���� ������ ��ȸ
--   ���ʽ� ���� ���� = (�޿� + (�޿�*���ʽ�)) * 12
SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY + (SALARY*BONUS))*12
FROM EMPLOYEE;

/*
    * �÷��� ��Ī �ο��ϱ� 
      : ������� ����� ��� �ǹ̸� �ľ��ϱ� ��Ʊ� ������
        ��Ī�� �ο��Ͽ� ��Ȯ�ϰ� ����ϰ� ��ȸ�� �� ����!
        
    [ǥ����]
    
            (1) �÷��� ��Ī
            (2) �÷��� AS ��Ī
            (3) �÷��� "��Ī"
            (4) �÷��� AS "��Ī"
*/
-- ��� ����� �����, �޿�, ���ʽ�, ����, ���ʽ� ���� ���� ������ ��ȸ (* ��Ī �ο�)
SELECT EMP_NAME �����, SALARY AS �޿�, BONUS "���ʽ�", SALARY*12 AS "����"
        , (SALARY + (SALARY*BONUS))*12 "���ʽ� ���� ����"
FROM EMPLOYEE;


/*
    - ���� ��¥�ð� ���� : SYSDATE
    - ���� ���̺�(�ӽ� ���̺�) : DUAL
*/
-- ���� ��¥�ð� ���� ��ȸ
SELECT SYSDATE FROM DUAL;   -- YY/MM/DD �������� ��ȸ��!

-- ��� ����� �����, �Ի���, �ٹ��ϼ� ��ȸ
--     �ٹ��ϼ� = ���糯¥ - �Ի��� + 1
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE + 1 "�ٹ��ϼ�"
FROM EMPLOYEE;
-- DATE Ÿ�� - DATE Ÿ�� => �� ������ ǥ�õ�!

/*
    * ���ͷ�(�� ��ü) : ���Ƿ� ������ ���� ���ڿ�('') ǥ�� �Ǵ� ���ڷ� ǥ��
      -> SELECT ���� ����ϴ� ��� ��ȸ�� ���(Result Set)�� �ݺ������� ǥ�õ�!
*/
-- �����, �޿�, '��' ��ȸ (* ��Ī �ο�)
SELECT EMP_NAME �����, SALARY �޿�, '��' ��
FROM EMPLOYEE;

/*
    ���� ������ : ||
    �� ���� �÷� �Ǵ� ���� �÷��� �������ִ� ������
*/
-- ��� ����� "XXX��" �������� �޿������� ��ȸ
SELECT SALARY || '��' �޿�
FROM EMPLOYEE;

-- ���, �̸�, �޿��� �ѹ���(�� �÷���) ��ȸ
-- SELECT EMP_ID, EMP_NAME, SALARY
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- "XXX�� �޿��� XXXX���Դϴ�" �������� ��ȸ (*��Ī: �޿�����)
-- {�����} + '�� �޿��� ' + {�޿�} + '���Դϴ�'
SELECT EMP_NAME || '�� �޿��� ' || SALARY || '���Դϴ�.' AS �޿�����
FROM EMPLOYEE;

/*
    * �ߺ� ���� : DISTINCT
      �ߺ��� ������� ���� ��� ��ȸ ����� �ϳ��� ǥ������
      
      [ǥ����]
      DISTINCT �÷���[, �÷���, ...]
*/
-- ������̺��� �����ڵ� ��ȸ
SELECT JOB_CODE FROM EMPLOYEE;

-- ��� ���̺��� �ߺ� �����Ͽ� �����ڵ� ��ȸ
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- ��� ���̺��� �μ��ڵ� ��ȸ (*�ߺ� ����)
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

-- SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
-- * SELECT������ DISTINCT �� �ѹ��� ��� ����!!
SELECT DISTINCT JOB_CODE, DEPT_CODE     -- JOB_CODE, DEPT_CODE�� �� ������ ��� �ߺ� ��������!!
FROM EMPLOYEE;

-- =============================================================================
/*
    * WHERE�� : ��ȸ�ϰ��� �ϴ� �����͸� Ư�� ���ǿ� ���� �����ϰ��� �� �� ���
    
    [ǥ����]
            SELECT �÷���, �÷� �Ǵ� ������ ���� �����
            FROM ���̺��
            WHERE ����;
            
    - �񱳿�����
        * ��� �� : > < >= <=
        * ���� �� 
            - ���� �� �� : =
            - �ٸ� �� �� : != <> ^=
*/
-- ��� ���̺��� �μ��ڵ尡 'D9'�� ������� ������ ��ȸ
SELECT *                -- (3) ��ü �÷��� �����͸� ��ȸ
FROM EMPLOYEE           -- (1) EMPLOYEE ���̺���
WHERE DEPT_CODE = 'D9'; -- (2) DEPT_CODE �÷��� ���� 'D9'��

-- ��� ���� �� �μ��ڵ尡 'D1'�� ������� �����, �޿�, �μ��ڵ带 ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- ��� ���� �� �μ��ڵ尡 'D1'�� �ƴ� ������� �����, �޿�, �μ��ڵ带 ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D1';
-- WHERE DEPT_CODE <> 'D1';
WHERE DEPT_CODE ^= 'D1';

-- �޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ������ ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- �޿��� 400���� �̸��� ������� �����, �μ��ڵ� �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < 4000000;
--==============================================================================
----------------------- �ǽ� ���� -----------------------------------------------
-- * ��, ���� ��� �� ���ʽ� ���� **

-- [1] �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ���� ��ȸ (��Ī ����)
SELECT EMP_NAME �����, SALARY "�޿�", HIRE_DATE AS �Ի���, SALARY*12 AS "����"
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- [2] ������ 5õ���� �̻��� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ (��Ī ����)
SELECT EMP_NAME �����, SALARY �޿�, SALARY*12 ����, DEPT_CODE �μ��ڵ�    -- (3)
FROM EMPLOYEE                   -- (1)
WHERE SALARY*12 >= 50000000;    -- (2)


-- [3] ���� �ڵ尡 'J5'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ (��Ī ����)
SELECT EMP_ID ���, EMP_NAME �����, JOB_CODE �����ڵ�, ENT_YN ��翩��
FROM EMPLOYEE
WHERE JOB_CODE <> 'J5'; 

-- [4] �޿��� 350���� �̻� 600���� ������ ��� ����� �����, ���, �޿� ��ȸ (��Ī ����)
--     * �������� : AND, OR�� ������ ������ �� ����!
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
--------------------------------------------------------------------------------
/*
    * BETWEEN AND : ���ǽĿ��� ���Ǵ� ����
      => ~ �̻� ~ ������ ������ ���� ������ �����ϴ� ����
      
      [ǥ����]
      
            �÷��� BETWEEN A AND B
            
            - �÷��� : �� ��� �÷�
            - A     : �ּڰ�
            - B     : �ִ�
            ==> �ش� �÷��� ���� �ּڰ� �̻��̰� �ִ� ������ ���
*/
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿�
FROM EMPLOYEE
-- WHERE SALARY >= 3500000 AND SALARY <= 6000000;  -- BETWEEN AND ���� ����!
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- �޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� �����, ���, �޿� ��ȸ
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;

/*
    * ���������� : NOT
*/
-- �޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� �����, ���, �޿� ��ȸ (BETWEEN AND, NOT)
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿�
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
-- WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

/*
    * IN : �񱳴���÷��� ���� ������ ���� �߿� ��ġ�ϴ� ���� �ִ� ��츦 ��ȸ�ϴ� ����
    
      [ǥ����]
              �÷��� IN (��1, ��2, ��3, ....)
              
              �Ʒ��� ������
              
              �÷��� = ��1 OR �÷��� = ��2 OR �÷��� = ��3 ...
*/
-- �μ��ڵ尡 'D6'�̰ų� 'D8'�̰ų� 'D5'�� ������� �����, �μ��ڵ�, �޿��� ��ȸ (* IN ������� ���� ���)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';

-- �μ��ڵ尡 'D6'�̰ų� 'D8'�̰ų� 'D5'�� ������� �����, �μ��ڵ�, �޿��� ��ȸ (* IN ����� ���)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');
--==============================================================================
/*
    * LIKE : ���ϰ��� �ϴ� �÷��� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
        [ǥ����]
             �񱳴���÷� LIKE '����'

             ==> Ư�� ���� : '%', '_'�� ���ϵ�ī��� ���
             
             * % : 0���� �̻�
               ex) �񱳴���÷� LIKE '����%'  => �񱳴���÷��� ���� ���ڷ� "����"�Ǵ� ���� ��ȸ
                   �񱳴���÷� LIKE '%����'  => �񱳴���÷��� ���� ���ڷ� "��"���� ���� ��ȸ
                   �񱳴���÷� LIKE '%����%' => �񱳴���÷��� ���� ���ڰ� "����"�Ǵ� ���� ��ȸ (Ű���� �˻�)
             
             * _ : 1����
               ex) �񱳴���÷� LIKE '_����' => �񱳴���÷��� ������ ���� �տ� ������ �ѱ��ڰ� ���� ��츦 ��ȸ
                   �񱳴���÷� LIKE '__����' => �񱳴���÷��� ������ ���� �տ� ������ �α��ڰ� ���� ��츦 ��ȸ
                   �񱳴���÷� LIKE '_����_' => �񱳴���÷��� ������ ���� ��, �ڷ� ������ �ѱ��ھ� ���� ��츦 ��ȸ
*/
-- ����� �߿� "��"�� ���� ���� ����� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- ����� "��"�� ���Ե� ����� �����, �ֹι�ȣ, ����ó ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- ������� ��� ���ڰ� "��"�� ����� �����, ����ó ��ȸ (* ������� 3������ ����� �� ��ȸ)
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

-- ����� �� ����ó�� 3��°�ڸ��� 1�� ����� ���, �����, ����ó, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- ����� �� �̸��Ͽ� 4��°�ڸ��� _�� ����� ���, �̸�, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; -- > ���ϴ� ����� Ȯ���� �� ����!
-- ���ϵ�ī��� ���Ǵ� ���ڿ� �÷��� ��� ���ڰ� �����ϱ� ������ ��� ���ϵ�ī��� �νĵ�!
-- ����, ������ ����� ��! (=> ������ ���ϵ� ī�带 ����ؾ� ��! ESCAPE �ɼ� �߰�!)

-- [ǥ����] �񱳴���÷� LIKE '����' ESCAPE '��ȣ'; 

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';
--==============================================================================
/*
    * IS NULL / IS NOT NULL
      : �÷����� NULL�� �ִ� ��� NULL���� ���� �� ���Ǵ� ������
      
      - IS NULL : �÷� ���� NULL ������ ��
      - IS NOT NULL : �÷� ���� NULL���� �ƴ��� ��
*/
-- ���ʽ��� ���� �ʴ� ������� ���, �����, �޿�, ���ʽ� ��ȸ
-- => BONUS �÷��� ���� NULL�� ���
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ������� ���, �����, �޿�, ���ʽ� ��ȸ
-- => BONUS �÷��� ���� NULL�� �ƴ� ���
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
-- WHERE NOT BONUS IS NULL; -- �̷��Ե� ������!

-- ����� ���� ������� �����, ������, �μ��ڵ� ��ȸ
-- => MANAGER_ID �÷��� ���� NULL�� ���
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- �μ� ��ġ�� ���� �ʾ�����, ���ʽ��� �ް� �ִ� ����� �����, ���ʽ�, �μ��ڵ� ��ȸ
-- => DEPT_CODE �÷��� ���� NULL -- �μ� ��ġ�� ���� ����!
-- => BONUS �÷��� ���� NULL �� �ƴ� �� -- ���ʽ��� �ް� ����!
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL 
      AND BONUS IS NOT NULL;
--==============================================================================
-- �����ڵ尡 'J7'�̰ų� 'J2'�� ����� �� �޿��� 200���� �̻��� ����� ��� ������ ��ȸ
SELECT *
FROM EMPLOYEE
-- WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY >= 2000000;  -- ���ϴ� ����� ǥ�õ��� ����!
-- WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;
WHERE JOB_CODE IN ('J7', 'J2') AND SALARY >= 2000000;
/*
    * ������ �켱����
        (0) ()
        (1) ��������� : * / + -
        (2) ���Ῥ���� : ||
        (3) �񱳿����� : > < >= <= = != <> ^=
        (4) IS NULL / LIKE '����' / IN
        (5) BETWEEN AND
        (6) NOT
        (7) AND
        (8) OR
*/
--==============================================================================
/*
    * ���� : ORDER BY
             => SELECT������ ���� ������ �ٿ� �ۼ�
             => ���� ���� ���� �������� ����
             
      [ǥ����]
            SELECT ��ȸ�� �÷�, ...
            FROM ���̺��
            WHERE ���ǽ�
            ORDER BY ���ı����̵Ǵ��÷�|��Ī|�÷����� [ASC|DESC] [NULLS FIRST|NULLS LAST]
            
            * ASC : �������� ���� (�⺻��)
            * DESC : �������� ����
            
            * NULLS FIRST : �����ϰ��� �ϴ� �÷��� ���� NULL�� ��� �� �տ� ��ġ (DESC�� ��� �⺻��)
            * NULLS LAST : �����ϰ��� �ϴ� �÷��� ���� NULL�� ��� �� �ڿ� ��ġ (ASC�� ��� �⺻��)
            --> NULL ���� ū ������ �з��Ͽ� ����!
*/
-- ��� ����� �����, ���� ��ȸ (������ �������� ����)
SELECT EMP_NAME, SALARY * 12 ����
FROM EMPLOYEE
-- ORDER BY SALARY * 12 DESC;   -- ���ı����̵Ǵ� �÷�(�����)
-- ORDER BY ���� DESC;   -- ��Ī
ORDER BY 2 DESC;    -- �÷� ���� ��� (* ����Ŭ������ ������ 1���� ����!)

-- ���ʽ� �������� ����
SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS;     -- �⺻�� (ASC, NULLS LAST)
-- ORDER BY BONUS ASC;    --             NULLS LAST
-- ORDER BY BONUS ASC NULLS LAST;
-- ORDER BY BONUS DESC;    -- DESC �� �� NULLS FIRST �⺻��
ORDER BY BONUS DESC, SALARY ASC;
-- ���ʽ� �÷��� �������� ����, �޿� �÷��� �������� ����
-- => ���ʽ� ���� �������� �����ϴµ�, ���ʽ� ���� ���� ���� ��� �޿��� ���� �������� ����












