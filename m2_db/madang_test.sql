--����1_1115. ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�

--Q. ������ 10,000�� �̻��� ������ �˻��ϼ���.
SELECT *
FROM book
WHERE price > 10000;

--����1_1114: ������ 10,000�� �̻� 20,000 ������ ������ �˻��ϼ���.(2���� ���)
SELECT *
FROM book
WHERE price >= 10000 AND price <= 20000;

--2nd solution
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

--����2_1114: ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� ������ �˻��Ͻÿ�.(3���� ���)
--�ַ��1
SELECT *
FROM book
WHERE publisher = '�½�����' OR publisher = '���ѹ̵��';

--2
SELECT *
FROM book
WHERE publisher IN ('�½�����', '���ѹ̵��');

--3
SELECT * FROM BOOK;

SELECT *
FROM book
WHERE publisher NOT IN ('������', '�̻�̵��', '�Ｚ��', 'Pearson');


--����3_1114: �����̸��� '�౸'�� ���Ե� ���ǻ縦 �˻��Ͻÿ�.
--����3_1114 �ַ��
SELECT bookname, publisher
FROM book
WHERE bookname like '%�౸%';

--����4_1114: �����̸��� ���� �� ��° ��ġ�� '��'��� ���ڿ��� ���� ������ �˻��Ͻÿ�.
--����4_1114 �ַ��
SELECT bookname, publisher
FROM book
WHERE bookname like '_��%';

--����5_1114: �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
--����5_1115 �ַ��
SELECT bookname, price
FROM book
WHERE bookname like '%�౸%' AND price >= 20000;

--��������
SELECT *
FROM book
ORDER BY price DESC;

--�������� ����Ʈ
SELECT *
FROM book
ORDER BY price ASC;

--����6_1114: ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�
--����6_1114 �ַ��
SELECT bookname, price
FROM book
ORDER BY price, bookname;

--����7_1114: 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
--SELECT * FROM orders; --�̰��� ���..
--����7_1114 �ַ��
SELECT *
FROM book, customer, orders;

SELECT SUM(saleprice)
FROM orders
WHERE custid = 2
GROUP BY custid;

--����8_1114: ������ 9,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.
--��, �� �� �̻� ������ ���� ���Ͻÿ�.(GROUP BY, COUNT �� ���)
--����8_1114 �ַ�� --���� �ߴµ� ������
SELECT custid, COUNT(*)
FROM orders
GROUP BY custid
HAVING saleprice >= 9000 AND (SELECT orderid FROM orders WHERE orderid >2 );


--����8_1114 �ַ�� --�ߵ�!
--where�������� having�� ����.. ���� ����!
SELECT custid, COUNT(*) AS "��������"
FROM orders
WHERE saleprice >= 9000
GROUP BY custid
HAVING COUNT(*) >= 2; --where���� �Ǵٸ� ������ �� �� having�� ��

select * from orders;


--����8_1114: ������ 9,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.
--��, �� �� �̻� ������ ���� ���Ͻÿ�.(GROUP BY, COUNT �� ���)
SELECT custid, COUNT(*) AS "��������", SUM(saleprice) AS "�� �Ǹž�" --������ ������ ����ǥ�� �����ְ� �׷��� �ƴϸ� �����൵��
FROM orders
GROUP BY custid;



--���ֽ´� ���� 11 �ַ��. ���̺� �����
create table mart(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , frequency number -- �湮 ��
    , amount_num number
    , amount_price number
    , parking varchar2(20) -- ��������
    , family number -- ���� ������ ��
);

alter table mart drop column amount_num;
alter table mart modify (name varchar2(20));
alter table mart modify (phone varchar2(100));

insert into mart values(1, '��浿', 32, '��', '010-1234-1234', '���� ����', 5, 1500000, 'N', 3);
insert into mart values(2, '�����', 31, '��', '010-7777-1234', '���� ��õ', 5, 200000000, 'Y', 4);
insert into mart values(3, '�̼���', 57, '��', '010-1592-1234', '�泲 �뿵', 5, 270000, 'N', 1);
insert into mart values(4, '������', 30, '��', '010-0516-1234', '���� ����', 5, 750000000, 'Y', 4);

select * from mart;


create table department(
    vipid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , use_store varchar2(100) -- ���� ã�� ����
    , amount_num number
    , amount_price number
    , valet varchar2(20) -- �߷���ŷ ���� ��뿩��
    , rounge varchar2(20) -- vip ����� ��뿩��
    , foreign key (vipid) references mart(custid) delete on cascade
);

