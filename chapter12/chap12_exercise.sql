--12�� DDL DATA DEFINITION LANGUAGE(����Ÿ ���Ǿ�)
--DDL�� �ڵ����� COMMIT�� �̷���� ROLBACK �Ұ� (!����)
CREATE TABLE EMP_DDL(
    EMPNO       NUMBER(4),
    ENAME       VARCHAR2(10),
    JOB         VARCHAR2(9),
    MGR         NUMBER(4),
    HIREDATE    DATE,
    DAL         NUMBER(7,2),
    COMM        NUMBER(7,2),
    DEPTNO      NUMBER(2)
);    
--���̺� ��/�� �� ���� ��Ģ
--1. ���ڷ� ���� �Ұ�, 2. ����� 30��, �ѱ��� 15��
--3. ���� ����� ������ ���̺��̸� �ߺ� �Ұ�
--4. Ư������ $, #, _��� �Ҽ� �ִ�. EC)EMP#90_OB
--6. SELECT, FROM �� ������ ���̺� �̸����� ��� �Ұ�

--���� ���̺� �� ����ȭ �����͸� �����Ͽ� �� ���̺� �����ϱ�
CREATE TABLE DEPT_DDL
    AS SELECT * FROM DEPT;

DESC DEPT_DDL;

SELECT * FROM DEPT_DDL;

--�ٸ� ���̺��� �Ϻθ� �����Ῡ ���̺� �����ϱ�
CREATE TABLE EMP_DDL_30
    AS SELECT * FROM EMP WHERE DEPTNO = 30;

SELECT * FROM EMP_DDL_30;

--���� ���̺� �� ������ �����Ͽ� �� ���̺� ����
CREATE TABLE EMPDEPT_DDL
    AS SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
            , E.SAL, E.COMM, D.DEPTNO, D.DNAME, D.LOC
        FROM EMP E, DEPT D
        WHERE 1<>1;

SELECT * FROM EMPDEPT_DDL;

--12-6EMP ���̺� �����ؼ� ���̺� ���� ����
CREATE TABLE EMP_ALTER
    AS SELECT * FROM EMP;--�÷� �߰�

SELECT * FROM EMP_ALTER;

ALTER TABLE EMP_ALTER
  ADD HP VARCHAR2(20);  --���̺� �׸� �߰�
  
SELECT * FROM EMP_ALTER;

--12-8 �÷��� ������

ALTER TABLE EMP_ALTER
 RENAME COLUMN HP TO TEL;  --HP�÷����� TEL�� ����

SELECT * FROM EMP_ALTER;
DESC EMP_ALTER;

--�÷� ������ ����
ALTER TABLE EMP_ALTER
MODIFY EMPNO NUMBER(5);--������ Ȯ���� �����ϳ� ��Ҵ� �Ұ���

--�÷� ����
ALTER TABLE EMP_ALTER
DROP COLUMN TEL;  --TEL�÷� ����

SELECT * FROM EMP_ALTER;

--���̺� �� ����
RENAME EMP_ALTER TO EMP_RENAME;--RENAME ������ ���̺� TO ������ �̸�

DESC EMP_ALTER;
DESC EMP_RENAME;

SELECT * FROM EMP_RENAME;

TRUNCATE TABLE EMP_RENAME;--������ ��� ���� ���� �Ұ�

DROP TABLE EMP_RENAME; --���̺� ����

--Q1
CREATE TABLE EMP_HW(
                    EMPNO        NUMBER(4),
                    ENAME        VARCHAR2(10),
                    JOB          VARCHAR2(9),
                    MGR          NUMBER(4),
                    HIREDATE     DATE,
                    SAL          NUMBER(7,2),
                    COMM         NUMBER(7,2),
                    DEPTNO       NUMBER(2)
                    );
SELECT * FROM EMP_HW;
DESC EMP_HW;

--Q2
ALTER TABLE EMP_HW
  ADD BIGO VARCHAR2(20);

--Q3
ALTER TABLE EMP_HW
MODIFY BIGO VARCHAR2(30);

--Q4
ALTER TABLE EMP_HW
 RENAME COLUMN BIGO TO REMAKE; 

--Q5
SELECT * FROM EMP;
INSERT INTO EMP_HW
    SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL --�������� VALUES ��� X
    FROM EMP;

--Q6
DROP TABLE EMP_HW;

DESC EMP_HW;