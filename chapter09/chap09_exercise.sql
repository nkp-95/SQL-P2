--9장 서브 쿼리
--9-1 JONES인 사원의 급여 출력
SELECT SAL
  FROM EMP
 WHERE ENAME = 'JONES';
 
--9-2 급여가 2975보다 높은 사원 출력
SELECT *
  FROM EMP
 WHERE SAL >2975;

--9-3
SELECT *
  FROM EMP
 WHERE SAL > (SELECT SAL
                FROM EMP
               WHERE ENAME = 'JONES');  --2975;

--서브쿼리 특징
--1. 괄호 2. 특수한경우 제외 서브쿼리에는 ORDER BY 절을 사용할수 없습니다.
--3. 메인쿼리 비교대상과 데이터 개수와 자료형 고려해야함
--4. 서브쿼리 단일행, 다중행에 따라 연산자 사용 고려 
SELECT *
  FROM EMPLOYEES 
 WHERE SALARY <= (SELECT SALARY
                    FROM EMPLOYEES
                   WHERE FIRST_NAME = 'ADAM');                
                 
--1분 복습 사원정보중에서 사원이름이 ALLEN인 사원의 추가 수당(COMM)보다 많은
--추가수당을 받는 사원 정보 출력
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

--단일행 서브 쿼리와 함수
---9-5 사원정보에서 20번 부서에서 평균 급여보다 많이 많이 받는 사람
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
     , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL > (SELECT AVG(SAL)
                FROM EMP);

--1분 복습 
--전체사원의 평균급여보다 작거나 같은 급여를 받고있는 
--20번 부서의 사원 및 부서정보를 구하는 쿼리
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
     , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL <= (SELECT AVG(SAL)
                   FROM EMP);

--9-6 다중행 서브 쿼리 연산자: IN, ANY/SOME, ALL, EXISTS
SELECT *
  FROM EMP
 WHERE DEPTNO IN (20, 30);
 
SELECT MAX(SAL)
  FROM EMP
 GROUP BY DEPTNO;

--9-7 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력
SELECT *
  FROM EMP
 WHERE SAL IN (SELECT MAX(SAL)
                 FROM EMP
                GROUP BY DEPTNO);
 
--ANY/SOME
--(조건식을 사용한 결과가 하나라도 TRUE라면 
--메인 쿼리 조건식은 TRUE로 반환해주는 연산자)
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

--30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원정보 출력하기
SELECT *
  FROM EMP
 WHERE SAL < ANY (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
 ORDER BY SAL, EMPNO;  --2850보다 작게 받느 직원

-- < ANY는 서브쿼리에 MAX 함수를 사용한경우와 동일 
SELECT *
  FROM EMP
 WHERE SAL < (SELECT MAX(SAL)
                    FROM EMP
                   WHERE DEPTNO = 30)
 ORDER BY SAL, EMPNO;
--30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원정보 출력하기
SELECT *
  FROM EMP
 WHERE SAL > ANY (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
 ORDER BY SAL, EMPNO;

--ALL 연산자: 모두 만족해야 TURE
--9-14
--30번 부서 사원들의 최소 급여보다 적은 급여를 받는 사원정보 출력하기
SELECT *
  FROM EMP
 WHERE SAL < ALL (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
 ORDER BY SAL;
--9-15
--30번 부서 사원들의 최대 급여보다 많은 급여를 받는 사원정보 출력하기
SELECT *
  FROM EMP
 WHERE SAL > ALL (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
 ORDER BY SAL;

--9-16 EXISTS연산자 : 서브쿼리 결과값이 존재하면 TRUE
--실습 
--EXISTS존재하는지 없는지가 중요O 뭘 찾는지는 중요X
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

--1분 복습 다중행 연산자 사용
--EMP 테이블의 사원중에 10번 부서에 속한 모든 사원들 보다 일찍 입사한 
--사원정보 출력
SELECT *
  FROM EMP
 WHERE HIREDATE < ALL(SELECT HIREDATE
                        FROM EMP
                       WHERE DEPTNO = 10);

--상관 쿼리
-- :메인쿼리와 서브쿼리 간에 서로 상관 참조하는 쿼리
--사원이 한명이라도 있는 부서명을 출력
SELECT DNAME
  FROM DEPT D
 WHERE EXISTS (SELECT 1 FROM EMP WHERE DEPTNO = D.DEPTNO);

SELECT EMPNO FROM EMP WHERE DEPTNO = 10; --ACCOUNTING
SELECT EMPNO FROM EMP WHERE DEPTNO = 20; --RESEARCH 
SELECT EMPNO FROM EMP WHERE DEPTNO = 30; --SALES
SELECT EMPNO FROM EMP WHERE DEPTNO = 40; --OPERATIONS 없음

SELECT * FROM EMP;

--비교할 열이 여러개인 다중열 서브쿼리
--9-18
SELECT *
  FROM EMP
 WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                           FROM EMP
                          GROUP BY DEPTNO);

--각부서의 최대급여를 받는 사원의 부서코드 , 이름 급여를 
--출력하는데 부서코드 순으로 오름차순 정렬하여 출력하는 쿼리 작성
SELECT DEPTNO, ENAME, SAL
  FROM EMP E
 WHERE SAL = (SELECT MAX(SAL)
                FROM EMP
               WHERE DEPTNO = E.DEPTNO)
 ORDER BY DEPTNO;
 

                          
                          

--SELECT절의 서브쿼리 : 스칼라쿼리, 상관쿼리
SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAME
  FROM EMP E;
  
-- 스칼라쿼리 아닌경우
SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , D.DNAME 
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO;

--9-05 FROM절에 사용하는 서브 쿼리와 WITH절
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO
     , D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10
     , (SELECT * FROM DEPT) D
 WHERE E10.DEPTNO = D.DEPTNO;
 
--WITH절 사용하기
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

--한발더 나가기: 상호 연관 서브 쿼리
SELECT * 
  FROM EMP E1
 WHERE SAL > (SELECT MIN(SAL)
                FROM EMP E2
               WHERE E2.DEPTNO = E1.DEPTNO)
 ORDER BY DEPTNO, SAL;              

--9-21 SELECT절에 서브 쿼리(스칼라쿼리) 사용하기
--스칼라쿼리는 아우터 조인 없이도 NULLL값 출력됨
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
--문제
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
 
 
 --중간문제--1EMPLOYEES가 MAIN  2  DEPARTMENTS 테이블이 MAIN 3 다중행연산자 IN 
    -- 4 IS NOT NULL EMPLOYEES 가 MAIN 5. NOT IN  6 LOCATIONS가 MAIN  IN(3중 쿼리)
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