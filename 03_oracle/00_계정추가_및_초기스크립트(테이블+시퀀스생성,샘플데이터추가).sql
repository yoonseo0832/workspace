-- * JDBC �� ���� : C##JDBC / JDBC  ---> ������ �������� ����

CREATE USER C##JDBC IDENTIFIED BY JDBC; -- * ���� ����
GRANT CONNECT, RESOURCE TO C##JDBC;     -- * ���� �ο�
ALTER USER C##JDBC QUOTA UNLIMITED ON USERS;    -- * ���̺� �����̽� ����

--------------------------------------------
---> C##JDBC �������� ����
-- ȸ�� ������ ������ ���̺� (MEMBER)
DROP TABLE MEMBER;
CREATE TABLE MEMBER (
    MEMBERNO NUMBER PRIMARY KEY,                -- ȸ�� ��ȣ
    MEMBERID VARCHAR2(20) NOT NULL UNIQUE,      -- ȸ�� ���̵�
    MEMBERPW VARCHAR2(20) NOT NULL,             -- ȸ�� ��й�ȣ
    GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')), -- ���� ('M', 'F')
    AGE NUMBER,                                 -- ����
    EMAIL VARCHAR2(30),                         -- �̸���
    ADDRESS VARCHAR2(100),                      -- �ּ�
    PHONE VARCHAR2(13),                         -- ����ó (XXX-XXXX-XXXX)
    HOBBY VARCHAR2(50),                         -- ���
    ENROLLDATE DATE DEFAULT SYSDATE NOT NULL    -- ������
);

-- ȸ�� ��ȣ�� ����� ������ ��ü ����
DROP SEQUENCE SEQ_MNO;
CREATE SEQUENCE SEQ_MNO
NOCACHE;

-- ���õ����� �߰� (2��)
INSERT INTO MEMBER
    VALUES (SEQ_MNO.NEXTVAL, 'admin', '1234', 'M', 20, 'admin@kh.or.kr', '����', '010-0000-0000', NULL, '2020/03/12');
INSERT INTO MEMBER
    VALUES (SEQ_MNO.NEXTVAL, 'sjlim', '1234', 'F', 20, 'sjlim@kh.or.kr', NULL, '010-0000-0000', NULL, DEFAULT);

COMMIT;
--------------------------------------------------------------------------------

-- �׽�Ʈ�� ���̺� (TEST)
CREATE TABLE TEST (
    TNO NUMBER,
    TNAME VARCHAR2(30),
    TDATE DATE
);

INSERT INTO TEST VALUES (1, 'ȫ�浿', SYSDATE);

COMMIT;

--------------------------------------------------------------------------------