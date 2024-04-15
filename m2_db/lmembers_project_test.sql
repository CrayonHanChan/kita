-- �̿� �� �� 

SELECT TO_CHAR(to_date(PP.��������, 'YYYYMMDD'), 'YYYY-MM') AS ���ų��,
       COUNT(*) AS �ŷ��Ǽ�
FROM compet CP
INNER JOIN purprod PP ON CP.����ȣ = PP.����ȣ
WHERE PP.���űݾ� BETWEEN 1000 AND 10000
      AND PP.���޻� = 'A'
      AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
GROUP BY TO_CHAR(to_date(PP.��������, 'YYYYMMDD'), 'YYYY-MM')
ORDER BY ���ų��;


-- ����� ���� �̿� ��  ���޻� �ϳ��ϳ� ����
SELECT TO_CHAR(to_date(PP.��������, 'YYYYMMDD'), 'YYYY-MM') AS ���ų��,
       COUNT(*) AS �ŷ��Ǽ�
FROM compet CP
INNER JOIN purprod PP ON CP.����ȣ = PP.����ȣ
WHERE PP.���űݾ� BETWEEN 1000 AND 10000
      AND PP.���޻� = 'D'
      AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-01-31', 'YYYY-MM-DD')
      and CP.�̿��� = 201501
GROUP BY TO_CHAR(to_date(PP.��������, 'YYYYMMDD'), 'YYYY-MM')
ORDER BY ���ų��;


-- ����� ���� �̿� �� ���޻� A,B,C,D ����
SELECT
    TO_CHAR(to_date(PP.��������, 'YYYYMMDD'), 'YYYY-MM') AS ���ų��,
    SUM(CASE WHEN PP.���޻� = 'A' THEN 1 ELSE 0 END) AS "A �ŷ��Ǽ�",
    SUM(CASE WHEN PP.���޻� = 'B' THEN 1 ELSE 0 END) AS "B �ŷ��Ǽ�",
    SUM(CASE WHEN PP.���޻� = 'C' THEN 1 ELSE 0 END) AS "C �ŷ��Ǽ�",
    SUM(CASE WHEN PP.���޻� = 'D' THEN 1 ELSE 0 END) AS "D �ŷ��Ǽ�"
FROM compet CP
INNER JOIN purprod PP ON CP.����ȣ = PP.����ȣ
WHERE PP.���űݾ� BETWEEN 1000 AND 10000
      AND PP.���޻� IN ('A', 'B', 'C', 'D')
      AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-03-31', 'YYYY-MM-DD')
      AND CP.�̿��� = 201501
GROUP BY TO_CHAR(to_date(PP.��������, 'YYYYMMDD'), 'YYYY-MM')
ORDER BY ���ų��;


----------------------------------------------------------------
--���޻� A, B, C, D�� ���� ����� ������ ������ ��� -- �̿� �� �� 

SELECT
    TO_CHAR(to_date(PP.��������, 'YYYYMMDD'), 'YYYY-MM') AS ���ų��,
    SUM(CASE WHEN PP.���޻� = 'A' THEN 1 ELSE 0 END) AS "A �ŷ��Ǽ�",
    SUM(CASE WHEN PP.���޻� = 'B' THEN 1 ELSE 0 END) AS "B �ŷ��Ǽ�",
    SUM(CASE WHEN PP.���޻� = 'C' THEN 1 ELSE 0 END) AS "C �ŷ��Ǽ�",
    SUM(CASE WHEN PP.���޻� = 'D' THEN 1 ELSE 0 END) AS "D �ŷ��Ǽ�"
FROM compet CP
INNER JOIN purprod PP ON CP.����ȣ = PP.����ȣ
WHERE PP.���űݾ� BETWEEN 1000 AND 10000
      AND PP.���޻� IN ('A', 'B', 'C', 'D')
      AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
GROUP BY TO_CHAR(to_date(PP.��������, 'YYYYMMDD'), 'YYYY-MM')
ORDER BY ���ų��;


