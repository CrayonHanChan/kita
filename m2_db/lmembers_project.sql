--�� ���̺� �� �ʵ�� ������ �����Դϴ�.
--========================================
select * from channel;         -- ���޻�, ����ȣ, �̿�Ƚ��
select * from compet;         -- ���޻�, ����ȣ, �����, �̿���
select * from custdemo;      --        ����ȣ, ����, ���ɴ�, ��������
select * from member;        --        ����ȣ, ����ʸ�, ���Գ��
select * from prodcls;          -- ���޻�,                     ��з��ڵ�, �ߺз��ڵ�, �Һз��ڵ�, �ߺз���, �Һз���
select * from purprod;        -- ���޻�,          ��������ȣ, ��з��ڵ�, �ߺз��ڵ�, �Һз��ڵ�, ����ȣ, �����ڵ�, ��������, ���Žð�, ���űݾ�

-- ���հ��� : LMEMBERS �����ͼ��� Ž���Ͽ� ���� ū �̽�(�ٰż���)�� ã�Ƽ� �� ��å�� �����ϼ���.
-- ���� : ���Ű��� �� ����(14�� ��ݱ� ��� 15�� �Ϲݱ�) �� ���� ���
-- �м� ��� ����Ʈ�� PPT�� �ۼ� ��ǥ
-- [Point] ��ǰ���� ������ �ݵ�� ����, ���� ���� �̽��� ����

--�� �̿�Ƚ�� ī��Ʈ.
---1�� �̿�� 1535, 2�� 892, 3�� 616, ... 10�� 226..
--lmembers���� ���� ū �̽��� ����? 2014-2015�߿� ���� �̿��� ��.(��ǻ� �޸���̵�) �� ������ �� �����°�?
--�� �̽��� �ذ��ϴ� ������ ����?
--���� ���忡��.. 1���̳� 2�������� ���� �̿��� ���� �����°��� ���� �Ͱ���.
select "�̿�Ƚ��", count("�̿�Ƚ��")
from channel
where "�̿�Ƚ��" > 0
group by "�̿�Ƚ��"
order by count("�̿�Ƚ��") desc;

--lmembers �� ���޻� ���� �� �̿�Ƚ�� 119,736
select sum(sum(�̿�Ƚ��))
from channel
group by �̿�Ƚ��;

--�켱 �̿�Ƚ���� �������� �з��� ������ Ȯ���غ��°��� �����Ͱ���.
--�����纰 �� �̿�Ƚ��
select "���޻�", count("�̿�Ƚ��")
from channel
group by "���޻�"
order by count("�̿�Ƚ��") desc;

--�� ���� 6766��
select "����ȣ", count(*)
from channel
where "����ȣ" > 0
group by "����ȣ";

--���� ���� �̿���Ƚ�� 5��.(��3��), 4���� 15��.. �����Ͱ� �̻��ؼ� �ٽ� Ȯ���ʿ�
select channel."����ȣ", count(channel."����ȣ")
from compet, channel
--where channel.���޻� = compet.���޻� 
group by channel."����ȣ"
order by count(channel."����ȣ") desc;

--�� ���������� �̿�Ƚ�� ����;;
select "����", count("����")
from custdemo
group by "����"
order by count("����");

--���ɴ뺰 �̿�Ƚ��.. �ߺ��� ����... ���� �����ʿ�
select custdemo."���ɴ�", count(custdemo."���ɴ�")
from custdemo
group by custdemo."���ɴ�"
order by custdemo."���ɴ�";

--�� ���������� ���� �̿�Ƚ�� �̰͵� �ߺ�����..
select "��������", count("��������")
from custdemo
group by "��������"
order by count("��������") desc;

--����� ���� �̿�Ƚ��.. �ߺ����� �����ʿ�
--���̸�Ʈ �ӽ� �ٵ��� ���� ���� ���� ���.
--���̸�Ʈ�� 4418�� �����̻�. �״��� �ٵ��� 2009.
--�ӽ��� ������ ���ؼ� 1000�����ۿ��ȵǾ �̽��� ����. �÷�����
select ����ʸ�, count("����ʸ�")
from member
group by "����ʸ�";

--����纰 
select �����, count("�����")
from compet
group by �����
order by count("�����") desc;

SELECT *
FROM compet



select *
from compet;

--ä�� ���̺����� ���޻�� ������� �̿��� ���� �̱�
--�׸��� �̿��� ���� ���� ���� ���޻�� ������ ���ؼ� 
select * from channel;

select * from member;

--������. ���������� � �̽����� ������ ���;���
--������ �ɰ��� ��ǰ�� �� ���ɼ��� ����. ��ǰ�� �� ����
--4�б�γ�����(14�� 14�� 14�� 14��)
--�̽��� ����..
--�����͸� �м��ϰ� �� �ȿ��� �̽��� ã�ƾ���
--���� ���, ���Ű��� �� ����(14�� ��ݱ� ��� 15�� �Ϲݱ�) �� ���� ���
--�� �ٸ� ���� �����͸� �̰����� �̾ƺ��鼭 �а� �����͸� ã�ƺ���
--�������� ���ص�.. �б⺰, ���̴뺰, ����, ��ǰ��, ����������... Ȥ��, �������� ���� �͵� ���ַ�..
--���� ���ص��� ���ĺ��ų� �����ų� �ϸ鼭 �����͸� �м� ���� �غ���.
--Ư�� pruprod �� ���ڵ�� �Բ� �������� ���Žð� ���űݾװ� �����Ǿ��ֱ� ������ �̰����� ���� �� �� ��������
--���Žð��� ���� ����, ���� �ݾ��� ������ �� �� ������.
--Ȥ��... �ѱ������� ���� ������.. Ȥ�� ��������� ���� Ƚ���� ���� �̿���... �׺е��� �������ڸ� Ȯ���� ����,
--�� �������ڸ� ����� ���Գ���ε� ���غ��� �б⺰�� ������ ���� �ð��� �������⵵ �ϰ�,
--������������ member���Գ��
--������� �̿����� �˾ƺ��� 
select *
from purprod;