alter table department modify (amount_price check (amount_price > 100000000));
alter table department modify (rounge default 'Y');
alter table department modify (valet default 'Y');
alter table department modify (phone varchar2(100));
alter table department drop column amount_num;
alter table department add (custid number);

insert into department values(1, '�����', 31, '��', '010-7777-1234', '���� ��õ', 'LV', 900000000,'','');
insert into department values(2, '������', 30, '��', '010-0516-1234', '���� ����', 'GUCCI', 1500000000,'','',4);

update department
set valet = ''
where vipid = 1;

delete from department
where custid = 4;

select * from department;





--���� 11 ������� �ַ��

CREATE TABLE school(
schoolid NUMBER PRIMARY KEY,
schoolname VARCHAR2(20) NOT NULL,
schooltype VARCHAR2(10) NOT NULL,
schooladdress VARCHAR2(50) NOT NULL,
schoolsize NUMBER,
headmaster_name VARCHAR2(10),
class_total NUMBER DEFAULT 1,
teachers_total NUMBER,
students_total NUMBER CHECK(students_total>5),
established_date DATE);

DESC school;

CREATE TABLE student(
schoolid NUMBER,
schoolname VARCHAR2(20) NOT NULL,
schooltype VARCHAR2(10) NOT NULL,
gradenumber NUMBER NOT NULL,
classnumber NUMBER NOT NULL,
studentnumber NUMBER,
studentname VARCHAR2(10) NOT NULL,
address VARCHAR2(50),
email VARCHAR2(30) UNIQUE,
phone CHAR(13) DEFAULT '000-0000-0000', --phone number�� ���� fix�� �ű⶧���� 13�ڸ� ���ؼ� char �� datatype�� ��
PRIMARY KEY(studentnumber),
FOREIGN KEY(schoolid) REFERENCES school(schoolid) ON DELETE CASCADE);

DESC student;

ALTER TABLE school MODIFY(schooltype VARCHAR2(20)); --������ 10 �̾��µ�(���� byte) �ѱ��� 1���� 3����Ʈ����... ����(MODIFY)
INSERT INTO school VALUES(1,'��ȭ','�ʵ��б�','�λ����� ���ݵ�', 1000,'�ƹ���',36,50,1080,'1955-01-01');
INSERT INTO school VALUES(2,'����','�ʵ��б�','�λ����� �簨��',1200,'�贩��',48,60,1920,'1996-01-01');
INSERT INTO school VALUES(3,'����','�ʵ��б�','�λ곲�� ��ȣ��',1100,'�̴���',36,50,1080,'2001-01-01');
INSERT INTO school VALUES(4,'����','���б�','�λ곲�� ��ȣ��',1000,'�ڴ���',30,40,800,'2002-01-01');
INSERT INTO school VALUES(5,'����','����б�','�λ곲�� ��ȣ��',1000,'������',20,30,600,'2002-01-01');
SELECT * FROM school;

ALTER TABLE student MODIFY(schooltype VARCHAR2(20));
INSERT INTO student VALUES(1,'��ȭ','�ʵ��б�',1,3,20,'������','�λ����� ���ݵ�','jsldk@naver.com','');
INSERT INTO student VALUES(1,'��ȭ','�ʵ��б�',2,3,24,'�Ѵ���','�λ����� �簨��','lkjq@gmail.com',DEFAULT);
INSERT INTO student VALUES(2,'����','�ʵ��б�',6,1,10,'������','�λ����� �簨��','poir@naver.com','010-1234-1234');
INSERT INTO student VALUES(3,'����','�ʵ��б�',4,3,21,'Ȳ����','�λ����� ��ȣ��','',DEFAULT);
INSERT INTO student VALUES(4,'����','���б�',3,2,1,'�δ���','�λ����� ��ȣ��','','010-987-6543');

DELETE school
WHERE schoolid = 1; -- cascade�� ���ؼ� �̰� run �ϸ� �����������Ե�.

DELETE student
WHERE schoolid = 2;

SELECT * FROM school;
SELECT * FROM student;


