--DML(Data Manipulation Language)
--�����ͺ��̽����� �����͸� �����ϴ� �� ���Ǵ� SQL�� �Ϻ�. 
--�ַ� INSERT, UPDATE, DELETE ���� ����Ͽ� �����͸� ����, ����, ����

--INSERT - ������ ����
--���ο� �����͸� ���̺� �߰��� �� ���
--UPDATE - ������ ����
--���̺��� ���� �����͸� ������ �� ���
--DELETE - ������ ����
--���̺��� �����͸� ������ �� ���
--UPDATE�� DELETE ����� �����ϹǷ� ���� ���ǰ� �ʿ�!!!
--Ư�� WHERE ���� �����ϸ� ���̺��� ��� ���� ������ ���� �� �ִ�.!!! WHERE�Ⱦ��� ���̺� �ִ� ������ �� ���� �� ����. ����ų�� ����..
--���̺��� �����͸� �����ϴ� �۾��� �ǵ��� �� �����Ƿ�, Ư�� �߿��� �����͸� �ٷ� ���� �����ϰ� �۾�.
--�����ͺ��̽��� ���Ἲ�� �����ϱ� ���� ������ ���������� �����Ǿ� �ִ��� Ȯ��!!!
--�׻� �����ϰ� �� �ٷ����.. ��Ȯ�� �ʿ�!


--madang user ����
--4���� ���̺� ���� : book, customer, imported_book, orders

SELECT * FROM book;
SELECT * FROM customer;
SELECT * FROM imported_book;
SELECT * FROM orders;

SELECT * FROM book;
SELECT bookname, price FROM book;
SELECT publisher FROM book;
--�ߺ� ���� ���
SELECT DISTINCT publisher FROM book;

--Q. ������ 10,000�� �̻��� ������ �˻��ϼ���.
--�ַ��
SELECT *
FROM book
WHERE price > 10000;

--����1_1114: ������ 10,000�� �̻� 20,000 ������ ������ �˻��ϼ���.(2���� ���)
--�ַ��1
SELECT *
FROM book
WHERE price >= 10000 AND price <= 20000;
--�ַ��2
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;
--WHERE not price < 10000 AND price > 20000; --�̰Ŵ� �ȵ�..

--����2_1114: ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� ������ �˻��Ͻÿ�.(3���� ���)
--�ַ��1
SELECT *
FROM book
WHERE (publisher = '���ѹ̵��') OR (publisher = '�½�����');
--�ַ��2
SELECT *
FROM book
WHERE publisher IN ('���ѹ̵��', '�½�����'); --IN ���� �׾ȿ� �ִ°��� �� �����ϴ°��� , �� ����
--�ַ��3
SELECT * FROM book WHERE publisher = '���ѹ̵��'
UNION --�ߺ��� ���ڵ带 �����ϰ� ����� ���� --�������� union�� ���
SELECT * FROM book WHERE publisher = '�½�����';
--�߰��ַ��
--IN �� Ȱ��
SELECT *
FROM book
WHERE '�½�����' IN publisher or '���ѹ̵��' IN publisher;

SELECT *
FROM book
WHERE publisher IN ('�½�����', '���ѹ̵��');

--NOT IN �� Ȱ��
SELECT *
FROM book
WHERE publisher NOT IN ('������', '�̻�̵��', '�Ｚ��', 'Pearson'); --not in ���⿡ ���°�

--����2_1114 ������� �ַ��
SELECT *
FROM book
WHERE  publisher IN ('�½�����','���ѹ̵��')
;
SELECT *
FROM book
WHERE  publisher = '�½�����'
UNION
SELECT *
FROM book
WHERE  publisher = '���ѹ̵��'
;

--����3_1114: �����̸��� '�౸'�� ���Ե� ���ǻ縦 �˻��Ͻÿ�.
--����3_1114 �ַ��
SELECT bookname, publisher FROM book
    WHERE bookname LIKE '%�౸%'; --LIKE �� �ش�Ǵ°� �˻�..


--����4_1114: �����̸��� ���� �� ��° ��ġ�� '��'��� ���ڿ��� ���� ������ �˻��Ͻÿ�.
--����4_1114 �ַ��
SELECT bookname FROM book
    WHERE bookname LIKE '_��%';
