--과제1_1115. 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오

--Q. 가격이 10,000원 이상인 도서를 검색하세요.
SELECT *
FROM book
WHERE price > 10000;

--과제1_1114: 가격이 10,000원 이상 20,000 이하인 도서를 검색하세요.(2가지 방법)
SELECT *
FROM book
WHERE price >= 10000 AND price <= 20000;

--2nd solution
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

--과제2_1114: 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오.(3가지 방법)
--솔루션1
SELECT *
FROM book
WHERE publisher = '굿스포츠' OR publisher = '대한미디어';

--2
SELECT *
FROM book
WHERE publisher IN ('굿스포츠', '대한미디어');

--3
SELECT * FROM BOOK;

SELECT *
FROM book
WHERE publisher NOT IN ('나무수', '이상미디어', '삼성당', 'Pearson');


--과제3_1114: 도서이름에 '축구'가 포함된 출판사를 검색하시오.
--과제3_1114 솔루션
SELECT bookname, publisher
FROM book
WHERE bookname like '%축구%';

--과제4_1114: 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오.
--과제4_1114 솔루션
SELECT bookname, publisher
FROM book
WHERE bookname like '_구%';

--과제5_1114: 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
--과제5_1115 솔루션
SELECT bookname, price
FROM book
WHERE bookname like '%축구%' AND price >= 20000;

--내림차순
SELECT *
FROM book
ORDER BY price DESC;

--오름차순 디폴트
SELECT *
FROM book
ORDER BY price ASC;

--과제6_1114: 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
--과제6_1114 솔루션
SELECT bookname, price
FROM book
ORDER BY price, bookname;

--과제7_1114: 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
--SELECT * FROM orders; --이것을 사용..
--과제7_1114 솔루션
SELECT *
FROM book, customer, orders;

SELECT SUM(saleprice)
FROM orders
WHERE custid = 2
GROUP BY custid;

--과제8_1114: 가격이 9,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
--단, 두 권 이상 구매한 고객만 구하시오.(GROUP BY, COUNT 를 사용)
--과제8_1114 솔루션 --내가 했는데 오류남
SELECT custid, COUNT(*)
FROM orders
GROUP BY custid
HAVING saleprice >= 9000 AND (SELECT orderid FROM orders WHERE orderid >2 );


--과제8_1114 솔루션 --잘됨!
--where먼저쓰고 having을 쓴다.. 순서 유의!
SELECT custid, COUNT(*) AS "도서수량"
FROM orders
WHERE saleprice >= 9000
GROUP BY custid
HAVING COUNT(*) >= 2; --where다음 또다른 조건을 할 때 having을 씀

select * from orders;


--과제8_1114: 가격이 9,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
--단, 두 권 이상 구매한 고객만 구하시오.(GROUP BY, COUNT 를 사용)
SELECT custid, COUNT(*) AS "도서수량", SUM(saleprice) AS "총 판매액" --공란이 있으면 따옴표로 묶어주고 그런거 아니면 안해줘도됨
FROM orders
GROUP BY custid;



--심주승님 과제 11 솔루션. 테이블 만들기
create table mart(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , frequency number -- 방문 빈도
    , amount_num number
    , amount_price number
    , parking varchar2(20) -- 주차여부
    , family number -- 가족 구성원 수
);

alter table mart drop column amount_num;
alter table mart modify (name varchar2(20));
alter table mart modify (phone varchar2(100));

insert into mart values(1, '고길동', 32, '남', '010-1234-1234', '서울 강남', 5, 1500000, 'N', 3);
insert into mart values(2, '손흥민', 31, '남', '010-7777-1234', '강원 춘천', 5, 200000000, 'Y', 4);
insert into mart values(3, '이순신', 57, '남', '010-1592-1234', '경남 통영', 5, 270000, 'N', 1);
insert into mart values(4, '아이유', 30, '여', '010-0516-1234', '서울 서초', 5, 750000000, 'Y', 4);

select * from mart;


