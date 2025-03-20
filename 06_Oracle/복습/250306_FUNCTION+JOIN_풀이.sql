/*
    �Ʒ� �������� ���� ������?   2 > 3 > 4 > 5 > 1 > 6
    
    SELECT �÷���                            -- 1
    FROM ���̺��                             -- 2
    WHERE ����                               -- 3
    GROUP BY �׷�ȭ����                       -- 4
    HAVING �׷� ����                          -- 5
    ORDER BY ���� ����                        -- 6
*/

--=========================================================================
--     ������ ����(C##KH) �α��� �� �Ʒ� ������ ��ȸ�� �� �ִ� �������� �ۼ����ּ���
--=========================================================================
-- �̸����� ���̵� �κп�(@ �պκ�) k�� ���Ե� ��� ���� ��ȸ
SELECT * FROM EMPLOYEE
-- WHERE SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) LIKE '%k%';
WHERE EMAIL LIKE '%k%@%';

-- ����ó ���ڸ��� 010, 011�� �����ϴ� ��� �� ��ȸ
SELECT COUNT(*) "��� ��" FROM EMPLOYEE
-- WHERE PHONE LIKE '010%' OR PHONE LIKE '011%';
WHERE SUBSTR(PHONE, 1, 3) IN ('010', '011');

-- ������ 7�������� ������� �Ի���� ��� �� ��ȸ (�Ʒ��� ���� ���)
/*
------------------------------------------------------------
    ����     |   �Ի��   |   �Ի� �����|
         7�� |       4�� |          2��|
         7�� |       9�� |          1��|
         ...
         9�� |       6�� |          1��|
------------------------------------------------------------
*/
SELECT LPAD(SUBSTR(EMP_NO, 3, 2), 6) || '��' AS "����"
        , LPAD(EXTRACT(MONTH FROM HIRE_DATE), 6) || '��' AS "�Ի��" 
        , LPAD(COUNT(*), 6) || '��' AS "�Ի� �����"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 3, 2) >= 7
GROUP BY SUBSTR(EMP_NO, 3, 2), EXTRACT(MONTH FROM HIRE_DATE)
ORDER BY ����, 2;

-- �����μ� ����� ���, �����, �μ���, ���޸� ��ȸ
--  ���, �μ�, ����
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;   -- ���������� / �ؿܿ��� 1,2,3��
SELECT * FROM JOB;
-- ** ����Ŭ ���� **
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID           -- EMPLOYEE ���̺� + DEPARTMENT ���̺�
    AND E.JOB_CODE = J.JOB_CODE     -- EMPLOYEE ���̺� + JOB ���̺�
    AND DEPT_TITLE LIKE '%����%';     -- ���� ���� �μ��� ���� ����

-- ** ANSI ���� **
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM EMPLOYEE E
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID  -- EMPLOYEE ���̺� + DEPARTMENT ���̺�
    -- JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
    JOIN JOB USING (JOB_CODE)               -- EMPLOYEE ���̺� + JOB ���̺�
WHERE DEPT_TITLE LIKE '%����%';


-- ����� ���� ��� ���� ��ȸ (�μ���, ���, ����� ��ȸ)
--  ���, �μ�
-- ** ����Ŭ ���� **
SELECT DEPT_TITLE �μ���, EMP_ID ���, EMP_NAME �����
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND MANAGER_ID IS NULL;

-- ** ANSI ���� **
SELECT DEPT_TITLE �μ���, EMP_ID ���, EMP_NAME �����
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE MANAGER_ID IS NULL;


-- �μ��� ����� ���� ��� �� ��ȸ (�μ���, ����� ��ȸ)
-- ** ����Ŭ ���� **
SELECT DEPT_TITLE �μ���, COUNT(*) �����
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND MANAGER_ID IS NULL
GROUP BY DEPT_TITLE;


-- ** ANSI ���� **
SELECT DEPT_TITLE �μ���, COUNT(*) �����
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE MANAGER_ID IS NULL
GROUP BY DEPT_TITLE;




