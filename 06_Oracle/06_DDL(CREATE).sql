/*
    DDL : ������ ���� ���
    
    ����Ŭ���� �����ϴ� ��ü�� ���� ����� (CREATE)
                            �����ϰ�    (ALTER)
                            ����      (DROP)      �ϴ� ���
    ==> ���� �����Ͱ� �ƴ� ��Ģ/������ �����ϴ� ���
    
    * ����Ŭ������ ��ü(����) : ���̺�, ��, ������, �ε���, ��Ű��, Ʈ����,
                             ���ν���, �Լ�, ���Ǿ�, �����, ...
*/

/*
    * CREATE : ��ü�� ���� �����ϴ� ����
    
    [���̺� ����]
    - ���̺� : ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
              ��� �����͵��� ���̺��� ���� �����
              
    - ǥ����
            CREATE TABLE ���̺�� (
                �÷��� �ڷ���(ũ��),
                �÷��� �ڷ���,
                �÷��� �ڷ���,
                ...
            
            );
            
        * �ڷ���
        
            - ���� => �ݵ�� ũ�� ��������� ��!
                + CHAR(����Ʈũ��)       : �������� (������ ������ �����͸� ���� ���)
                                          -> ������ ���̺��� ���� ������ ���� ����� ��� �������� ä���� ����
                                          �ִ� 2000����Ʈ���� ���� ����
                                          
                + VARCHAR2(����Ʈũ��)   : �������� (�������� ���̰� ���������� ���� ���)
                                          -> ����Ǵ� ������ ���̸�ŭ�� ������ ����
                                          �ִ� 4000����Ʈ���� ���� ����
                
            - ����    : NUMBER
            - ��¥    : DATE
*/
-- ȸ�� ������ ������ ���̺� ����
-- * ���̺�� : MEMBER
/*
    * �÷� ����
    - ȸ����ȣ      : ���� (NUMBER)
    - ȸ�����̵�    : ���� (VARCHAR2(20))
    - ȸ����й�ȣ  : ���� (VARCHAR2(20))
    - ȸ���̸�      : ���� (VARCHAR2(20))
    - ����         : ����, '��'/'��' (CHAR(3))            --> �ѱ��� 3byte
    - ����ó       : ����, '010-XXXX-XXXX' (CHAR(13))     --> ����,����,��ȣ 1byte
    - �̸���       : ���� (VARCHAR2(50))
    - ������       : ��¥ (DATE)
*/
CREATE TABLE MEMBER (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
);

SELECT * FROM MEMBER;
--------------------------------------------------------------------------------
/*
    * �÷��� ���� �߰��ϱ�
    
    [ǥ����]
            COMMENT ON COLUMN ���̺��.�÷��� IS '����';
            
    => �߸��ۼ����� ��� �ٽ� �ۼ� �� ���� --> �������!
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.GENDER IS '����';
COMMENT ON COLUMN MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.ENROLLDATE IS '������';

-- ���̺� �����ϱ� : DROP TABLE ���̺��;
-- DROP TABLE MEMBER;

-- ���̺� ������ �߰��ϱ� : INSERT INTO ���̺�� VALUES (��, ��, ��, ...)
INSERT INTO MEMBER VALUES (1, 'sjlim', '1234', '�Ӽ���', '��', '010-1234-1234'
                            , 'sjlim.iei@gmail.com', SYSDATE);

SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES (2, 'iu1234', '1234', '������', '��', NULL, NULL, SYSDATE);

INSERT INTO MEMBER VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT;     --> ������� ����
--------------------------------------------------------------------------------
/*
    * �������� : ���ϴ� ������ ���� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
                ������ ���Ἲ�� �����ϱ� ���� ����!
                
      - ���� ��� : �÷�������� / ���̺������
      
      - ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/
--
/*
    * NOT NULL *
      : �ش� �÷��� �ݵ�� ���� �����ؾ� �ϴ� ���
        => ���� NULL���� ����Ǹ� �ȵǴ� ���
        
    * ������ �߰�(����)/���� �� NULL���� ������� ����!
    * �÷� ���� ������θ� ���� ����!!
*/
-- * NOT NULL ���� ������ �߰��� ȸ�� ���̺�
--   ���̺�� : MEMBER_NOTNULL
--   ��, ȸ����ȣ, ���̵�, ��й�ȣ, �̸��� ���� �����ʹ� NULL���� ������� �ʴ´�.
CREATE TABLE MEMBER_NOTNULL (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
);

SELECT * FROM MEMBER_NOTNULL;