--�б⺰�� purprod ����
SELECT *
FROM PURPROD
WHERE
  ("��������" BETWEEN '20140101' AND '20140630')
  OR
  ("��������" BETWEEN '20140701' AND '20141231')
  OR
  ("��������" BETWEEN '20150101' AND '20150630')
  OR
  ("��������" BETWEEN '20150701' AND '20151231');

--�б⺰�� purprod �������� ���Žð� ���űݾ� ����
SELECT
    CASE
        WHEN "��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
        WHEN "��������" BETWEEN '20140701' AND '20141231' THEN '2014�� �Ϲݱ�'
        WHEN "��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
        WHEN "��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
        ELSE '��Ÿ'
    END AS "�б�",
    "��������",
    "���Žð�",
    "���űݾ�"
FROM purprod
WHERE
    ("��������" BETWEEN '20140101' AND '20140630')
    OR
    ("��������" BETWEEN '20140701' AND '20141231')
    OR
    ("��������" BETWEEN '20150101' AND '20150630')
    OR
    ("��������" BETWEEN '20150701' AND '20151231');


--���Žð� min max avg ����
select min(���Žð�), max(���Žð�), avg(���Žð�)
from purprod;

--purprod ���Žð� ��ħ�������� �׿� �߰� ���� ���� ����
SELECT
    CASE
        WHEN "���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
        WHEN "���Žð�" BETWEEN 12 AND 17 THEN '����'
        WHEN "���Žð�" BETWEEN 18 AND 21 THEN '����'
        ELSE '�߰�'
    END AS "�ð���",
    COUNT(*) AS "���ŰǼ�"
FROM purprod
GROUP BY
    CASE
        WHEN "���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
        WHEN "���Žð�" BETWEEN 12 AND 17 THEN '����'
        WHEN "���Žð�" BETWEEN 18 AND 21 THEN '����'
        ELSE '�߰�'
    END
ORDER BY
    CASE
        WHEN "���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
        WHEN "���Žð�" BETWEEN 12 AND 17 THEN '����'
        WHEN "���Žð�" BETWEEN 18 AND 21 THEN '����'
        ELSE '�߰�'
    END;

--"purprod" ���̺��� �б⺰�� ����� ��ħ, ����, ����, �߰� �ð��뺰 ���ŰǼ��� ��ȸ + �б⺰�ջ�����
--2014���ݱ� ���� 2015�� ��ݱ���� ��ħ��������߰� �� ���ŰǼ��� �ôٰ�.
--2015�� �Ϲݱ⿡ ���ڱ� �϶�����.
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            WHEN "��������" BETWEEN '20140701' AND '20141231' THEN '2014�� �Ϲݱ�'
            WHEN "��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
            WHEN "��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        CASE
            WHEN "���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
            WHEN "���Žð�" BETWEEN 12 AND 17 THEN '����'
            WHEN "���Žð�" BETWEEN 18 AND 21 THEN '����'
            ELSE '�߰�'
        END AS "�ð���"
    FROM purprod
    WHERE
        ("��������" BETWEEN '20140101' AND '20140630')
        OR
        ("��������" BETWEEN '20140701' AND '20141231')
        OR
        ("��������" BETWEEN '20150101' AND '20150630')
        OR
        ("��������" BETWEEN '20150701' AND '20151231')
)
SELECT
    "�б�",
    "�ð���",
    COUNT(*) AS "���ŰǼ�",
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "�ð���"
ORDER BY "�б�", "�ð���";


--���űݾ� min max avg
select min(���űݾ�), max(���űݾ�), avg(���űݾ�)
from purprod;


--���űݾ��� ����ȭ�� ����� ���� �б⺰, �ð��뺰 ���ŰǼ� �� �б⺰ �ջ� ���ŰǼ��� �����ִ� ������
--���� �ð���(12:00-17:00)�� ���ŰǼ��� ���� ����
--�׷��� ��ħ(06:00-11:00)�� ����(18:00-21:00) �ð��뿡�� ����� ���ŰǼ��� ����
--1000-5000�� ������ 5000-10000�� ������ ���ŰǼ��� ���� ����
--�� ���� �ݾ״�(10000�� �̻�)�� ���ŰǼ��� ����� ����
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            WHEN "��������" BETWEEN '20140701' AND '20141231' THEN '2014�� �Ϲݱ�'
            WHEN "��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
            WHEN "��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        CASE
            WHEN "���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
            WHEN "���Žð�" BETWEEN 12 AND 17 THEN '����'
            WHEN "���Žð�" BETWEEN 18 AND 21 THEN '����'
            ELSE '�߰�'
        END AS "�ð���",
        CASE
            WHEN "���űݾ�" BETWEEN 0 AND 1000 THEN '0-1000'
            WHEN "���űݾ�" BETWEEN 1000 AND 5000 THEN '1000-5000'
            WHEN "���űݾ�" BETWEEN 5000 AND 10000 THEN '5000-10000'
            WHEN "���űݾ�" BETWEEN 10000 AND 20000 THEN '10000-20000'
            WHEN "���űݾ�" BETWEEN 20000 AND 50000 THEN '20000-50000'
            WHEN "���űݾ�" BETWEEN 50000 AND 200000 THEN '50000-200000'
            WHEN "���űݾ�" BETWEEN 200000 AND 1000000 THEN '200000-1000000'
            WHEN "���űݾ�" BETWEEN 1000000 AND 10000000 THEN '1000000-10000000'
            ELSE '�׿�'
        END AS "���űݾ׺з�"
    FROM purprod
    WHERE
        ("��������" BETWEEN '20140101' AND '20140630')
        OR
        ("��������" BETWEEN '20140701' AND '20141231')
        OR
        ("��������" BETWEEN '20150101' AND '20150630')
        OR
        ("��������" BETWEEN '20150701' AND '20151231')
)
SELECT
    "�б�",
    "�ð���",
    "���űݾ׺з�",
    COUNT(*) AS "���ŰǼ�",
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "�ð���", "���űݾ׺з�"
ORDER BY "�б�", "�ð���", "���űݾ׺з�";

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
select * from prodcls;