--����....
--------------------------------------------------------------------
--����1_1116: ParentTable, ChildTable 2���� �ۼ��ϰ� �� ���̺��� �Ӽ��� 4��(������ Ÿ���� ��� �ٸ�)�� ���������� 5�� �̻� �����Ѵ�. �ִ��� �پ��ϰ�...
--����1_1116 �ַ��
--ParentTable�� �⺻Ű�� ���Ͽ� ChildTable�� �Ӽ��� �ϳ��� ������ �ϴ� �ܷ�Ű�� �����ϰ� Ư�� �����͸� �����ϸ� ��� ������ �ǵ��� �Ѵ�.
--�����ʹ� ���� 10���� �Է��ϰ� ������ �����Ѵ�.
--������ ��ü ��ȸ, ����, ���� ���� ���Ͽ� ���ϴ� �׷��� ���� �ݾ��� �����Ѵ�.
--VARCHAR2, CHAR, TIMESTAMP, DATE, NUMBER, [DECIMAL(�����ʿ��� ���� ��Ȯ�ϰԾ���..), FLOAT(�Ǽ�), INTEGER]
--���߿��� VARCHAR2, TIMESTAMP Ȥ��DATE, NUMBER ����..

--ENTERTAINMENT ���̺� ����
CREATE TABLE ENTERTAINMENT(
 ent_name VARCHAR2(40) PRIMARY KEY NOT NULL,
 Oday DATE NOT NULL,
 place VARCHAR2(100) NOT NULL,
 founder VARCHAR2(30) NOT NULL
);

DESC entertainment;

--ARTISTS ���̺� ���� 
CREATE TABLE ARTISTS(
 ent_name VARCHAR2(40) NOT NULL,
 artist_name VARCHAR2(40) UNIQUE NOT NULL,
 num_members NUMBER(15) default 1,
 debut_day DATE NOT NULL,
 PRIMARY KEY (debut_day),
 FOREIGN KEY (ent_name) REFERENCES ENTERTAINMENT(ent_name) ON DELETE CASCADE
);

DESC artists;

--���̺� ����
--DROP TABLE ENTERTAINMENT;
--DROP TABLE ARTISTS;

SELECT * FROM entertainment;
SELECT * FROM artists;

--������ ����
INSERT INTO entertainment VALUES('JYP', '1996-04-25', '���� ������', 'JYP');
INSERT INTO entertainment VALUES('SM', '1995-02-14', '���� ������', '�̼���');
INSERT INTO entertainment VALUES('YG', '1998-02-24', '���� ������', '������');
INSERT INTO entertainment VALUES('HYBE', '2005-02-04', '���� ��걸', '�����');
INSERT INTO entertainment VALUES('STARSHIP', '2008-01-03', '���� ������', '������');
INSERT INTO entertainment VALUES('THEBLACKLABEL', '2016-03-17', '���� ������', '��ȫ��');
INSERT INTO entertainment VALUES('P NATION', '2018-10-29', '���� ������', 'PSY');
INSERT INTO entertainment VALUES('MNH', '2014-11-18', '���� ������', '���ּ�');
INSERT INTO entertainment VALUES('FNC', '2006-12-14', '���� ������', '�Ѽ�ȣ');
INSERT INTO entertainment VALUES('fantagio', '1991-01-08', '���� ������', '������');
INSERT INTO entertainment VALUES('ť�꿣�����θ�Ʈ', '2006-08-29', '���� ������', 'ȫ�¼�');

SELECT * FROM entertainment;

INSERT INTO artists VALUES('JYP', 'TWICE', 9, '2015-10-20');
INSERT INTO artists VALUES('SM', 'f(x)', 4, '2009-09-05');
INSERT INTO artists VALUES('SM', 'Red Velvet', 5, '2014-08-01');
INSERT INTO artists VALUES('YG', 'BLACKPINK ', 4, '2016-08-08');
INSERT INTO artists VALUES('STARSHIP', 'IVE', 6, '2021-12-01');
INSERT INTO artists VALUES('THEBLACKLABEL', '���ҹ�', 1, '2019-06-13');
INSERT INTO artists VALUES('P NATION', 'CRUSH', 1, '2012-05-01');
INSERT INTO artists VALUES('FNC', '���ö���', 5, '2015-05-20');
INSERT INTO artists VALUES('fantagio', '��Ű��Ű', 8, '2017-08-08');
INSERT INTO artists VALUES('ť�꿣�����θ�Ʈ', '(����)���̵�', 5, '2018-05-02');

SELECT * FROM artists;
 
DELETE entertainment
WHERE ent_name = 'SM';

DELETE artists
WHERE ent_name = 'JYP';

SELECT * FROM entertainment;
SELECT * FROM artists;


 




