INSERT INTO MEMBER_NOTNULL 
       VALUES (1, 'hong123', '1234', 'ȫ�浿', '��', '010-1234-1234', 'hong123@gmail.com', sysdate);

INSERT INTO MEMBER_NOTNULL
       VALUES (2, 'myu1234', '4321', '������', null, null, null, null);

INSERT INTO MEMBER_NOTNULL
       VALUES (3, NULL, '5432', '������', NULL, NULL, NULL, NULL);
--> ������������ ���� ȸ�����̵� ���� NULL�̶� ���� �߻�! (�������ǿ� �����)

INSERT INTO MEMBER_NOTNULL 
       VALUES (1, 'hong123', '1234', 'ȫ�浿', '��', '010-1234-1234', 'hong123@gmail.com', sysdate);
--> �ߺ��Ǵ� �����Ͱ� �������� �߰��� ��...
--------------------------------------------------------------------------------
/*
    * UNIQUE *
      : �ش� �÷��� �ߺ��� ���� ���� ��� �����ϴ� ��������
      
    => ������ �߰�(����) / ���� �� ������ �ִ� ������ �� �� �ߺ��Ǵ� ���� ���� ��� ���� �߻�!
*/
-- * UNIQUE ���������� �߰��Ͽ� ���̺� ����
-- ���̺��: MEMBER_UNIQUE
--  -> ȸ�� ���̵� �ߺ����� �ʵ��� ����
CREATE TABLE MEMBER_UNIQUE (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,    -- �÷��������. NOT NULL, UNIQUE ������ �����Ǿ� ����
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    -- , UNIQUE (MEM_ID)        -- ���̺� �������
);

SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE
    VALUES (1, 'sjlim', '1234', '�Ӽ���', '��', '010-1111-2222', null, null);

INSERT INTO MEMBER_UNIQUE
    VALUES (2, 'sjlim', '3333', '�����', '��', '010-3331-2222', null, null);
-- UNIQUE ���� ���ǿ� ����Ǿ� ������ �߰� ���� (���� �߻�!)
--> ���� ���뿡 �������Ǹ����� �˷��� (�˾ƺ��Ⱑ ��ƴ�.)
--> ���� ���� ���� �� �������Ǹ��� �������� ������ �ý��ۿ��� �ڵ����� �������.
--------------------------------------------------------------------------------
/*
    * �������Ǹ� �����ϱ�
    
    [1] �÷� ���� ���
    
        CREATE TABLE ���̺�� (
            
            �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������
        
        );
        
    [2] ���̺� ���� ���
    
        CREATE TABLE ���̺�� (
        
            �÷��� �ڷ���,
            �÷��� �ڷ���,
            
            [CONSTRAINT �������Ǹ�] �������� �÷���
        
        )
*/
-- MEMBER_UNIQUE ���̺� ����
DROP TABLE MEMBER_UNIQUE;

-- �������Ǹ��� �����Ͽ� �ٽ� ����
CREATE TABLE MEMBER_UNIQUE (
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNM_NT NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , CONSTRAINT MEMID_UQ UNIQUE (MEM_ID)
);

INSERT INTO MEMBER_UNIQUE 
     VALUES (1, 'qqqq', '1234', '�׽�Ʈ1', '��', '010-1234-1234', 'test1@test.com', sysdate);

INSERT INTO MEMBER_UNIQUE
     VALUES (2, 'test2', '1234', '�׽�Ʈ2', null, null, null, null);

SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE
     VALUES (3, 'qqqq', '2222', '�׽�Ʈ3', null, null, null, null);
--> ������ �������Ǹ��� Ȯ���� �� ����! (MEMID_UQ)

INSERT INTO MEMBER_UNIQUE
    VALUES (4, null, null, null, null, null, null, null);
    
INSERT INTO MEMBER_UNIQUE
     VALUES (3, 'test3', '1234', '�׽�Ʈ3', '��', null, null, null);
--------------------------------------------------------------------------------
/*
    * CHECK(���ǽ�) *
      : �ش� �÷��� ������ �� �ִ� ���� ���� ������ ����
        ���ǿ� �����ϴ� ������ ������ �� ����
        => ������ ������ �����ϰ��� �� �� ���
*/
-- * CHECK ���� ������ �߰��� ���̺� ����
--  ���̺�� : MEMBER_CHECK
--  ���� �÷��� '��' �Ǵ� '��' �����͸� ����� �� �ֵ��� ����
CREATE TABLE MEMBER_CHECK (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , UNIQUE (MEM_ID)
    -- , CHECK(GENDER IN ('��', '��'))
);

SELECT * FROM MEMBER_CHECK;