--------------------------------------------
--����� �������� ���� �̱�..
--��) ��ݱ��϶� ���޻� A,B,C,D �����̿��� ���̶�. ���޻� D�� �̿��Ѱ� ��츦 �̰� ��
--���޻� 

 select count(*) 
 from compet CP 
 inner join purprod PP on CP.����ȣ = PP.����ȣ 
 where PP.���űݾ� between 1000 and 10000 
       and PP.���޻� = 'A'
       and to_date(PP.��������, 'YYYYMMDD') between to_date('2015-01-01', 'YYYY-MM-DD') and to_date('2015-06-30', 'YYYY-MM-DD')
       and to_date(CP.�̿���, 'YYYYMM') between to_date('2015-01', 'YYYY-MM') and to_date('2015-6', 'YYYY-MM');
       
--
-- ��ݱ� ���� ���޻� A, B, C, D�� ��� �̿��� �� �� --�����ʿ�..
SELECT COUNT(*) AS "��ݱ� ��� ���޻� �̿� �� ��"
FROM (
    SELECT CP.����ȣ
    FROM compet CP
    INNER JOIN purprod PP ON CP.����ȣ = PP.����ȣ
    WHERE PP.���űݾ� BETWEEN 1000 AND 10000
          AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
          AND TO_DATE(CP.�̿���, 'YYYYMM') BETWEEN TO_DATE('2015-01', 'YYYY-MM') AND TO_DATE('2015-06', 'YYYY-MM')
          AND PP.���޻� IN ('A')
    GROUP BY CP.����ȣ
    HAVING COUNT(DISTINCT PP.���޻�) = 1
);

--���̿�� -�����ʿ�..
SELECT COUNT(*) AS "�� �̿� �� ��"
FROM (
    SELECT CP.����ȣ
    FROM compet CP
    INNER JOIN purprod PP ON CP.����ȣ = PP.����ȣ
    WHERE PP.���űݾ� BETWEEN 1000 AND 10000
          AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
--          AND TO_DATE(CP.�̿���, 'YYYYMM') BETWEEN TO_DATE('2015-01', 'YYYY-MM') AND TO_DATE('2015-06', 'YYYY-MM')
          AND PP.���޻� IN ('B','C')
    GROUP BY CP.����ȣ
    HAVING COUNT(DISTINCT PP.���޻�) = 2
);

--����� ������ ��, �Ⱓ, ���޻纰��....  
SELECT COUNT(*) AS "�� �̿� ��", CP.����ȣ
    FROM compet CP
    INNER JOIN purprod PP ON CP.����ȣ = PP.����ȣ
    WHERE PP.���űݾ� BETWEEN 1000 AND 10000
          AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
          AND TO_DATE(CP.�̿���, 'YYYYMM') BETWEEN TO_DATE('2015-01', 'YYYY-MM') AND TO_DATE('2015-01', 'YYYY-MM')
          AND PP.���޻� IN ('D')
    GROUP BY CP.����ȣ
--    HAVING COUNT(DISTINCT PP.���޻�) = 4
    order by "�� �̿� ��" DESC
;

-------------------------
--�� ���� ���������� ���� �� ����غ���
SELECT COUNT(*) AS "�� �̿� ��", CP.����ȣ
    FROM compet CP
    INNER JOIN purprod PP ON CP.����ȣ = PP.����ȣ
    WHERE PP.���űݾ� BETWEEN 1000 AND 10000
          AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
--          AND TO_DATE(CP.�̿���, 'YYYYMM') BETWEEN TO_DATE('2015-12', 'YYYY-MM') AND TO_DATE('2015-12', 'YYYY-MM')
          AND PP.���޻� IN ('D')
          AND PP.����ȣ = 14923
    GROUP BY CP.����ȣ
--    HAVING COUNT(DISTINCT PP.���޻�) = 4
    order by "�� �̿� ��" DESC
;

----------------------------------
--
SELECT PC.�Һз���, COUNT(*) AS ����
FROM purprod PP
JOIN PRODCLS PC ON PP.��з��ڵ� = PC.��з��ڵ�
WHERE PP.����ȣ = 18989
AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
AND PC.�Һз��� IN ('���ڽ���', '����', '��������', '����û����', '���������', '�������', '�����ᳪ��', '��ɼ�����', '��Ÿ���丣Ʈ', '��갡��',
                  '���̼�', '�κη�', '����Ʈ��', '���Դ¿䱸��Ʈ', '���ô¿䱸��Ʈ', '���ɸ�', '���/ȭ���', '�ٳ���', '���׽���', '�������',
                  '��ħ�κ�', '��Ƽ��ǰ', '����', '������', '����', '���絨��', '�ҽ�', '�ҽ���', '����(�δ�)', '����������',
                  '������/����', '����', '���/�׻�䱸��Ʈ', '�', '������Ǫ��', '�������׼�����', '������', '����������', '��������', '�����ä��',
                  '����ǰ', '�Ϲݰ�����ǰ', '�Ϲݰ��', '�Ϲݼ���', '�Ϲݽ���', '�Ϲݿ���', '�Ϲ������', '�Ͽ���ȭ', '��������Ŀ��', '��������',
                  '�ַ�', '�߽ĵ���', '�Ｎ����', 'ä��', 'û��', 'ģȯ��ä��(Ư��)', '�ܽ���', '�ᳪ��', '��Ű', 'ũ��Ŀ',
                  'Ʈ��Ʈ��Ʈ/��', '����', '�����ݸ�', '��Ƽ���̳�', '���̼�Ŭ����', 'ǲ�ɾ�', '�ϵ�ĵ��', '�ڵ�μ�/ũ��', '��', '������',
                  'ȥ��ź��')
GROUP BY PC.�Һз���
ORDER BY ���� DESC, PC.�Һз���;







--��з��ڵ� = 1 2015�� ��ݱ�
SELECT PC.�Һз���, COUNT(*) AS ����
FROM purprod PP
JOIN PRODCLS PC ON PP.��з��ڵ� = PC.��з��ڵ�
WHERE PP.����ȣ = 13911
AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
--AND PC.�Һз��� IN ('���ڽ���', '����', '��������', '����û����', '���������', '�������', '�����ᳪ��', '��ɼ�����', '��Ÿ���丣Ʈ', '��갡��',
--                  '���̼�', '�κη�', '����Ʈ��', '���Դ¿䱸��Ʈ', '���ô¿䱸��Ʈ', '���ɸ�', '���/ȭ���', '�ٳ���', '���׽���', '�������',
--                  '��ħ�κ�', '��Ƽ��ǰ', '����', '������', '����', '���絨��', '�ҽ�', '�ҽ���', '����(�δ�)', '����������',
--                  '������/����', '����', '���/�׻�䱸��Ʈ', '�', '������Ǫ��', '�������׼�����', '������', '����������', '��������', '�����ä��',
--                  '����ǰ', '�Ϲݰ�����ǰ', '�Ϲݰ��', '�Ϲݼ���', '�Ϲݽ���', '�Ϲݿ���', '�Ϲ������', '�Ͽ���ȭ', '��������Ŀ��', '��������',
--                  '�ַ�', '�߽ĵ���', '�Ｎ����', 'ä��', 'û��', 'ģȯ��ä��(Ư��)', '�ܽ���', '�ᳪ��', '��Ű', 'ũ��Ŀ',
--                  'Ʈ��Ʈ��Ʈ/��', '����', '�����ݸ�', '��Ƽ���̳�', '���̼�Ŭ����', 'ǲ�ɾ�', '�ϵ�ĵ��', '�ڵ�μ�/ũ��', '��', '������',
--                  'ȥ��ź��')
AND PP.��з��ڵ� = 1
AND PC.��з��ڵ� = 1
GROUP BY PC.�Һз���
ORDER BY ���� DESC, PC.�Һз���;

--��з��ڵ� = 1 2015�� �Ϲݱ�
SELECT PC.�Һз���, COUNT(*) AS ����
FROM purprod PP
JOIN PRODCLS PC ON PP.��з��ڵ� = PC.��з��ڵ�
WHERE PP.����ȣ = 13911
AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
--AND PC.�Һз��� IN ('���ڽ���', '����', '��������', '����û����', '���������', '�������', '�����ᳪ��', '��ɼ�����', '��Ÿ���丣Ʈ', '��갡��',
--                  '���̼�', '�κη�', '����Ʈ��', '���Դ¿䱸��Ʈ', '���ô¿䱸��Ʈ', '���ɸ�', '���/ȭ���', '�ٳ���', '���׽���', '�������',
--                  '��ħ�κ�', '��Ƽ��ǰ', '����', '������', '����', '���絨��', '�ҽ�', '�ҽ���', '����(�δ�)', '����������',
--                  '������/����', '����', '���/�׻�䱸��Ʈ', '�', '������Ǫ��', '�������׼�����', '������', '����������', '��������', '�����ä��',
--                  '����ǰ', '�Ϲݰ�����ǰ', '�Ϲݰ��', '�Ϲݼ���', '�Ϲݽ���', '�Ϲݿ���', '�Ϲ������', '�Ͽ���ȭ', '��������Ŀ��', '��������',
--                  '�ַ�', '�߽ĵ���', '�Ｎ����', 'ä��', 'û��', 'ģȯ��ä��(Ư��)', '�ܽ���', '�ᳪ��', '��Ű', 'ũ��Ŀ',
--                  'Ʈ��Ʈ��Ʈ/��', '����', '�����ݸ�', '��Ƽ���̳�', '���̼�Ŭ����', 'ǲ�ɾ�', '�ϵ�ĵ��', '�ڵ�μ�/ũ��', '��', '������',
--                  'ȥ��ź��')
AND PP.��з��ڵ� = 1
AND PC.��з��ڵ� = 1
GROUP BY PC.�Һз���
ORDER BY ���� DESC, PC.�Һз���;



-----------------------------




SELECT PC.�ߺз���, COUNT(*) AS ����
FROM purprod PP
JOIN PRODCLS PC ON PP.�ߺз��ڵ� = PC.�ߺз��ڵ�
WHERE PP.����ȣ = 18989
AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
--AND PC.�Һз��� IN ('���ڽ���', '����', '��������', '����û����', '���������', '�������', '�����ᳪ��', '��ɼ�����', '��Ÿ���丣Ʈ', '��갡��',
--                  '���̼�', '�κη�', '����Ʈ��', '���Դ¿䱸��Ʈ', '���ô¿䱸��Ʈ', '���ɸ�', '���/ȭ���', '�ٳ���', '���׽���', '�������',
--                  '��ħ�κ�', '��Ƽ��ǰ', '����', '������', '����', '���絨��', '�ҽ�', '�ҽ���', '����(�δ�)', '����������',
--                  '������/����', '����', '���/�׻�䱸��Ʈ', '�', '������Ǫ��', '�������׼�����', '������', '����������', '��������', '�����ä��',
--                  '����ǰ', '�Ϲݰ�����ǰ', '�Ϲݰ��', '�Ϲݼ���', '�Ϲݽ���', '�Ϲݿ���', '�Ϲ������', '�Ͽ���ȭ', '��������Ŀ��', '��������',
--                  '�ַ�', '�߽ĵ���', '�Ｎ����', 'ä��', 'û��', 'ģȯ��ä��(Ư��)', '�ܽ���', '�ᳪ��', '��Ű', 'ũ��Ŀ',
--                  'Ʈ��Ʈ��Ʈ/��', '����', '�����ݸ�', '��Ƽ���̳�', '���̼�Ŭ����', 'ǲ�ɾ�', '�ϵ�ĵ��', '�ڵ�μ�/ũ��', '��', '������',
--                  'ȥ��ź��')
AND PP.�ߺз��ڵ� = 0106
AND PC.�ߺз��ڵ� = 0106
GROUP BY PC.�ߺз���
ORDER BY ���� DESC;

