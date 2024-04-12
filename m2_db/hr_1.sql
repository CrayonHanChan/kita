SELECT * FROM employees;

--Q. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력.
--솔루션
SELECT E.employee_id 사번ID, LAST_NAME, J.job_id 업무, J.job_title 업무명
FROM employees E, jobs J
WHERE employee_ID LIKE 120 AND E.job_id = J.job_id;

--전유빈님 솔루션
SELECT E.employee_id 사번, E.first_name 이름, E.last_name 성, E.job_id 업무, J.job_title 업무명
FROM employees E
INNER JOIN jobs J ON E.job_id = J.job_id
WHERE E.employee_id = 120; -- = 자리에 대신 LIKE 써도 됨

--주용규님 솔루션
-- Q. 사번이 120번인 사람의 사번, 이름, 업무(JOB_ID), 업무명(JOB_TITLE)
SELECT 
EMPLOYEE_ID 사번, 
FIRST_NAME || ' ' || LAST_NAME AS 이름,
J.JOB_ID 업무,
J.JOB_TITLE 업무명
FROM EMPLOYEES E, JOBS J
WHERE E.EMPLOYEE_ID=120
AND e.job_id = j.job_id;

--서브쿼리 사용해서 하는법..?
SELECT E.employee_id 사번ID
 , E.LAST_NAME
 , J.job_id 업무
 , J.job_title 업무명
FROM employees E, jobs J
WHERE J.job_id IN (SELECT E.job_id FROM employees WHERE E.employee_id = 120); -- WHERE 여기에 E. J. 다 붙여주고 잘 붙여줘야함
--WHERE employee_ID LIKE 120 AND E.job_id = J.job_id;


--과제2_1116: HR EMPLOYEES 테이블에서 이름, 급여, 10% 인상된 급여으로 출력하세요.
--과제2_1116 솔루션
SELECT last_name AS 이름, salary AS "급여 (달러)", salary * 1100 / 1000  "10%인상된 급여 (달러)"
FROM Employees;

--과제3_1116: 2005년 상반기에 입사한 사람들만 출력
--과제3_1116 솔루션
SELECT employee_id 사원ID, start_date 입사일
FROM Job_History
WHERE employee_id IN (SELECT employee_id FROM Job_History WHERE start_date > );

--과제3_1116 김신미님 솔루션
SELECT first_name||' '||last_name "이름", hire_date "입사일"
FROM employees
WHERE TO_CHAR(hire_date, 'YY/MM') BETWEEN '05/01' AND '05/06';

--과제3_1116 전유빈님 솔루션
SELECT *
FROM employees
WHERE hire_date BETWEEN '2005-01-01' AND '2005-06-30';

--과제4_1116: 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
--과제4_1116 서영우님 솔루션
SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('SA_MAN', 'IT_PROG', 'ST_MAN');

--과제5_1116: manager_id가 101에서 103인 사람만 출력
--과제5_1116 황인서님 솔루션
SELECT manager_id
FROM employees
WHERE manager_id between 101 and 103;


--_을 와일드카드가 아닌 문자로 취급하고 싶을 때 escape 옵션을 사용
select * from employees where job_id like '%\_A%' escape '\';
select * from employees where job_id like '%#_A%' escape '#';

--IN : OR 대신 사용
select * from employees where manager_id=101 or manager_id=102 or manager_id=103;
select * from employees where manager_id in ( 101, 102, 103 );

--IS NULL / IS NOT NULL
--null 값인지를 확인할 경우 = 비교 연산자를 사용하지 않고 is null을 사용한다.
select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

--ORDER BY
--ORDER BY 컬럼명 [ASC | DESC]
select * from employees order by salary; --default = asc. 디폴트값이 올림차순
select * from employees order by salary asc; --올림차순
select * from employees order by salary desc; --내림차순
select * from employees order by salary asc, last_name desc; --salary 기준 올림차순. 같다면 last_name기준으로 내림차순

--DUAL 테이블
--mod 는 나머지. employee_id 를 2로 나눠서 그게 1(나머지)라면 그게 조건. 즉 홀수 인것만 뽑아라~
select * from employees where mod( employee_id, 2 ) = 1;
select mod( 10, 3 ) from dual; --10 나누기 3 의 나머지 는 1