--��ǰ�� �б⺰�� ������ �������� �ۼ�
--# ���޻纰 �Һз� ����Ʈ ('A,B,C,D')

SELECT
    "���޻�",
    CONCAT("��з��ڵ�", "�ߺз��ڵ�") AS "A1 �ڵ�",
    "�ߺз���",
    "�Һз���"
FROM prodcls;


-- A ���޻翡 ���� �Һз� ����Ʈ (���̸�Ʈ)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '���̸�Ʈ')
    AND PP.���޻� IN ('A') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC;
    
    
-- B ���޻翡 ���� �Һз� ����Ʈ (���̸�Ʈ)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '���̸�Ʈ')
    AND PP.���޻� IN ('B') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC;


-- C ���޻翡 ���� �Һз� ����Ʈ (���̸�Ʈ)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '���̸�Ʈ')
    AND PP.���޻� IN ('C') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC;
    

-- D ���޻翡 ���� �Һз� ����Ʈ (���̸�Ʈ)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '���̸�Ʈ')
    AND PP.���޻� IN ('D') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC;
--#=====================================================================


-- A ���޻翡 ���� �Һз� ����Ʈ (�ӽ�)  
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '�ӽ�')
    AND PP.���޻� IN ('A') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC; 
    
    
-- B ���޻翡 ���� �Һз� ����Ʈ (�ӽ�)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '�ӽ�')
    AND PP.���޻� IN ('B') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC; 
    
    
-- C ���޻翡 ���� �Һз� ����Ʈ (�ӽ�)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '�ӽ�')
    AND PP.���޻� IN ('C') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC; 
    
    
-- D ���޻翡 ���� �Һз� ����Ʈ (�ӽ�)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '�ӽ�')
    AND PP.���޻� IN ('D') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC;     
--#=====================================================================


-- A ���޻翡 ���� �Һз� ����Ʈ (����)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '����')
    AND PP.���޻� IN ('A') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC;    


-- B ���޻翡 ���� �Һз� ����Ʈ (����)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '����')
    AND PP.���޻� IN ('B') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC;    


-- C ���޻翡 ���� �Һз� ����Ʈ (����)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '����')
    AND PP.���޻� IN ('C') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC;    
    
    
  -- D ���޻翡 ���� �Һз� ����Ʈ (����)  
 SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '����')
    AND PP.���޻� IN ('D') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC;       
--#=====================================================================


-- A ���޻翡 ���� �Һз� ����Ʈ (�ٵ���)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '�ٵ���')
    AND PP.���޻� IN ('A') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC;  
    
    
-- B ���޻翡 ���� �Һз� ����Ʈ (�ٵ���)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '�ٵ���')
    AND PP.���޻� IN ('B') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC; 
    

-- C ���޻翡 ���� �Һз� ����Ʈ (�ٵ���)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '�ٵ���')
    AND PP.���޻� IN ('C') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC; 


-- D ���޻翡 ���� �Һз� ����Ʈ (�ٵ���)
SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    COUNT(*) AS ���ŰǼ�
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE
    PP.����ȣ IN (SELECT ����ȣ FROM member WHERE ����ʸ� = '�ٵ���')
    AND PP.���޻� IN ('D') 
GROUP BY
    PP.���޻�, PP.�Һз��ڵ�, PC.�Һз���
ORDER BY
    PP.���޻�, ���ŰǼ� DESC; 


----
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN p."��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            WHEN p."��������" BETWEEN '20140701' AND '20141231' THEN '2014�� �Ϲݱ�'
            WHEN p."��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
            WHEN p."��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        CASE
            WHEN p."���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
            WHEN p."���Žð�" BETWEEN 12 AND 17 THEN '����'
            WHEN p."���Žð�" BETWEEN 18 AND 21 THEN '����'
            ELSE '�߰�'
        END AS "�ð���",
        CASE
            WHEN p."���űݾ�" BETWEEN 0 AND 1000 THEN '0-1000'
            WHEN p."���űݾ�" BETWEEN 1000 AND 5000 THEN '1000-5000'
            WHEN p."���űݾ�" BETWEEN 5000 AND 10000 THEN '5000-10000'
            WHEN p."���űݾ�" BETWEEN 10000 AND 20000 THEN '10000-20000'
            WHEN p."���űݾ�" BETWEEN 20000 AND 50000 THEN '20000-50000'
            WHEN p."���űݾ�" BETWEEN 50000 AND 200000 THEN '50000-200000'
            WHEN p."���űݾ�" BETWEEN 200000 AND 1000000 THEN '200000-1000000'
            WHEN p."���űݾ�" BETWEEN 1000000 AND 10000000 THEN '1000000-10000000'
            ELSE '�׿�'
        END AS "���űݾ׺з�",
        p."��з��ڵ�",
        p."�ߺз��ڵ�",
        p."�Һз��ڵ�"
    FROM purprod p
    WHERE
        (p."��������" BETWEEN '20140101' AND '20140630')
        OR
        (p."��������" BETWEEN '20140701' AND '20141231')
        OR
        (p."��������" BETWEEN '20150101' AND '20150630')
        OR
        (p."��������" BETWEEN '20150701' AND '20151231')
)
SELECT
    "�б�",
    "�ð���",
    "��з��ڵ�",
    "�ߺз��ڵ�",
    "�Һз��ڵ�",
    "���űݾ׺з�",
    COUNT(*) AS "���ŰǼ�",
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "�ð���", "��з��ڵ�", "�ߺз��ڵ�", "�Һз��ڵ�", "���űݾ׺з�"
ORDER BY "�б�", "�ð���", "��з��ڵ�", "�ߺз��ڵ�", "�Һз��ڵ�", "���űݾ׺з�";
-----------------------------------------------------------------------------


--�б� ��з� ���ŰǼ�
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN p."��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            WHEN p."��������" BETWEEN '20140701' AND '20141231' THEN '2014�� �Ϲݱ�'
            WHEN p."��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
            WHEN p."��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        p."��з��ڵ�"
    FROM purprod p
    WHERE
        (p."��������" BETWEEN '20140101' AND '20140630')
        OR
        (p."��������" BETWEEN '20140701' AND '20141231')
        OR
        (p."��������" BETWEEN '20150101' AND '20150630')
        OR
        (p."��������" BETWEEN '20150701' AND '20151231')
)
SELECT
    "�б�",
    "��з��ڵ�",
    COUNT(*) AS "���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "��з��ڵ�"
HAVING COUNT(*) >= 10000
ORDER BY "�б�", "��з��ڵ�", "���ŰǼ�" DESC;


--�б� ��з� �ߺз� ���ŰǼ�
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN p."��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            WHEN p."��������" BETWEEN '20140701' AND '20141231' THEN '2014�� �Ϲݱ�'
            WHEN p."��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
            WHEN p."��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        p."��з��ڵ�",
        p."�ߺз��ڵ�"
    FROM purprod p
    WHERE
        (p."��������" BETWEEN '20140101' AND '20140630')
        OR
        (p."��������" BETWEEN '20140701' AND '20141231')
        OR
        (p."��������" BETWEEN '20150101' AND '20150630')
        OR
        (p."��������" BETWEEN '20150701' AND '20151231')
)
SELECT
    "�б�",
    "��з��ڵ�",
    "�ߺз��ڵ�",
    COUNT(*) AS "���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "��з��ڵ�", "�ߺз��ڵ�"
HAVING COUNT(*) >= 10000
ORDER BY "�б�", "��з��ڵ�", "�ߺз��ڵ�", "���ŰǼ�" DESC;

--��з� �ߺз� �Һз� �� ȸ�縶�� �ٸ��� �������� �� ����!
--���� ���, 0801�� ��ǰ�� ������ �н�ƮǪ��(...) �� ��������...
--�׷��� ���� ������ �м��Ҷ����� �����ͺм������� ���̹��� ���ΰ������� ��ǰ�з�ü�踦 Ȱ���ؼ� ������ ��Ŵ. �׷��� ������ �ʰ� �з� �� ���ְԵ�
--


select * from channel;
select * from compet;
select * from prodcls;
select * from purprod;

--�Ⱓ : 2015��ݱ�, 2015�Ϲݱ�� ������ ��.
--������ õ��~������ ��ǰ.
--purprod ���̺��� Ȱ���ؼ� ����� ����.

-- 2015�� ��ݱ�� �Ϲݱ⿡�� õ������ �������� ��ǰ ��
SELECT '2015�� ��ݱ�' AS �Ⱓ, COUNT(*) AS õ��_������_��ǰ_��
FROM purprod
WHERE �������� BETWEEN '20150101' AND '20150630'
  AND ���űݾ� >= 1000
  AND ���űݾ� <= 10000
UNION
SELECT '2015�� �Ϲݱ�' AS �Ⱓ, COUNT(*) AS õ��_������_��ǰ_��
FROM purprod
WHERE �������� BETWEEN '20150701' AND '20151231'
  AND ���űݾ� >= 1000
  AND ���űݾ� <= 10000;
  
--�� ��ǰ���� ��µǰԲ��Ǿ���. ����. ���� ���� �� �ݾ��� ���캸��. 
-- 2015�� ��ݱ�� �Ϲݱ⿡�� õ������ �������� ��ǰ �� �� ���� �� �ݾ�
SELECT '2015�� ��ݱ�' AS �Ⱓ,
       COUNT(*) AS õ��_������_��ǰ_��,
       SUM(���űݾ�) AS ��ݱ�_��_����_�ݾ�
FROM purprod
WHERE �������� BETWEEN '20150101' AND '20150630'
  AND ���űݾ� >= 1000
  AND ���űݾ� <= 10000
UNION
SELECT '2015�� �Ϲݱ�' AS �Ⱓ,
       COUNT(*) AS õ��_������_��ǰ_��,
       SUM(���űݾ�) AS �Ϲݱ�_��_����_�ݾ�
FROM purprod
WHERE �������� BETWEEN '20150701' AND '20151231'
  AND ���űݾ� >= 1000
  AND ���űݾ� <= 10000;