----
SELECT PC.�ߺз���, COUNT(*) AS ����
FROM purprod PP
JOIN PRODCLS PC ON PP.�ߺз��ڵ� = PC.�ߺз��ڵ�
WHERE PP.����ȣ = 18989
AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-06-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
--AND PC.�Һз��� IN ('���ڽ���', '����', '��������', '����û����', '���������', '�������', '�����ᳪ��', '��ɼ�����', '��Ÿ���丣Ʈ', '��갡��',
--                  '���̼�', '�κη�', '����Ʈ��', '���Դ¿䱸��Ʈ', '���ô¿䱸��Ʈ', '���ɸ�', '���/ȭ���', '�ٳ���', '���׽���', '�������',
--                  '��ħ�κ�', '��Ƽ��ǰ', '����', '������', '����', '���絨��', '�ҽ�', '�ҽ���', '����(�δ�)', '����������',
--                  '������/����', '����', '���/�׻�䱸��Ʈ', '�', '������Ǫ��', '�������׼�����', '������', '����������', '��������', '�����ä��',
--                  '����ǰ', '�Ϲݰ�����ǰ', '�Ϲݰ��', '�Ϲݼ���', '�Ϲݽ���', '�Ϲݿ���', '�Ϲ������', '�Ͽ���ȭ', '��������Ŀ��', '��������',
--                  '�ַ�', '�߽ĵ���', '�Ｎ����', 'ä��', 'û��', 'ģȯ��ä��(Ư��)', '�ܽ���', '�ᳪ��', '��Ű', 'ũ��Ŀ',
--                  'Ʈ��Ʈ��Ʈ/��', '����', '�����ݸ�', '��Ƽ���̳�', '���̼�Ŭ����', 'ǲ�ɾ�', '�ϵ�ĵ��', '�ڵ�μ�/ũ��', '��', '������',
--                  'ȥ��ź��')
AND PP.�ߺз��ڵ� = 0106
AND PC.�ߺз��ڵ� = 0106
GROUP BY PC.�ߺз���
ORDER BY ���� DESC;

--�ߺз��ڵ�
select �ߺз��ڵ�, count(�ߺз��ڵ�) from purprod
group by �ߺз��ڵ�
order by count(�ߺз��ڵ�) desc;