--����4_1114 �����δ� �ַ��
SELECT *
FROM book
WHERE SUBSTR(bookname, 2, 1) = '��';

--����5_1114: �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
--����5_1115 �ַ��
SELECT bookname, price FROM book
WHERE bookname Like '%�౸%' AND price >= 20000; --��� ���~


--�ø��������� ����..(ASC�� ����)
SELECT *
FROM book
ORDER BY bookname; --python ���� sort. ���� by �����? ���⼱ bookname����

--������������ ���� DESC ..
SELECT *
FROM book
ORDER BY bookname DESC; --�������� DESC. ������ ������ �� �� ����.

--����6_1114: ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�
--����6_1114 �ַ��
SELECT * FROM book
ORDER BY price DESC, bookname ASC; --����price�ϴ� bookname���� sort���Ǵ°�
--������ �ַ��
SELECT *
FROM book
ORDER BY price, bookname;


--����7_1114: 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
--SELECT * FROM orders; --�̰��� ���..
--����7_1114 �ַ��
SELECT * FROM orders;
--    WHERE custid = 2
--    GROUP custid
--    HAVING SUM(saleprice*orderid);


--����7_1114 ���ֽ´� �ַ��
--sum�߱⿡ group by �ؾ���
select customer.name, orders.custid, sum(orders.saleprice) 
from orders
inner join customer on orders.custid = customer.custid --inner join �������� ���°���. orders.custid = customer.custid �̰��� ����Ű��
where orders.custid = 2
group by customer.name, orders.custid;

--����7_1114 �ַ��
SELECT SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE custid = 2;

--����8_1114: ������ 9,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.
--��, �� �� �̻� ������ ���� ���Ͻÿ�.(GROUP BY, COUNT �� ���)
--����8_1114 �ַ��
SELECT 
( 
    SELECT NAME FROM CUSTOMER WHERE CUSTID=A.CUSTID
) NAME, 
COUNT(*) AS Count
FROM
ORDERS  A
WHERE
BOOKID IN (
    SELECT BOOKID FROM BOOK WHERE PRICE >= 8000
)
GROUP BY CUSTID;

--����8_1114 �ַ��
--where�������� having�� ����.. ���� ����!
SELECT custid, COUNT(*) AS "��������"
FROM orders
WHERE saleprice >= 9000
GROUP BY custid
HAVING COUNT(*) >= 2; --where���� �Ǵٸ� ������ �� �� having�� ��

--GROUP BY ���� SQL���� �ſ� �߿��� ��������, �����͸� Ư�� ���ؿ� ���� �׷�ȭ�ϴ� �� ���
--�̸� ���� ���� �Լ�(��: SUM, AVG, MAX, MIN, COUNT ��)�� ����Ͽ� �� �׷쿡 ���� ���� �����͸� ���
SELECT SUM(saleprice) AS total, --AS �� �˸��, ��Ī��. SUM(saleprice)�ѰŸ� total�̶� �θ��ڴ�.
       AVG(saleprice) AS average,
       MIN(saleprice) AS minimum,
       MAX(saleprice) AS maximum
FROM orders;

SELECT * FROM orders;
--orderid �� �ߺ��Ǹ�ȵ�.. �ߺ��Ǹ� �ŷ��� �� ����..
--custid�� �ߺ��ɼ� ���� ~ ���� ������ ��� �����ϱ�.. �ߺ��ȵǰ��ϴ°��� �̻���
--bookid�� ����å �ٸ������ ��� ������ �ߺ�����
--��ȭ�� �� 10000���� �߿��� ���� ��� .. VIP �ý��� �� �Ϸ��� �ϸ� ��� db���� ������ �ұ�?
--���Ž����Ϸ� �ϱ�? sum - group by
--���Ŵܰ��� �ϱ�? ��ȸ��ǰ�� ��»��. ��ǰ������ ��ǰ��� ���.
--��ȭ�������� ������ ���� �ø� ���ִµ��� ����ϱ⶧���� �ѷ�������ȵ�!!!!
--Ƚ����� 1ȸ��� �̷��� ���ϸ� �ش� ���� ���Ž�����..... �������� �ޱ۷� ������ �����͸� �Ӵ�ǽ���̼ǰ���
--�м��� �����ͷ� �λ���Ʈ�� ����
--�� db, dml�� ������.....
--�׷����� group by�� ���� �پ��� ���� Ž�����м��� �� �� ����
--�̷������� approaching�� ������
--��ձݾ�, ����Ƚ�� ���� �׷캰�� �������ؼ� ����......
--�׷��� �츮�� vip�� Ÿ���Ҽ� �ִ� �׷��� �����! �̷��� �Ǵ°���
--vip���ٴ� ��ǰ�����ؼ� Ÿ����,,, ���� ��� ��ȸ��ǰ(�޹ݰ��� ���� �������ִ°��� �����Ϸ�����)
--�׷� ��ü data �ʿ����. �ش�Ǵ� segement�ϸ��. �װſ� �´� ������ �༭ 
--�³׵��� ���ؼ��� �����̺� �ϴ°���

