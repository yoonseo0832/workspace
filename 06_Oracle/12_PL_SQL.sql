/*
    * PL/SQL : PROCEDURE LANGUAGE EXTENSION TO SQL
    
      ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
      SQL ���� ������ ���� ����, ���ǹ�, �ݺ��� ���� ���� -> SQL ������ ����
      �ټ��� SQL���� �ѹ��� ���డ��
      
    * ���� *
    
    [�����]       : DECLARE �� ����. ������ ����� �ʱ�ȭ�ϴ� �κ�.
    �����         : BEGIN ���� ����. SQL�� �Ǵ� ���(���ǹ�, �ݺ���)���� ������ �ۼ��ϴ� �κ�
    [����ó����]    : EXCEPTION ���� ����. ���� �߻� �� �ذ�(ó��)�ϱ� ���� �κ�.
*/
-- * ȭ�鿡 ǥ���ϱ� ���� ����
SET SERVEROUTPUT ON;


-- "HELLO ORACLE" ���
----> ȭ�鿡 ����ϰ��� �� �� : DBMS_OUTPUT.PUT_LINE(����ҳ���)

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
    --> JAVA : System.out.println("Hello Java");
END;
/
--------------------------------------------------------------------------------
/*
    * ����� (DECLARE)
      : ���� �Ǵ� ����� �����ϴ� �κ� (����� ���ÿ� �ʱ�ȭ�� ����)
      
    - ������Ÿ�� ���� ����
      * �Ϲ� Ÿ��
      * ���۷��� Ÿ��
      * ROW Ÿ��
*/
-----
/*
    * �Ϲ� Ÿ�� ���� *
    
    ������ [CONSTANT] �ڷ��� [:= ��];
    
    -- ��� ���� �� CONSTANT �� �߰�
    -- �ʱ�ȭ �� := ��ȣ�� ���
*/

DECLARE
    EID NUMBER;                 -- EID ��� �̸��� NUMBER Ÿ�� ����
    ENAME VARCHAR2(20);         -- ENAME ��� �̸��� VARCHAR2(20) Ÿ�� ����
    PI CONSTANT NUMBER := 3.14;   -- PI ��� �̸��� NUMBER Ÿ�� ��� ���� �� 3.14��� ������ �ʱ�ȭ
