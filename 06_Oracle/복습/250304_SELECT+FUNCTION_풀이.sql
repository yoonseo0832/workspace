/*
* DQL (Data Query Language) - ������ �˻� ���
  - SELECT ��ɾ� ���
  - ǥ���� �� ���� ���� ǥ��
		Ű���� => FROM ORDER BY SELECT WHERE
        SELECT �÷��� �Ǵ� ����� �Ǵ� �Լ��� �Ǵ� *(��ü�÷�)  --- (3) ��Ī�� ����� �� ����!
        FROM ���̺��                                     --- (1)
        WHERE ���ǽ�                                     --- (2)
        ORDER BY ���ı����̵Ǵ��÷�...                       --- (4) ��Ī ��� ����!

        * ORDER BY ���� ���� �⺻���� ��������(ASC), NULLS LAST
                            ��������(DESC), NULLS FIRST


* �Լ� (FUNCTION)
	- ���� �� �Լ� : N���� ������ N���� ������� ��ȯ (�� �ึ�� �Լ� ���� ��� ��ȯ)
	- �׷� �Լ� : N���� ������ 1���� ������� ��ȯ (�׷����� ���� �Լ� ���� ��� ��ȯ)  
  
*/  
---------------------------------------------
-- === �Ʒ� ������ ��ȸ�� �� �ִ� SQL���� �ۼ� ===
-- ��� ���� �� �����ȣ, �̸�, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- �μ��ڵ尡 'D9'�� ����� �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ����ó�� 4��°�ڸ��� 7�� ������ �̸�, ����ó ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
-- WHERE SUBSTR(PHONE, 4, 1) = '7';
WHERE PHONE LIKE '___7%';

-- �����ڵ尡 'J7'�� ���� �� �޿��� 200���� �̻��� ������ �̸�, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J7'
      AND SALARY >= 2000000;

-- ��ü ��� ������ �ֱ� �Ի��� �������� �����Ͽ� ��ȸ
SELECT *
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

-- ��������� 60���� �������� �̸�, �ֹι�ȣ, �̸���, ����ó ��ȸ
-- (��, �ֹι�ȣ�� ��� 7�ڸ������� ǥ���ϰ� �������� *�� ǥ��)
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') EMP_NO, EMAIL, PHONE
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
      AND SUBSTR(EMP_NO, 1, 2) BETWEEN 60 AND 69;
      -- '63', '69', '65' -> 63, 69, 65 �ڵ����� ����ȯ��!
      
-- ����� �� �Ի��� �޿� ������ ����� ���, �����, �����, ��������� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SUBSTR(EMP_NO, 1, 6) BIRTH
FROM EMPLOYEE
WHERE EXTRACT(MONTH FROM HIRE_DATE) = SUBSTR(EMP_NO, 3, 2)
-- 9 = '09'


