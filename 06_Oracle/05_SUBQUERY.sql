/*
    * �������� (SUBQUERY)
    : �ϳ��� ������ ���� ���Ե� �� �ٸ� ������
      ���� ������ �ϴ� �������� ���� ���� ������ �ϴ� ������
*/
-- "���ö" ����� ���� �μ��� ���� ��� ������ ��ȸ

-- 1) ���ö ����� �μ��ڵ带 ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';
---> 'D9'

-- 2) �μ��ڵ尡 'D9'�� ��� ������ ��ȸ
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';
---> 3�� ��ȸ��


---- ���� �� �������� �ϳ��� ���ĺ���!
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö' );


-- ��ü ����� ��� �޿����� �� ���� �޿��� �޴� ����� ������ ��ȸ
-- 1) ��ü ����� ��� �޿� ��ȸ (* �ݿø�ó��)
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;
---> 3047663

-- 2) ��� �޿�(3047663)���� �� ���� �޿��� �޴� ��� ���� ��ȸ
SELECT * 
FROM EMPLOYEE
WHERE SALARY >= 3047663;

---> ���������� �����غ���!
SELECT * 
FROM EMPLOYEE
WHERE SALARY >= ( SELECT ROUND(AVG(SALARY))
                  FROM EMPLOYEE );
--------------------------------------------------------------------------------
/*
    * ���������� ���� *
      ���������� ������ ������� �� �� �� ���� �����Ŀ� ���� �з�
    
    - ������ �������� : ���������� ����� ������ 1���� �� (1�� 1��)
    - ������ �������� : ���������� ����� ���� ���� �� (N�� 1��)
    - ���߿� �������� : ���������� ����� �� ���̰� ���� ���� ��(�÷�)�� �� (1�� N��)
    - ������ ���߿� �������� : ���������� ����� ���� �� ���� ��(�÷�)�� �� (N�� M��)
    
    >> ������ ���� �������� �տ� �ٴ� �����ڰ� �޶���!!
*/
-- * ������ ��������
--   >> �Ϲ����� �񱳿����� ��� ���� : = != > < >= ..

-- �� ����� ��� �޿����� �� ���� �޿��� �޴� ������� �����, �����ڵ�, �޿��� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < ( SELECT AVG(SALARY) FROM EMPLOYEE );

-- �޿��� ���� ���� ����� �����, �����ڵ�, �޿��� ��ȸ
-- * �����޿� ��ȸ
SELECT MIN(SALARY) FROM EMPLOYEE;

SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY = ( SELECT MIN(SALARY) FROM EMPLOYEE );

-- ���ö ����� �޿����� ���� �޴� ����� �����, �μ��ڵ�, �޿� ��ȸ
-- * ���ö ����� �޿�
SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ö';

SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY > ( SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ö' );

--> �μ��ڵ带 �μ������� ��ȸ�ϰ��� �Ѵٸ�?
-- * ����Ŭ ���� *
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND SALARY > ( SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ö' );

-- * ANSI ���� *
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE  JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID  
WHERE SALARY > ( SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ö' );

-- �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿����� ��ȸ
-- 1) �μ��� �޿��� �� ���� ū ���� ��ȸ
--     -> �μ��� �޿��� ��ȸ
        SELECT DEPT_CODE, SUM(SALARY)
        FROM EMPLOYEE
        GROUP BY DEPT_CODE;

--     -> �μ��� �޿��� �� �ִ밪 ��ȸ
        SELECT MAX(SUM(SALARY))
        FROM EMPLOYEE
        GROUP BY DEPT_CODE;

-- 2) �μ��� �޿����� ���� ū (17700000) �μ��� �μ��ڵ�, �޿��� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;


--> ���������� �����غ���!
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = ( SELECT MAX(SUM(SALARY))
                       FROM EMPLOYEE
                       GROUP BY DEPT_CODE );

-- ������ ����� ���� �μ��� ������� ���, �����, ����ó, �Ի���, �μ����� ��ȸ
-- (��, ������ ����� �����ϰ� ��ȸ!)
-- * ����Ŭ ���� *
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND DEPT_CODE = ( SELECT DEPT_CODE
                        FROM EMPLOYEE
                       WHERE EMP_NAME = '������' ) -- ������ ����� ���� �μ��� ���� ����
    AND EMP_NAME <> '������';      -- ������ ����� ������ ����

-- * ANSI ���� *
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE = ( SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������' )
    AND EMP_NAME != '������';
--------------------------------------------------------------------------------
/*
    ������ �������� : �������� ����� ���� ���� ��� (N�� 1��)
    
    IN ( �������� )  : ���� ���� ����� �߿� �ϳ��� ��ġ�ϴ� ���� ���� ��� ��ȸ
    
    > ANY ( �������� ) : ���� ���� ����� �߿��� �ϳ��� ū ��찡 �ִٸ� ��ȸ
    < ANY ( �������� ) : ���� ���� ����� �߿��� �ϳ��� ���� ��찡 �ִٸ� ��ȸ
        * �񱳴�� > �����1 OR �񱳴�� > �����2 OR �񱳴�� > �����3 ...
        
    > ALL ( �������� ) : ���� ���� ��� ��������� Ŭ ��� ��ȸ
    < ALL ( �������� ) : ���� ���� ��� ��������� ���� ��� ��ȸ
        * �񱳴�� < �����1 AND �񱳴�� < �����2 AND �񱳴�� < �����3 ...
*/
-- ����� ��� �Ǵ� ������ ����� ���� ������ ������� ���� ��ȸ (���/�����/�����ڵ�/�޿�)
-- 1) ����� ��� �Ǵ� ������ ����� �����ڵ� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE
-- WHERE EMP_NAME = '�����' OR EMP_NAME = '������';
WHERE EMP_NAME IN ('�����', '������');
--> 'J3', 'J7'

-- 2) �����ڵ尡 'J3' �Ǵ� 'J7'�� ������� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');