SELECT * FROM customer, book, orders, imported_book;

--����8_1114: ������ 9,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.
--��, �� �� �̻� ������ ���� ���Ͻÿ�.(GROUP BY, COUNT �� ���)
SELECT custid, COUNT(*) AS "��������", SUM(saleprice) AS "�� �Ǹž�" --������ ������ ����ǥ�� �����ְ� �׷��� �ƴϸ� �����൵��
FROM orders
GROUP BY custid;

--����7_1114: 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
--HAVING ���� SQL���� GROUP BY ���� �Բ� ���Ǿ� �׷�ȭ�� ����� ������ �����ϴ� �� ���
--WHERE ���� ó���� �� ���� ��쿡 ���
SELECT custid, COUNT(*) AS "��������", SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE bookid > 5
GROUP BY custid --�׷����� �����ϰ� �׷����� ������ �ִ°�.
HAVING COUNT(*) > 2; --�������� �ٷ� having

SELECT * FROM orders;
SELECT * FROM customer;
--Q. ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�.
SELECT name AS "������ �̸�", SUM(saleprice) AS "�� ���ž�"
FROM customer, orders
GROUP BY name
ORDER BY name;



--����1_1115. ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�
--����1_1115 �����δ� �ַ��
SELECT
customer.custid AS ��ID,
customer.name AS ���̸�,
customer.address AS �ּ�,
customer.phone AS ��ȭ��ȣ,
orders.orderid AS �ֹ�ID,
orders.bookid AS ����ID,
orders.saleprice AS �ǸŰ���,
orders.orderdate AS �ֹ�����
FROM 
customer , orders
WHERE 
customer.custid = orders.custid 
ORDER BY 
customer.custid, orders.orderid;
--����1_1115 �����δ� �ַ�ǿ� * ���
SELECT *
FROM customer , orders
WHERE customer.custid = orders.custid 
ORDER BY customer.custid;

--����2_1115. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
--����2_1115 �̹����� �ַ��
SELECT customer.name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;

--����3_1115. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
--����3_1115 ���ֽ´� �ַ��
select customer.custid, customer.name, sum(orders.saleprice)
from customer
inner join orders on customer.custid = orders.custid
group by customer.custid, customer.name
order by customer.custid, customer.name;

--����3_1115 �ַ��
SELECT custid, SUM(saleprice) "�� �Ǹž�" --AS�� ��������..
FROM orders
GROUP BY custid
ORDER BY custid;
--����3_1115 �ַ�� �̸��̳����Բ�
SELECT name, SUM(saleprice) AS "�� �Ǹž�"
FROM customer C, orders O --�̷��� ��� ������ ���ְ�
WHERE C.custid = O.custid --�ؿ��� �̷��� ���� ����
GROUP BY C.name
ORDER BY C.name;
--custid�� customer���� �ְ� orders���� �ֱ⶧���� �������ֱ� ���� ������ �Ҽ� ����.. AS�� ��������


--����4_1115. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
--����4_1115 ������� �ַ��
SELECT customer.name, book.bookname
FROM orders
INNER JOIN customer ON orders.custid = customer.custid --join�� �Ἥ �����̺��� ��ħ
INNER JOIN book ON orders.bookid = book.bookid;

--����4_1115 �ַ�� WHERE �� ���.
SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid=O.custid AND O.bookid = B.bookid;

--����5_1115. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
--����5_1115 �ֿ�Դ� �ַ��
SELECT 
(SELECT NAME FROM customer where custid = x.custid) "����",
(SELECT BOOKNAME FROM book where bookid = x.bookid) "å�̸�",
(SELECT PRICE FROM book where bookid = x.bookid) "å�ǸŰ�",
x.saleprice "���԰���",
x.orderdate "���Գ�¥"
FROM orders x
WHERE bookid IN (SELECT BOOKID FROM BOOK WHERE price = 20000)
ORDER BY custid;

--����5_1115 �ַ��
SELECT C.name, B.bookname
FROM book B, customer C, orders O
WHERE C.custid = O.custid AND O.bookid=B.bookid AND B.price = 20000;

SELECT  name, saleprice FROM customer,orders
--JOIN�� �� �� �̻��� ���̺��� �����Ͽ� ���õ� �����͸� ������ �� ���
--���� ���� (INNER JOIN). ���� �����ϸ鱳����.
SELECT customer.name, orders.saleprice
FROM customer
INNER JOIN orders ON customer.custid=orders.custid; --select �ڿ� ���� ���̺�� inner join �ڿ� ���� ���̺��� �����ִµ� on�� ��.

--���� �ܺ� ���� (Left Outer Join) : �� ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
SELECT customer.name, orders.saleprice
FROM customer
LEFT OUTER JOIN orders ON customer.custid=orders.custid; --�ڼ��� null �̸��� �ִµ� saleprice�� ��� null�� �� �̸�����\
--ù���� ���̺��� �������� �ؼ� join


--������ �ܺ� ���� (Right Outer Join) : ù ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
SELECT customer.name, orders.saleprice
FROM customer
RIGHT OUTER JOIN orders ON customer.custid=orders.custid;
--join�ڿ����°��� ���������ؼ� join


--FULL OUTER JOIN : ��ġ�ϴ� �����Ͱ� ���� ��� �ش� ���̺����� NULL ���� ���
SELECT customer.name, orders.saleprice
FROM customer
FULL OUTER JOIN orders ON customer.custid=orders.custid;
--�Ѵ� join


--CROSS JOIN : �� ���̺� ���� ��� ������ ������ ����
SELECT customer.name, orders.saleprice
FROM customer
CROSS JOIN orders;

--����6_1115. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�.(2���� ���, WHERE, JOIN)
--����6_1115 �ֿ�Դ� �ַ��
-- WHERE ���
SELECT 
(SELECT NAME FROM customer where custid = x.custid) "����",
(SELECT bookname FROM book where bookid = x.bookid) "å�̸�",
(SELECT price FROM book WHERE bookid = x.bookid) "�ǸŰ���"
FROM orders x
UNION
SELECT 
name "����",
null "å�̸�",
null "�ǸŰ���"
FROM customer
WHERE 
custid NOT IN (SELECT DISTINCT(CUSTID) FROM orders)
ORDER BY "����";

-- JOIN ���
SELECT C.NAME "����",
(SELECT BOOKNAME FROM BOOK WHERE BOOKID = D.BOOKID) "å�̸�",
(SELECT PRICE FROM BOOK WHERE BOOKID = D.BOOKID) "�ǸŰ���"
FROM
CUSTOMER C
LEFT OUTER JOIN ORDERS D
ON C.CUSTID = D.CUSTID
ORDER BY "����";

--����6_1115 ��Ź̴� �ַ�� WHERE
SELECT C.name AS "����", B.bookname AS "������", O.saleprice AS "�ǸŰ���"
FROM customer C, orders O, book B
WHERE O.custid(+) = C.custid AND B.bookid(+) = O.bookid;
--����6_1115 ��Ź̴� �ַ�� ������ �°�..
SELECT C.name AS "����", O.saleprice AS "���� �ǸŰ���"
FROM customer C, orders O
WHERE O.custid(+) = C.custid;

--����6_1115 ������ �ַ��
SELECT name, saleprice
FROM customer
LEFT OUTER JOIN orders on customer.custid = orders.custid;

SELECT customer.name, orders.saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;