--round() 반올림 함수
select round( 355.95555 ) from dual; --356
select round( 355.95555, 2 ) from dual; --355.96
select round( 355.95555, -1 ) from dual; --360
select round( 355.95555, -2 ) from dual; --400

--trunc() 버림 함수. 지정한 자릿수 이하를 버린 결과 제공
select trunc( 45.5555, 1 ) from dual; --45.5

--ceil() 올림 함수.
select ceil( 45.111 ) from dual; --46

--과제6_1116: EMPLOYEE_ID 가 홀수인 직원의 EMPLOYEE_ID 와 LAST_NAME을 출력하세요.
--과제6_1116 솔루션
SELECT employee_id 사원번호, last_name 이름 
FROM employees
WHERE employee_id IN (SELECT employee_id FROM employees WHERE mod(employee_id, 2) = 1);

--과제7_1116: EMPLOYEES 테이블에서 commission_pct의 null 값 갯수를 출력하세요.
--과제7_1116 솔루션
SELECT count(*)
FROM Employees
WHERE commission_pct is NULL;

--과제8_1116: EMPLOYEES 테이블에서 department_id 가 없는 직원을 추출하여 POSITION을 '신입'으로 출력하세요.
--과제8_1116 솔루션
ALTER TABLE employees ADD position varchar2(20);
SELECT *
FROM employees
WHERE employee_id IN (SELECT employee_id FROM employees WHERE department_id is NULL);

UPDATE employees
SET position = '신입';

SELECT position
FROM employees
WHERE employee_id IN (SELECT employee_id FROM employees WHERE department_id is NULL);

select employee_id, first_name, last_name, '신입' as position 
from employees
where department_id is null;

--과제9_1116: employees 테이블에서 이름에 FRIST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--과제9_1116 솔루션
SELECT FIRST_NAME||' '||LAST_NAME AS NAME
FROM employees;

--과제10_1116: HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
--과제10_1116 솔루션
SELECT salary, last_name
FROM Employees
ORDER BY salary, last_name;

select last_name, round(sysdate-hire_date) 근무기간 from employees;

--add_months()		특정 개월 수 를 더한 날짜를 구한다.
select last_name, hire_date, add_months( hire_date, 6 ) from employees;
select last_name, hire_date, add_months(hire_date,6) from employees;


--last_day()        해당 월의 마지막 날짜를 반환하는 함수
select last_name, hire_date, last_day( hire_date ) from employees;

select last_name,hire_date, last_day(add_months(hire_date,1)) from employees;

--next day(1)       해당 날짜를 기준으로 명시된 요일에 해당하는 날짜를 반환
--일~토, 1~7 로 표현가능
select hire_date, next_day( hire_date, '월' ) from employees;

--months_between()  날짜와 날짜 사이의 개월수를 구한다.
--hire_date와 sys_date 사이의 날짜 개월 수
SELECT hire_date, round(months_between(sysdate, hire_date),1) from employees;

--형 변환 함수 : to_date()       문자열을 날짜로
--'2023-01-01'이라는 문자열을 날짜 타입으로 변환
select to_date('2023-01-01', 'yyyy-mm-dd') from dual;

--to_char( 날짜 )     날짜를 문자로 변환
select to_char( sysdate, 'yy/mm-dd' ) from dual;


--형식------------------------------------------------------------
--YYYY       네 자리 연도
--YY      두 자리 연도
--YEAR      연도 영문 표기
--MM      월을 숫자로
--MON      월을 알파벳으로
--DD      일을 숫자로
--DAY      요일 표현
--DY      요일 약어 표현
--D      요일 숫자 표현
--
--AM 또는 PM   오전 오후
--HH 또는 HH12   12시간
--HH24      24시간
--MI      분
--SS      초
------------------------------------------------------------------
--9      한 자리의 숫자 표현      ( 1111, ‘99999’ )      1111   
--0      앞 부분을 0으로 표현      ( 1111, ‘099999’ )      001111
--$      달러 기호를 앞에 표현      ( 1111, ‘$99999’ )      $1111
--.      소수점을 표시         ( 1111, ‘99999.99’ )      1111.00
--,      특정 위치에 , 표시      ( 1111, ‘99,999’ )      1,111
--MI      오른쪽에 - 기호 표시      ( 1111, ‘99999MI’ )      1111-
--PR      음수값을 <>로 표현      ( -1111, ‘99999PR’ )      <1111>
--EEEE      과학적 표현         ( 1111, ‘99.99EEEE’ )      1.11E+03
--V      10을 n승 곱한값으로 표현   ( 1111, ‘999V99’ )      111100
--B      공백을 0으로 표현      ( 1111, ‘B9999.99’ )      1111.00
--L      지역통화         ( 1111, ‘L9999’ )
------------------------------------------------------------------
select salary, to_char( salary, '0999999' ) from employees;
select to_char( -salary, '999999PR' ) from employees;
--1111 ->(과학적표기법) 1.11e+03 .. 매우긴수를 간단하게 표현하기 위해서 이렇게씀
select to_char( 11111, '9.999EEEE' ) from dual;
select to_char( -1111, '9999MI' ) from dual;
select to_char( 1111, '$99999' ) from dual;

