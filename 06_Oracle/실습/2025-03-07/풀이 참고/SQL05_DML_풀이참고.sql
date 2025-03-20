-- SQL05_DML.pdf

-- 1. ���� ���� ���̺� ������ �߰� (DML - INSERT)
SELECT * FROM TB_CLASS_TYPE;

INSERT INTO TB_CLASS_TYPE VALUES ('01', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('02', '��������');
INSERT INTO TB_CLASS_TYPE VALUES ('03', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('04', '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES ('05', '������');
COMMIT;


-- 2. �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺� ���� (�������� �̿�) (DDL - CREATE)
CREATE TABLE TB_�л��Ϲ�����
AS ( SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�, STUDENT_ADDRESS �ּ� FROM TB_STUDENT );

SELECT * FROM TB_�л��Ϲ�����;


-- 3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺� ���� (DDL - CREATE)
CREATE TABLE TB_������а� 
AS ( SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�
          , TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 2), 'RR'), 'YYYY') ����⵵
          , PROFESSOR_NAME �����̸�
       FROM TB_STUDENT S
            LEFT JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO 
            -- JOIN TB_DEPARTMENT D USING (DEPARTMENT_NO) 
            --> DEPARTMENT_NO �÷��� TB_STUDENT ���̺��� �����ϰ�, TB_PROFESSOR ���̺��� ������!
            JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO            
        WHERE DEPARTMENT_NAME = '������а�' );

SELECT * FROM TB_������а�;


-- 4. �� �а����� ������ 10% ������Ű���� �Ѵ�. ��, �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� �Ѵ�.
UPDATE TB_DEPARTMENT
   SET CAPACITY = ROUND(CAPACITY * 1.1);


-- 5. �й��� 'A413042'�� �ڰǿ� �л��� �ּҰ� '����� ���α� ���ε� 181-21'�� ����Ǿ��ٰ� �Ѵ�.
SELECT * FROM TB_STUDENT WHERE STUDENT_NAME = '�ڰǿ�' AND STUDENT_NO = 'A413042';

UPDATE TB_STUDENT
   SET STUDENT_ADDRESS = '����� ���α� ���ε� 181-21'
 WHERE STUDENT_NAME = '�ڰǿ�' AND STUDENT_NO = 'A413042';


-- 6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʵ��� �����Ǿ���. 
UPDATE TB_STUDENT
   SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);
   
SELECT * FROM TB_STUDENT WHERE LENGTH(STUDENT_SSN) <> 6;
--> �ݿ����� ���� �����Ͱ� �ִ� �� ��ȸ**


-- 7. ���а� ����� �л��� 2005�� 1�б⿡ �ڽ��� ������ '�Ǻλ�����'������ �߸��Ǿ��ٴ� ����
--    �߰��ϰ� ���� ��û�� �Ͽ���. �ش� ������ ������ 3.5�� �����϶�
SELECT POINT, STUDENT_NAME, DEPARTMENT_NAME, TERM_NO, CLASS_NAME 
  FROM TB_GRADE 
       JOIN TB_STUDENT USING (STUDENT_NO)
       JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
       JOIN TB_CLASS USING (CLASS_NO)
 WHERE DEPARTMENT_NAME = '���а�' 
       AND STUDENT_NAME = '�����'
       AND TERM_NO = '200501' AND CLASS_NAME = '�Ǻλ�����';

UPDATE TB_GRADE 
   SET POINT = 3.5
 WHERE STUDENT_NO = ( SELECT STUDENT_NO
                        FROM TB_STUDENT
                             JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
                       WHERE DEPARTMENT_NAME = '���а�'
                             AND STUDENT_NAME = '�����' )
       AND CLASS_NO = ( SELECT CLASS_NO
                          FROM TB_CLASS
                         WHERE CLASS_NAME = '�Ǻλ�����' )
       AND TERM_NO = '200501';
       
COMMIT;


-- 8. ���� ���̺��� ���л����� �����׸��� ����
SELECT COUNT(*) FROM TB_GRADE JOIN TB_STUDENT USING (STUDENT_NO)
    WHERE ABSENCE_YN = 'Y';

DELETE FROM TB_GRADE
 WHERE STUDENT_NO IN ( SELECT STUDENT_NO FROM TB_STUDENT WHERE ABSENCE_YN = 'Y' );

COMMIT;