--�μ� ����
--��������.
SELECT * FROM book;
SELECT * FROM orders;
--Q. ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders); --1.orders�� custid�� �� �ֹ��� ����� id�� �������ؼ��������� �ֹ����̷����ִ� custid.
--�װ��� ��������ؼ� �״����� ����.. 2.���ش�Ǵ� custid�� �̾���. 3.��Ŀ���͸� id�� �̸��� ���.. 1.�̰����߿���

--����7_1115 : '���ѹ̵��'���� ������ ������ ������ ���� �̸��� ���̽ÿ�.
--����7_1115 �ַ��
SELECT C.name ���̸�
FROM customer C, orders O
WHERE O.bookid = (SELECT bookid FROM book WHERE publisher = "���ѹ̵��");

--����7_1115 �ַ��
SELECT name
FROM customer 
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book
WHERE publisher = '���ѹ̵��'));

--����8_1115 : ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
--����8_1115 �ַ��
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(b2.price)
FROM book b2
WHERE b2.publisher = b1.publisher);

--����9_1115 : ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
--����9_1115 �ַ��
--�����밡 ������ �ֹ��� ���� ���� ������ �ֹ����� ���� ���� ����
SELECT name
FROM customer 
MINUS --����� MINUS
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders);

--����9_1115 �ַ��
--NOT IN �� ���...
SELECT name
FROM customer
WHERE custid NOt IN(SELECT custid FROM orders);

--����10_1115 : �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT name ���̸�, address �ּ�
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--������ Ÿ�� (Oracle. MariaDB�� �ٸ��͵��� 10�������� �ٸ� �� ����)
--������ (Numeric Types)
--NUMBER : ���� �������� ���� ������ Ÿ��. ����, �Ǽ�, ���� �Ҽ���, �ε� �Ҽ��� ���� ����
--������ (Character Types)
--VARCHAR2(size): ���� ���� ���ڿ��� ����. size�� �ִ� ���� ���̸� ����Ʈ�� ����
--NVARCHAR2(size)�� ����� ������ ���� ����Ʈ ���� ��� �׻� ���� ������ ũ�Ⱑ ����
--CHAR(size): ���� ���� ���ڿ��� ����. ������ ���̺��� ª�� ���ڿ��� �ԷµǸ� �������� �������� ä����
--��¥ �� �ð��� (Date and Time Types)
--DATE: ��¥�� �ð��� ����. ������ Ÿ���� ��, ��, ��, ��, ��, �ʸ� ����
--TIMESTAMP: ��¥�� �ð��� �� ���� ������ �������� ����
--���� �������� (Binary Data Types)
--BLOB: �뷮�� ���� �����͸� ����. �̹���, ����� ���� ���� �����ϴ� �� ����
--��Ը� ��ü�� (Large Object Types)
--CLOB: �뷮�� ���� �����͸� ����
--NCLOB: �뷮�� ������ ���� ���� �����͸� ����

--�������� : 
--PRIMARY KEY : �� ���� �����ϰ� �ĺ��ϴ� ��(�Ǵ� ������ ����). �ߺ��ǰų� NULL ���� ������� �ʴ´�.
--FOREIGN KEY : �ٸ� ���̺��� �⺻ Ű�� �����ϴ� ��. ���� ���Ἲ�� ����
--UNIQUE : ���� �ߺ��� ���� ����� ���� ����. NULL���� ���
--NOT NULL : ���� NULL ���� ������� �ʴ´�.
--CHECK : �� ���� Ư�� ������ �����ؾ� ���� ���� (��: age > 18)
--DEAFULT : ���� ������� ���� �������� ���� ��� ���� �⺻���� ����

----------------------------------
--DCL

--AUTHOR ���̺� ����
CREATE TABLE authors (
 id NUMBER PRIMARY KEY,
 first_name VARCHAR2(50) NOT NULL,
 last_name VARCHAR2(50) NOT NULL,
 nationality VARCHAR2(50)
);
DROP TABLE authors; --DROP ����! ���̺� ��°�� ���󰡴°���...

--Q. NEWBOOK�̶�� ���̺��� �����ϼ���.
CREATE TABLE newbook (
 book_id VARCHAR2(50) PRIMARY KEY,
 book_name VARCHAR2(50) NOT NULL,
 book_publisher VARCHAR2(50) NOT NULL,
 book_price NUMBER NOT NULL
);
DROP TABLE newbook; --���̺����
INSERT INTO newbook VALUES('00001_a_231115', '��մ� å', 'JamJam', '55000');
DESC newbook; --���̺� Ȯ��

