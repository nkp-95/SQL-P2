--9�� ���� ����
--9-1 JONES�� ����� �޿� ���
SELECT SAL
  FROM EMP
 WHERE ENAME = 'JONES';
 
--9-2 �޿��� 2975���� ���� ��� ���
SELECT *
  FROM EMP
 WHERE SAL >2975;

--9-3
SELECT *
  FROM EMP
 WHERE SAL > (SELECT SAL
                FROM EMP
               WHERE ENAME = 'JONES');  --2975;

--�������� Ư¡
--1. ��ȣ 2. Ư���Ѱ�� ���� ������������ ORDER BY ���� ����Ҽ� �����ϴ�.
--3. �������� �񱳴��� ������ ������ �ڷ��� ����ؾ���
--4. �������� ������, �����࿡ ���� ������ ��� ��� 
SELECT *
  FROM EMPLOYEES 
 WHERE SALARY <= (SELECT SALARY
                    FROM EMPLOYEES
                   WHERE FIRST_NAME = 'ADAM');                
                 
--1�� ���� ��������߿��� ����̸��� ALLEN�� ����� �߰� ����(COMM)���� ����
--�߰������� �޴� ��� ���� ���
SELECT *
  FROM EMP
 WHERE COMM > (SELECT COMM
                 FROM EMP
                WHERE ENAME = 'ALLEN');
                 
--9-4
SELECT *
  FROM EMP
 WHERE HIREDATE < (SELECT HIREDATE
                     FROM EMP
                    WHERE ENAME = 'SCOTT');

SELECT *
  FROM EMP
 WHERE HIREDATE < (SELECT HIREDATE
                     FROM EMP
                    WHERE ENAME = 'SCOTT')
   AND HIREDATE > (SELECT HIREDATE
                     FROM EMP
                    WHERE ENAME = 'JONES');
SELECT *
  FROM EMPLOYEES
 WHERE SALARY > (SELECT SALARY
                  FROM EMPLOYEES
                WHERE HIRE_DATE = '2006/01/03');

--������ ���� ������ �Լ�
---9-5 ����������� 20�� �μ����� ��� �޿����� ���� ���� �޴� ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
     , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL > (SELECT AVG(SAL)
                FROM EMP);

--1�� ���� 
--��ü����� ��ձ޿����� �۰ų� ���� �޿��� �ް��ִ� 
--20�� �μ��� ��� �� �μ������� ���ϴ� ����
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
     , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL <= (SELECT AVG(SAL)
                   FROM EMP);

--9-6 ������ ���� ���� ������: IN, ANY/SOME, ALL, EXISTS
SELECT *
  FROM EMP
 WHERE DEPTNO IN (20, 30);
 
SELECT MAX(SAL)
  FROM EMP
 GROUP BY DEPTNO;

--9-7 �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ���� ���
SELECT *
  FROM EMP
 WHERE SAL IN (SELECT MAX(SAL)
                 FROM EMP
                GROUP BY DEPTNO);
 
--ANY/SOME
--(���ǽ��� ����� ����� �ϳ��� TRUE��� 
--���� ���� ���ǽ��� TRUE�� ��ȯ���ִ� ������)
SELECT *
  FROM EMP
 WHERE SAL = ANY(SELECT MAX(SAL)
                 FROM EMP
                GROUP BY DEPTNO);

--9-10
SELECT *
  FROM EMP
 WHERE SAL = SOME(SELECT MAX(SAL)
                 FROM EMP
                GROUP BY DEPTNO);

--30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ������� ����ϱ�
SELECT *
  FROM EMP
 WHERE SAL < ANY (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
 ORDER BY SAL, EMPNO;  --2850���� �۰� �޴� ����

-- < ANY�� ���������� MAX �Լ��� ����Ѱ��� ���� 
SELECT *
  FROM EMP
 WHERE SAL < (SELECT MAX(SAL)
                    FROM EMP
                   WHERE DEPTNO = 30)
 ORDER BY SAL, EMPNO;
--30�� �μ� ������� �ּ� �޿����� ���� �޿��� �޴� ������� ����ϱ�
SELECT *
  FROM EMP
 WHERE SAL > ANY (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
 ORDER BY SAL, EMPNO;

--ALL ������: ��� �����ؾ� TURE
--9-14
--30�� �μ� ������� �ּ� �޿����� ���� �޿��� �޴� ������� ����ϱ�
SELECT *
  FROM EMP
 WHERE SAL < ALL (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
 ORDER BY SAL;
--9-15
--30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ������� ����ϱ�
SELECT *
  FROM EMP
 WHERE SAL > ALL (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
 ORDER BY SAL;

--9-16 EXISTS������ : �������� ������� �����ϸ� TRUE
--�ǽ� 
--EXISTS�����ϴ��� �������� �߿�O �� ã������ �߿�X
SELECT *
  FROM EMP 
 WHERE EXISTS (SELECT DNAME
                 FROM DEPT
                WHERE DEPTNO = 10);
                
SELECT *
  FROM EMP 
 WHERE EXISTS (SELECT 1
                 FROM DEPT
                WHERE DEPTNO = 10);
                
--9-17
SELECT *
  FROM EMP 
 WHERE EXISTS (SELECT DNAME
                 FROM DEPT
                WHERE DEPTNO = 50);

--1�� ���� ������ ������ ���
--EMP ���̺��� ����߿� 10�� �μ��� ���� ��� ����� ���� ���� �Ի��� 
--������� ���
SELECT *
  FROM EMP
 WHERE HIREDATE < ALL(SELECT HIREDATE
                        FROM EMP
                       WHERE DEPTNO = 10);

--��� ����
-- :���������� �������� ���� ���� ��� �����ϴ� ����
--����� �Ѹ��̶� �ִ� �μ����� ���
SELECT DNAME
  FROM DEPT D
 WHERE EXISTS (SELECT 1 FROM EMP WHERE DEPTNO = D.DEPTNO);

SELECT EMPNO FROM EMP WHERE DEPTNO = 10; --ACCOUNTING
SELECT EMPNO FROM EMP WHERE DEPTNO = 20; --RESEARCH 
SELECT EMPNO FROM EMP WHERE DEPTNO = 30; --SALES
SELECT EMPNO FROM EMP WHERE DEPTNO = 40; --OPERATIONS ����

SELECT * FROM EMP;

--���� ���� �������� ���߿� ��������
--9-18
SELECT *
  FROM EMP
 WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                           FROM EMP
                          GROUP BY DEPTNO);

--���μ��� �ִ�޿��� �޴� ����� �μ��ڵ� , �̸� �޿��� 
--����ϴµ� �μ��ڵ� ������ �������� �����Ͽ� ����ϴ� ���� �ۼ�
SELECT DEPTNO, ENAME, SAL
  FROM EMP E
 WHERE SAL = (SELECT MAX(SAL)
                FROM EMP
               WHERE DEPTNO = E.DEPTNO)
 ORDER BY DEPTNO;
 

                          
                          

--SELECT���� �������� : ��Į������, �������
SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAME
  FROM EMP E;
  
-- ��Į������ �ƴѰ��
SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , D.DNAME 
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO;

--9-05 FROM���� ����ϴ� ���� ������ WITH��
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO
     , D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10
     , (SELECT * FROM DEPT) D
 WHERE E10.DEPTNO = D.DEPTNO;
 
--WITH�� ����ϱ�
 WITH
 E10 AS (
    SELECT * 
      FROM EMP 
     WHERE DEPTNO = 10),
 D AS (
    SELECT *
      FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM E10, D
 WHERE E10.DEPTNO = D.DEPTNO;

--�ѹߴ� ������: ��ȣ ���� ���� ����
SELECT * 
  FROM EMP E1
 WHERE SAL > (SELECT MIN(SAL)
                FROM EMP E2
               WHERE E2.DEPTNO = E1.DEPTNO)
 ORDER BY DEPTNO, SAL;              

--9-21 SELECT���� ���� ����(��Į������) ����ϱ�
--��Į�������� �ƿ��� ���� ���̵� NULLL�� ��µ�
SELECT EMPNO, ENAME, JOB, SAL
     , (SELECT GRADE
          FROM SALGRADE
         WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE
     , DEPTNO
     , (SELECT DNAME FROM DEPT
         WHERE DEPTNO = E.DEPTNO) AS DNAME
     , (SELECT ENAME FROM EMP
         WHERE EMPNO = E.MGR) AS MGR 
  FROM EMP E;
--����
--Q1
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
 WHERE E.JOB = (SELECT JOB
                  FROM EMP
                 WHERE ENAME = 'ALLEN');
--Q2
SELECT E.EMPNO, E.ENAME
     , D.DNAME, E.HIREDATE,  D.LOC, E.SAL
     , S.GRADE
  FROM EMP E, DEPT D, SALGRADE S
 WHERE E.SAL > (SELECT AVG(SAL)
                  FROM EMP)
   AND E.SAL BETWEEN S.LOSAL AND S.HISAL  
   AND E.DEPTNO = D.DEPTNO
 ORDER BY SAL DESC, EMPNO;
--Q3
SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO
     , D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = 10
   AND E.DEPTNO = D.DEPTNO
   AND E.JOB NOT IN(SELECT DISTINCT JOB
                    FROM EMP
                   WHERE DEPTNO = 30);  

SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO
     , D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = 10
   AND E.DEPTNO = D.DEPTNO
   AND NOT EXISTS(SELECT JOB FROM EMP
                   WHERE DEPTNO = 30 AND JOB = E.JOB);
                   
--Q4
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL > (SELECT MAX(SAL)
                  FROM EMP
                 WHERE JOB = 'SALESMAN')
   AND E.SAL BETWEEN S.LOSAL AND S.HISAL
 ORDER BY EMPNO; 
   
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL > ALL(SELECT SAL
                  FROM EMP
                 WHERE JOB = 'SALESMAN')
   AND E.SAL BETWEEN S.LOSAL AND S.HISAL
 ORDER BY EMPNO;
    
SELECT EMPNO, ENAME, SAL
     , (SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) AS GRADE
  FROM EMP E
 WHERE E.SAL > ALL(SELECT SAL
                  FROM EMP
                 WHERE JOB = 'SALESMAN')
 ORDER BY EMPNO;
 
 
 --�߰�����--1EMPLOYEES�� MAIN  2  DEPARTMENTS ���̺��� MAIN 3 �����࿬���� IN 
    -- 4 IS NOT NULL EMPLOYEES �� MAIN 5. NOT IN  6 LOCATIONS�� MAIN  IN(3�� ����)
--Q1
SELECT FIRST_NAME, LAST_NAME, JOB_ID, SALARY
  FROM EMPLOYEES
  WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                           FROM DEPARTMENTS
                          WHERE DEPARTMENT_NAME = 'IT');

--Q2
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE LOCATION_ID = (SELECT LOCATION_ID
                          FROM LOCATIONS
                         WHERE STATE_PROVINCE = 'California');
                         
--Q3
SELECT CITY, STATE_PROVINCE, STREET_ADDRESS
  FROM LOCATIONS
 WHERE COUNTRY_ID IN (SELECT COUNTRY_ID
                        FROM COUNTRIES
                       WHERE REGION_ID = 3);
                       
--Q4
SELECT FIRST_NAME, LAST_NAME, JOB_ID, SALARY
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                           FROM DEPARTMENTS
                          WHERE MANAGER_ID IS NOT NULL);

--Q5
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
  FROM DEPARTMENTS
 WHERE LOCATION_ID NOT IN (SELECT LOCATION_ID
                             FROM LOCATIONS
                            WHERE CITY = 'Seattle');



--Q6
SELECT CITY, STATE_PROVINCE, STREET_ADDRESS
  FROM LOCATIONS
 WHERE COUNTRY_ID IN(SELECT COUNTRY_ID
                       FROM COUNTRIES
                      WHERE REGION_ID = (SELECT REGION_ID
                                           FROM REGIONS
                                          WHERE REGION_NAME = 'Europe'));