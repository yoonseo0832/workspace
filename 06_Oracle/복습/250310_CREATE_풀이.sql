/*
    ��ĭ�� ������ �ܾ �ۼ��Ͻÿ�.
    (DDL) : CREATE, ALTER, DROP
        - ������ ���� ��� : ������ ����. ��ü ����/����/����
    
    (DML) : INSERT, DELETE, UPDATE
        - ������ ���� ��� : �����͸� �߰�/����/����
    
    (DQL) : SELECT
        - ������ ���� ��� : �����͸� ��ȸ
*/

/*
-- ���� ����� ���� ���� �� �Ʒ� ������ �ۼ����ּ���.
-- ID/PW  :  TEST250305 / test0305
    * ����� ���� �߰�(����)
        CREATE USER C##TEST250305 IDENTIFIED BY test0305;
        
    * �ּ����� ���� �ο� (CONNECT, RESOURCE)
        GRANT CONNECT, RESOURCE TO C##TEST250305;

-- �Ʒ� ������ �߰��ϱ� ���� ���̺��� �������ּ���.
-- �� �÷��� ������ �߰����ּ���.
-- ���� �����͸� �߰��ϱ� ���� ���� �������� �ۼ����ּ���. --> INSERT
--  ex) ����: �ﱹ��, ����: ����, ������: 14/02/14, ISBN : 9780394502946
------------------------------------------------------------
*/
/*
	- ���� ���� ���̺� : BOOK
	- ���� ����
	  - ����� ���ڸ��� NULL���� ������� �ʴ´�.  --> NOT NULL
	  - ISBN ��ȣ�� �ߺ��� ������� �ʴ´�.       --> UNIQUE
	- ���� ������
	  + ���� ��ȣ ex) 1, 2, 3, ...             --> PK(�⺻Ű)
	  + ���� ex) '�ﱹ��', '�����', '�ڽ���', ...
	  + ���� ex) '����', '�������丮', 'Į ���̰�', ...
	  + ������ ex) '14/02/14', '22/09/19', ...
	  + ISBN��ȣ ex) '9780394502946', '978-0152048044', ...
*/
-- ���̺� --> �����ͺ��̽� ��ü �� �ϳ�
CREATE TABLE BOOK (
    BK_NO NUMBER PRIMARY KEY, -- ������ȣ
    BK_TITLE VARCHAR2(200) NOT NULL, -- ����
    BK_AUTHOR VARCHAR2(200) NOT NULL, -- ����
    PUB_DATE DATE,  -- ������
    ISBN VARCHAR2(20) CONSTRAINT ISBN_UQ UNIQUE -- ISBN
);
-- �÷��� ���� ���� �߰�
COMMENT ON COLUMN BOOK.BK_NO IS '������ȣ';
COMMENT ON COLUMN BOOK.BK_TITLE IS '������';
COMMENT ON COLUMN BOOK.BK_AUTHOR IS '���ڸ�';
COMMENT ON COLUMN BOOK.PUB_DATE IS '������';
COMMENT ON COLUMN BOOK.ISBN IS 'ISBN';
-- ���� ������ �߰� --> INSERT (DML)
INSERT INTO BOOK VALUES (1, '�ﱹ��', '����', '14/02/14', '9780394502946');

-- �⺻Ű �������� Ȯ��
INSERT INTO BOOK VALUES (NULL, '�ﱹ��', '����', '14/02/14', '9780394502946');
--  * NOT NULL üũ
INSERT INTO BOOK VALUES (1, '�ﱹ��', '����', '14/02/14', '9780394502946');
--  * UNIQUE üũ

-- NOT NULL �������� Ȯ�� (����, ����)
INSERT INTO BOOK VALUES (2, NULL, '����', '14/02/14', '9780394502946');
INSERT INTO BOOK (BK_NO, BK_AUTHOR, PUB_DATE, ISBN)
        VALUES (2, '����', '14/02/14', '9780394502946');
        --> ����(BK_TITLE)�� ���� �÷��� �������� ������, NULL���� �����!
INSERT INTO BOOK VALUES (2, '�ﱹ��', NULL, '14/02/14', '9780394502946');        

-- UNIQUE �������� Ȯ�� (ISBN)
INSERT INTO BOOK VALUES (2, '�����', '�����㺣��', '22/09/19', '9780394502946');
--> �̹� ����Ǿ� �ִ� ISBN��ȣ�� �߰��� �� ����!

-- ������ ��ȸ (DQL)
SELECT * FROM BOOK;

------------------------------------------------------------