INSERT INTO MEMBER_CHECK
    VALUES (1, 'hong22', '1234', 'ȫ�浿', '��', null, null, sysdate);

INSERT INTO MEMBER_CHECK
    VALUES (2, 'kong23', '1234', '����', 'rrr', null, null, sysdate);
--> ���� �÷��� ����Ʈ ���� �°� �����͸� �߰� ==> üũ �������ǿ� �����! (�����߻�)

INSERT INTO MEMBER_CHECK
    VALUES (2, 'kong23', '1234', '����', '��', null, null, sysdate);
--> check ���ǿ� �´� ���� ���尡��!

INSERT INTO MEMBER_CHECK
    VALUES (3, 'park24', '1234', '���ϴ�', NULL, NULL, NULL, SYSDATE);
--> ���� �÷��� NULL���� ����
--> ==> NULL�� ���� ���ٴ� �ǹ��̱� ������ ������ ����!
------> NULL���� ������� �ʰ��� �Ѵٸ� NOT NULL ���������� �߰��ϸ� ��!
--------------------------------------------------------------------------------
/*
    * PRIMARY KEY (�⺻Ű) *
      : ���̺��� �� ���� �ĺ��ϱ� ���� ���Ǵ� �÷��� �ο��ϴ� ��������
      
    ex) ȸ����ȣ, �й�, ��ǰ�ڵ�, �ֹ���ȣ, �����ȣ, ...
    
    - PRIMARY KEY => NOT NULL + UNIQUE
    - ���̺� �� ���� �� ���� ���� ����!
*/
-- * �⺻Ű ���������� �߰��Ͽ� ���̺� ����
--   ���̺�� : MEMBER_PRI
--   ȸ����ȣ�� �⺻Ű�� ����
CREATE TABLE MEMBER_PRI (
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , UNIQUE (MEM_ID)
);

SELECT * FROM MEMBER_PRI;

INSERT INTO MEMBER_PRI
    VALUES (1, 'hong123', 'qwer', 'ȫ�浿', null, null, null, sysdate);
    
INSERT INTO MEMBER_PRI
    VALUES (1, 'kong33', '1234', '����', null, null, null, sysdate);
--> �⺻Ű �÷�(ȸ����ȣ)�� �ߺ��� ���� ����Ƿ��� �ؼ� ���� �߻�! (=> UNIQUE �������ǿ� �����!)

INSERT INTO MEMBER_PRI
    VALUES (NULL, 'kong33', '1234', '����', null, null, null, sysdate);
--> �⺻Ű �÷�(ȸ����ȣ)�� NULL ���� �����Ϸ��� �ؼ� ���� �߻�! (=> NOT NULL �������ǿ� �����!)

INSERT INTO MEMBER_PRI
    VALUES (2, 'kong33', '1234', '����', null, null, null, sysdate);

SELECT * FROM MEMBER_PRI;
------------------------------------------------------------------
-- * �� ���� �÷����� �⺻Ű�� �����Ͽ� ���̺� ����
--  ���̺�� : MEMBER_PRI2
--  ȸ����ȣ, ȸ�����̵� �⺻Ű�� ���� (=> ����Ű)
CREATE TABLE MEMBER_PRI2 (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , UNIQUE (MEM_ID)
    , CONSTRAINT MEMPRI2_PK PRIMARY KEY (MEM_NO, MEM_ID)
);
SELECT * FROM MEMBER_PRI2;

INSERT INTO MEMBER_PRI2
    VALUES (1, 'hong12', '1234', 'ȫ�浿', NULL, NULL, NULL, SYSDATE);
INSERT INTO MEMBER_PRI2
    VALUES (1, 'kong12', '1234', '����', NULL, NULL, NULL, SYSDATE);
--> ����Ű : �� ���� �÷��� ���ÿ� �ϳ��� �⺻Ű�� �����ϴ� ��
--> ȸ�� ��ȣ�� �����ϳ�, ȸ�����̵� �ٸ��� ������ �����Ͱ� �߰��� ��!

-- � ȸ���� ��ǰ�� ��ٱ��Ͽ� ��� ������ �����ϴ� ���̺�
-- ȸ����ȣ, ��ǰ��, ���峯¥
CREATE TABLE MEMBER_LIKE (
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(50),
    LIKE_DATE DATE,
    
    PRIMARY KEY (MEM_NO, PRODUCT_NAME)
);

INSERT INTO MEMBER_LIKE
    VALUES (1, '��Ǯ���ű�', '25/03/01');
INSERT INTO MEMBER_LIKE
    VALUES (1, 'Ű����', '25/03/03');

