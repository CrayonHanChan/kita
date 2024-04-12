--Q. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���.
--�ַ��
select employees.employee_id, employees.last_name, jobs.job_id, jobs.job_title
from employees, jobs
where employees.employee_id = 120 and employees.job_id = jobs.job_id;

select *
from employees
where employee_id = 120;

--����3_1116 ��Ź̴� �ַ��
SELECT first_name||' '||last_name "�̸�", hire_date "�Ի���"
FROM employees
WHERE TO_CHAR(hire_date, 'YY/MM') BETWEEN '05/01' AND '05/06';

select first_name|| ' ' ||last_name, hire_date
from employees
where hire_date between '05-01-01' and '05-06-30';

--����4_1116: ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
select *
from employees
WHERE JOB_ID IN ('SA_MAN', 'IT_PROG', 'ST_MAN');

--����5_1116: manager_id�� 101���� 103�� ����� ���
select manager_id, last_name
from employees
where manager_id IN (101,103);


--����6_1116: EMPLOYEE_ID �� Ȧ���� ������ EMPLOYEE_ID �� LAST_NAME�� ����ϼ���.
--����6_1116 �ַ��
select employee_id, last_name
from employees
where employee_id IN (select employee_id from employees where mod(employee_id, 2) = 1)
order by employee_id;

--����7_1116: EMPLOYEES ���̺��� commission_pct�� null �� ������ ����ϼ���.
--����7_1116 �ַ��
select commission_pct, count(*) "null�� ����"
from employees
where commission_pct IS NULL
group by commission_pct;

--����8_1116: EMPLOYEES ���̺��� department_id �� ���� ������ �����Ͽ� POSITION�� '����'���� ����ϼ���.
--����8_1116 �ַ��
select *
from employees;

SELECT EMPLOYEE_ID, LAST_NAME, '����' AS POSITION
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

select employee_id, first_name, last_name, '����' as position 
from employees
where department_id is null;

select employee_id, first_name, last_name as �̸�, 999 as manager_id, manager_id
from employees
where manager_id is null;

--����9_1116: employees ���̺��� �̸��� FRIST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--����9_1116 �ַ��
select first_name ||' '|| last_name "NAME"
from employees;

--����10_1116: HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
--����10_1116 �ַ��
select salary, last_name
from employees
order by salary, last_name;

--Q. employees ���̺��� salary�� 5�� ������� ǥ���ϼ���
select min(salary), max(salary) from employees;
select salary, width_bucket(salary, 2100, 24001, 5) "���" 
from employees
order by "���" desc;

--����1_1117: ���� ��¥(SYSDATE)�� 'YYYY-MM-DD' ������ ���ڿ��� ��ȯ�ϼ���.
--����1_1117 �ַ��
select to_char(sysdate, 'yyyy-mm-dd')
from dual; 

--����2_1117: '01-01-2023' �̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ�ϼ���.
select to_date('01-01-2023', 'mm-dd-yy')
from dual;

--����3_1117: ���� ��¥�� �ð�(SYSDATE)�� 'YYYY-MM-DD HH24:MI:SS' ������ ���ڿ��� ��ȯ�ϼ���.
select to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
from dual;

--����4_1117: '2023-01-01 15:30:00'�̶�� ���ڿ��� ��¥ �� �ð� Ÿ������ ��ȯ�ϼ���.
select to_date('2023-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS')
from dual;


--Q. last_name�� Seo�� ������ last_name �� salary�� ���ϼ���.(Seo, SEO, seo ��� ����)
select last_name, salary
from employees
where lower(last_name) = 'seo';

--����5_1117: employees ���̺��� commission_pct �� null�� �ƴ� ���, 'A' null�� ��� 'N'�� ǥ���ϴ� ������ �ۼ�
select decode(commission_pct, null, 'n','a')
from employees;

--����6_1117: employees ���̺���
--salary�� 20000�̻��̸� 'a', 10000�� 20000 �̸� ���̸� 'b', �� ���ϸ� 'c'�� ǥ���ϴ� ������ �ۼ��Ͻÿ�.(case)
--����6_1117 �ַ��
select last_name, salary
, case
when salary >= 20000 then 'a'
when salary between 10000 and 19999 then 'b'
else 'c'
end
from employees;

--����7_1117: employees ���̺��� salary �� 10000 �̻��� �������� �����ϴ� �� special_employee �� �����ϴ� SQL ��ɹ��� �ۼ��Ͻÿ�.
--����7_1117 �ַ��
create view special_employee_test as
select salary
from employees
where salary >= 10000;

select * from special_employee_test;

--����8_1117: employees ���̺��� �� �μ��� ���� ���� �����ϴ� �並 �����ϼ���.
--����8_1117 �ַ��
create view number_employees as
select department_id, count(department_id) as "������"
from employees
group by department_id;

select * from number_employees;

--����9_1117: employees ���̺��� �ټӱⰣ�� 10�� �̻��� ������  �����ϴ� �並 �����ϼ���.
--����9_1117 �ַ��
--create view test10view as
create view hire_date_up10 as
select employee_id, hire_date, round(sysdate - hire_date,2) "�ٹ��Ⱓ"
from employees
where sysdate - hire_date > 365 * 10;

select * from hire_date_up10;