--width_bucket()        지정값, 최솟값, 최댓값, bucket개수
select width_bucket( 92, 0, 100, 10 ) from dual; --10번째 나옴
select width_bucket( 100, 0, 100, 10 ) from dual; --유의해야함... 이건 11번째 나옴
select width_bucket( 99, 0, 100, 10 ) from dual; --10
select width_bucket( 100, 0, 101, 10 ) from dual; --10

--Q. employees 테이블의 salary를 5개 등급으로 표시하세요
--최재빈님 솔루션
select salary from employees;
select max(salary), min(salary) from employees;
SELECT salary, WIDTH_BUCKET(salary, 2100, 24001, 5) AS grade
FROM employees
order by grade desc;

select salary from employees;
select max(salary), min(salary) from employees;
select salary, width_bucket(salary, 2100, 24001, 5) as "1-5등급제"
from employees
order by salary desc;
------------------------------------------------------------------
--문제1_1117: 현재 날짜(SYSDATE)를 'YYYY-MM-DD' 형식의 문자열로 변환하세요.
--문제1_1117 솔루션
select to_char(sysdate, 'yyyy-mm-dd') from dual;

--문제1_1117 김신미님 솔루션
select to_char(sysdate, 'YYYY/MM/DD') "날짜" from dual;

--문제2_1117: '01-01-2023' 이라는 문자열을 날짜 타입으로 변환하세요.
--문제2_1117 솔루션
select to_date('01-01-2023', 'mm-dd-yyyy') from dual;

--문제2_1117 서영우님 솔루션
SELECT TO_DATE('01-01-2023', 'mm-dd-YYYY') FROM DUAL; --앞이 month 그다음 day year.

--문제3_1117: 현재 날짜와 시간(SYSDATE)을 'YYYY-MM-DD HH24:MI:SS' 형식의 문자열로 변환하세요.
--문제3_1117 솔루션
select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;

--문제4_1117: '2023-01-01 15:30:00'이라는 문자열을 날짜 및 시간 타입으로 변환하세요.
--문제4_1117 솔루션
--이거는 시분초가 안나옴... 왜???
select to_date('2023-01-01 15:30:00', 'yyyy-mm-dd hh24:mi:ss') from dual;
--to_date는 'yyyy-mm-dd hh24:mi:ss' 이부분은 입력한것이 이렇게 되어있다(이러한 포맷으로되어있다)라고 하는것임 컴터가 얘를 인식해야하니까...
--to_char는  'YYYY/MM/DD' 이러한 포맷형태로 출력해달라. 그래서 앞에 sysdate(현재시간) 하고 , 로 구분하는것임
--시분초 나오는데 char임
SELECT to_timestamp('2023-01-01 15:30:00','YYYY-MM-DD HH24:MI:SS') FROM dual;

--문자 함수 Character Function
--upper()       대문자로 변경
select upper( 'Hello World' ) From Dual;
--lower()       소문자로 변경
select lower( 'Hello World' ) From dual;

--Q. last_name이 Seo인 직원의 last_name 과 salary를 구하세요.(Seo, SEO, seo 모두 검출)
--솔루션
select last_name from employees;
select salary from employees where lower(last_name) = 'seo';

--initcap()     첫글자만 대문자
select job_id, initcap( job_id ) from employees;

--length()      문자열의 길이
select job_id, length( job_id ) from employees;