---> �������� �����ϱ�!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ( SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN ('�����', '������') );

-- �븮 ������ ����� �� ���� ������ �ּ� �޿����� ���� �޴� ��� ���� ��ȸ ( ���, �̸�, ���޸�, �޿� )
-- 1) ���� ������ �޿� ��ȸ
SELECT SALARY
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����';
--> 3760000, 2200000, 2500000

-- 2) > ANY �����ڸ� ����Ͽ� ��
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
WHERE SALARY > ANY (3760000, 2200000, 2500000)
    AND JOB_NAME = '�븮';


---> ���������� �����غ���!
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
WHERE SALARY > ANY (
                    SELECT SALARY
                    FROM EMPLOYEE
                        JOIN JOB USING (JOB_CODE)
                    WHERE JOB_NAME = '����'
                    )
    AND JOB_NAME = '�븮';
--------------------------------------------------------------------------------
/*
    ���߿� �������� : �������� ����� 1�� ���̰�, ���� ���� ��(�÷�)�� ���
*/
-- ������ ����� ���� �μ�, ���� ������ ��� ������ ��ȸ
-- 1) ������ ����� �μ��ڵ�, �����ڵ� ��ȸ
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';


-- * ������ ���������� ����Ѵٸ�?
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = ( SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������' )
    AND JOB_CODE = ( SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������' );

-- * ���߿� ���������� ����Ѵٸ�?
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = ( SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE WHERE EMP_NAME = '������' );

-- �ڳ��� ����� ������ ����, ����� ������ ����� �����, �����ڵ�, �����ȣ�� ��ȸ
SELECT EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = ( SELECT JOB_CODE, MANAGER_ID
                                 FROM EMPLOYEE
                                 WHERE EMP_NAME = '�ڳ���' )
    AND EMP_NAME <> '�ڳ���';
--------------------------------------------------------------------------------
/*
    * ������ ���߿� �������� : ���������� ����� ���� ��, ���� ��(�÷�)�� ���
*/
-- �� ���޺� �ּұ޿��� �޴� ��� ������ ��ȸ (���, �̸�, �����ڵ�, �޿�)
-- 1) ���޺� �ּұ޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;
/*
J1	8000000
J2	3700000
J4	1550000
J3	3400000
J7	1380000
J5	2200000
J6	2000000
*/
-- 2) �� ���޺� �ּұ޿��� �޴� ��� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J1' AND SALARY = 8000000
    OR JOB_CODE = 'J2' AND SALARY = 3700000
    OR JOB_CODE = 'J4' AND SALARY = 1550000;
    --...;

---> ���������� �����Ѵٸ�?
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN ( SELECT JOB_CODE, MIN(SALARY)
                              FROM EMPLOYEE
                              GROUP BY JOB_CODE );
--------------------------------------------------------------------------------
/*
    * �ζ��� �� : ���������� FROM���� ����ϴ� ��
                 => ���������� ����� ��ġ ���̺�ó�� ����ϴ� ��
*/
-- ���, �̸�, ���ʽ� ���� ����, �μ��ڵ带 ��ȸ
-- (��, ���ʽ� ���� ������ ����� NULL�� �ƴϾ�� �ϰ�,    --> NVL : NULL ���� ��� �ٸ� ������ ����
--      ���ʽ� ���� ������ 3000���� �̻��� ����鸸 ��ȸ�� ��)
SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY*NVL(BONUS, 0))) * 12 "���ʽ� ���� ����", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + (SALARY*NVL(BONUS, 0))) * 12 >= 30000000
ORDER BY 3 DESC;