--�̰Ϳ� �ð��뺰�� �����ؼ� �ѹ� Ȯ���غ���
--�б�, �ð���(��ħ�������� �׿� �߰�), ���űݾ�(1000~10000��)�� �з��Ͽ� ���ŰǼ��� ���ϴ� ������
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN p."��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            WHEN p."��������" BETWEEN '20140701' AND '20141231' THEN '2014�� �Ϲݱ�'
            WHEN p."��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
            WHEN p."��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        CASE
            WHEN p."���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
            WHEN p."���Žð�" BETWEEN 12 AND 17 THEN '����'
            WHEN p."���Žð�" BETWEEN 18 AND 21 THEN '����'
            ELSE '�߰�'
        END AS "�ð���",
        CASE
            WHEN p."���űݾ�" BETWEEN 1000 AND 10000 THEN '1000-10000'
            ELSE '�׿�'
        END AS "���űݾ׺з�"
    FROM purprod p
    WHERE
        (p."��������" BETWEEN '20140101' AND '20140630')
        OR
        (p."��������" BETWEEN '20140701' AND '20141231')
        OR
        (p."��������" BETWEEN '20150101' AND '20150630')
        OR
        (p."��������" BETWEEN '20150701' AND '20151231')
)
SELECT
    "�б�",
    "�ð���",
    "���űݾ׺з�",
    COUNT(*) AS "���ŰǼ�",
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "�ð���", "���űݾ׺з�"
ORDER BY "�б�", "�ð���", "���űݾ׺з�";
--�б⺰�� ������ ���ŰǼ��� ����, 2014�� ��ݱ� : 6709382,  2014�� �Ϲݱ� : 7162132, 2015�� ��ݱ� : 7474098, 2015�� �Ϲݱ� : 7247418
--2015�� �Ϲݱ⿡ ���ŰǼ��� �پ��� ����� ���Դϴ�. �׷��� �̺κ��� �̽��� �Ǵ��Ͽ� �� �׷� ����� ���̴��� Ȯ���� �� �ʿ䰡 �־����ϴ�.
--���űݾ��� ������ Ȯ���غ���, �������� ���űݾ��� 1000~10000���� �Ǽ��� ���� �϶����� ���ҽ��ϴ�.
--�׷��� ���űݾ��� 1000~10000�������� �͵��� ���� �˾ƺ��ҽ��ϴ�.
--�б� ��, ��ħ�������� �߰�(�ð��뺰) �� �з��ϰ� ���űݾ��� 1000~10000�� ������ ��ǰ���� ���ŰǼ��� Ȯ���غ���,
--���ݱ� ��� 2015���Ϲݱ⿡ ���ŰǼ��� .. ��󼳸�
--2015�� �Ϲݱ��� ���ŰǼ� �϶��ϴ� ����� ���̴� �����ͷ� ���� �ִ°��� ȸ���������� ũ��Ƽ���� �̽���� �Ǵ��߽��ϴ�.
--
--���ŰǼ� �϶��� �̽������� ��Ģ���� ��å����� ����� ���� ������ �м��� �Ͽ����ϴ�.
--1. ��ǰ���� �϶��� ����� Ȯ�� 2. ������ �϶��� ����� Ȯ�� �غ���� �Ͽ����ϴ�.

--�б�, �ð���(��ħ�������� �׿� �߰�), ���űݾ�(1000~10000��)�� �з��Ͽ� ���ŰǼ��� ���ϴ� ������
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN p."��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            WHEN p."��������" BETWEEN '20140701' AND '20141231' THEN '2014�� �Ϲݱ�'
            WHEN p."��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
            WHEN p."��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        CASE
            WHEN p."���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
            WHEN p."���Žð�" BETWEEN 12 AND 17 THEN '����'
            WHEN p."���Žð�" BETWEEN 18 AND 21 THEN '����'
            ELSE '�߰�'
        END AS "�ð���",
        CASE
            WHEN p."���űݾ�" BETWEEN 1000 AND 10000 THEN '1000-10000'
            ELSE '�׿�'
        END AS "���űݾ׺з�"
    FROM purprod p
    WHERE
        (p."��������" BETWEEN '20140101' AND '20140630')
        OR
        (p."��������" BETWEEN '20140701' AND '20141231')
        OR
        (p."��������" BETWEEN '20150101' AND '20150630')
        OR
        (p."��������" BETWEEN '20150701' AND '20151231')
)
SELECT
    "�б�",
    "�ð���",
    "���űݾ׺з�",
    COUNT(*) AS "���ŰǼ�",
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "�ð���", "���űݾ׺з�"
ORDER BY "�б�", "�ð���", "���űݾ׺з�";

----
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            WHEN "��������" BETWEEN '20140701' AND '20141231' THEN '2014�� �Ϲݱ�'
            WHEN "��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
            WHEN "��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        CASE
            WHEN "���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
            WHEN "���Žð�" BETWEEN 12 AND 17 THEN '����'
            WHEN "���Žð�" BETWEEN 18 AND 21 THEN '����'
            ELSE '�߰�'
        END AS "�ð���",
        CASE
            WHEN "���űݾ�" BETWEEN 0 AND 1000 THEN '~ 1õ��'
            WHEN "���űݾ�" BETWEEN 1001 AND 10000 THEN '~ 1����'
            WHEN "���űݾ�" BETWEEN 10001 AND 50000 THEN '~ 5����'
            WHEN "���űݾ�" BETWEEN 50001 AND 100000 THEN '~ 10��'
            WHEN "���űݾ�" BETWEEN 100001 AND 1000000 THEN '~ 100��'
            WHEN "���űݾ�" BETWEEN 1000001 AND 10000000 THEN '~ 1000��'
            ELSE '1000�� �ʰ�'
        END AS "���űݾ׺з�"
    FROM purprod
    WHERE
        ("��������" BETWEEN '20140101' AND '20140630')
        OR
        ("��������" BETWEEN '20140701' AND '20141231')
        OR
        ("��������" BETWEEN '20150101' AND '20150630')
        OR
        ("��������" BETWEEN '20150701' AND '20151231')
)
SELECT
    "�б�",
    "�ð���",
    "���űݾ׺з�",
    COUNT(*) AS "���ŰǼ�",
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "�ð���", "���űݾ׺з�"
ORDER BY "�б�", "�ð���", "���űݾ׺з�";

---------------------------------------

select * from custdemo;      --        ����ȣ, ����, ���ɴ�, ��������
select * from compet;

select ���űݾ�
from purprod
where ���űݾ� = 10000;

--���� ���� �з��ؼ� �ѹ��غ���.
--���� 2015�� ��ݱ� 2015�� �Ϲݱ��� ������ �Ǽ��� ���� ����ȣ�� �����ͳ���(������)�� ��.
--���� ���� ���� ���ɴ� ���� �����ѵ�..
--�������� ���Ұųĸ�..... ���ŰǼ�..



--���� ���� ���� �Ǽ��� �з��ϰ� ���� ������ ������ ������ ������� ������ ���� ������ �� �ֽ��ϴ�
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            WHEN "��������" BETWEEN '20140701' AND '20141231' THEN '2014�� �Ϲݱ�'
            WHEN "��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
            WHEN "��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        CASE
            WHEN "���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
            WHEN "���Žð�" BETWEEN 12 AND 17 THEN '����'
            WHEN "���Žð�" BETWEEN 18 AND 21 THEN '����'
            ELSE '�߰�'
        END AS "�ð���",
        CASE
            WHEN "���űݾ�" BETWEEN 0 AND 1000 THEN 'õ�� �̸�'
            WHEN "���űݾ�" BETWEEN 1000 AND 10000 THEN 'õ��-1��'
            WHEN "���űݾ�" BETWEEN 10000 AND 50000 THEN '1��-5��'
            WHEN "���űݾ�" BETWEEN 50000 AND 100000 THEN '5��-10��'
            WHEN "���űݾ�" BETWEEN 100000 AND 1000000 THEN '10��-100��'
            WHEN "���űݾ�" BETWEEN 1000000 AND 10000000 THEN '100��-1000��'
            ELSE '1000�� �̻�'
        END AS "���űݾ׺з�"
    FROM purprod
    WHERE
        ("��������" BETWEEN '20140101' AND '20140630')
        OR
        ("��������" BETWEEN '20140701' AND '20141231')
        OR
        ("��������" BETWEEN '20150101' AND '20150630')
        OR
        ("��������" BETWEEN '20150701' AND '20151231')
)
SELECT
    "�б�",
    "�ð���",
    "���űݾ׺з�",
    COUNT(*) AS "���ŰǼ�",
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "�ð���", "���űݾ׺з�"
ORDER BY "�б�", "�ð���", "���űݾ׺з�";


---
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        CASE
            WHEN "���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
            WHEN "���Žð�" BETWEEN 12 AND 17 THEN '����'
            WHEN "���Žð�" BETWEEN 18 AND 21 THEN '����'
            ELSE '�߰�'
        END AS "�ð���",
        CASE
            WHEN "���űݾ�" BETWEEN 0 AND 1000 THEN 'õ�� �̸�'
            WHEN "���űݾ�" BETWEEN 1000 AND 10000 THEN 'õ��-1��'
            WHEN "���űݾ�" BETWEEN 10000 AND 50000 THEN '1��-5��'
            WHEN "���űݾ�" BETWEEN 50000 AND 100000 THEN '5��-10��'
            WHEN "���űݾ�" BETWEEN 100000 AND 1000000 THEN '10��-100��'
            WHEN "���űݾ�" BETWEEN 1000000 AND 10000000 THEN '100��-1000��'
            ELSE '1000�� �̻�'
        END AS "���űݾ׺з�"
    FROM purprod
    WHERE
        ("��������" BETWEEN '20140101' AND '20140630')
)
SELECT
    "�б�",
    "�ð���",
    "���űݾ׺з�",
    COUNT(*) AS "���ŰǼ�",
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "�ð���", "���űݾ׺з�"
ORDER BY "�б�", "�ð���", "���űݾ׺з�";


--------------------------------------------------------------------------------------

- �Һз� ������ ��

SELECT
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    PP.����ȣ,
    PP.��������,
    MAX(PP.���Žð�) AS ���Žð�,
    PP.���űݾ�,
    CASE
        WHEN TO_NUMBER(SUBSTR(MAX(PP.���Žð�), 1, 2)) BETWEEN 6 AND 11 THEN '��ħ'
        WHEN TO_NUMBER(SUBSTR(MAX(PP.���Žð�), 1, 2)) BETWEEN 12 AND 17 THEN '����'
        WHEN TO_NUMBER(SUBSTR(MAX(PP.���Žð�), 1, 2)) BETWEEN 18 AND 21 THEN '����'
        ELSE '�߰�'
    END AS �ð���
FROM PURPROD PP
JOIN PRODCLS PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE PP.���޻� = 'A' -- A���޻縸 ���͸�
  AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
  AND PP.���űݾ� BETWEEN 1000 AND 10000
GROUP BY
    PP.���޻�,
    PP.�Һз��ڵ�,
    PC.�Һз���,
    PP.����ȣ,
    PP.��������,
    PP.���űݾ�
ORDER BY TO_NUMBER(SUBSTR(MAX(PP.���Žð�), 1, 2)), PP.����ȣ;



SELECT
    PC.�Һз���,
    COUNT(*) AS �ŷ��Ǽ�,
    SUM(PP.���űݾ�) AS �ѱ��űݾ�
FROM PURPROD PP
JOIN PRODCLS PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE PP.���޻� = 'A' -- A���޻縸 ���͸�
  AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
  AND PP.���űݾ� BETWEEN 1000 AND 10000
GROUP BY PC.�Һз���
ORDER BY �ŷ��Ǽ� DESC, �ѱ��űݾ� ASC;


----------1122

WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        CASE
            WHEN "���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
            WHEN "���Žð�" BETWEEN 12 AND 17 THEN '����'
            WHEN "���Žð�" BETWEEN 18 AND 21 THEN '����'
            ELSE '�߰�'
        END AS "�ð���",
        CASE
            WHEN "���űݾ�" BETWEEN 0 AND 1000 THEN 'õ�� �̸�'
            WHEN "���űݾ�" BETWEEN 1000 AND 10000 THEN 'õ��-1��'
            WHEN "���űݾ�" BETWEEN 10000 AND 50000 THEN '1��-5��'
            WHEN "���űݾ�" BETWEEN 50000 AND 100000 THEN '5��-10��'
            WHEN "���űݾ�" BETWEEN 100000 AND 1000000 THEN '10��-100��'
            WHEN "���űݾ�" BETWEEN 1000000 AND 10000000 THEN '100��-1000��'
            ELSE '1000�� �̻�'
        END AS "���űݾ׺з�"
    FROM purprod
    WHERE
        ("��������" BETWEEN '20140101' AND '20140630')
)
SELECT
    "�б�",
    "�ð���",
    "���űݾ׺з�",
    COUNT(*) AS "���ŰǼ�",
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "�ð���", "���űݾ׺з�"
ORDER BY "�б�", "�ð���", "���űݾ׺з�";

----
-- 2015�� ��ݱ�

WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        CASE
            WHEN "���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
            WHEN "���Žð�" BETWEEN 12 AND 17 THEN '����'
            WHEN "���Žð�" BETWEEN 18 AND 21 THEN '����'
            ELSE '�߰�'
        END AS "�ð���",
        CASE
            WHEN "���űݾ�" BETWEEN 0 AND 1000 THEN 'õ�� �̸�'
            WHEN "���űݾ�" BETWEEN 1000 AND 10000 THEN 'õ��-1��'
            WHEN "���űݾ�" BETWEEN 10000 AND 50000 THEN '1��-5��'
            WHEN "���űݾ�" BETWEEN 50000 AND 100000 THEN '5��-10��'
            WHEN "���űݾ�" BETWEEN 100000 AND 1000000 THEN '10��-100��'
            WHEN "���űݾ�" BETWEEN 1000000 AND 10000000 THEN '100��-1000��'
            ELSE '1000�� �̻�'
        END AS "���űݾ׺з�"
    FROM purprod
    WHERE
        ("��������" BETWEEN '20150101' AND '20150630')
)
SELECT
    "�б�",
    "�ð���",
    "���űݾ׺з�",
    COUNT(*) AS "���ŰǼ�",
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "�ð���", "���űݾ׺з�"
ORDER BY "�б�", "�ð���", "���űݾ׺з�";


--
-- 2015�� �Ϲݱ�

WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
            ELSE '��Ÿ'
        END AS "�б�",
        CASE
            WHEN "���Žð�" BETWEEN 6 AND 11 THEN '��ħ'
            WHEN "���Žð�" BETWEEN 12 AND 17 THEN '����'
            WHEN "���Žð�" BETWEEN 18 AND 21 THEN '����'
            ELSE '�߰�'
        END AS "�ð���",
        CASE
            WHEN "���űݾ�" BETWEEN 0 AND 1000 THEN 'õ�� �̸�'
            WHEN "���űݾ�" BETWEEN 1000 AND 10000 THEN 'õ��-1��'
            WHEN "���űݾ�" BETWEEN 10000 AND 50000 THEN '1��-5��'
            WHEN "���űݾ�" BETWEEN 50000 AND 100000 THEN '5��-10��'
            WHEN "���űݾ�" BETWEEN 100000 AND 1000000 THEN '10��-100��'
            WHEN "���űݾ�" BETWEEN 1000000 AND 10000000 THEN '100��-1000��'
            ELSE '1000�� �̻�'
        END AS "���űݾ׺з�"
    FROM purprod
    WHERE
        ("��������" BETWEEN '20150601' AND '20151231')
)
SELECT
    "�б�",
    "�ð���",
    "���űݾ׺з�",
    COUNT(*) AS "���ŰǼ�",
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�", "�ð���", "���űݾ׺з�"
ORDER BY "�б�", "�ð���", "���űݾ׺з�";

--


where �Һз��� IN ('���ڽ���', '����', '��������', '����û����', '���������', '�������', '�����ᳪ��', '��ɼ�����', '��Ÿ���丣Ʈ', '��갡��',
                  '���̼�', '�κη�', '����Ʈ��', '���Դ¿䱸��Ʈ', '���ô¿䱸��Ʈ', '���ɸ�', '���/ȭ���', '�ٳ���', '���׽���', '�������',
                  '��ħ�κ�', '��Ƽ��ǰ', '����', '������', '����', '���絨��', '�ҽ�', '�ҽ���', '����(�δ�)', '����������',
                  '������/����', '����', '���/�׻�䱸��Ʈ', '�', '������Ǫ��', '�������׼�����', '������', '����������', '��������', '�����ä��',
                  '����ǰ', '�Ϲݰ�����ǰ', '�Ϲݰ��', '�Ϲݼ���', '�Ϲݽ���', '�Ϲݿ���', '�Ϲ������', '�Ͽ���ȭ', '��������Ŀ��', '��������',
                  '�ַ�', '�߽ĵ���', '�Ｎ����', 'ä��', 'û��', 'ģȯ��ä��(Ư��)', '�ܽ���', '�ᳪ��', '��Ű', 'ũ��Ŀ',
                  'Ʈ��Ʈ��Ʈ/��', '����', '�����ݸ�', '��Ƽ���̳�', '���̼�Ŭ����', 'ǲ�ɾ�', '�ϵ�ĵ��', '�ڵ�μ�/ũ��', '��', '������',
                  'ȥ��ź��')

--

SELECT
    CD.����ȣ,
    PC.�Һз���,
    COUNT(PP.��������) AS ����Ƚ��,
    SUM(PP.���űݾ�) AS �ѱ��űݾ�
