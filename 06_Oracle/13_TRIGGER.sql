/*
    * Ʈ���� (TRIGGER)
      : ������ ���̺� DML(INSERT, UPDATE, DELETE)���� ���ؼ� ��������� ���� �� ( �̺�Ʈ�� �߻����� �� )
        �ڵ����� �Ź� ������ ������ �̸� �����صδ� ��
        
    ex) ȸ�� Ż�� �� ���� ȸ�����̺� ������ ����(DELETE)�ϰ�
        Ż�� ȸ�� ���̺� ������ �߰�(INSERT)�ؾ� �� �� �ڵ����� ����..
        
    ex) �Ű� Ƚ���� Ư�� ���� �Ѿ�� �� �ش� ȸ���� ������Ʈ�� ó��
    
    ex) ����� ���� �����͸� ������ �� �ش� ��ǰ�� ��� ������ �����ؾ� �� ��
*/
------
/*
    * Ʈ������ ���� *
    
    - SQL���� ���� �ñ⿡ ���� �з� -
        * BEFORE TRIGGER : ������ ���̺� �̺�Ʈ�� �߻��ϱ� ���� Ʈ���� ����
        * AFTER TRIGGER  : ������ ���̺� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ����
    
    - SQL���� ���� ������ �޴� �� �࿡ ���� �з� -
        * ���� Ʈ����  :  �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
        * �� Ʈ����   :  �ش� SQL���� ����� ������ �Ź� Ʈ���� ����
                        - FOR EACH ROW �ɼ� �����ؾ� ��.
                        
            :OLD  - BEFORE UPDATE (���� �� ������), BEFORE DELETE (���� �� ������)
            :NEW  - AFTER INSERT (�߰��� ������), AFTER UPDATE (������ ������)
*/
-------------
/*
    * Ʈ���� ���� *
    
    CREATE TRIGGER Ʈ���Ÿ�                             -- Ʈ���� �⺻���� (�̸�)
    BEFORE|AFTER INSERT|UPDATE|DELETE ON ���̺��       -- �̺�Ʈ ���� ����
    [FOR EACH ROW]                                  -- �Ź� Ʈ���Ÿ� �߻� ��ų ��� �ۼ�
    [DECLARE]       -- ����/��� ���� �� �ʱ�ȭ
    BEGIN           -- ����� (SQL��, ���ǹ�, �ݺ���, ...)
                       �̺�Ʈ �߻� �� �ڵ����� ó���ϰ��� �ϴ� ����
    [EXCEPTION]     -- ����ó����
    END;
    /
*/
-- * EMPLOYEE ���̺� �����Ͱ� �߰��� ������ '���Ի���� ȯ���մϴ� ^^' ȭ�鿡 ǥ��
CREATE TRIGGER TRG_EMP01
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ� ^^');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
        VALUES (SEQ_EID.NEXTVAL, 'ȫ�浿', '770808-1111111', 'J6', SYSDATE);
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
        VALUES (SEQ_EID.NEXTVAL, '��浿', '770208-1111111', 'J6', SYSDATE);

SELECT * FROM EMPLOYEE;
--------------------------------------------------------------------------------
-- * ��ǰ �԰� , ��� ���� *

-- TB_PRODUCT ���̺� ����  --> ��ǰ ������ �����ϱ� ���� ���̺�
CREATE TABLE TB_PRODUCT (
    PNO NUMBER PRIMARY KEY,         -- ��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL,    -- ��ǰ��
    BRAND VARCHAR2(30) NOT NULL,    -- �귣��
    PRICE NUMBER DEFAULT 0,         -- ����
    STOCK NUMBER DEFAULT 0          -- ������
);

-- SEQ_PNO ������ ���� (���۹�ȣ: 200, ������: 5, ĳ�ø޸�X)
CREATE SEQUENCE SEQ_PNO
START WITH 200
INCREMENT BY 5
NOCACHE;

-- * ���� ������ �߰�
INSERT INTO TB_PRODUCT (PNO, PNAME, BRAND) VALUES (SEQ_PNO.NEXTVAL, '������16', '���');
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '������ 25', '����', 1500000, 50);
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '��������', '�����', 900000, 200);

SELECT * FROM TB_PRODUCT;

