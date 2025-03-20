-- KH_��������
-- 1. 2025�� 12�� 25���� ���� ��ȸ
SELECT TO_CHAR( TO_DATE('20251225'), 'DAY' ) FROM DUAL;

-- 2. 70��� ��(1970~1979) �� �����̸鼭 ������ ����� �̸���, �ֹι�ȣ, �μ���, ���� ��ȸ
-- * ����Ŭ ���� ���� *
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE, DEPARTMENT, JOB
WHERE DEPT_CODE = DEPT_ID                   -- EMPLOYEE ���̺�� DEPARTMENT ���̺� ����
    AND EMPLOYEE.JOB_CODE = JOB.JOB_CODE        -- EMPLOYEE ���̺�� JOB ���̺� ����
    AND SUBSTR(EMP_NO, 1, 2) BETWEEN 70 AND 79  -- 70��� ���� ���� ����
    AND SUBSTR(EMP_NO, 8, 1) = 2            -- ���ڿ� ���� ����
    AND EMP_NAME LIKE '��%';                 -- ���� ���� ���� ����
      
-- * ANSI ���� *
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID  -- EMPLOYEE ���̺�� DEPARTMENT ���̺� ����
    JOIN JOB USING (JOB_CODE)               -- EMPLOYEE ���̺�� JOB ���̺� ����
WHERE SUBSTR(EMP_NO, 1, 2) BETWEEN 70 AND 79  -- 70��� ���� ���� ����
    AND SUBSTR(EMP_NO, 8, 1) = 2            -- ���ڿ� ���� ����
    AND EMP_NAME LIKE '��%';                 -- ���� ���� ���� ����
    
-- 3. ���� ������ ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� ��ȸ
SELECT EMP_ID, EMP_NAME, EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19' || SUBSTR(EMP_NO, 1, 2)) ����
        , DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
WHERE EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19' || SUBSTR(EMP_NO, 1, 2))
    =   ( SELECT MIN(EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19' || SUBSTR(EMP_NO, 1, 2)))
          FROM EMPLOYEE );


SELECT EMP_ID, EMP_NAME, EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER('19' || SUBSTR(EMP_NO, 1, 2)) ����
        , DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
WHERE SUBSTR(EMP_NO, 1, 2)
    =   ( SELECT MAX(SUBSTR(EMP_NO, 1, 2))
          FROM EMPLOYEE );

-- 4. �̸��� �������� ���� ����� ��� �ڵ�, ��� ��, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
WHERE EMP_NAME LIKE '%��%';
 
-- 5. �μ� �ڵ尡 D5�̰ų� D6�� ����� ��� ��, ����, �μ� �ڵ�, �μ� �� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
WHERE DEPT_CODE IN ('D5', 'D6');
 
-- 6. ���ʽ��� �޴� ����� ��� ��, ���ʽ�, �μ� ��, ���� �� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
WHERE BONUS IS NOT NULL;

-- 7. ��� ��, ����, �μ� ��, ���� �� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;
    

 
-- 8. �ѱ��̳� �Ϻ����� �ٹ� ���� ����� ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ 
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');


-- 9. �� ����� ���� �μ����� ���ϴ� ����� �̸� ��ȸ
SELECT E1.DEPT_CODE "�μ��ڵ�", E1.EMP_NAME "���1 �̸�", E2.EMP_NAME "���2 �̸�"
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.DEPT_CODE = E2.DEPT_CODE
    AND E1.EMP_NAME <> E2.EMP_NAME;

 
-- 10. ���ʽ��� ���� ���� �ڵ尡 J4�̰ų� J7�� ����� �̸�, ����, �޿� ��ȸ (NVL �̿�)
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
WHERE NVL(BONUS, 0) = 0 AND JOB_CODE IN ('J4', 'J7');
 
-- 11. ��� ���� ���� ����� ����� ����� �� ��ȸ
SELECT DECODE(ENT_YN, 'Y', '����� ����� ��', '������� ���� ����� ��') "�з�"
        , COUNT(*)
FROM EMPLOYEE
GROUP BY ENT_YN;

 
-- 12. ���ʽ� ������ ������ ���� 5���� ���, �̸�, �μ� ��, ����, �Ի���, ���� ��ȸ
SELECT * 
FROM (
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE
            , RANK() OVER(ORDER BY(SALARY + (SALARY * NVL(BONUS, 0))*12) DESC) "����"
    FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN JOB USING (JOB_CODE)
)
WHERE ���� <= 5;
 
-- 13. �μ� �� �޿� �հ谡 ��ü �޿� �� ���� 20%���� ���� �μ��� �μ� ��, �μ� �� �޿� �հ� ��ȸ
--	13-1. JOIN�� HAVING ���
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > ( SELECT MAX(SALARY) * 0.2
                         FROM EMPLOYEE );
                      
--	13-2. �ζ��� �� ���
SELECT DEPT_TITLE, SSAL
FROM ( SELECT DEPT_TITLE, SUM(SALARY) SSAL
         FROM EMPLOYEE
            JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
         GROUP BY DEPT_TITLE )
WHERE SSAL > ( SELECT MAX(SALARY) * 0.2 FROM EMPLOYEE );

--	13-3. WITH ���
--        ���������� �̸��� �ٿ��ִ� ���. ������ ���������� ���� �� ����� ��� ���!
WITH DEPT_SAL AS ( SELECT DEPT_TITLE, SUM(SALARY) SSAL
                        FROM EMPLOYEE
                        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
                    GROUP BY DEPT_TITLE )
SELECT DEPT_TITLE, SSAL
  FROM DEPT_SAL
 WHERE SSAL > ( SELECT MAX(SALARY) * 0.2 FROM EMPLOYEE );
 
-- 14. �μ� ��� �μ� �� �޿� �հ� ��ȸ
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE;