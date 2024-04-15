--DML(Data Manipulation Language)
--데이터베이스에서 데이터를 조작하는 데 사용되는 SQL의 일부. 
--주로 INSERT, UPDATE, DELETE 문을 사용하여 데이터를 삽입, 수정, 삭제

--INSERT - 데이터 삽입
--새로운 데이터를 테이블에 추가할 때 사용
--UPDATE - 데이터 수정
--테이블의 기존 데이터를 수정할 때 사용
--DELETE - 데이터 삭제
--테이블에서 데이터를 삭제할 때 사용
--UPDATE와 DELETE 명령은 강력하므로 사용시 주의가 필요!!!
--특히 WHERE 절을 생략하면 테이블의 모든 행이 영향을 받을 수 있다.!!! WHERE안쓰면 테이블에 있는 데이터 다 날릴 수 있음. 돌이킬수 없음..
--테이블의 데이터를 변경하는 작업은 되돌릴 수 없으므로, 특히 중요한 데이터를 다룰 때는 신중하게 작업.
--데이터베이스의 무결성을 유지하기 위해 적절한 제약조건이 설정되어 있는지 확인!!!
--항상 조심하고 잘 다뤄야함.. 재확인 필요!


--madang user 생성
--4개의 테이블 생성 : book, customer, imported_book, orders

SELECT * FROM book;
SELECT * FROM customer;
SELECT * FROM imported_book;
SELECT * FROM orders;

SELECT * FROM book;
SELECT bookname, price FROM book;
SELECT publisher FROM book;
--중복 없이 출력
SELECT DISTINCT publisher FROM book;

--Q. 가격이 10,000원 이상인 도서를 검색하세요.
--솔루션
SELECT *
FROM book
WHERE price > 10000;

--과제1_1114: 가격이 10,000원 이상 20,000 이하인 도서를 검색하세요.(2가지 방법)
--솔루션1
SELECT *
FROM book
WHERE price >= 10000 AND price <= 20000;
--솔루션2
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;
--WHERE not price < 10000 AND price > 20000; --이거는 안됨..

--과제2_1114: 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오.(3가지 방법)
--솔루션1
SELECT *
FROM book
WHERE (publisher = '대한미디어') OR (publisher = '굿스포츠');
--솔루션2
SELECT *
FROM book
WHERE publisher IN ('대한미디어', '굿스포츠'); --IN 쓰면 그안에 있는것은 다 만족하는것임 , 로 쓰자
--솔루션3
SELECT * FROM book WHERE publisher = '대한미디어'
UNION --중복된 레코드를 제거하고 결과를 결합 --합집합은 union을 사용
SELECT * FROM book WHERE publisher = '굿스포츠';
--추가솔루션
--IN 을 활용
SELECT *
FROM book
WHERE '굿스포츠' IN publisher or '대한미디어' IN publisher;

SELECT *
FROM book
WHERE publisher IN ('굿스포츠', '대한미디어');

--NOT IN 을 활용
SELECT *
FROM book
WHERE publisher NOT IN ('나무수', '이상미디어', '삼성당', 'Pearson'); --not in 여기에 없는것

--과제2_1114 서영우님 솔루션
SELECT *
FROM book
WHERE  publisher IN ('굿스포츠','대한미디어')
;
SELECT *
FROM book
WHERE  publisher = '굿스포츠'
UNION
SELECT *
FROM book
WHERE  publisher = '대한미디어'
;

--과제3_1114: 도서이름에 '축구'가 포함된 출판사를 검색하시오.
--과제3_1114 솔루션
SELECT bookname, publisher FROM book
    WHERE bookname LIKE '%축구%'; --LIKE 는 해당되는거 검색..


--과제4_1114: 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오.
--과제4_1114 솔루션
SELECT bookname FROM book
    WHERE bookname LIKE '_구%';
--과제4_1114 윤성민님 솔루션
SELECT *
FROM book
WHERE SUBSTR(bookname, 2, 1) = '구';

--과제5_1114: 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
--과제5_1115 솔루션
SELECT bookname, price FROM book
WHERE bookname Like '%축구%' AND price >= 20000; --섞어서 사용~


--올림차순으로 나옴..(ASC가 생략)
SELECT *
FROM book
ORDER BY bookname; --python 에서 sort. 정렬 by 어떤기준? 여기선 bookname으로

--내림차순으로 정렬 DESC ..
SELECT *
FROM book
ORDER BY bookname DESC; --내림차순 DESC. 기준을 여러개 할 수 있음.

--과제6_1114: 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
--과제6_1114 솔루션
SELECT * FROM book
ORDER BY price DESC, bookname ASC; --같은price일대 bookname으로 sort가되는것
--간단한 솔루션
SELECT *
FROM book
ORDER BY price, bookname;


--과제7_1114: 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
--SELECT * FROM orders; --이것을 사용..
--과제7_1114 솔루션
SELECT * FROM orders;
--    WHERE custid = 2
--    GROUP custid
--    HAVING SUM(saleprice*orderid);


--과제7_1114 심주승님 솔루션
--sum했기에 group by 해야함
select customer.name, orders.custid, sum(orders.saleprice) 
from orders
inner join customer on orders.custid = customer.custid --inner join 교집합을 쓰는것임. orders.custid = customer.custid 이것이 공동키값
where orders.custid = 2
group by customer.name, orders.custid;

--과제7_1114 솔루션
SELECT SUM(saleprice) AS "총 판매액"
FROM orders
WHERE custid = 2;

--과제8_1114: 가격이 9,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
--단, 두 권 이상 구매한 고객만 구하시오.(GROUP BY, COUNT 를 사용)
--과제8_1114 솔루션
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

--과제8_1114 솔루션
--where먼저쓰고 having을 쓴다.. 순서 유의!
SELECT custid, COUNT(*) AS "도서수량"
FROM orders
WHERE saleprice >= 9000
GROUP BY custid
HAVING COUNT(*) >= 2; --where다음 또다른 조건을 할 때 having을 씀

--GROUP BY 절은 SQL에서 매우 중요한 개념으로, 데이터를 특정 기준에 따라 그룹화하는 데 사용
--이를 통해 집계 함수(예: SUM, AVG, MAX, MIN, COUNT 등)를 사용하여 각 그룹에 대한 집계 데이터를 계산
SELECT SUM(saleprice) AS total, --AS 는 알리어스, 별칭임. SUM(saleprice)한거를 total이라 부르겠다.
       AVG(saleprice) AS average,
       MIN(saleprice) AS minimum,
       MAX(saleprice) AS maximum
FROM orders;

SELECT * FROM orders;
--orderid 는 중복되면안됨.. 중복되면 신뢰할 수 없음..
--custid는 중복될수 있음 ~ 고객이 여러번 살수 있으니까.. 중복안되게하는것이 이상함
--bookid는 같은책 다른사람이 살수 잇으니 중복가능
--백화점 고객 10000명중 중요한 고객을 골라서 .. VIP 시스템 을 하려고 하면 어떻게 db에서 추출을 할까?
--구매스케일로 하기? sum - group by
--구매단가로 하기? 일회용품만 사는사람. 명품관에서 명품사는 사람.
--백화점에서는 매출을 많이 올릴 수있는데에 써야하기때문에 총량만보면안됨!!!!
--횟수대비 1회평균 이런걸 구하면 해당 고객의 구매스케일..... 여러가지 앵글로 각도로 데이터를 머니퓰레이션가능
--분석한 데이터로 인사이트를 도출
--왜 db, dml을 배우는지.....
--그랬을때 group by를 쓰면 다양한 고객별 탐색적분석을 할 수 있음
--이런식으로 approaching할 수있음
--평균금액, 구매횟수 등을 그룹별로 각각비교해서 보고......
--그러면 우리가 vip로 타겟할수 있는 그룹이 요고구나! 이렇게 되는것임
--vip보다는 제품개발해서 타겟을,,, 예를 들어 일회용품(햇반같은 쉽게 먹을수있는것을 개발하려고함)
--그럼 전체 data 필요없음. 해당되는 segement하면됨. 그거에 맞는 조건을 줘서 
--걔네들을 대해서만 딥다이브 하는것임

SELECT * FROM customer, book, orders, imported_book;

--과제8_1114: 가격이 9,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
--단, 두 권 이상 구매한 고객만 구하시오.(GROUP BY, COUNT 를 사용)
SELECT custid, COUNT(*) AS "도서수량", SUM(saleprice) AS "총 판매액" --공란이 있으면 따옴표로 묶어주고 그런거 아니면 안해줘도됨
FROM orders
GROUP BY custid;

--과제7_1114: 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
--HAVING 절은 SQL에서 GROUP BY 절과 함께 사용되어 그룹화된 결과에 조건을 적용하는 데 사용
--WHERE 절로 처리할 수 없는 경우에 사용
SELECT custid, COUNT(*) AS "도서수량", SUM(saleprice) AS "총 판매액"
FROM orders
WHERE bookid > 5
GROUP BY custid --그루핑을 먼저하고 그런다음 조건을 주는것.
HAVING COUNT(*) > 2; --그조건이 바로 having

SELECT * FROM orders;
SELECT * FROM customer;
--Q. 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오.
SELECT name AS "구매자 이름", SUM(saleprice) AS "총 구매액"
FROM customer, orders
GROUP BY name
ORDER BY name;



--과제1_1115. 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오
--과제1_1115 윤성민님 솔루션
SELECT
customer.custid AS 고객ID,
customer.name AS 고객이름,
customer.address AS 주소,
customer.phone AS 전화번호,
orders.orderid AS 주문ID,
orders.bookid AS 도서ID,
orders.saleprice AS 판매가격,
orders.orderdate AS 주문일자
FROM 
customer , orders
WHERE 
customer.custid = orders.custid 
ORDER BY 
customer.custid, orders.orderid;
--과제1_1115 윤성민님 솔루션에 * 사용
SELECT *
FROM customer , orders
WHERE customer.custid = orders.custid 
ORDER BY customer.custid;

--과제2_1115. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
--과제2_1115 이민지님 솔루션
SELECT customer.name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;

--과제3_1115. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
--과제3_1115 심주승님 솔루션
select customer.custid, customer.name, sum(orders.saleprice)
from customer
inner join orders on customer.custid = orders.custid
group by customer.custid, customer.name
order by customer.custid, customer.name;

--과제3_1115 솔루션
SELECT custid, SUM(saleprice) "총 판매액" --AS는 생략가능..
FROM orders
GROUP BY custid
ORDER BY custid;
--과제3_1115 솔루션 이름이나오게끔
SELECT name, SUM(saleprice) AS "총 판매액"
FROM customer C, orders O --이렇게 약어 설정을 해주고
WHERE C.custid = O.custid --밑에서 이렇게 쓸수 있음
GROUP BY C.name
ORDER BY C.name;
--custid가 customer에도 있고 orders에도 있기때문에 구분해주기 위해 저렇게 할수 있음.. AS는 생략가능


--과제4_1115. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
--과제4_1115 전유빈님 솔루션
SELECT customer.name, book.bookname
FROM orders
INNER JOIN customer ON orders.custid = customer.custid --join을 써서 두테이블을 합침
INNER JOIN book ON orders.bookid = book.bookid;

--과제4_1115 솔루션 WHERE 을 사용.
SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid=O.custid AND O.bookid = B.bookid;

--과제5_1115. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
--과제5_1115 주용규님 솔루션
SELECT 
(SELECT NAME FROM customer where custid = x.custid) "고객명",
(SELECT BOOKNAME FROM book where bookid = x.bookid) "책이름",
(SELECT PRICE FROM book where bookid = x.bookid) "책판매가",
x.saleprice "구입가격",
x.orderdate "구입날짜"
FROM orders x
WHERE bookid IN (SELECT BOOKID FROM BOOK WHERE price = 20000)
ORDER BY custid;

--과제5_1115 솔루션
SELECT C.name, B.bookname
FROM book B, customer C, orders O
WHERE C.custid = O.custid AND O.bookid=B.bookid AND B.price = 20000;

SELECT  name, saleprice FROM customer,orders
--JOIN은 두 개 이상의 테이블을 연결하여 관련된 데이터를 결합할 때 사용
--내부 조인 (INNER JOIN). 쉽게 생각하면교집합.
SELECT customer.name, orders.saleprice
FROM customer
INNER JOIN orders ON customer.custid=orders.custid; --select 뒤에 오는 테이블과 inner join 뒤에 오는 테이블을 합쳐주는데 on을 씀.

--왼쪽 외부 조인 (Left Outer Join) : 두 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
SELECT customer.name, orders.saleprice
FROM customer
LEFT OUTER JOIN orders ON customer.custid=orders.custid; --박세리 null 이름은 있는데 saleprice는 없어서 null로 뜸 이름은뜸\
--첫번재 테이블을 기준으로 해서 join


--오른쪽 외부 조인 (Right Outer Join) : 첫 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
SELECT customer.name, orders.saleprice
FROM customer
RIGHT OUTER JOIN orders ON customer.custid=orders.custid;
--join뒤에오는것을 기준으로해서 join


--FULL OUTER JOIN : 일치하는 데이터가 없는 경우 해당 테이블에서는 NULL 값이 사용
SELECT customer.name, orders.saleprice
FROM customer
FULL OUTER JOIN orders ON customer.custid=orders.custid;
--둘다 join


--CROSS JOIN : 두 테이블 간의 모든 가능한 조합을 생성
SELECT customer.name, orders.saleprice
FROM customer
CROSS JOIN orders;

--과제6_1115. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.(2가지 방법, WHERE, JOIN)
--과제6_1115 주용규님 솔루션
-- WHERE 방법
SELECT 
(SELECT NAME FROM customer where custid = x.custid) "고객명",
(SELECT bookname FROM book where bookid = x.bookid) "책이름",
(SELECT price FROM book WHERE bookid = x.bookid) "판매가격"
FROM orders x
UNION
SELECT 
name "고객명",
null "책이름",
null "판매가격"
FROM customer
WHERE 
custid NOT IN (SELECT DISTINCT(CUSTID) FROM orders)
ORDER BY "고객명";

-- JOIN 방법
SELECT C.NAME "고객명",
(SELECT BOOKNAME FROM BOOK WHERE BOOKID = D.BOOKID) "책이름",
(SELECT PRICE FROM BOOK WHERE BOOKID = D.BOOKID) "판매가격"
FROM
CUSTOMER C
LEFT OUTER JOIN ORDERS D
ON C.CUSTID = D.CUSTID
ORDER BY "고객명";

--과제6_1115 김신미님 솔루션 WHERE
SELECT C.name AS "고객명", B.bookname AS "도서명", O.saleprice AS "판매가격"
FROM customer C, orders O, book B
WHERE O.custid(+) = C.custid AND B.bookid(+) = O.bookid;
--과제6_1115 김신미님 솔루션 문제에 맞게..
SELECT C.name AS "고객명", O.saleprice AS "도서 판매가격"
FROM customer C, orders O
WHERE O.custid(+) = C.custid;

--과제6_1115 최재빈님 솔루션
SELECT name, saleprice
FROM customer
LEFT OUTER JOIN orders on customer.custid = orders.custid;

SELECT customer.name, orders.saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;


--부속 질의
--서브쿼리.
SELECT * FROM book;
SELECT * FROM orders;
--Q. 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders); --1.orders의 custid는 다 주문한 사람의 id임 쿼리를해서뽑은것은 주문한이력이있는 custid.
--그것을 기반으로해서 그다음을 진행.. 2.그해당되는 custid를 뽑아줘. 3.그커스터머 id의 이름을 출력.. 1.이것이중요함

--과제7_1115 : '대한미디어'에서 출판한 도서를 구매한 고객의 이름을 보이시오.
--과제7_1115 솔루션
SELECT C.name 고객이름
FROM customer C, orders O
WHERE O.bookid = (SELECT bookid FROM book WHERE publisher = "대한미디어");

--과제7_1115 솔루션
SELECT name
FROM customer 
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book
WHERE publisher = '대한미디어'));

--과제8_1115 : 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
--과제8_1115 솔루션
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(b2.price)
FROM book b2
WHERE b2.publisher = b1.publisher);

--과제9_1115 : 도서를 주문하지 않은 고객의 이름을 보이시오.
--과제9_1115 솔루션
--고객에대가 도서를 주문한 고객을 빼면 도서를 주문하지 않은 고객만 나옴
SELECT name
FROM customer 
MINUS --빼기는 MINUS
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders);

--과제9_1115 솔루션
--NOT IN 을 사용...
SELECT name
FROM customer
WHERE custid NOt IN(SELECT custid FROM orders);

--과제10_1115 : 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT name 고객이름, address 주소
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--데이터 타입 (Oracle. MariaDB나 다른것들은 10프로정도 다를 수 있음)
--숫자형 (Numeric Types)
--NUMBER : 가장 범용적인 숫자 데이터 타입. 정수, 실수, 고정 소수점, 부동 소수점 수를 저장
--문자형 (Character Types)
--VARCHAR2(size): 가변 길이 문자열을 저장. size는 최대 문자 길이를 바이트로 지정
--NVARCHAR2(size)의 사이즈를 지정할 때는 바이트 단위 대신 항상 문자 단위로 크기가 지정
--CHAR(size): 고정 길이 문자열을 저장. 지정된 길이보다 짧은 문자열이 입력되면 나머지는 공백으로 채워짐
--날짜 및 시간형 (Date and Time Types)
--DATE: 날짜와 시간을 저장. 데이터 타입은 년, 월, 일, 시, 분, 초를 포함
--TIMESTAMP: 날짜와 시간을 더 상세히 나노초 단위까지 저장
--이진 데이터형 (Binary Data Types)
--BLOB: 대량의 이진 데이터를 저장. 이미지, 오디오 파일 등을 저장하는 데 적합
--대규모 객체형 (Large Object Types)
--CLOB: 대량의 문자 데이터를 저장
--NCLOB: 대량의 국가별 문자 집합 데이터를 저장

--제약조건 : 
--PRIMARY KEY : 각 행을 고유하게 식별하는 열(또는 열들의 조합). 중복되거나 NULL 값을 허용하지 않는다.
--FOREIGN KEY : 다른 테이블의 기본 키를 참조하는 열. 참조 무결성을 유지
--UNIQUE : 열에 중복된 값이 없어야 함을 지정. NULL값이 허용
--NOT NULL : 열에 NULL 값을 허용하지 않는다.
--CHECK : 열 값이 특정 조건을 만족해야 함을 지정 (예: age > 18)
--DEAFULT : 열에 명시적인 값이 제공되지 않을 경우 사용될 기본값을 지정

----------------------------------
--DCL

--AUTHOR 테이블 생성
CREATE TABLE authors (
 id NUMBER PRIMARY KEY,
 first_name VARCHAR2(50) NOT NULL,
 last_name VARCHAR2(50) NOT NULL,
 nationality VARCHAR2(50)
);
DROP TABLE authors; --DROP 주의! 테이블 통째로 날라가는것임...

--Q. NEWBOOK이라는 테이블을 생성하세요.
CREATE TABLE newbook (
 book_id VARCHAR2(50) PRIMARY KEY,
 book_name VARCHAR2(50) NOT NULL,
 book_publisher VARCHAR2(50) NOT NULL,
 book_price NUMBER NOT NULL
);
DROP TABLE newbook; --테이블삭제
INSERT INTO newbook VALUES('00001_a_231115', '재밌는 책', 'JamJam', '55000');
DESC newbook; --테이블 확인

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

DESC newbook; --테이블의 내역을 볼 수 있음 . describe 의 약자임 descent(내림차순)과 헷갈리면 X
--테이블 제약조건 수정, 추가, 속성(column)추가 삭제 수정.
ALTER TABLE newbook MODIFY (isbn VARCHAR2(10)); --isbn을 number에서 varchar2(10)로 바뀜a
ALTER TABLE newbook ADD author_id NUMBER; --추가
ALTER TABLE newbook DROP COLUMN author_id; --삭제
--추가 삭제 수정 다 ALTER 로 한다

--ON DELETE CASCADE 옵션이 설정되어 있어, newcustomer 테이블에서 어떤 고객의 레코드가 삭제되면,
--해당 고객의 모든 주문이 neworders 테이블에서도 자동으로 삭제
--데이터베이스에서 '무결성'은 데이터의 정확성, 일관성, 유효성이 유지되는 특성을 말합니다. 
--newcustomer 테이블 생성
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
 FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE --참조 reference 연동되어서 데이터가 같이 삭제되게끔..
);

CREATE TABLE test1(
 idk number
);
DROP TABLE test1;







--과제11_1115 : 10개의 속성으로 구성되는 테이블 2개를 작성하세요.
--단, FOREIGN KEY를 적용하여 한쪽 테이블의 데이터를 삭제 시 다른 테이블의 관련되는 데이터도 모두 삭제되도록 하세요. (모든 제약 조건을 사용)
--과제11_1115 솔루션
--테이블 생성

CREATE TABLE GimbabMenu(
 menu_id number NOT NULL UNIQUE,
 name varchar2(40) NOT NULL,
 price number NOT NULL CHECK(price>0)
);
--DROP TABLE GimbabMenu; --테이블삭제
DESC GimbabMenu;

CREATE TABLE GimbabOrders(
 order_id number NOT NULL,
 menu_id number NOT NULL UNIQUE,
 ordertime VARCHAR2(40),
 howmany number DEFAULT 1 CHECK(howmany>=1),
 forhere_togo varchar2(40) NOT NULL, -- CHECK(forhere_togo = 매장 OR forhere_togo = 포장) 이거 안됨...
 PRIMARY KEY(order_id),
 FOREIGN KEY(menu_id) REFERENCES GimbabMenu(menu_id) ON DELETE CASCADE --이렇게하면 foreign key 이지만 삭제가 됨
);
DESC GimbabOrders;

--GimbabMenu, GimbabOrders 데이터 생성
--GimbabMenu 속성 : menu_id, name, price
INSERT INTO GimbabMenu VALUES(001,'기본김밥','3000');
INSERT INTO GimbabMenu VALUES(002,'김과밥','2000');
INSERT INTO GimbabMenu VALUES(003,'묵은지참치김밥','4000');
INSERT INTO GimbabMenu VALUES(004,'꼬다리김밥','5000');
INSERT INTO GimbabMenu VALUES(005,'계란말이김밥','5000') ;
INSERT INTO GimbabMenu VALUES(006,'단무지없는어묵김밥','3000');

--GimbabOrders 속성 : order_id, menu_id, ordertime, howmany, forhere_togo
INSERT INTO GimbabOrders VALUES(1, 001, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 2, '포장');
INSERT INTO GimbabOrders VALUES(2, 006, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 1, '매장');
INSERT INTO GimbabOrders VALUES(3, 002, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 4, '매장');
INSERT INTO GimbabOrders VALUES(4, 003, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 2, '포장');
INSERT INTO GimbabOrders VALUES(5, 004, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 1, '매장');
INSERT INTO GimbabOrders VALUES(6, 005, to_char(sysdate,'yyyy.mm.dd hh24:mi'), 1, '포장');

--테이블 확인
SELECT * FROM gimbabmenu;
SELECT * FROM gimbaborders;



--과제 11 이후 복습--DCL, DML 모두 활용.. 1117에 공유,, 종합적인 db쓰는법..-------------------------------------------
--과제1_1116: ParentTable, ChildTable 2개를 작성하고 각 테이블의 속성은 4개(데이터 타입은 모두 다름)로 제약조건은 5개 이상 적용한다. 최대한 다양하게...
--과제1_1116 솔루션
--ParentTable의 기본키에 대하여 ChildTable의 속성중 하나가 참조를 하는 외래키를 설정하고 특정 데이터를 삭제하면 모두 삭제가 되도록 한다.
--데이터는 각각 10개씩 입력하고 다음을 수행한다.
--데이터 전체 조회, 수정, 삭제 등을 통하여 원하는 그룹의 현금 금액을 도출한다.
--VARCHAR2, CHAR, TIMESTAMP, DATE, NUMBER, [DECIMAL(금육쪽에서 더욱 정확하게쓸때..), FLOAT(실수), INTEGER]
--이중에서 VARCHAR2, TIMESTAMP 혹은DATE, NUMBER 정도..
--CREATE ParentTable

--ENTERTAINMENT 테이블 생성
CREATE TABLE ENTERTAINMENT(
 ent_name VARCHAR2(40) PRIMARY KEY NOT NULL,
 Oday DATE NOT NULL,
 place VARCHAR2(100) NOT NULL,
 founder VARCHAR2(30) NOT NULL
);

DESC entertainment;

--ARTISTS 테이블 생성 
CREATE TABLE ARTISTS(
 ent_name VARCHAR2(40) NOT NULL,
 artist_name VARCHAR2(40) UNIQUE NOT NULL,
 num_members NUMBER(15) default 1,
 debut_day DATE NOT NULL,
 PRIMARY KEY (debut_day),
 FOREIGN KEY (ent_name) REFERENCES ENTERTAINMENT(ent_name) ON DELETE CASCADE
);

DESC artists;

--테이블 삭제
--DROP TABLE ENTERTAINMENT;
--DROP TABLE ARTISTS;

SELECT * FROM entertainment;
SELECT * FROM artists;

--데이터 생성
INSERT INTO entertainment VALUES('JYP', '1996-04-25', '서울 강동구', 'JYP');
INSERT INTO entertainment VALUES('SM', '1995-02-14', '서울 성동구', '이수만');
INSERT INTO entertainment VALUES('YG', '1998-02-24', '서울 마포구', '양현석');
INSERT INTO entertainment VALUES('HYBE', '2005-02-04', '서울 용산구', '방시혁');
INSERT INTO entertainment VALUES('STARSHIP', '2008-01-03', '서울 강남구', '서현주');
INSERT INTO entertainment VALUES('THEBLACKLABEL', '2016-03-17', '서울 마포구', '박홍준');
INSERT INTO entertainment VALUES('P NATION', '2018-10-29', '서울 강남구', 'PSY');
INSERT INTO entertainment VALUES('MNH', '2014-11-18', '서울 강남구', '이주섭');
INSERT INTO entertainment VALUES('FNC', '2006-12-14', '서울 강남구', '한성호');
INSERT INTO entertainment VALUES('fantagio', '1991-01-08', '서울 강남구', '나병준');
INSERT INTO entertainment VALUES('큐브엔터테인먼트', '2006-08-29', '서울 성동구', '홍승성');

SELECT * FROM entertainment;

INSERT INTO artists VALUES('JYP', 'TWICE', 9, '2015-10-20');
INSERT INTO artists VALUES('SM', 'f(x)', 4, '2009-09-05');
INSERT INTO artists VALUES('SM', 'Red Velvet', 5, '2014-08-01');
INSERT INTO artists VALUES('YG', 'BLACKPINK ', 4, '2016-08-08');
INSERT INTO artists VALUES('STARSHIP', 'IVE', 6, '2021-12-01');
INSERT INTO artists VALUES('THEBLACKLABEL', '전소미', 1, '2019-06-13');
INSERT INTO artists VALUES('P NATION', 'CRUSH', 1, '2012-05-01');
INSERT INTO artists VALUES('FNC', '엔플라잉', 5, '2015-05-20');
INSERT INTO artists VALUES('fantagio', '위키미키', 8, '2017-08-08');
INSERT INTO artists VALUES('큐브엔터테인먼트', '(여자)아이들', 5, '2018-05-02');

SELECT * FROM artists;
 
DELETE entertainment
WHERE ent_name = 'SM';

DELETE artists
WHERE ent_name = 'JYP';

SELECT * FROM entertainment;
SELECT * FROM artists;




SELECT * FROM customer;
--Q. Customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하시오.

--데이터 수정
UPDATE customer
SET address= '대한민국 부산'
WHERE custid = 5;

--과제12_1115 : Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
--과제12_1115 최재빈님 솔루션
UPDATE customer
SET address = (
    SELECT address
    FROM customer
    WHERE name = '김연아'
)
WHERE name = '박세리';

--확인
select address, name
from customer;

--다시 부산으로 변경
update customer
set address = '대한민국 부산'
where name ='박세리';


--데이터 삽입
INSERT INTO customer VALUES(11, '김연경', '수원', '000-1111-0001');
--데이터 삭제
DELETE customer
WHERE custid = 11;

SELECT * FROM customer;

--하다가 오류나서 안씀...
SELECT * FROM neworders;
INSERT INTO neworders VALUES(1,10,10,10000,TO_DATE('2020-07-01','yyyy-mm-dd'));
desc neworders;

--10번 삭제
DELETE book
WHERE bookid = 10;

--과제13_1115 : 10개의 속성값을 가진 테이블 생성 후 5개 데이터를 삽입한 후 각각에 대하여 수정 후 2개를 삭제하고 남은 3개를 출력하세요.
--과제13은 스킵... 11에서함

--ABS는 절대값
SELECT ABS(-78), ABS(+78) 
FROM dual;

--4.875 를 반올림 하려면?
SELECT ROUND(4.875, 1) --ROUND 로 반올림. (반올림할 숫자, n째자릿수까지반올림)
FROM dual;

--Q. 고객별 평균 주문 금액을 백원 단위까지 반올림한 값을 구하시오.
--솔루션
--테이블 확인
SELECT * FROM orders;