BEGIN
    -- * ������ ���� ����
    EID := 100;           -- EID ������ 100�̶�� ���� ����
    ENAME := '�Ӽ���';     -- ENAME ������ ���� �̸��� ����
    
    -- * �� ����, ����� ����� ���� ȭ�鿡 ���
    DBMS_OUTPUT.PUT_LINE(EID);
    DBMS_OUTPUT.PUT_LINE(ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
    --> Ư�� ���ڿ� ��(����)�� �����ϰ��� �� ��� ���Ῥ����(||)�� ���!
END;
/

-- * ���� �Է� �޾� ������ ����
DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    ENAME := '�Ӽ���';    
    EID := &�����ȣ;
    --> ���� �Է¹ް��� �� ��� &��ü������ �������� �ۼ�
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
---------------------------------------------------
/*
    * ���۷��� Ÿ�� ���� *
      : � ���̺��� � �÷��� ������ Ÿ���� �����Ͽ� �ش� Ÿ������ ������ ����
      
    [ǥ����]
            ������ ���̺��.�÷���%TYPE    
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;       -- EID ��� ������ EMPLOYEE ���̺��� EMP_ID �÷��� Ÿ���� ����
    ENAME EMPLOYEE.EMP_NAME%TYPE;   -- ENAME ��� ������ EMPLOYEE ���̺��� EMP_NAME �÷��� Ÿ���� ����
    SAL EMPLOYEE.SALARY%TYPE;       -- SAL ��� ���� EMPLOYEE ���̺��� SALARY �÷��� Ÿ���� ����
BEGIN
    -- EMPLOYEE ���̺��� �Է¹��� ����� ���� ��� ������ ��ȸ (���, �̸�, �޿�)
    SELECT EMP_ID, EMP_NAME, SALARY
      INTO EID, ENAME, SAL      -- �� �÷��� ���� ���� ������ ����(����)
      FROM EMPLOYEE
     -- WHERE EMP_ID = 200;
     WHERE EMP_ID = &���;    -- ����� �Է¹޾� �ش� ������� ��� ������ ��ȸ

    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/

---- * Quiz * ----
/*
    * ���۷��� Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE�� �����ϰ�
      �� �ڷ����� EMPLOYEE ���̺��� EMP_ID, EMP_NAME, JOB_CODE, SALARY �÷���
                DEPARTMENT ���̺��� DEPT_TITLE �÷��� �����ϵ��� �� ��
      ����ڰ� �Է��� ����� ��� ������ ��ȸ�Ͽ� ������ ��� ���
    
      => ��� ���� : {���}, {�̸�}, {�����ڵ�}, {�޿�}, {�μ���}
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
      INTO EID, ENAME, JCODE, SAL, DTITLE
      FROM EMPLOYEE
           JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
     WHERE EMP_ID = &���;
     
     DBMS_OUTPUT.PUT_LINE(EID || ', ' || ENAME || ', ' || JCODE || ', ' || SAL || ', ' || DTITLE);
END;
/
-------------------------------------------------------
/*
    * ROW Ÿ�� ���� *
     : ���̺��� �� �࿡ ���� ��� �÷����� �ѹ��� ���� �� �ִ� ����
     
    [ǥ����]
            ������ ���̺��%ROWTYPE;
*/
-- E ��� ������ EMPLOYEE ���̺��� ROW Ÿ�� ���� ����
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
      INTO E
      FROM EMPLOYEE
     WHERE EMP_ID = &���;

    -- �����, �޿�, ���ʽ� ������ ���
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    -- DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || E.BONUS);
    --> NULL ���� �ٸ� ������ ǥ���ϰ� ���� ��� : NVL �Լ� ��� ����!
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || NVL(E.BONUS, 0));
    -- DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || TO_CHAR(NVL(E.BONUS, 0), '0.0'));
    -- * �Ҽ��� ǥ�� ���� ����
END;
/