FROM CUSTDEMO CD
JOIN PURPROD PP ON CD.����ȣ = PP.����ȣ
JOIN PRODCLS PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
  AND PC.�Һз��� IN ('���ڽ���', '����', '��������', '����û����', '���������', '�������', '�����ᳪ��', '��ɼ�����', '��Ÿ���丣Ʈ', '��갡��',
                  '���̼�', '�κη�', '����Ʈ��', '���Դ¿䱸��Ʈ', '���ô¿䱸��Ʈ', '���ɸ�', '���/ȭ���', '�ٳ���', '���׽���', '�������',
                  '��ħ�κ�', '��Ƽ��ǰ', '����', '������', '����', '���絨��', '�ҽ�', '�ҽ���', '����(�δ�)', '����������',
                  '������/����', '����', '���/�׻�䱸��Ʈ', '�', '������Ǫ��', '�������׼�����', '������', '����������', '��������', '�����ä��',
                  '����ǰ', '�Ϲݰ�����ǰ', '�Ϲݰ��', '�Ϲݼ���', '�Ϲݽ���', '�Ϲݿ���', '�Ϲ������', '�Ͽ���ȭ', '��������Ŀ��', '��������',
                  '�ַ�', '�߽ĵ���', '�Ｎ����', 'ä��', 'û��', 'ģȯ��ä��(Ư��)', '�ܽ���', '�ᳪ��', '��Ű', 'ũ��Ŀ',
                  'Ʈ��Ʈ��Ʈ/��', '����', '�����ݸ�', '��Ƽ���̳�', '���̼�Ŭ����', 'ǲ�ɾ�', '�ϵ�ĵ��', '�ڵ�μ�/ũ��', '��', '������',
                  'ȥ��ź��')
  AND PP.���űݾ� BETWEEN 1000 AND 10000
GROUP BY CD.����ȣ, PC.�Һз���
ORDER BY ����Ƚ�� DESC;

--
SELECT
    CD.����ȣ,
    PP.��������,
    PC.�Һз���,
    COUNT(PP.��������) AS ����Ƚ��,
    SUM(PP.���űݾ�) AS �ѱ��űݾ�
FROM CUSTDEMO CD
JOIN PURPROD PP ON CD.����ȣ = PP.����ȣ
JOIN PRODCLS PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-6-30', 'YYYY-MM-DD')
  AND PC.�Һз��� IN ('���ڽ���', '����', '��������', '����û����', '���������', '�������', '�����ᳪ��', '��ɼ�����', '��Ÿ���丣Ʈ', '��갡��',
                  '���̼�', '�κη�', '����Ʈ��', '���Դ¿䱸��Ʈ', '���ô¿䱸��Ʈ', '���ɸ�', '���/ȭ���', '�ٳ���', '���׽���', '�������',
                  '��ħ�κ�', '��Ƽ��ǰ', '����', '������', '����', '���絨��', '�ҽ�', '�ҽ���', '����(�δ�)', '����������',
                  '������/����', '����', '���/�׻�䱸��Ʈ', '�', '������Ǫ��', '�������׼�����', '������', '����������', '��������', '�����ä��',
                  '����ǰ', '�Ϲݰ�����ǰ', '�Ϲݰ��', '�Ϲݼ���', '�Ϲݽ���', '�Ϲݿ���', '�Ϲ������', '�Ͽ���ȭ', '��������Ŀ��', '��������',
                  '�ַ�', '�߽ĵ���', '�Ｎ����', 'ä��', 'û��', 'ģȯ��ä��(Ư��)', '�ܽ���', '�ᳪ��', '��Ű', 'ũ��Ŀ',
                  'Ʈ��Ʈ��Ʈ/��', '����', '�����ݸ�', '��Ƽ���̳�', '���̼�Ŭ����', 'ǲ�ɾ�', '�ϵ�ĵ��', '�ڵ�μ�/ũ��', '��', '������',
                  'ȥ��ź��')
  AND PP.���űݾ� BETWEEN 1000 AND 10000
GROUP BY CD.����ȣ, PP.��������, PC.�Һз���
ORDER BY ����Ƚ�� DESC, �ѱ��űݾ� DESC;


---�־���������
 select count(*) 
 from compet CP 
 inner join purprod PP on CP.����ȣ = PP.����ȣ 
 where PP.���űݾ� between 1000 and 10000 
       and PP.���޻� = 'C' 
       and to_date(PP.��������, 'YYYYMMDD') between to_date('2015-01-01', 'YYYY-MM-DD') and to_date('2015-06-30', 'YYYY-MM-DD')
       and to_date(CP.�̿���, 'YYYYMM') between to_date('2015-01', 'YYYY-MM') and to_date('2015-6', 'YYYY-MM'); 


-------------"�̿� �� ��"
 select count(*) AS "�̿� �� ��"
 from compet CP 
 inner join purprod PP on CP.����ȣ = PP.����ȣ 
 where PP.���űݾ� between 1000 and 10000 
       and PP.���޻� = 'A' 
       and to_date(PP.��������, 'YYYYMMDD') between to_date('2015-01-01', 'YYYY-MM-DD') and to_date('2015-01-31', 'YYYY-MM-DD');
--       and CP.�̿��� = 201501;

-------------"����� ���� �̿� ��"
 select count(*) AS "����� ���� �̿� ��"
 from compet CP 
 inner join purprod PP on CP.����ȣ = PP.����ȣ 
 where PP.���űݾ� between 1000 and 10000 
       and PP.���޻� = 'A'
       and to_date(PP.��������, 'YYYYMMDD') between to_date('2015-01-01', 'YYYY-MM-DD') and to_date('2015-01-31', 'YYYY-MM-DD')
       and CP.�̿��� = 201501;
       
       