--instr()       문자열, 찾을 문자, 찾을 위치, 찾은 문자 중 몇 번 째
select instr( 'Hello World', 'o', 3, 1 ) from dual; --5
select instr( 'Hello World', 'o', 3, 2 ) from dual; --8
--해석 : Hello World 에서 o 를 찾는데 3부터 시작(l) 거기서 부터 1(첫번째)오는 o 는 hello world 에서 5번째(출력 5)

--substr()      문자열, 시작위치, 개수
select substr( 'Hello World', 9, 3 ) from dual; --rld.
--해석 : Hello World 에서 9부터 3개를 출력

SELECT substr('Hello World', -3, 3) FROM dual;
--해석 : Hello World 에서 뒤에서 3번째부터 3개 출력

--lpad()        오른쪽 정렬 후 왼쪽에 문자를 채운다.
select lpad( 'Hello World', 20, '#' ) from dual;
--rpad()        왼쪽 정렬 후 오른쪽에 문자를 채운다.
select rpad( 'Hello World', 20, '#' ) from dual;

--ltrim()
select ltrim( 'aaaHello Worldaaa', 'a' ) from dual; --왼쪽의 a 를 지워줌
--가운데에 a 넣으면 안됨. 그러면 deplace() 해야함
select ltrim( '   Hello World   ' ) from dual; --ltrim 넣고 공백양쪽에 넣고 함수안에 문자열만넣으면 .. 왼쪽공백 없어짐
--rtrim()
select rtrim( 'aaaHello Worldaaa', 'a' ) from dual;
select rtrim( '   Hello World   ' ) from dual; --오른쪽 공백 없어짐


select last_name from employees;
select last_name, ltrim(last_name, 'A') from employees;

--trim
--공백지우기 양옆!
select trim( '    Hello World                ' ) from dual;

-- trim(str): 문자열의 양쪽의 공백을 제거.
select trim('   Hello World   ') from dual;
-- [참고]] trim((CHAR)from (STR)): 문자열(STR)의 양쪽에 주어진 문자(CHAR)를 제거. 
select trim('a' from 'aaaHello Worldaaa') from dual;
-- nvl(): null을 0 또는 다른 값으로 변환
select last_name, manager_id, nvl(to_char(manager_id), 'CEO') "Check 결과" from employees;

-----------------------------------------------------------------------------------------------------------
-- decode(): if문이나 case문과 같이 여러 경우를 선택할 수 있도록 하는 함수
----- DECODE 함수는 단순한 조건에 기반하여 값을 반환합니다.
--구문은 DECODE(expression, search1, result1, ..., searchN, resultN, default) 
----- 여기서 expression은 검사할 값을 나타내고, search와 result는 각각 조건과 해당 조건이 참일 때 반환할 값
----- default는 모든 search 조건이 거짓일 때 반환할 기본 값 출력
-- Q. 부서코드가 90이면 '경영지원실', 60이면 '프로그래밍', 100이면 '인사부', 그리고 부서코드가 없으면 '기타'로 표기하시오.
select last_name, department_id, 
decode(department_id, 90, '경영지원실', 60, '프로그래밍', 100, '인사부', '기타') "부서" 
-- 조건 표기가 없으면 'null'값 체크
from employees;              -- length(): 문자열의 길이 구하기

--과제5_1117: employees 테이블에서 commission_pct 가 null이 아닌 경우, 'A' null인 경우 'N'을 표시하는 쿼리를 작성
--과제5_1117 솔루션
select * from employees;
select commission_pct, decode(commission_pct, NULL, 'N', 'A')
from employees;

--과제5_1117 심주승님 솔루션
select commission_pct as commission
    , decode(commission_pct, null, 'N', 'A') as 변환
from employees
order by 변환 desc;

-----------------------------------------------------------------------------------------------
-- case()
----- decode() 함수와 동일하나 decode() 함수는 조건이 동일한 경우만 가능하지만
----- case() 함수는 다양한 비교연산자로 조건을 제시할 수 있다.
----- CASE 문은 조건에 따라 다른 값을 반환하는 데 사용되며, DECODE보다 복잡한 조건을 표현할 수 있다. 
----- 구문은 CASE WHEN condition THEN result ... ELSE default END이다. 
select last_name, department_id,
case when department_id = 90 then '경영지원실'
when department_id = 60 then '프로그래밍'
when department_id = 100 then '인사부'
else '기타'
end as 소속
from employees;