COMMIT;     -- DB�� ����!


-- TB_PDETAIL ���̺� ����  ---> ��ǰ ����� ������ �����ϱ� ���� ���̺�
CREATE TABLE TB_PDETAIL (
    DNO NUMBER PRIMARY KEY,             -- ������� ��ȣ
    PNO NUMBER REFERENCES TB_PRODUCT,   -- ��ǰ ��ȣ
    DDATE DATE DEFAULT SYSDATE,         -- �������
    AMOUNT NUMBER NOT NULL,             -- ����� ����
    DTYPE CHAR(10) CHECK(DTYPE IN ('�԰�', '���'))  -- ����� ����
);

-- * SEQ_DNO ������ ���� (ĳ�ø޸� X) --> ���۹�ȣ: 1, ������: 1
CREATE SEQUENCE SEQ_DNO
NOCACHE;

--------*-------

-- 205�� ��ǰ, ���� 5�� ���
--  * TB_PDETAIL ���̺��� �����Ͱ� �߰�
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 205, DEFAULT, 5, '���');
--  * TB_PRODUCT ���̺��� �����͸� ����(����) -> 205�� ��ǰ�� ���
UPDATE TB_PRODUCT
   SET STOCK = STOCK - 5
 WHERE PNO = 205;

SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PDETAIL;

COMMIT;

-- 200�� ��ǰ�� 10�� �԰�
-- * TB_PDETAIL ������ �߰�
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '�԰�');

-- * TB_PRODUCT ������ ������Ʈ
UPDATE TB_PRODUCT
   SET STOCK = STOCK + 10
 WHERE PNO = 205; --> ������Ʈ�� �߸���!! �ѹ�!!

ROLLBACK;

INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '�԰�');

UPDATE TB_PRODUCT
   SET STOCK = STOCK + 10
 WHERE PNO = 200;
--------------------------------------------------------------------------------
/*
    TB_PDETAIL (�������) ���̺� �����Ͱ� �߰��Ǿ��� ��
    TB_PRODUCT (��ǰ) ���̺� �ش� �������� ��� ������ ����(������Ʈ)�ؾ� ��!
    
    - UPDATE ���� - 
      * ��ǰ�� �԰�� ��� -> �ش� ��ǰ�� ã�Ƽ� ��� ������ ����
        UPDATE TB_PRODUCT
           SET STOCK = STOCK + �԰����(TB_PDETAIL.AMOUNT) ---> :NEW.AMOUNT
         WHERE PNO = �԰�Ȼ�ǰ��ȣ(TP_PDETAIL.PNO)         ---> :NEW.PNO
         
      * ��ǰ�� ���� ��� -> �ش� ��ǰ�� ã�Ƽ� ��� ������ ����
        UPDATE TB_PRODUCT
           SET STOCK = STOCK - ������(TB_PDETAIL.AMOUNT) ---> :NEW.AMOUNT
         WHERE PNO = ���Ȼ�ǰ��ȣ(TP_PDETAIL.PNO)         ---> :NEW.PNO
*/
-- * TRG_02 Ʈ���� ���� *
CREATE TRIGGER TRG_02
AFTER INSERT ON TB_PDETAIL
FOR EACH ROW
BEGIN
    -- ��ǰ�� �԰�Ǿ��� �� --> ��� ���� ����
    -- > �߰��� ������ �� DTYPE �÷����� Ȯ�� ����!
    
    IF :NEW.DTYPE = '�԰�'    --> ���� �߰��� ������(:NEW) �� DTYPE �÷��� ���� '�԰�'�� ���
        THEN
            UPDATE TB_PRODUCT
                   SET STOCK = STOCK + :NEW.AMOUNT
                 WHERE PNO = :NEW.PNO;
                 
    ELSE -- ����� ��� --> ��� ���� ����
        UPDATE TB_PRODUCT
           SET STOCK = STOCK - :NEW.AMOUNT
         WHERE PNO = :NEW.PNO;
         
    END IF;
END;
/

SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PDETAIL;

-- �԰� ������ �߰�
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 210, SYSDATE, 7, '�԰�');

-- ��� ������ �߰�
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, DEFAULT, 3, '���');

COMMIT;