---> ���� N���� ��ȸ : "TOP-N�м�"
--      => ROWNUM : ��ȸ�� �࿡ ���Ͽ� ������� 1���� ������ �ο����ִ� ���� �÷�
SELECT ROWNUM, ���, EMP_NAME, "���ʽ� ���� ����", DEPT_CODE
FROM (
        SELECT EMP_ID ���, EMP_NAME, (SALARY + (SALARY*NVL(BONUS, 0))) * 12 "���ʽ� ���� ����", DEPT_CODE
        FROM EMPLOYEE
        WHERE (SALARY + (SALARY*NVL(BONUS, 0))) * 12 >= 30000000
        ORDER BY 3 DESC
      )
WHERE ROWNUM <= 5;
-- > ���ʽ� ���� ������ ���� 5���� ����� ��ȸ!


-- ���� �ֱٿ� �Ի��� ��� 5���� ��ȸ
-- * �Ի��� ���� �������� ����
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

SELECT ���, �̸�, �Ի���
FROM ( SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի���
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC )
WHERE ROWNUM <= 5;
-- * ROWNUM �� ���� ������ �߰���ġ�� �ϰ��� �� ��� �ζ��� �信 �÷��� ���� �ۼ� �� ����ؾ� ��!
--------------------------------------------------------------------------------
/*
    * ������ �ű�� �Լ� (WINDOW FUNCTION)
    
    - RANK() OVER(���ı���)      : ������ ���� ������ ����� ������ �� ��ŭ �ǳʶٰ� ���� ���
    - DENSE_RANK() OVER(���ı���): ������ ������ �ִ��� �� ���� ����� +1�ؼ� ���� ���
    
    => SELECT�������� ��� ����!
*/
-- �޿��� ���� ������� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, SALARY,
        RANK() OVER( ORDER BY SALARY DESC ) "����"
FROM EMPLOYEE;
--> ���� 19���� 2���� �ְ�, �� ���� ������ 21���� ǥ�õ�.

SELECT EMP_NAME, SALARY,
        DENSE_RANK() OVER( ORDER BY SALARY DESC ) "����"
FROM EMPLOYEE;
--> ���� 19���� 2���� �ְ�, �� ���� ������ 20���� ǥ�õ�.


--- * ���� 5�� ��ȸ
SELECT *
FROM (
        SELECT EMP_NAME, SALARY,
                RANK() OVER( ORDER BY SALARY DESC ) "����"
        FROM EMPLOYEE
)
WHERE ���� <= 5;

--- * ���� 3�� ~ 5�� ��ȸ
SELECT *
FROM (
        SELECT EMP_NAME, SALARY,
                RANK() OVER( ORDER BY SALARY DESC ) "����"
        FROM EMPLOYEE
)
WHERE ���� BETWEEN 3 AND 5;
--------------------------------------------------------------------------------
-- ============================= QUIZ ======================================= --
-- 1) ROWNUM�� Ȱ���Ͽ� �޿��� ���� ���� 5���� ��ȸ�Ϸ� ������, ����� ��ȸ���� �ʾҴ�.
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

--  ������(����) : ���ĵǱ� ���� 5���� �߷�����. ROWNUM�� ���� ������ ���� ���� �ο���!
--  �ذ���(��ġ����)
SELECT ROWNUM, EMP_NAME, SALARY
FROM ( SELECT EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC )
WHERE ROWNUM <= 5;

-- 2) �μ��� ��ձ޿��� 270������ �ʰ��ϴ� �μ��� �ش��ϴ� �μ��ڵ�, �μ��� �� �޿���,
--          �μ��� ��ձ޿�, �μ��� ��� ���� ��ȸ�Ϸ� ������, ����� ��ȸ�� ���� �ʾҴ�.
SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS ���, COUNT(*) �����
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--  ������(����) : �μ��� ��ձ޿��� �ƴ� ��� �������� �޿��� �������� �����ߴ�. 
--  �ذ���(��ġ����)
SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS ���, COUNT(*) �����
FROM EMPLOYEE
-- WHERE SALARY > 2700000
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;


-- �Ǵ�
SELECT *
FROM (
        SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS ���, COUNT(*) �����
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
)
WHERE ��� > 2700000;







