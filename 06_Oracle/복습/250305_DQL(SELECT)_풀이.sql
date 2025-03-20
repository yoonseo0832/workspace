--====== 250305_DQL(SELECT)_���������(TEST250305).sql ���� �� �Ʒ� ��ȸ ======--
-- ����� ������ �������ּ���. (����ڸ�: C##TEST250305 / ��й�ȣ: test0305)
-- * ����� ���� �߰�(����) -------------------
CREATE USER C##TEST250305 IDENTIFIED BY test0305;

GRANT CONNECT, RESOURCE TO C##TEST250305;

ALTER USER C##TEST250305 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
--- => ������ �������� �����ؾ� ��!! ---
--------------------------------------------
-- ��� ����� ���� ��ȸ
SELECT * FROM CUSTOMER;

-- �̸�, �������, ���� ���� ��ȸ
SELECT NAME �̸�, BIRTHDATE �������
        , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 ����
FROM CUSTOMER;

-- ���̰� 40���� ������� ���� ��ȸ
SELECT * FROM CUSTOMER
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 BETWEEN 40 AND 49;
-- EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 >= 40 
--   AND EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) + 1 <= 49 �� ����!

-- �����ÿ� ���� ���� ������� ���� ��ȸ
SELECT * FROM CUSTOMER
WHERE ADDRESS LIKE '%������%';

-- �̸��� 2���� ������� ���� ��ȸ
SELECT * FROM CUSTOMER
WHERE LENGTH(NAME) = 2;
-- LENGTHB(NAME) = 6 -- �ѱ��� �� ���ڴ� 3����Ʈ��!

--===========================================================================
-- '250305' ����Ÿ�� �����͸� '2025�� 03�� 05��'�� ǥ��
SELECT TO_CHAR( TO_DATE('250305', 'YYMMDD'), 'YYYY"��" MM"��" DD"��"' ) FROM DUAL;

-- ������ �¾�� ��ĥ °���� Ȯ��
SELECT CEIL(SYSDATE - TO_DATE('250301')) || '�� °' FROM DUAL;

--===========================================================================
-- ����� ������ �������ּ���. (����ڸ�: C##KH / ��й�ȣ: KH)
--  �ش� ������ ���� ��� �߰� �� kh.sql ��ũ��Ʈ �����Ͽ� �Ʒ� ������ �������ּ���.

SELECT * FROM EMPLOYEE;
-- ������� ���� ����� �޿� �� ��ȸ
SELECT SUM(SALARY) "�޿� ��"
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- �Ի���� ��� �� ��ȸ (* �Ի�� �������� ����)
SELECT EXTRACT(MONTH FROM HIRE_DATE) "�Ի� ��", COUNT(*) "��� ��"    -- 3
FROM EMPLOYEE                               -- 1
GROUP BY EXTRACT(MONTH FROM HIRE_DATE)      -- 2
ORDER BY 1;                                 -- 4






