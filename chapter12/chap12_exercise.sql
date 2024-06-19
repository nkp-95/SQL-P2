--12장 DDL DATA DEFINITION LANGUAGE(데이타 정의어)
--DDL은 자동으로 COMMIT인 이루어짐 ROLBACK 불가 (!주의)
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
--테이블 명/열 명 생성 규칙
--1. 숫자로 시작 불가, 2. 영어는 30자, 한글은 15자
--3. 같은 사용자 소유의 테이블이름 중복 불가
--4. 특수문자 $, #, _사용 할수 있다. EC)EMP#90_OB
--6. SELECT, FROM 등 예약어는 테이블 이름으로 사용 불가

--기존 테이블 열 구조화 데이터를 복사하여 새 테이블 생성하기
CREATE TABLE DEPT_DDL
    AS SELECT * FROM DEPT;

DESC DEPT_DDL;

SELECT * FROM DEPT_DDL;

--다른 테이블의 일부를 복사햐여 테이블 생성하기
CREATE TABLE EMP_DDL_30
    AS SELECT * FROM EMP WHERE DEPTNO = 30;

SELECT * FROM EMP_DDL_30;

--기존 테이블에 열 구조만 복사하여 새 테이블 생성
CREATE TABLE EMPDEPT_DDL
    AS SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
            , E.SAL, E.COMM, D.DEPTNO, D.DNAME, D.LOC
        FROM EMP E, DEPT D
        WHERE 1<>1;

SELECT * FROM EMPDEPT_DDL;

--12-6EMP 테이블 복사해서 테이블 수정 연습
CREATE TABLE EMP_ALTER
    AS SELECT * FROM EMP;--컬럼 추가

SELECT * FROM EMP_ALTER;

ALTER TABLE EMP_ALTER
  ADD HP VARCHAR2(20);  --테이블에 항목 추가
  
SELECT * FROM EMP_ALTER;

--12-8 컬럼명 리네임

ALTER TABLE EMP_ALTER
 RENAME COLUMN HP TO TEL;  --HP컬럼명을 TEL로 변경

SELECT * FROM EMP_ALTER;
DESC EMP_ALTER;

--컬럼 사이즈 변경
ALTER TABLE EMP_ALTER
MODIFY EMPNO NUMBER(5);--데이터 확장은 가능하나 축소는 불가능

--컬럼 삭제
ALTER TABLE EMP_ALTER
DROP COLUMN TEL;  --TEL컬럼 삭제

SELECT * FROM EMP_ALTER;

--테이블 명 변경
RENAME EMP_ALTER TO EMP_RENAME;--RENAME 변경대상 테이블 TO 변경할 이름

DESC EMP_ALTER;
DESC EMP_RENAME;

SELECT * FROM EMP_RENAME;

TRUNCATE TABLE EMP_RENAME;--데이터 모두 날라감 복구 불가

DROP TABLE EMP_RENAME; --테이블 삭제

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
    SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL --서브쿼리 VALUES 사용 X
    FROM EMP;

--Q6
DROP TABLE EMP_HW;

DESC EMP_HW;