CREATE TABLE newbook (
    bookid NUMBER,
    isbn NUMBER(13),
    bookname VARCHAR2(50) NOT NULL,
    author VARCHAR2(50) NOT NULL,
    publisher VARCHAR2(30) NOT NULL,
    price NUMBER DEFAULT 10000 CHECK(price>1000),
    published_date DATE,
    PRIMARY KEY(bookid)
);

DESC newbook; --���̺��� ������ �� �� ���� . describe �� ������ descent(��������)�� �򰥸��� X
--���̺� �������� ����, �߰�, �Ӽ�(column)�߰� ���� ����.
ALTER TABLE newbook MODIFY (isbn VARCHAR2(10)); --isbn�� number���� varchar2(10)�� �ٲ�a
ALTER TABLE newbook ADD author_id NUMBER; --�߰�
ALTER TABLE newbook DROP COLUMN author_id; --����
--�߰� ���� ���� �� ALTER �� �Ѵ�

--ON DELETE CASCADE �ɼ��� �����Ǿ� �־�, newcustomer ���̺��� � ���� ���ڵ尡 �����Ǹ�,
--�ش� ���� ��� �ֹ��� neworders ���̺����� �ڵ����� ����
--�����ͺ��̽����� '���Ἲ'�� �������� ��Ȯ��, �ϰ���, ��ȿ���� �����Ǵ� Ư���� ���մϴ�. 
--newcustomer ���̺� ����
CREATE TABLE newcustomer(
 custid NUMBER PRIMARY KEY,
 name VARCHAR2 (40),
 address VARCHAR2(40),
 phone VARCHAR2(30)
);

CREATE TABLE neworders(
 orderid NUMBER,
 custid NUMBER NOT NULL,
 bookid NUMBER NOT NULL,
 saleprice NUMBER,
 orderdate DATE,
 PRIMARY KEY(orderid),
 FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE --���� reference �����Ǿ �����Ͱ� ���� �����ǰԲ�..
);

CREATE TABLE test1(
 idk number
);
DROP TABLE test1;







--����11_1115 : 10���� �Ӽ����� �����Ǵ� ���̺� 2���� �ۼ��ϼ���.
--��, FOREIGN KEY�� �����Ͽ� ���� ���̺��� �����͸� ���� �� �ٸ� ���̺��� ���õǴ� �����͵� ��� �����ǵ��� �ϼ���. (��� ���� ������ ���)
--����11_1115 �ַ��
--���̺� ����

CREATE TABLE GimbabMenu(
 menu_id number NOT NULL UNIQUE,
 name varchar2(40) NOT NULL,
 price number NOT NULL CHECK(price>0)
);
--DROP TABLE GimbabMenu; --���̺����
DESC GimbabMenu;

CREATE TABLE GimbabOrders(
 order_id number NOT NULL,
 menu_id number NOT NULL UNIQUE,
 ordertime VARCHAR2(40),
 howmany number DEFAULT 1 CHECK(howmany>=1),
 forhere_togo varchar2(40) NOT NULL, -- CHECK(forhere_togo = ���� OR forhere_togo = ����) �̰� �ȵ�...
 PRIMARY KEY(order_id),
 FOREIGN KEY(menu_id) REFERENCES GimbabMenu(menu_id) ON DELETE CASCADE --�̷����ϸ� foreign key ������ ������ ��
);
DESC GimbabOrders;

--GimbabMenu, GimbabOrders ������ ����
--GimbabMenu �Ӽ� : menu_id, name, price
INSERT INTO GimbabMenu VALUES(001,'�⺻���','3000');
INSERT INTO GimbabMenu VALUES(002,'�����','2000');
INSERT INTO GimbabMenu VALUES(003,'��������ġ���','4000');
INSERT INTO GimbabMenu VALUES(004,'���ٸ����','5000');
INSERT INTO GimbabMenu VALUES(005,'������̱��','5000') ;
INSERT INTO GimbabMenu VALUES(006,'�ܹ������¾���','3000');