--과제6_1117: employees 테이블에서
--salary가 20000이상이면 'a', 10000과 20000 미만 사이면 'b', 그 이하면 'c'로 표시하는 쿼리를 작성하시오.(case)
--과제6_1117 솔루션
select last_name,salary, case
when salary>=20000 then ' a'
when salary>10000 and salary<20000 then ' b'
else ' c'
end as 등급
from employees;

select last_name, salary, 
case
when salary >= 20000 then 'a'
when salary >10000 and salary <20000 then 'b'
else 'c'
end
from employees;
--INSERT
--테이블에 데이터를 입력하는 방법은 두 가지 유형이 있으며 한 번에 한 건만 입력된다.
--a. INSERT INTO 테이블명 (COLUMN_LIST) VALUES (COLUMN)LIST에 넣을 VALUE_LIST);
--b. INSERT INTO 테이블명 VALUES (전체 COLUMN에 넣을 VALUE_LIST);

-- Concatenation : 콤마 대신에 사용하면 문자열이 연결되어 출력된다.
select last_name, 'is a ' , job_id from employees;
select last_name || ' is a ' || job_id from employees;

--UNION
--UNION( 합 집합 ) INTERSECT( 교 집합 ) MINUS( 차 집합 ) UNION ALL( 겹치는 것까지 포함 unique 반대)
--두 개의 쿼리문을 사용해야 한다. 데이터 타입을 일치 시켜야 한다.
select first_name 이름, salary 급여 from employees
where salary < 5000
union
select first_name 이름, salary 급여 from employees
where hire_date < '99/01/01';

--minus
select first_name 이름, salary 급여 from employees
where salary < 5000
minus
select first_name 이름, salary 급여 from employees
where hire_date < '99/01/01';

--intersect
select first_name 이름, salary 급여 from employees
where salary < 5000
intersect
select first_name 이름, salary 급여 from employees
where hire_date < '99/01/01';

--intersect
select first_name 이름, salary 급여 from employees
where salary < 5000
union all
select first_name 이름, salary 급여 from employees
where hire_date < '99/01/01';

-----------------------------------------------------------------------------------------------------------------------------
--CREATE VIEW 명령어는 오라클 SQL에서 테이블의 특정 부분이나 조인된 결과를 논리적인 뷰(view)로 만들 때 사용
--뷰는 데이터를 요약하거나 복잡한 조인을 단순화하며, 사용자에게 필요한 데이터만을 보여주는 데 유용
--뷰는 실제 테이블 데이터를 복사하지 않고, 대신 쿼리 결과를 저장
--뷰의 주요 특징
--쿼리 단순화: 복잡한 쿼리를 뷰로 저장함으로써 사용자는 복잡한 쿼리문을 반복해서 작성할 필요 없이 간단하게 뷰를 참조할 수 있다.
--데이터 추상화: 뷰는 기본 테이블의 구조를 숨기고 사용자에게 필요한 데이터만을 보여줄 수 있어, 데이터 추상화를 제공.
--보안 강화: 뷰를 사용하면 특정 데이터에 대한 접근을 제한할 수 있으며, 사용자가 볼 수 있는 데이터의 범위를 제어할 수 있다.
--데이터 무결성 유지: 뷰를 사용하여 데이터를 수정하더라도, 이 변경사항이 기본 테이블의 데이터 무결성 규칙을 위반하지 않도록 관리할 수 있다.


CREATE VIEW employee_details AS
SELECT employee_id, last_name, department_id
FROM employees;

SELECT * FROM employee_details;

--과제7_1117: employees 테이블에서 salary 가 10000 이상인 직원만을 포함하는 뷰 special_employee 를 생성하는 SQL 명령문을 작성하시오.
--과제7_1117 솔루션
CREATE VIEW special_employee AS
SELECT salary
FROM employees
WHERE salary > 10000;
--DROP VIEW special_employee;
SELECT * FROM special_employee;

--과제8_1117: employees 테이블에서 각 부서별 직원 수를 포함하는 뷰를 생성하세요.
--과제8_1117 솔루션
CREATE VIEW number_of_emp AS
SELECT ;

--과제9_1117: employees 테이블에서 근속기간이 10년 이상인 직원을  포함하는 뷰를 생성하세요.
--과제9_1117 솔루션
SELECT * FROM employees;