--��ǰ ��з��ڵ��, ��ݱ�, ���޻� = D.. �����ʿ�
select purprod.��з��ڵ�, count(purprod.��з��ڵ�)
from purprod, prodcls, custdemo
where TO_DATE(purprod.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
AND custdemo."����ȣ" = purprod."����ȣ"
AND custdemo.����ȣ = 6868
AND prodcls.��з��ڵ� = purprod.��з��ڵ�
AND prodcls.���޻� = purprod.���޻�
AND purprod.���޻� = 'D'
group by purprod.��з��ڵ�
order by count(purprod.��з��ڵ�) desc;

--������..  ��ǰ ��з��ڵ��, ��ݱ�, ���޻� = D
SELECT purprod.��з��ڵ�, COUNT(DISTINCT purprod.����ȣ) AS ��ǰ��
FROM purprod
JOIN prodcls ON purprod.��з��ڵ� = prodcls.��з��ڵ�
WHERE TO_DATE(purprod.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
  AND purprod.���޻� = 'D'
  AND ����ȣ = 16129         
GROUP BY purprod.��з��ڵ�
ORDER BY ��ǰ�� DESC;

SELECT ��з��ڵ�, COUNT(��з��ڵ�) AS ��ǰ��
FROM purprod
GROUP BY ��з��ڵ�
ORDER BY ��ǰ�� DESC;

select * from purprod order by "��з��ڵ�";

--�Һз���
select �Һз���, count(�Һз���) from prodcls
group by �Һз���
order by count(�Һз���) desc;

--���� ���� �Һз���
select prodcls.�Һз���, count(prodcls.�Һз���) from prodcls, purprod
where prodcls."�Һз��ڵ�" = purprod."�Һз��ڵ�"
group by prodcls.�Һз���
order by count(prodcls.�Һз���) desc;


--���� ���ż��� ��ݱ�
select custdemo.����ȣ, count(custdemo."����ȣ")
from custdemo, purprod
where TO_DATE(purprod.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
AND custdemo.����ȣ = purprod."����ȣ"
AND purprod.���޻� = 'D'
group by custdemo."����ȣ"
order by count(custdemo."����ȣ") desc
;
--���� 10�� ���� ���ż��� ��ݱ�
--����ȣ, ī��Ʈ.
--6868	368
--17959	306
--16129	298
--10490	284
--18989	281
--18469	264
--13736	263
--13529	258
--18373	252
--17230	244

--���� ���ż��� �Ϲݱ�
select custdemo.����ȣ, count(custdemo."����ȣ")
from custdemo, purprod
where TO_DATE(purprod.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
AND custdemo.����ȣ = purprod."����ȣ"
AND purprod.���޻� = 'D'
group by custdemo."����ȣ"
order by count(custdemo."����ȣ") desc
;
--���� 10�� ���� ���ż��� �Ϲݱ�
--����ȣ, ī��Ʈ.
--16722	336
--19350	294
--18294	292
--13460	290
--13719	286
--17230	280
--15697	280
--18894	275
--17951	271
--13529	271

--����(����10��), 

--
SELECT PC.�ߺз���, COUNT(*) AS ����
FROM purprod PP
JOIN PRODCLS PC ON PP.�ߺз��ڵ� = PC.�ߺз��ڵ�
WHERE PP.����ȣ = 18989
AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-06-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
AND PP.�ߺз��ڵ� = 0106
AND PC.�ߺз��ڵ� = 0106
GROUP BY PC.�ߺз���
ORDER BY ���� DESC;


--��ݱ�
SELECT
    CD.����ȣ,
    SUM(PP.���űݾ�) AS �ѱ��űݾ�,
    COUNT(PP.��������) AS �ѱ���Ƚ��,
    PC.�Һз���
FROM CUSTDEMO CD
JOIN PURPROD PP ON CD.����ȣ = PP.����ȣ
JOIN PRODCLS PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE CD.����ȣ = 16129   
  AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('20150101', 'YYYYMMDD') AND TO_DATE('20150630', 'YYYYMMDD')
  AND PP.���űݾ� BETWEEN 1000 AND 10000
GROUP BY CD.����ȣ, PC.�Һз���
order by �ѱ���Ƚ�� desc;

--�Ϲݱ�
SELECT
    CD.����ȣ,
    SUM(PP.���űݾ�) AS �ѱ��űݾ�,
    COUNT(PP.��������) AS �ѱ���Ƚ��,
    PC.�Һз���
FROM CUSTDEMO CD
JOIN PURPROD PP ON CD.����ȣ = PP.����ȣ
JOIN PRODCLS PC ON PP.�Һз��ڵ� = PC.�Һз��ڵ�
WHERE CD.����ȣ = 16129   
  AND TO_DATE(PP.��������, 'YYYYMMDD') BETWEEN TO_DATE('20150701', 'YYYYMMDD') AND TO_DATE('20151231', 'YYYYMMDD')
  AND PP.���űݾ� BETWEEN 1000 AND 10000
GROUP BY CD.����ȣ, PC.�Һз���
order by �ѱ���Ƚ�� desc;

----
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "��������" BETWEEN '20140101' AND '20140630' THEN '2014�� ��ݱ�'
            WHEN "��������" BETWEEN '20140701' AND '20141231' THEN '2014�� �Ϲݱ�'
            WHEN "��������" BETWEEN '20150101' AND '20150630' THEN '2015�� ��ݱ�'
            WHEN "��������" BETWEEN '20150701' AND '20151231' THEN '2015�� �Ϲݱ�'
            ELSE '��Ÿ'
        END AS "�б�"
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
    SUM(COUNT(*)) OVER (PARTITION BY "�б�") AS "�б⺰_�ջ�_���ŰǼ�"
FROM TimeBasedData
GROUP BY "�б�"
ORDER BY "�б�";

-----

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
--���� ���ż��� ��ݱ�
select custdemo.����ȣ, count(custdemo."����ȣ")
from custdemo, purprod
where TO_DATE(purprod.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
AND custdemo.����ȣ = purprod."����ȣ"
AND purprod.���޻� = 'D'
group by custdemo."����ȣ"
order by count(custdemo."����ȣ") desc
;

--���� ���ż��� �Ϲݱ�
select custdemo.����ȣ, count(custdemo."����ȣ")
from custdemo, purprod
where TO_DATE(purprod.��������, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
AND custdemo.����ȣ = purprod."����ȣ"
AND purprod.���޻� = 'D'
group by custdemo."����ȣ"
order by count(custdemo."����ȣ") desc
;