--GimbabOrders �Ӽ� : order_id, menu_id, ordertime, howmany, forhere_togo
INSERT INTO GimbabOrders VALUES(1, 001, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 2, '����');
INSERT INTO GimbabOrders VALUES(2, 006, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 1, '����');
INSERT INTO GimbabOrders VALUES(3, 002, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 4, '����');
INSERT INTO GimbabOrders VALUES(4, 003, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 2, '����');
INSERT INTO GimbabOrders VALUES(5, 004, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 1, '����');
INSERT INTO GimbabOrders VALUES(6, 005, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 1, '����');

--���̺� Ȯ��
SELECT * FROM gimbabmenu;
SELECT * FROM gimbaborders;



--���� 11 ���� ����--DCL, DML ��� Ȱ��.. 1117�� ����,, �������� db���¹�..-------------------------------------------
--����1_1116: ParentTable, ChildTable 2���� �ۼ��ϰ� �� ���̺��� �Ӽ��� 4��(������ Ÿ���� ��� �ٸ�)�� ���������� 5�� �̻� �����Ѵ�. �ִ��� �پ��ϰ�...
--����1_1116 �ַ��
--ParentTable�� �⺻Ű�� ���Ͽ� ChildTable�� �Ӽ��� �ϳ��� ������ �ϴ� �ܷ�Ű�� �����ϰ� Ư�� �����͸� �����ϸ� ��� ������ �ǵ��� �Ѵ�.
--�����ʹ� ���� 10���� �Է��ϰ� ������ �����Ѵ�.
--������ ��ü ��ȸ, ����, ���� ���� ���Ͽ� ���ϴ� �׷��� ���� �ݾ��� �����Ѵ�.
--VARCHAR2, CHAR, TIMESTAMP, DATE, NUMBER, [DECIMAL(�����ʿ��� ���� ��Ȯ�ϰԾ���..), FLOAT(�Ǽ�), INTEGER]
--���߿��� VARCHAR2, TIMESTAMP Ȥ��DATE, NUMBER ����..
--CREATE ParentTable

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




SELECT * FROM customer;
--Q. Customer ���̺��� ����ȣ�� 5�� ���� �ּҸ� '���ѹα� �λ�'���� �����Ͻÿ�.

--������ ����
UPDATE customer
SET address= '���ѹα� �λ�'
WHERE custid = 5;

--����12_1115 : Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
--����12_1115 ������ �ַ��
UPDATE customer
SET address = (
    SELECT address
    FROM customer
    WHERE name = '�迬��'
)
WHERE name = '�ڼ���';

--Ȯ��
select address, name
from customer;

--�ٽ� �λ����� ����
update customer
set address = '���ѹα� �λ�'
where name ='�ڼ���';


--������ ����
INSERT INTO customer VALUES(11, '�迬��', '����', '000-1111-0001');
--������ ����
DELETE customer
WHERE custid = 11;

SELECT * FROM customer;

--�ϴٰ� �������� �Ⱦ�...
SELECT * FROM neworders;
INSERT INTO neworders VALUES(1,10,10,10000,TO_DATE('2020-07-01','yyyy-mm-dd'));
desc neworders;

--10�� ����
DELETE book
WHERE bookid = 10;

--����13_1115 : 10���� �Ӽ����� ���� ���̺� ���� �� 5�� �����͸� ������ �� ������ ���Ͽ� ���� �� 2���� �����ϰ� ���� 3���� ����ϼ���.
--����13�� ��ŵ... 11������

--ABS�� ���밪
SELECT ABS(-78), ABS(+78) 
FROM dual;

--4.875 �� �ݿø� �Ϸ���?
SELECT ROUND(4.875, 1) --ROUND �� �ݿø�. (�ݿø��� ����, n°�ڸ��������ݿø�)
FROM dual;

--Q. ���� ��� �ֹ� �ݾ��� ��� �������� �ݿø��� ���� ���Ͻÿ�.
--�ַ��
--���̺� Ȯ��
SELECT * FROM orders;

--ROUND()�� �ݿø� AVG()�� ��հ�
SELECT custid AS ����ȣ, ROUND(AVG(saleprice), -2) AS ����ֹ��ݾ� --10���������� 100�������� �ٲ�°��� -2, 100�������� -2
FROM orders
GROUP BY custid;