CREATE VIEW goinmul AS
SELECT last_name, round(sysdate-hire_date) AS 근속기간
FROM employees
WHERE round(sysdate-hire_date) > 365 * 10;

SELECT * from goinmul;

----------------------------------------------------------------------------------------------------------------
--TCL (Transaction Control Language)
--COMMIT: 현재 트랜잭션 내에서 수행된 모든 변경(INSERT, UPDATE, DELETE 등)을 데이터베이스에 영구적으로 저장.
--COMMIT 명령을 실행하면, 트랜잭션은 완료되며, 그 이후에는 변경 사항을 되돌릴 수 없다.
--ROLLBACK: 현재 트랜잭션 내에서 수행된 변경들을 취소하고, 데이터베이스를 트랜잭션이 시작하기 전의 상태로 되돌린다. 
--오류가 발생했거나 다른 이유로 트랜잭션을 취소해야 할 경우에 사용된다.
--SAVEPOINT: 트랜잭션 내에서 중간 체크포인트를 생성합니다. 오류가 발생할 경우, ROLLBACK을 사용하여 최근의 SAVEPOINT까지 되돌릴 수 있다.
--트랜잭션을 콘트롤하는 TCL(TRANSACTION CONTROL LANGUAGE)


--과제10_1117.
--orders라는 테이블을 생성하고, order_id, customer_id, order_date, amount, status라는 속성을 설정하세요.
--데이터를 5개 입력하세요.
--입력한 데이터 중 2개를 수정하세요.
--수정한 데이터를 취소하기 위해 롤백을 사용하세요.
--3개의 새로운 데이터를 입력하고, 그 중 마지막 데이터 입력만 취소한 후 나머지를 커밋하세요.
--과제10_1117 솔루션
CREATE TABLE orders(
 order_id NUMBER(20) NOT NULL PRIMARY KEY
 , customer_id NUMBER(20) NOT NULL
 , order_date VARCHAR2(100)
 , amount NUMBER(20) default 1 
 , status CHAR(10) default 'failed' -- <-> 'success'
);

desc orders;

INSERT INTO orders VALUES(1, 001, to_char('YYYY-MM-MM'), 1, 'sceess');
INSERT INTO orders VALUES(1, 001, to_char('YYYY-MM-MM'), 2, 'sceess');

select * from orders;


--과제11_1117: 관심있는 db 테이블을 생성하고 관리하는 시나리오를 작성하여
--데이터 입력, 수정, 삭제 과정을 진행한 후 최종 데이터 10개를 출력하세요.
--ROLLBACK 2회, SAVEPOINT 2개를 최소한 사용
--과제11_1117 심주승님 솔루션
create table employee_evaluation(
    employee_id char(10) primary key -- 1부터 10까지
    , name varchar2(50) not null
    , department char(50) not null -- 기획부, 지원부, 영업1부, 영업2부
    , position char(10) not null
    , hire_date date
    , goal int not null
    , performance int
);

select *
from employee_evaluation;

alter table employee_evaluation drop column name;
alter table employee_evaluation add (first_name varchar2(50));
alter table employee_evaluation add (last_name varchar2(50));
alter table employee_evaluation add (salary number check(salary > 3000));
alter table employee_evaluation add (achieve char(10) not null);

select *
from employee_evaluation;

savepoint sp_1;

alter table employee_evaluation drop column achieve;
alter table employee_evaluation add (achieve char(10));

rollback sp_1;

insert into employee_evaluation values (1, '기획부', '팀장', '2020-01-01', 100, 110, '현규', '오', 10000, '');
insert into employee_evaluation values (2, '기획부', '차장', '2020-05-01', 70, 70, '우영', '정', 7500, '');
insert into employee_evaluation values (3, '기획부', '대리', '2021-01-25', 30, 25, '규성', '조', 5500, '');
insert into employee_evaluation values (4, '영업1부', '팀장', '2020-01-01', 100, 120, '의조', '황', 9000, '');
insert into employee_evaluation values (5, '영업1부', '차장', '2020-05-01', 70, 90, '선민', '문', 7300, '');
insert into employee_evaluation values (6, '영업1부', '대리', '2021-01-25', 30, 45, '용우', '박', 5300, '');
insert into employee_evaluation values (7, '영업2부', '차장', '2020-05-01', 70, 80, '흥민', '손', 7300, '');
insert into employee_evaluation values (8, '영업2부', '과장', '2020-05-01', 50, 120, '강인', '이', 5800, '');
insert into employee_evaluation values (9, '영업2부', '사원', '2023-06-01', 15, 20, '순민', '이', 4500, '');
insert into employee_evaluation values (10, '지원부', '대리', '2022-05-14', 30, 45, '재성', '이', 5600, '');