-- SELECT * FROM EMPLOYEE WHERE EMP_ID = 219;
--==============================================================================
/*
    * ����� (BEGIN)
    
    ** ���ǹ� **
        - ���� IF��    : IF ���ǽ� THEN ���೻�� END IF;
        - IF/ELSE��   : IF ���ǽ� THEN ���ǿ������Ҷ����೻��
                        ELSE �����������������������೻�� END IF;
        - IF/ELSIF��  : IF ���ǽ�1 THEN ���ǽ�1�������Ҷ����೻�� 
                        ELSIF ���ǽ�2 THEN ���ǽ�2�������Ҷ����೻��
                        ...
                        [ELSE ��������������������������೻��] 
                        END IF;
        - CASE/WHEN/THEN ��
            CASE �񱳴�� WHEN �񱳰�1 THEN �����1   -- �񱳴��� �񱳰�1�� ���� ��� �����1
                         WHEN �񱳰�2 THEN �����2   -- �񱳴��� �񱳰�2�� ���� ��� �����2
                         ...
                         ELSE �����N      -- �񱳰����� �񱳴��� ��� �ٸ� ��� �����N
            END;
*/
-----
/*
    ����ڿ��� ����� �Է¹޾� �ش� ����� ���, �̸�, �޿�, ���ʽ� ������ ��ȸ�Ͽ� ���
    * �� �����Ϳ� ���� ���� : ���(EID), �̸�(ENAME), �޿�(SAL), ���ʽ�(BONUS)
    ��, ���ʽ� ���� 0(NULL)�� ����� ��� "���ʽ��� ���� �ʴ� ����Դϴ�" ���
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
      INTO EID, ENAME, SAL, BONUS
      FROM EMPLOYEE
     WHERE EMP_ID = &���;
     
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID); 
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);

    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� �ʴ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('BONUS : ' || BONUS);
    END IF;
END;
/

----------
/*
    ����ڷκ��� ����� �Է¹޾� ��� ������ ��ȸ�Ͽ� ȭ�鿡 ǥ�� (���, �̸�, �μ���, ��������)
    --> �������� : 'KO' �� ��� "������" ǥ��, �׷������� ��� "�ؿ���" ǥ��
    
    * ���۷��� Ÿ�� ���� : ���, �̸�, �μ���, �����ڵ�
    * �Ϲ� Ÿ�� ����    : �� ������ ����. ����Ÿ��.
    
    **** ȭ�鿡 ǥ�� ****
    ���: XX
    �̸�: XXX
    �μ�: XXXX
    �Ҽ�: ������ �Ǵ� �ؿ���
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    
    TEAM VARCHAR2(10);
BEGIN
    -- * ���, �����, �μ���, �����ڵ带 ��ȸ
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
      INTO EID, ENAME, DTITLE, NCODE
      FROM EMPLOYEE
            JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
            JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
     WHERE EMP_ID = '&���_��ȣ';

    -- * �����ڵ� (NCODE)�� ���� �� ������ ����(����)
    IF NCODE = 'KO'
        THEN TEAM := '������';     -- TEAM ������ '������' ���� ����
    ELSE
        TEAM := '�ؿ���';          -- TEAM ������ '�ؿ���' ���� ����
    END IF;
    
    -- * ������ ������ ���(ȭ�鿡 ǥ��)
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('����� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
  FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
 WHERE EMP_ID = 216;
----------------------------------------------
/*
    ����(SCORE): ����ڿ��� �Է¹��� ������ ������ ����
    ���(GRADE): ������ ���� ��� ������ ������ ���� ('A', 'B', 'C', 'D', 'F')
    
    ����ڿ��� ������ �Է¹޾�
        90�� �̻��̸� 'A'
        80�� �̻��̸� 'B'
        70�� �̻��̸� 'C'
        60�� �̻��̸� 'D'
        �� �Ʒ��� 'F' �� ����� �ο��Ѵ�.
    
    ** ȭ�鿡 ǥ�� **
    "������ XX�̰�, ����� X�Դϴ�."
    ���� F����̶�� "���� ����Դϴ�." �߰��� ǥ��
*/
DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN
    -- ����ڿ��� ������ �Է¹޾� SCORE ������ ����
    SCORE := &����;
    
    -- SCORE ���� ���� GRADE ������ ����
    IF SCORE >= 90
        THEN GRADE := 'A';
    ELSIF SCORE >= 80
        THEN GRADE := 'B';
    ELSIF SCORE >= 70
        THEN GRADE := 'C';
    ELSIF SCORE >= 60
        THEN GRADE := 'D';
    ELSE
        GRADE := 'F';
    END IF;
    
    -- ȭ�鿡 ������ ����� ǥ��(���)
    DBMS_OUTPUT.PUT_LINE('������ ' || SCORE || '�̰�, ����� ' || GRADE || '�Դϴ�.');
    
    -- ����, ����� 'F'��� '���� ����Դϴ�.' ǥ��
    IF GRADE = 'F'
        THEN DBMS_OUTPUT.PUT_LINE('���� ����Դϴ�.');
    END IF;
    
END;
/
------------------------------------------------------
-- * ����� �Է¹޾� �ش� ����� �μ��ڵ带 �������� �μ����� ��� (* JOIN ��� X)

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    
    DTITLE VARCHAR2(20);
BEGIN
    -- ����� �Է¹޾� �ش� ����� ������ ��ȸ�Ͽ� ������ ����
    SELECT * 
      INTO EMP
      FROM EMPLOYEE
     WHERE EMP_ID = &���;
     
    -- �ش� ����� �μ��ڵ� �������� �μ��� ������ DTITLE ������ ����
    DTITLE :=   CASE EMP.DEPT_CODE
                    WHEN 'D1' THEN '�λ������'
                    WHEN 'D2' THEN 'ȸ�������'
                    WHEN 'D3' THEN '�����ú�'
                    WHEN 'D4' THEN '����������'
                    WHEN 'D5' THEN '�ؿܿ���1��'
                    WHEN 'D6' THEN '�ؿܿ���2��'
                    WHEN 'D7' THEN '�ؿܿ���3��'
                    WHEN 'D8' THEN '���������'
                    WHEN 'D9' THEN '�ѹ���'
                END;
                
    -- XXX ����� �ҼӺμ��� XX�Դϴ�. ǥ��(���)
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || ' ����� �ҼӺμ��� ' || DTITLE || '�Դϴ�.');
END;
/

SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE EMP_ID = 217;
--------------------------------------------------------------------------------
/*
    * �ݺ��� *
    
        - �⺻ ����
            LOOP
                �ݺ��� ����
                �ݺ����� ������ ����
            END LOOP;
            
            * �ݺ����� ������ ����
              1) IF ���ǽ� 
                    THEN EXIT; 
                 END IF;
                 
              2) EXIT WHEN ���ǽ�;
        
        - FOR LOOP ��
            FOR ������ IN [REVERSE] �ʱⰪ..������
            LOOP
                �ݺ��� ����
                [�ݺ����� ������ ����]
            END LOOP;
            
            * REVERSE : ���������� �ʱⰪ���� �ݺ�
        
        - WHILE LOOP ��
            WHILE ���ǽ�
            LOOP
                �ݺ��� ����
                [�ݺ����� ������ ����]
            END LOOP;
*/
-- * �⺻ ������ ����Ͽ� 'HELLO ORACLE!' 5�� ���
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('HELLO ORACLE!');
        N := N + 1;
        
        IF N > 5
            THEN EXIT;
        END IF;
    END LOOP;
END;
/

-- * FOR LOOP�� ����Ͽ� HELLO ORACLE�� 5�� ���
BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I || ') HELLO ORACLE!!');
    END LOOP;
END;
/

BEGIN
    FOR I IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I || ') HELLO ORACLE!!');
    END LOOP;
END;
/
---------------------------------------------------
-- * TEST ���̺� ����
DROP TABLE TEST;

-- * TEST ���̺��� ���� : TNO(PK), TDATE
CREATE TABLE TEST (
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

-- * SEQ_TNO ������ ���� - ������ 2, �ִ밪 1000, ��ȯ X, ĳ�ø޸� X
CREATE SEQUENCE SEQ_TNO
INCREMENT BY 2
MAXVALUE 1000
NOCYCLE
NOCACHE;

-- * TEST ���̺� �����͸� 100�� �߰�. TDATE ���� ���� ��¥ ������ �߰�.
BEGIN
    FOR I IN 1..100
    LOOP
        INSERT INTO TEST VALUES (SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END;
/

SELECT COUNT(*) FROM TEST;
--------------------------------------------------------------------------------
/*
    * ����ó���� (EXCEPTION) *
      -> ���� �� �߻��ϴ� ����
      
    [ǥ����]
            EXCEPTION
                WHEN ���ܸ� THEN ����ó������;
                WHEN ���ܸ� THEN ����ó������;
                ...
                WHEN OTHERS THEN ����ó������;
                
            * ����Ŭ���� �̸� ������ ���� => �ý��� ����
                - NO_DATA_FOUND : ��ȸ�� ����� ���� �� 
                - TOO_MANY_ROWS : ��ȸ�� ����� ���� ���� �� (=> ������ ����)
                - ZERO_DIVIDE   : 0���� ���� �������� �� ��
                - DUP_VAL_ON_INDEX : UNIQUE ���ǿ� ����� �� (�ߺ��� �ִ� ���)
                ....
            * OTHERS  :  � ���ܵ� �߻��Ǿ��� ��
*/

-- * ����ڿ��� ���ڸ� �Է¹޾� 10�� ���� ����� ���
DECLARE
    NUM NUMBER;
BEGIN
    NUM := &����;
    
    DBMS_OUTPUT.PUT_LINE( 10 / NUM );
EXCEPTION

    -- WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� ����!!');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� ����!!');
    
END;
/

-- EMPLOYEE ���̺� EMP_ID �÷��� �⺻Ű�� ���� *
-- ALTER TABLE EMPLOYEE ADD PRIMARY KEY (EMP_ID);

-- PK : NOT NULL + UNIQUE

--  ����ڿ��� ����� �Է¹޾�, ���ö ����� ����� ����
BEGIN

    UPDATE EMPLOYEE
       SET EMP_ID = '&������_���'
     WHERE EMP_NAME = '���ö';
     
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�ߺ��� �����ȣ �Դϴ�.');
END;
/