--ROUND()는 반올림 AVG()는 평균값
SELECT custid AS 고객번호, ROUND(AVG(saleprice), -2) AS 평균주문금액 --10원단위에서 100원단위로 바뀌는것이 -2, 100원단위는 -2
FROM orders
GROUP BY custid;

--Q. 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서 목록, 가격을 보이시오.
--야구가 다 농구로 바뀜. replace함수를 사용. (column, 이것을, 이렇게)
SELECT bookid, REPLACE(bookname, '농구', '야구') bookname, publisher, price
FROM book;

--Q. '굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
--length함수는 글자수.. length에 b를 붙임(바이너리) 하면 바이트수
SELECT bookname 제목, length(bookname) 글자수, lengthb(bookname) 바이트수
FROM book
WHERE publisher = '굿스포츠';
--만약 5번박세리가 없다면.. 실행
SELECT * FROM customer;
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전', NULL);

--Q. 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성씨별로 인원수를 구하시오.
--심주승님 솔루션. substr()을 사용. customer.name의 첫글자를 그루핑하고 카운팅 한것을 출력
SELECT * FROM customer;
select substr(name,1,1), count(*) 인원
from customer
group by substr(name,1,1);

--Q. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
--솔루션
--table orders 확인
SELECT * FROM orders;

SELECT orderdate AS "주문일", orderdate + 10 AS "주문의 확정일자"
FROM orders;

--윤성민님 솔루션
SELECT orderid, orderdate AS 주문일, orderdate + 10 AS 확정일자
FROM orders;

--Q.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오.
--단 주문일은 'yyyy-mm-dd 요일' 형태로 표시한다.
SELECT orderid 주문번호, TO_CHAR(orderdate, 'YYYY-mm-dd hh:mi:ss day') 주문일, custid 고객번호, bookid 도서번호 --TO CHAR 로 바꿔주라
--TO는 로 해. 바꿔. 이런뜻. 그래서 TO_CHAR로 썼는데, TO_DATE는 안됨
--SELECT orderid 주분번보, orderdate 주문일, custid 고객번호, bookid 도서번호
FROM orders
WHERE orderdate = '2020-07-07';

desc orders;

SELECT SYSDATE FROM DUAL; --SYSDATE 는 시분초 까지 다 가지고 있음
--Q. DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.
--솔루션
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-mm-dd HH:MI:SS day') AS SYSDATE1 --월은 mm, 분은 mi 로 해야함..
FROM DUAL;


--Q. 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시하시오.
--NVL 함수는 값이 NYLL인 경우 지정값을 출력하고, NULL이 아니면 원래 값을 그대로 출력한다. 함수 : NVL("값","지정값")
SELECT name 이름, NVL(phone, '연락처없음') 전화번호
FROM customer;


--이건 복잡하니.. 그냥 넘어가도됨..
--인수를 순서대로 평가하고 처음으로 NULL이 아닌 첫 번째 식의 현재 값을 반환합니다.
--예를 들어 SELECT COALESCE(NULL, NULL, 'third_value', 'fourth_value');
--이것은 세 번째 값이 Null이 아닌 첫 값이기 때문에 세 번째 값을 반환


select * from customer;
--Q. 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.
--솔루션
SELECT custid 고객번호, name 이름, phone 전화번호
FROM customer
LIMIT 2;

--서영우님 솔루션
--rownum 은 오라클에서 자동으로 제공하는 가상 열로 쿼리가 진행되는 동안 각 행에 일련번호를 자동으로 할당.
SELECT rownum 순번, custid 고객번호, name 이름, phone 전화번호
FROM customer
WHERE rownum < 3; 

SELECT * FROM orders;
--Q. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
--솔루션 오류 발생...
SELECT orderid, saleprice, AVG(saleprice) 평균금액
FROM orders
WHERE saleprice < (select avg(saleprice) from orders)
GROUP BY *;

--솔루션
select orderid, saleprice
from orders
where saleprice < (select avg(saleprice) from orders);

--Q. 대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
--윤성민님 솔루션
SELECT * FROM customer;
SELECT SUM(saleprice) AS 총판매액
FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%대한민국%');

--(')홑따옴표 : 문자열을 감싸주는 기호
--(")쌍따옴표 : 컬럼명 등을 감싸주는 기호
--컬럼명을 쓸때는 쌍따옴표, 문자열은 홑따옴표 !