savepoint sp_2;

select *
from employee_evaluation;

alter table employee_evaluation modify (employee_id char(10));
alter table employee_evaluation modify (department varchar2(50));

rollback to sp_2;

commit;

alter table employee_evaluation modify (position char(15));

update employee_evaluation
set position = '팀장(부장)'
where position = '팀장';

commit;

update employee_evaluation
set performance = 90
where first_name = '의조';

update employee_evaluation
set performance = 50
where first_name = '선민';

commit;

-- 본문
create view KPI as
    select last_name||''||first_name as 이름
        , employee_id as 사번
        , position as 직급
        , goal as "목표 KPI"
        , performance as "달성 KPI"
        , (performance - goal) as "KPI 초과량"
        , case when (performance - goal) >= 0
            then 'Y'
            else 'N'
            end as "ACHIEVE"
    from employee_evaluation
    order by achieve desc, "KPI 초과량" desc;
    
select *
from KPI
where "KPI 초과량" >= 0;



--과제12_1117: HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 작성하세요. (예: 부서별 평균 SALARY 순위)
--과제12_1117 솔루션
--테이블생성, 부서별 급여와 총 급여를 확인 할 수 있음.
--(급여의 합 평균 최솟값 최댓값, 총 직원수, 급여전체총합, 직원평균급여, 부서평균급여)
--table 만들기 부서별 급여를 대략적으로 보기
--사용할 테이블 확인
select * from jobs;
select * from departments;
select * from employees;
select * from job_history;

--부서 목록 확인
SELECT department_id
from employees
group by department_id
order by department_id DESC;
-- 부서 목록 department_id : 10,20,30,40,50,60,70,80,90,100,110 그 외 나머지(120~200등..)는 없고 null 값이 있음.
--department_id 가 null 인 사람은 모두 job_id 에 맞는 department_id 를 부여해주려고함(데이터 무결성)
--1. department_id 가 null 값인 사람 찾기
select *
from employees
where department_id IS NULL;
--한명 밖에 없음. department_id : null, employee_id : 178, Job_id : SA_REP

--2. job_id 가 SA_REP 인 department_id 찾기 (직업에 맞는 부서 찾기)
select job_id, department_id
from job_history
where job_id IN 'SA_REP';
--SA_REP 의 department_id 는 80

--3. 수정 전 savepoint 생성
SAVEPOINT null_to_80;
------------------------SAVEPOINT---------------------------------

--4. 제약조건primary key 인 employee_id 로 찾아서 derpartment_id 를 80으로 수정
UPDATE employees
SET department_id = 80
WHERE employee_id = 178;

select * from employees where employee_id = 178;
ROLLBACK null_to_80; -- savepoint로 가기
--commit;
--수정끝


--부서의 급여 확인..
SELECT department_id,SALARY
FROM employees
WHERE department_id = ANY(10,20,30,40,50,60,70,80,90,100,110)
order by department_id;


--부서 이름 확인
select department_id, department_name from departments;


--department_id 부서별 직원수 확인 (employees 테이블에서)
select department_id, count(department_id)
from employees
group by department_id
order by department_id;

select *
from employees
order by department_id desc;

--부서별 총 급여 합산금액, 평균, 최소, 최대.. --평균값은 소수점 둘째자리까지...
SELECT sum(SALARY), round(avg(salary),2), min(salary), max(salary)
FROM employees
WHERE department_id = 80; --10,20,30,40,50,60,70,80,90,100,110

--------------------------------------------
--테이블 생성 : 부서별 급여를 대략적으로 보기..
CREATE TABLE OVERVIEW_departments_salary(
    department_id NUMBER(4) NOT NULL
    , department_name VARCHAR2(40) NOT NULL
    , department_num_of_employees NUMBER(3) NOT NULL
    , SUM_salary NUMBER(10) default 0
    , AVG_salary NUMBER(10) default 0
    , MIN_salary NUMBER(10) default 0
    , MAX_salary NUMBER(10) default 0
    , PRIMARY KEY (department_id, department_name)
);
DESC overview_departments_salary;

