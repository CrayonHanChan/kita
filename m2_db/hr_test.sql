--Q. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력.
--솔루션
select employees.employee_id, employees.last_name, jobs.job_id, jobs.job_title
from employees, jobs
where employees.employee_id = 120 and employees.job_id = jobs.job_id;

select *
from employees
where employee_id = 120;

--과제3_1116 김신미님 솔루션
SELECT first_name||' '||last_name "이름", hire_date "입사일"
FROM employees
WHERE TO_CHAR(hire_date, 'YY/MM') BETWEEN '05/01' AND '05/06';

select first_name|| ' ' ||last_name, hire_date
from employees
where hire_date between '05-01-01' and '05-06-30';

--과제4_1116: 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
select *
from employees
WHERE JOB_ID IN ('SA_MAN', 'IT_PROG', 'ST_MAN');

--과제5_1116: manager_id가 101에서 103인 사람만 출력
select manager_id, last_name
from employees
where manager_id IN (101,103);


--과제6_1116: EMPLOYEE_ID 가 홀수인 직원의 EMPLOYEE_ID 와 LAST_NAME을 출력하세요.
--과제6_1116 솔루션
select employee_id, last_name
from employees
where employee_id IN (select employee_id from employees where mod(employee_id, 2) = 1)
order by employee_id;

--과제7_1116: EMPLOYEES 테이블에서 commission_pct의 null 값 갯수를 출력하세요.
--과제7_1116 솔루션
select commission_pct, count(*) "null값 갯수"
from employees
where commission_pct IS NULL
group by commission_pct;

--과제8_1116: EMPLOYEES 테이블에서 department_id 가 없는 직원을 추출하여 POSITION을 '신입'으로 출력하세요.
--과제8_1116 솔루션
select *
from employees;

SELECT EMPLOYEE_ID, LAST_NAME, '신입' AS POSITION
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

select employee_id, first_name, last_name, '신입' as position 
from employees
where department_id is null;

select employee_id, first_name, last_name as 이름, 999 as manager_id, manager_id
from employees
where manager_id is null;

--과제9_1116: employees 테이블에서 이름에 FRIST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--과제9_1116 솔루션
select first_name ||' '|| last_name "NAME"
from employees;

--과제10_1116: HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
--과제10_1116 솔루션
select salary, last_name
from employees
order by salary, last_name;

--Q. employees 테이블의 salary를 5개 등급으로 표시하세요
select min(salary), max(salary) from employees;
select salary, width_bucket(salary, 2100, 24001, 5) "등급" 
from employees
order by "등급" desc;

--문제1_1117: 현재 날짜(SYSDATE)를 'YYYY-MM-DD' 형식의 문자열로 변환하세요.
--문제1_1117 솔루션
select to_char(sysdate, 'yyyy-mm-dd')
from dual; 

--문제2_1117: '01-01-2023' 이라는 문자열을 날짜 타입으로 변환하세요.
select to_date('01-01-2023', 'mm-dd-yy')
from dual;

--문제3_1117: 현재 날짜와 시간(SYSDATE)을 'YYYY-MM-DD HH24:MI:SS' 형식의 문자열로 변환하세요.
select to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
from dual;

--문제4_1117: '2023-01-01 15:30:00'이라는 문자열을 날짜 및 시간 타입으로 변환하세요.
select to_date('2023-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS')
from dual;


--Q. last_name이 Seo인 직원의 last_name 과 salary를 구하세요.(Seo, SEO, seo 모두 검출)
select last_name, salary
from employees
where lower(last_name) = 'seo';

--과제5_1117: employees 테이블에서 commission_pct 가 null이 아닌 경우, 'A' null인 경우 'N'을 표시하는 쿼리를 작성
select decode(commission_pct, null, 'n','a')
from employees;

--과제6_1117: employees 테이블에서
--salary가 20000이상이면 'a', 10000과 20000 미만 사이면 'b', 그 이하면 'c'로 표시하는 쿼리를 작성하시오.(case)
--과제6_1117 솔루션
select last_name, salary
, case
when salary >= 20000 then 'a'
when salary between 10000 and 19999 then 'b'
else 'c'
end
from employees;

--과제7_1117: employees 테이블에서 salary 가 10000 이상인 직원만을 포함하는 뷰 special_employee 를 생성하는 SQL 명령문을 작성하시오.
--과제7_1117 솔루션
create view special_employee_test as
select salary
from employees
where salary >= 10000;

select * from special_employee_test;

--과제8_1117: employees 테이블에서 각 부서별 직원 수를 포함하는 뷰를 생성하세요.
--과제8_1117 솔루션
create view number_employees as
select department_id, count(department_id) as "직원수"
from employees
group by department_id;

select * from number_employees;

--과제9_1117: employees 테이블에서 근속기간이 10년 이상인 직원을  포함하는 뷰를 생성하세요.
--과제9_1117 솔루션
--create view test10view as
create view hire_date_up10 as
select employee_id, hire_date, round(sysdate - hire_date,2) "근무기간"
from employees
where sysdate - hire_date > 365 * 10;

select * from hire_date_up10;