create table department(
    vipid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , use_store varchar2(100) -- 자주 찾는 매장
    , amount_num number
    , amount_price number
    , valet varchar2(20) -- 발렛파킹 서비스 사용여부
    , rounge varchar2(20) -- vip 라운지 사용여부
    , foreign key (vipid) references mart(custid) delete on cascade
);

alter table department modify (amount_price check (amount_price > 100000000));
alter table department modify (rounge default 'Y');
alter table department modify (valet default 'Y');
alter table department modify (phone varchar2(100));
alter table department drop column amount_num;
alter table department add (custid number);

insert into department values(1, '손흥민', 31, '남', '010-7777-1234', '강원 춘천', 'LV', 900000000,'','');
insert into department values(2, '아이유', 30, '여', '010-0516-1234', '서울 서초', 'GUCCI', 1500000000,'','',4);

update department
set valet = ''
where vipid = 1;

delete from department
where custid = 4;

select * from department;





--과제 11 전유빈님 솔루션

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
phone CHAR(13) DEFAULT '000-0000-0000', --phone number는 거의 fix된 거기때문에 13자리 로해서 char 로 datatype을 함
PRIMARY KEY(studentnumber),
FOREIGN KEY(schoolid) REFERENCES school(schoolid) ON DELETE CASCADE);

DESC student;

ALTER TABLE school MODIFY(schooltype VARCHAR2(20)); --원래는 10 이었는데(단위 byte) 한글은 1개당 3바이트여서... 수정(MODIFY)
INSERT INTO school VALUES(1,'개화','초등학교','부산진구 개금동', 1000,'아무개',36,50,1080,'1955-01-01');
INSERT INTO school VALUES(2,'개원','초등학교','부산진구 당감동',1200,'김누구',48,60,1920,'1996-01-01');
INSERT INTO school VALUES(3,'분포','초등학교','부산남구 용호동',1100,'이누구',36,50,1080,'2001-01-01');
INSERT INTO school VALUES(4,'분포','중학교','부산남구 용호동',1000,'박누구',30,40,800,'2002-01-01');
INSERT INTO school VALUES(5,'분포','고등학교','부산남구 용호동',1000,'조누구',20,30,600,'2002-01-01');
SELECT * FROM school;

ALTER TABLE student MODIFY(schooltype VARCHAR2(20));
INSERT INTO student VALUES(1,'개화','초등학교',1,3,20,'정누구','부산진구 개금동','jsldk@naver.com','');
INSERT INTO student VALUES(1,'개화','초등학교',2,3,24,'한누구','부산진구 당감동','lkjq@gmail.com',DEFAULT);
INSERT INTO student VALUES(2,'개원','초등학교',6,1,10,'전누구','부산진구 당감동','poir@naver.com','010-1234-1234');
INSERT INTO student VALUES(3,'분포','초등학교',4,3,21,'황누구','부산진구 용호동','',DEFAULT);
INSERT INTO student VALUES(4,'분포','중학교',3,2,1,'민누구','부산진구 용호동','','010-987-6543');

DELETE school
WHERE schoolid = 1; -- cascade를 통해서 이걸 run 하면 같이지워지게됨.

DELETE student
WHERE schoolid = 2;

SELECT * FROM school;
SELECT * FROM student;


--연습....
--------------------------------------------------------------------
--과제1_1116: ParentTable, ChildTable 2개를 작성하고 각 테이블의 속성은 4개(데이터 타입은 모두 다름)로 제약조건은 5개 이상 적용한다. 최대한 다양하게...
--과제1_1116 솔루션
--ParentTable의 기본키에 대하여 ChildTable의 속성중 하나가 참조를 하는 외래키를 설정하고 특정 데이터를 삭제하면 모두 삭제가 되도록 한다.
--데이터는 각각 10개씩 입력하고 다음을 수행한다.
--데이터 전체 조회, 수정, 삭제 등을 통하여 원하는 그룹의 현금 금액을 도출한다.
--VARCHAR2, CHAR, TIMESTAMP, DATE, NUMBER, [DECIMAL(금육쪽에서 더욱 정확하게쓸때..), FLOAT(실수), INTEGER]
--이중에서 VARCHAR2, TIMESTAMP 혹은DATE, NUMBER 정도..

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


 




