--컬럼명이너무 길어서 변경
ALTER TABLE OVERVIEW_departments_salary
RENAME COLUMN department_num_of_employees TO num_employees; 

--테이블 생성 후 INSERT 하기전 SAVEPOINT
SAVEPOINT before_insert;
---------------------------SAVEPOINT--------------------------------------

--데이터 입력. 
INSERT INTO OVERVIEW_departments_salary VALUES(10, 'Administration', 1, 4400, 4400, 4400, 4400);
INSERT INTO OVERVIEW_departments_salary VALUES(20, 'Marketing', 2, 19000, 9500, 6000, 13000);
INSERT INTO OVERVIEW_departments_salary VALUES(30, 'Purchasing', 6, 24900, 4150, 2500, 11000);
INSERT INTO OVERVIEW_departments_salary VALUES(40, 'Human Resources', 1, 6500, 6500, 6500, 6500);
INSERT INTO OVERVIEW_departments_salary VALUES(50, 'Shipping', 45, 156400, 3475.56, 2100, 8200);
INSERT INTO OVERVIEW_departments_salary VALUES(60, 'IT', 5, 28800, 5760, 4200, 9000);
INSERT INTO OVERVIEW_departments_salary VALUES(70, 'Public Relations', 1, 10000, 10000, 10000, 10000);
INSERT INTO OVERVIEW_departments_salary VALUES(80, 'Sales', 34, 311500, 8900, 6100, 14000);
INSERT INTO OVERVIEW_departments_salary VALUES(90, 'Executive', 3, 58000, 19333.33, 17000, 24000);
INSERT INTO OVERVIEW_departments_salary VALUES(100, 'Finance', 6, 51608, 8601.33, 6900, 12008);
INSERT INTO OVERVIEW_departments_salary VALUES(110, 'Accounting', 2, 20308, 10154, 8300, 12008);
--부서번호, 부서명, 사원수, 급여의 합-평균-최솟값-최댓값
select * from overview_departments_salary;

--급여총합순
select department_id, department_name, num_employees, sum_salary from overview_departments_salary order by sum_salary desc; 
--평균급여순
select department_id, department_name, num_employees, avg_salary from overview_departments_salary order by avg_salary desc; 
--최소급여순(오름차순)
select department_id, department_name, num_employees, min_salary from overview_departments_salary order by min_salary asc; 
--최대급여순
select department_id, department_name, num_employees, max_salary from overview_departments_salary order by max_salary desc; 

--총 직원수, 급여전체총합, 직원평균급여, 부서평균급여 확인
select 
    sum(num_employees) AS "총 직원수"
    , SUM(sum_salary) AS "급여전체총합"
    , round(SUM(sum_salary) / sum(num_employees),2) AS "직원평균급여"
    , AVG(sum_salary) AS "부서평균급여"
from overview_departments_salary;

-- savepoint로 가기
rollback before_insert;
--commit; --테이블 커밋.



--과제12_1117 전유빈님 솔루션
--각 부서마다 팀원은 몇명이고 어떤 포지션들이 있고 구성은 어떻게 되는지,팀구성 및 연차별 급여 구성
SELECT E.department_id, D.department_name, nvl(E.job_id,'Total') job_id , count(*) 직원수
FROM employees E
LEFT OUTER JOIN departments D on E.department_id = D.department_id
GROUP BY ROLLUP((E.department_id, D.department_name), E.job_id)
ORDER BY E.department_id;

--JOB ID 별 총 몇명이 있는지
SELECT E.job_ID, J.job_title, count(E.employee_id)
FROM employees E
LEFT OUTER JOIN jobs J on E.job_id = J.job_id
WHERE E.job_id = J.job_id
GROUP BY E.job_id, J.job_title;

--JOB ID 별 몇년차는 얼마 받는지 각 년차별로 샐러리 평균
SELECT job_id, 연차, round(avg(salary)) 평균급여
from (select job_id, floor(months_between(sysdate, hire_date)/12) as 연차, salary from employees)
GROUP BY job_id, 연차
ORDER BY job_id, 연차;