--Q. ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� ���� ���, ������ ���̽ÿ�.
--�߱��� �� �󱸷� �ٲ�. replace�Լ��� ���. (column, �̰���, �̷���)
SELECT bookid, REPLACE(bookname, '��', '�߱�') bookname, publisher, price
FROM book;

--Q. '�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
--length�Լ��� ���ڼ�.. length�� b�� ����(���̳ʸ�) �ϸ� ����Ʈ��
SELECT bookname ����, length(bookname) ���ڼ�, lengthb(bookname) ����Ʈ��
FROM book
WHERE publisher = '�½�����';
--���� 5���ڼ����� ���ٸ�.. ����
SELECT * FROM customer;
INSERT INTO Customer VALUES (5, '�ڼ���', '���ѹα� ����', NULL);

--Q. ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� �������� �ο����� ���Ͻÿ�.
--���ֽ´� �ַ��. substr()�� ���. customer.name�� ù���ڸ� �׷����ϰ� ī���� �Ѱ��� ���
SELECT * FROM customer;
select substr(name,1,1), count(*) �ο�
from customer
group by substr(name,1,1);

--Q. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
--�ַ��
--table orders Ȯ��
SELECT * FROM orders;

SELECT orderdate AS "�ֹ���", orderdate + 10 AS "�ֹ��� Ȯ������"
FROM orders;

--�����δ� �ַ��
SELECT orderid, orderdate AS �ֹ���, orderdate + 10 AS Ȯ������
FROM orders;

--Q.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�.
--�� �ֹ����� 'yyyy-mm-dd ����' ���·� ǥ���Ѵ�.
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate, 'YYYY-mm-dd hh:mi:ss day') �ֹ���, custid ����ȣ, bookid ������ȣ --TO CHAR �� �ٲ��ֶ�
--TO�� �� ��. �ٲ�. �̷���. �׷��� TO_CHAR�� ��µ�, TO_DATE�� �ȵ�
--SELECT orderid �ֺй���, orderdate �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate = '2020-07-07';

desc orders;

SELECT SYSDATE FROM DUAL; --SYSDATE �� �ú��� ���� �� ������ ����
--Q. DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.
--�ַ��
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-mm-dd HH:MI:SS day') AS SYSDATE1 --���� mm, ���� mi �� �ؾ���..
FROM DUAL;


--Q. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� '����ó����'���� ǥ���Ͻÿ�.
--NVL �Լ��� ���� NYLL�� ��� �������� ����ϰ�, NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�. �Լ� : NVL("��","������")
SELECT name �̸�, NVL(phone, '����ó����') ��ȭ��ȣ
FROM customer;


--�̰� �����ϴ�.. �׳� �Ѿ����..
--�μ��� ������� ���ϰ� ó������ NULL�� �ƴ� ù ��° ���� ���� ���� ��ȯ�մϴ�.
--���� ��� SELECT COALESCE(NULL, NULL, 'third_value', 'fourth_value');
--�̰��� �� ��° ���� Null�� �ƴ� ù ���̱� ������ �� ��° ���� ��ȯ


select * from customer;
--Q. ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.
--�ַ��
SELECT custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
LIMIT 2;

--������� �ַ��
--rownum �� ����Ŭ���� �ڵ����� �����ϴ� ���� ���� ������ ����Ǵ� ���� �� �࿡ �Ϸù�ȣ�� �ڵ����� �Ҵ�.
SELECT rownum ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE rownum < 3; 

SELECT * FROM orders;
--Q. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
--�ַ�� ���� �߻�...
SELECT orderid, saleprice, AVG(saleprice) ��ձݾ�
FROM orders
WHERE saleprice < (select avg(saleprice) from orders)
GROUP BY *;

--�ַ��
select orderid, saleprice
from orders
where saleprice < (select avg(saleprice) from orders);

--Q. ���ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
--�����δ� �ַ��
SELECT * FROM customer;
SELECT SUM(saleprice) AS ���Ǹž�
FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');

--(')Ȭ����ǥ : ���ڿ��� �����ִ� ��ȣ
--(")�ֵ���ǥ : �÷��� ���� �����ִ� ��ȣ
--�÷����� ������ �ֵ���ǥ, ���ڿ��� Ȭ����ǥ !