SELECT * FROM MEMBER_LIKE;

INSERT INTO MEMBER_LIKE
    VALUES (2, 'Ű����', '25/03/05');


SELECT MEM_NAME, PRODUCT_NAME
FROM MEMBER_PRI2
    JOIN MEMBER_LIKE USING (MEM_NO);
--> �����ʹ� ����!
--------------------------------------------------------------------------------
/*
    * FOREIGN KEY (�ܷ�Ű) *
     : �ٸ� ���̺��� �����ϴ� ���� �����ϰ��� �� �� ���Ǵ� ��������
       -> �ٸ� ���̺��� �����Ѵٰ� ǥ��
       -> �ַ� �ܷ�Ű�� ���ؼ� ���̺� ���� ���踦 ����
       
    - �÷��������
    
        �÷��� �ڷ��� REFERENCES ���������̺�� [(�������÷���)]
        
        
    - ���̺������
    
        FOREIGN KEY (�÷���) REFERENCES ���������̺�� [(�������÷���)]
        
    => �������÷��� ���� �� �����ϴ� ���̺��� �⺻Ű �÷��� ��Ī��!        
*/
-- * ȸ�� ��� ������ ������ ���̺� ����
--   ���̺�� : MEMBER_GRADE
--   ��޹�ȣ(PK), ��޸�(NOT NULL)
CREATE TABLE MEMBER_GRADE (
    GRADE_NO NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEMBER_GRADE VALUES (100, '�Ϲ�ȸ��');
INSERT INTO MEMBER_GRADE VALUES (200, 'VIPȸ��');
INSERT INTO MEMBER_GRADE VALUES (300, 'VVIPȸ��');

SELECT * FROM MEMBER_GRADE;

-- MEMBER ���̺� ����
DROP TABLE MEMBER;

-- MEMBER ���̺� ���� : ȸ����ȣ, ȸ�����̵�, ȸ����й�ȣ, ȸ���̸�, ����, ������, ȸ����޹�ȣ(GRADE_ID)
CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    ENROLLDATE DATE,
    -- �÷� ���� ���
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO)
    
    -- ���̺� ���� ���
    -- , FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE (GRADE_NO)
);

INSERT INTO MEMBER
    VALUES (1, 'sjlim', '1234', '�Ӽ���', '��', sysdate, 100);
INSERT INTO MEMBER
    VALUES (2, 'kim00', '1234', '�����', '��', sysdate, 200);
INSERT INTO MEMBER
    VALUES (3, 'choi11', '1234', '�ּ���', '��', sysdate, NULL);
--> �ܷ�Ű�� ������ �÷����� �⺻������ NULL���� ���� ����!

INSERT INTO MEMBER
    VALUES (4, 'kong44', '1234', '����', '��', sysdate, 400);
--> ���� �߻�!! "�θ� Ű�� �����ϴ�" --> ȸ����� ���̺� ������� ���� ���� ���!

-- MEMBER_GRADE (�θ����̺�) -|-----------<- MEMBER (�ڽ����̺�)
--      1:N ���� . 1 (�θ����̺�), N (�ڽ����̺�)

INSERT INTO MEMBER
    VALUES (4, 'kong44', '1234', '����', '��', sysdate, 100);

select * from member;

--> �θ����̺�(MEMBER_GRADE)���� "�Ϲ�ȸ��" ����� �����Ѵٸ�?

-- * ������ ���� : DELETE FROM ���̺�� WHERE ����;

-- ȸ�� ��� ���̺��� ��޹�ȣ�� 100�� �����͸� ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> �ڽ����̺�(MEMBER)���� 100�̶�� ���� ����ϱ� �ֱ� ������ ���� �Ұ�!

-- ȸ�� ��� ���̺��� ��޹�ȣ�� 300�� �����͸� ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 300;
--> �ڽ����̺�(MEMBER)���� 300�̶�� ���� ������� �ʾұ� ������ ���� ����!

-- * �ڽ����̺��� �̹� ����ϰ� �ִ� ���� ���� ��� 
--      �θ����̺�κ��� ������ ������ ���� �ʴ� "�����ɼ�"�� ����!

ROLLBACK;   -- ��������� ����ϴ� ��

SELECT * FROM MEMBER_GRADE;
--------------------------------------------------------------------------------
/*
    * �ܷ�Ű �������� - ���� �ɼ�
      : �θ����̺��� ������ ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽ����̺��� ����
        ��� �� �������� ���� �ɼ�
        
    - ON DELETE RESTRICTED (�⺻��) : �ڽ� ���̺�κ��� ������� ���� ���� ���
                                     �θ� ���̺��� �����͸� ���� �Ұ�
    - ON DELETE SET NULL : �θ� ���̺� �ִ� ������ ���� �� 
                           �ش� �����͸� ����ϰ� �ִ� �ڽ����̺� ���� NULL�� ����
    - ON DELETE CASCADE : �θ� ���̺� �ִ� ������ ���� ��
                          �ش� �����͸� ����ϰ� �ִ� �ڽ����̺� ���� ����
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    ENROLLDATE DATE,
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL
);

INSERT INTO MEMBER
    VALUES (1, 'sjlim', '1234', '�Ӽ���', '��', sysdate, 100);
INSERT INTO MEMBER
    VALUES (2, 'kim00', '1234', '�����', '��', sysdate, 200);
INSERT INTO MEMBER
    VALUES (3, 'choi11', '1234', '�ּ���', '��', sysdate, NULL);


SELECT * FROM MEMBER;

-- ȸ����� ���� �� 100���� ���� ��� ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> ���� �ɼǿ� ���� �ڽ����̺�(MEMBER)���� 100���� ����ߴ� �����Ͱ� NULL���� �����!
--  �θ����̺�(MEMBER_GRADE)���� 100���� ���� ������ ������!

SELECT * FROM MEMBER_GRADE;

ROLLBACK;
--------
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    ENROLLDATE DATE,
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE
);

INSERT INTO MEMBER
    VALUES (1, 'sjlim', '1234', '�Ӽ���', '��', sysdate, 100);
INSERT INTO MEMBER
    VALUES (2, 'kim00', '1234', '�����', '��', sysdate, 200);
INSERT INTO MEMBER
    VALUES (3, 'choi11', '1234', '�ּ���', '��', sysdate, NULL);
    
    
SELECT * FROM MEMBER;

-- ȸ�� ��� �� 100�� ��� ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
--> ���� �ɼǿ� ���� �ڽ����̺�(MEMBER)���� 100���� ����ϰ� �ִ� �����Ͱ� ������!
--------------------------------------------------------------------------------
/*
    * �⺻�� (DEFAULT)
     : ���������� �ƴ�!
       �÷��� �������� �ʰ� ������ �߰� �� NULL���� �߰��Ǵµ�
       �̶�, NULL���� �ƴ� �ٸ� ������ �����ϰ��� �� ��
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    AGE NUMBER,
    HOBBY VARCHAR2(30) DEFAULT '����',
    ENROLLDATE DATE
);

SELECT * FROM MEMBER;

INSERT INTO MEMBER
    VALUES (1, '�ο�', 24, '���ǰ���', SYSDATE);
INSERT INTO MEMBER
    VALUES (2, '����', 23, '����', NULL);
INSERT INTO MEMBER
    VALUES (3, '����', 26, NULL, NULL);


INSERT INTO MEMBER (MEM_NO, MEM_NAME)
    VALUES (4, '����');
--> �������� ���� �÷��� ���� ���� �⺻������ NULL���� �����
--  ��, �ش� �÷��� �⺻���� �����Ǿ� ���� ��� NULL���� �ƴ� �⺻������ �����.
--------------------------------------------------------------------------------
-- * ���̺� ����
/*
        CREATE TABLE ���̺��
        AS ��������;
*/
-- MEMBER ���̺� ����
CREATE TABLE MEMBER_COPY
AS SELECT * FROM MEMBER;

SELECT * FROM MEMBER_COPY;
--------------------------------------------------------------------------------
/*
    * ���̺��� ��������� �����ϰ��� �� �� => ALTER TABLE
    
            ALTER TABLE ���̺�� �����ҳ���
            
            * [������ ����]�� �ۼ�
        - NOT NULL : MODIFY �÷��� NOT NULL;
        
        - UNIQUE   : ADD UNIQUE(�÷���);
        - CHECK    : ADD CHECK(���ǽ�);
        - PRIMARY KEY : ADD PRIMARY KEY (�÷���);
        - FOREIGN KEY : ADD FOREIGN KEY (�÷���) REFERENCES ���������̺�� [(�������÷���)];
        
        - DEFAULT �ɼ� : MODIFY �÷��� DEFAULT �⺻��;
*/
-- MEMBER_COPY ���̺� ȸ����ȣ �÷��� �⺻Ű ����
ALTER TABLE MEMBER_COPY ADD PRIMARY KEY (MEM_NO);

-- MEMBER_COPY ���̺� ��� �÷��� �⺻�� ���� - '����'
ALTER TABLE MEMBER_COPY MODIFY HOBBY DEFAULT '-';














