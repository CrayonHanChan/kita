--각 테이블 별 필드명 정리한 내용입니다.
--========================================
select * from channel;         -- 제휴사, 고객번호, 이용횟수
select * from compet;         -- 제휴사, 고객번호, 경쟁사, 이용년월
select * from custdemo;      --        고객번호, 성별, 연령대, 거주지역
select * from member;        --        고객번호, 멤버십명, 가입년월
select * from prodcls;          -- 제휴사,                     대분류코드, 중분류코드, 소분류코드, 중분류명, 소분류명
select * from purprod;        -- 제휴사,          영수증번호, 대분류코드, 중분류코드, 소분류코드, 고객번호, 점포코드, 구매일자, 구매시간, 구매금액

-- 종합과제 : LMEMBERS 데이터셋을 탐색하여 가장 큰 이슈(근거설명)를 찾아서 그 대책을 제안하세요.
-- 예시 : 구매감소 고객 증가(14년 상반기 대비 15년 하반기) 및 대응 방안
-- 분석 결과 리포트를 PPT로 작성 발표
-- [Point] 상품관련 내용은 반드시 포함, 고객에 대한 이슈를 선택

--고객 이용횟수 카운트.
---1번 이용고객 1535, 2번 892, 3번 616, ... 10번 226..
--lmembers에서 가장 큰 이슈가 뭘까? 2014-2015중에 적게 이용한 고객.(사실상 휴면아이디) 이 고객들은 왜 떠났는가?
--이 이슈를 해결하는 방향은 어떨까요?
--고객사 입장에서.. 1번이나 2번정도로 적게 이용한 고객을 사로잡는것이 좋을 것같다.
select "이용횟수", count("이용횟수")
from channel
where "이용횟수" > 0
group by "이용횟수"
order by count("이용횟수") desc;

--lmembers 의 제휴사 포함 총 이용횟수 119,736
select sum(sum(이용횟수))
from channel
group by 이용횟수;

--우선 이용횟수를 여러가지 분류로 나눠서 확인해보는것이 좋을것같다.
--제조사별 고객 이용횟수
select "제휴사", count("이용횟수")
from channel
group by "제휴사"
order by count("이용횟수") desc;

--총 고객수 6766명
select "고객번호", count(*)
from channel
where "고객번호" > 0
group by "고객번호";

--가장 많이 이용한횟수 5번.(총3명), 4번은 15명.. 데이터가 이상해서 다시 확인필요
select channel."고객번호", count(channel."고객번호")
from compet, channel
--where channel.제휴사 = compet.제휴사 
group by channel."고객번호"
order by count(channel."고객번호") desc;

--고객 성별에따른 이용횟수 오류;;
select "성별", count("성별")
from custdemo
group by "성별"
order by count("성별");

--연령대별 이용횟수.. 중복이 있음... 추후 수정필요
select custdemo."연령대", count(custdemo."연령대")
from custdemo
group by custdemo."연령대"
order by custdemo."연령대";

--고객 거주지역에 따른 이용횟수 이것도 중복있음..
select "거주지역", count("거주지역")
from custdemo
group by "거주지역"
order by count("거주지역") desc;

--멤버십 별로 이용횟수.. 중복있음 수정필요
--하이마트 롭스 다둥이 더영 에서 고객이 사용.
--하이마트가 4418로 절반이상. 그다음 다둥이 2009.
--롭스와 더영이 합해서 1000정도밖에안되어서 이슈가 있음. 늘려야함
select 멤버십명, count("멤버십명")
from member
group by "멤버십명";

--경쟁사별 
select 경쟁사, count("경쟁사")
from compet
group by 경쟁사
order by count("경쟁사") desc;

SELECT *
FROM compet



select *
from compet;

--채널 테이블에서는 제휴사와 경쟁사의 이용년월 별로 뽑기
--그리고 이용년월 별로 뽑은 것을 제휴사와 경쟁사와 비교해서 
select * from channel;

select * from member;

--고객포함. 고객기준으로 어떤 이슈던지 고객별로 나와야함
--원인이 될것이 상품이 될 가능성이 높음. 상품은 꼭 포함
--4분기로나누고(14상 14하 14상 14하)
--이슈가 뭘까..
--데이터를 분석하고 그 안에서 이슈를 찾아야함
--예를 들면, 구매감소 고객 증가(14년 상반기 대비 15년 하반기) 및 대응 방안
--또 다른 예는 데이터를 이것저것 뽑아보면서 넓게 데이터를 찾아보자
--여러가지 기준들.. 분기별, 나이대별, 성별, 제품별, 거주지역별... 혹은, 몰려있을 법한 것들 위주로..
--여러 기준들을 합쳐보거나 빼보거나 하면서 데이터를 분석 정리 해보자.
--특히 pruprod 의 고객코드와 함께 구매일자 구매시간 구매금액가 제공되어있기 때문에 이것으로 많이 볼 수 있을듯함
--구매시간별 구매 패턴, 구매 금액을 나눠서 볼 수 있을듯.
--혹은... 총구매합이 높은 구매자.. 혹은 평범하지만 구매 횟수가 많은 이용자... 그분들의 구매일자를 확인해 보고,
--그 구매일자를 멤버쉽 가입년월로도 비교해보고 분기별로 나눠서 구매 시간을 나눠보기도 하고,
--이정도까지가 member가입년월
--경쟁사의 이용년월을 알아보고 
select *
from purprod;

--분기별로 purprod 보기
SELECT *
FROM PURPROD
WHERE
  ("구매일자" BETWEEN '20140101' AND '20140630')
  OR
  ("구매일자" BETWEEN '20140701' AND '20141231')
  OR
  ("구매일자" BETWEEN '20150101' AND '20150630')
  OR
  ("구매일자" BETWEEN '20150701' AND '20151231');

--분기별로 purprod 구매일자 구매시간 구매금액 보기
SELECT
    CASE
        WHEN "구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
        WHEN "구매일자" BETWEEN '20140701' AND '20141231' THEN '2014년 하반기'
        WHEN "구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
        WHEN "구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
        ELSE '기타'
    END AS "분기",
    "구매일자",
    "구매시간",
    "구매금액"
FROM purprod
WHERE
    ("구매일자" BETWEEN '20140101' AND '20140630')
    OR
    ("구매일자" BETWEEN '20140701' AND '20141231')
    OR
    ("구매일자" BETWEEN '20150101' AND '20150630')
    OR
    ("구매일자" BETWEEN '20150701' AND '20151231');


--구매시간 min max avg 보기
select min(구매시간), max(구매시간), avg(구매시간)
from purprod;

--purprod 구매시간 아침점심저녁 그외 야간 으로 나눠 보기
SELECT
    CASE
        WHEN "구매시간" BETWEEN 6 AND 11 THEN '아침'
        WHEN "구매시간" BETWEEN 12 AND 17 THEN '점심'
        WHEN "구매시간" BETWEEN 18 AND 21 THEN '저녁'
        ELSE '야간'
    END AS "시간대",
    COUNT(*) AS "구매건수"
FROM purprod
GROUP BY
    CASE
        WHEN "구매시간" BETWEEN 6 AND 11 THEN '아침'
        WHEN "구매시간" BETWEEN 12 AND 17 THEN '점심'
        WHEN "구매시간" BETWEEN 18 AND 21 THEN '저녁'
        ELSE '야간'
    END
ORDER BY
    CASE
        WHEN "구매시간" BETWEEN 6 AND 11 THEN '아침'
        WHEN "구매시간" BETWEEN 12 AND 17 THEN '점심'
        WHEN "구매시간" BETWEEN 18 AND 21 THEN '저녁'
        ELSE '야간'
    END;

--"purprod" 테이블을 분기별로 나누어서 아침, 점심, 저녁, 야간 시간대별 구매건수를 조회 + 분기별합산포함
--2014년상반기 부터 2015년 상반기까지 아침점심저녁야간 쭉 구매건수가 늘다가.
--2015년 하반기에 갑자기 하락세임.
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            WHEN "구매일자" BETWEEN '20140701' AND '20141231' THEN '2014년 하반기'
            WHEN "구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
            WHEN "구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
            ELSE '기타'
        END AS "분기",
        CASE
            WHEN "구매시간" BETWEEN 6 AND 11 THEN '아침'
            WHEN "구매시간" BETWEEN 12 AND 17 THEN '점심'
            WHEN "구매시간" BETWEEN 18 AND 21 THEN '저녁'
            ELSE '야간'
        END AS "시간대"
    FROM purprod
    WHERE
        ("구매일자" BETWEEN '20140101' AND '20140630')
        OR
        ("구매일자" BETWEEN '20140701' AND '20141231')
        OR
        ("구매일자" BETWEEN '20150101' AND '20150630')
        OR
        ("구매일자" BETWEEN '20150701' AND '20151231')
)
SELECT
    "분기",
    "시간대",
    COUNT(*) AS "구매건수",
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기", "시간대"
ORDER BY "분기", "시간대";


--구매금액 min max avg
select min(구매금액), max(구매금액), avg(구매금액)
from purprod;


--구매금액을 세분화한 결과에 따라 분기별, 시간대별 구매건수 및 분기별 합산 구매건수를 보여주는 쿼리문
--점심 시간대(12:00-17:00)에 구매건수가 가장 많음
--그러나 아침(06:00-11:00)과 저녁(18:00-21:00) 시간대에도 상당한 구매건수가 있음
--1000-5000원 범위와 5000-10000원 범위의 구매건수가 가장 많음
--더 높은 금액대(10000원 이상)의 구매건수도 상당히 많음
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            WHEN "구매일자" BETWEEN '20140701' AND '20141231' THEN '2014년 하반기'
            WHEN "구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
            WHEN "구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
            ELSE '기타'
        END AS "분기",
        CASE
            WHEN "구매시간" BETWEEN 6 AND 11 THEN '아침'
            WHEN "구매시간" BETWEEN 12 AND 17 THEN '점심'
            WHEN "구매시간" BETWEEN 18 AND 21 THEN '저녁'
            ELSE '야간'
        END AS "시간대",
        CASE
            WHEN "구매금액" BETWEEN 0 AND 1000 THEN '0-1000'
            WHEN "구매금액" BETWEEN 1000 AND 5000 THEN '1000-5000'
            WHEN "구매금액" BETWEEN 5000 AND 10000 THEN '5000-10000'
            WHEN "구매금액" BETWEEN 10000 AND 20000 THEN '10000-20000'
            WHEN "구매금액" BETWEEN 20000 AND 50000 THEN '20000-50000'
            WHEN "구매금액" BETWEEN 50000 AND 200000 THEN '50000-200000'
            WHEN "구매금액" BETWEEN 200000 AND 1000000 THEN '200000-1000000'
            WHEN "구매금액" BETWEEN 1000000 AND 10000000 THEN '1000000-10000000'
            ELSE '그외'
        END AS "구매금액분류"
    FROM purprod
    WHERE
        ("구매일자" BETWEEN '20140101' AND '20140630')
        OR
        ("구매일자" BETWEEN '20140701' AND '20141231')
        OR
        ("구매일자" BETWEEN '20150101' AND '20150630')
        OR
        ("구매일자" BETWEEN '20150701' AND '20151231')
)
SELECT
    "분기",
    "시간대",
    "구매금액분류",
    COUNT(*) AS "구매건수",
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기", "시간대", "구매금액분류"
ORDER BY "분기", "시간대", "구매금액분류";

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
select * from prodcls;


--상품을 분기별로 나눠서 쿼리문을 작성
--# 제휴사별 소분류 리스트 ('A,B,C,D')

SELECT
    "제휴사",
    CONCAT("대분류코드", "중분류코드") AS "A1 코드",
    "중분류명",
    "소분류명"
FROM prodcls;


-- A 제휴사에 대한 소분류 리스트 (하이마트)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '하이마트')
    AND PP.제휴사 IN ('A') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC;
    
    
-- B 제휴사에 대한 소분류 리스트 (하이마트)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '하이마트')
    AND PP.제휴사 IN ('B') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC;


-- C 제휴사에 대한 소분류 리스트 (하이마트)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '하이마트')
    AND PP.제휴사 IN ('C') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC;
    

-- D 제휴사에 대한 소분류 리스트 (하이마트)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '하이마트')
    AND PP.제휴사 IN ('D') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC;
--#=====================================================================


-- A 제휴사에 대한 소분류 리스트 (롭스)  
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '롭스')
    AND PP.제휴사 IN ('A') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC; 
    
    
-- B 제휴사에 대한 소분류 리스트 (롭스)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '롭스')
    AND PP.제휴사 IN ('B') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC; 
    
    
-- C 제휴사에 대한 소분류 리스트 (롭스)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '롭스')
    AND PP.제휴사 IN ('C') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC; 
    
    
-- D 제휴사에 대한 소분류 리스트 (롭스)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '롭스')
    AND PP.제휴사 IN ('D') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC;     
--#=====================================================================


-- A 제휴사에 대한 소분류 리스트 (더영)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '더영')
    AND PP.제휴사 IN ('A') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC;    


-- B 제휴사에 대한 소분류 리스트 (더영)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '더영')
    AND PP.제휴사 IN ('B') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC;    


-- C 제휴사에 대한 소분류 리스트 (더영)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '더영')
    AND PP.제휴사 IN ('C') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC;    
    
    
  -- D 제휴사에 대한 소분류 리스트 (더영)  
 SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '더영')
    AND PP.제휴사 IN ('D') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC;       
--#=====================================================================


-- A 제휴사에 대한 소분류 리스트 (다둥이)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '다둥이')
    AND PP.제휴사 IN ('A') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC;  
    
    
-- B 제휴사에 대한 소분류 리스트 (다둥이)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '다둥이')
    AND PP.제휴사 IN ('B') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC; 
    

-- C 제휴사에 대한 소분류 리스트 (다둥이)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '다둥이')
    AND PP.제휴사 IN ('C') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC; 


-- D 제휴사에 대한 소분류 리스트 (다둥이)
SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    COUNT(*) AS 구매건수
FROM
    purprod PP
LEFT OUTER JOIN
    prodcls PC ON PP.소분류코드 = PC.소분류코드
WHERE
    PP.고객번호 IN (SELECT 고객번호 FROM member WHERE 멤버십명 = '다둥이')
    AND PP.제휴사 IN ('D') 
GROUP BY
    PP.제휴사, PP.소분류코드, PC.소분류명
ORDER BY
    PP.제휴사, 구매건수 DESC; 


----
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN p."구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            WHEN p."구매일자" BETWEEN '20140701' AND '20141231' THEN '2014년 하반기'
            WHEN p."구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
            WHEN p."구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
            ELSE '기타'
        END AS "분기",
        CASE
            WHEN p."구매시간" BETWEEN 6 AND 11 THEN '아침'
            WHEN p."구매시간" BETWEEN 12 AND 17 THEN '점심'
            WHEN p."구매시간" BETWEEN 18 AND 21 THEN '저녁'
            ELSE '야간'
        END AS "시간대",
        CASE
            WHEN p."구매금액" BETWEEN 0 AND 1000 THEN '0-1000'
            WHEN p."구매금액" BETWEEN 1000 AND 5000 THEN '1000-5000'
            WHEN p."구매금액" BETWEEN 5000 AND 10000 THEN '5000-10000'
            WHEN p."구매금액" BETWEEN 10000 AND 20000 THEN '10000-20000'
            WHEN p."구매금액" BETWEEN 20000 AND 50000 THEN '20000-50000'
            WHEN p."구매금액" BETWEEN 50000 AND 200000 THEN '50000-200000'
            WHEN p."구매금액" BETWEEN 200000 AND 1000000 THEN '200000-1000000'
            WHEN p."구매금액" BETWEEN 1000000 AND 10000000 THEN '1000000-10000000'
            ELSE '그외'
        END AS "구매금액분류",
        p."대분류코드",
        p."중분류코드",
        p."소분류코드"
    FROM purprod p
    WHERE
        (p."구매일자" BETWEEN '20140101' AND '20140630')
        OR
        (p."구매일자" BETWEEN '20140701' AND '20141231')
        OR
        (p."구매일자" BETWEEN '20150101' AND '20150630')
        OR
        (p."구매일자" BETWEEN '20150701' AND '20151231')
)
SELECT
    "분기",
    "시간대",
    "대분류코드",
    "중분류코드",
    "소분류코드",
    "구매금액분류",
    COUNT(*) AS "구매건수",
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기", "시간대", "대분류코드", "중분류코드", "소분류코드", "구매금액분류"
ORDER BY "분기", "시간대", "대분류코드", "중분류코드", "소분류코드", "구매금액분류";
-----------------------------------------------------------------------------


--분기 대분류 구매건수
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN p."구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            WHEN p."구매일자" BETWEEN '20140701' AND '20141231' THEN '2014년 하반기'
            WHEN p."구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
            WHEN p."구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
            ELSE '기타'
        END AS "분기",
        p."대분류코드"
    FROM purprod p
    WHERE
        (p."구매일자" BETWEEN '20140101' AND '20140630')
        OR
        (p."구매일자" BETWEEN '20140701' AND '20141231')
        OR
        (p."구매일자" BETWEEN '20150101' AND '20150630')
        OR
        (p."구매일자" BETWEEN '20150701' AND '20151231')
)
SELECT
    "분기",
    "대분류코드",
    COUNT(*) AS "구매건수"
FROM TimeBasedData
GROUP BY "분기", "대분류코드"
HAVING COUNT(*) >= 10000
ORDER BY "분기", "대분류코드", "구매건수" DESC;


--분기 대분류 중분류 구매건수
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN p."구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            WHEN p."구매일자" BETWEEN '20140701' AND '20141231' THEN '2014년 하반기'
            WHEN p."구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
            WHEN p."구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
            ELSE '기타'
        END AS "분기",
        p."대분류코드",
        p."중분류코드"
    FROM purprod p
    WHERE
        (p."구매일자" BETWEEN '20140101' AND '20140630')
        OR
        (p."구매일자" BETWEEN '20140701' AND '20141231')
        OR
        (p."구매일자" BETWEEN '20150101' AND '20150630')
        OR
        (p."구매일자" BETWEEN '20150701' AND '20151231')
)
SELECT
    "분기",
    "대분류코드",
    "중분류코드",
    COUNT(*) AS "구매건수"
FROM TimeBasedData
GROUP BY "분기", "대분류코드", "중분류코드"
HAVING COUNT(*) >= 10000
ORDER BY "분기", "대분류코드", "중분류코드", "구매건수" DESC;

--대분류 중분류 소분류 가 회사마다 다르게 섞여있을 수 있음!
--예를 들면, 0801이 명품도 있지만 패스트푸드(...) 도 섞여있음...
--그래서 실제 데이터 분석할때에는 데이터분석가들이 네이버나 쿠팡같은곳의 상품분류체계를 활용해서 통합을 시킴. 그래야 섞이지 않고 분류 할 수있게됨
--


select * from channel;
select * from compet;
select * from prodcls;
select * from purprod;

--기간 : 2015상반기, 2015하반기로 나눠서 비교.
--가격은 천원~만원의 상품.
--purprod 테이블을 활용해서 만들어 보자.

-- 2015년 상반기와 하반기에서 천원에서 만원대의 상품 수
SELECT '2015년 상반기' AS 기간, COUNT(*) AS 천원_만원대_상품_수
FROM purprod
WHERE 구매일자 BETWEEN '20150101' AND '20150630'
  AND 구매금액 >= 1000
  AND 구매금액 <= 10000
UNION
SELECT '2015년 하반기' AS 기간, COUNT(*) AS 천원_만원대_상품_수
FROM purprod
WHERE 구매일자 BETWEEN '20150701' AND '20151231'
  AND 구매금액 >= 1000
  AND 구매금액 <= 10000;
  
--총 상품수가 출력되게끔되었어. 좋아. 이제 구매 총 금액을 살펴보자. 
-- 2015년 상반기와 하반기에서 천원에서 만원대의 상품 수 및 구매 총 금액
SELECT '2015년 상반기' AS 기간,
       COUNT(*) AS 천원_만원대_상품_수,
       SUM(구매금액) AS 상반기_총_구매_금액
FROM purprod
WHERE 구매일자 BETWEEN '20150101' AND '20150630'
  AND 구매금액 >= 1000
  AND 구매금액 <= 10000
UNION
SELECT '2015년 하반기' AS 기간,
       COUNT(*) AS 천원_만원대_상품_수,
       SUM(구매금액) AS 하반기_총_구매_금액
FROM purprod
WHERE 구매일자 BETWEEN '20150701' AND '20151231'
  AND 구매금액 >= 1000
  AND 구매금액 <= 10000;

--이것에 시간대별로 구분해서 한번 확인해보자
--분기, 시간대(아침점심저녁 그외 야간), 구매금액(1000~10000원)로 분류하여 구매건수를 구하는 쿼리문
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN p."구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            WHEN p."구매일자" BETWEEN '20140701' AND '20141231' THEN '2014년 하반기'
            WHEN p."구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
            WHEN p."구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
            ELSE '기타'
        END AS "분기",
        CASE
            WHEN p."구매시간" BETWEEN 6 AND 11 THEN '아침'
            WHEN p."구매시간" BETWEEN 12 AND 17 THEN '점심'
            WHEN p."구매시간" BETWEEN 18 AND 21 THEN '저녁'
            ELSE '야간'
        END AS "시간대",
        CASE
            WHEN p."구매금액" BETWEEN 1000 AND 10000 THEN '1000-10000'
            ELSE '그외'
        END AS "구매금액분류"
    FROM purprod p
    WHERE
        (p."구매일자" BETWEEN '20140101' AND '20140630')
        OR
        (p."구매일자" BETWEEN '20140701' AND '20141231')
        OR
        (p."구매일자" BETWEEN '20150101' AND '20150630')
        OR
        (p."구매일자" BETWEEN '20150701' AND '20151231')
)
SELECT
    "분기",
    "시간대",
    "구매금액분류",
    COUNT(*) AS "구매건수",
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기", "시간대", "구매금액분류"
ORDER BY "분기", "시간대", "구매금액분류";
--분기별로 나눠서 구매건수를 보니, 2014년 상반기 : 6709382,  2014년 하반기 : 7162132, 2015년 상반기 : 7474098, 2015년 하반기 : 7247418
--2015년 하반기에 구매건수가 줄어드는 양상을 보입니다. 그래서 이부분을 이슈라 판단하여 왜 그런 양상을 보이는지 확인해 볼 필요가 있었습니다.
--구매금액을 나눠서 확인해보니, 감소폭이 구매금액이 1000~10000원의 건수가 가장 하락폭이 높았습니다.
--그래서 구매금액이 1000~10000원사이인 것들을 좀더 알아보았습니다.
--분기 별, 아침점심저녁 야간(시간대별) 로 분류하고 구매금액이 1000~10000원 사이인 제품들을 구매건수를 확인해보니,
--전반기 대비 2015년하반기에 구매건수가 .. 양상설명
--2015년 하반기의 구매건수 하락하는 양상을 보이는 데이터로 볼수 있는것은 회사측에서는 크리티컬한 이슈라고 판단했습니다.
--
--구매건수 하락의 이슈에대한 규칙성과 대책방안을 세우기 위한 데이터 분석을 하였습니다.
--1. 제품별로 하락의 양상을 확인 2. 고객별로 하락의 양상을 확인 해보기로 하였습니다.

--분기, 시간대(아침점심저녁 그외 야간), 구매금액(1000~10000원)로 분류하여 구매건수를 구하는 쿼리문
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN p."구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            WHEN p."구매일자" BETWEEN '20140701' AND '20141231' THEN '2014년 하반기'
            WHEN p."구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
            WHEN p."구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
            ELSE '기타'
        END AS "분기",
        CASE
            WHEN p."구매시간" BETWEEN 6 AND 11 THEN '아침'
            WHEN p."구매시간" BETWEEN 12 AND 17 THEN '점심'
            WHEN p."구매시간" BETWEEN 18 AND 21 THEN '저녁'
            ELSE '야간'
        END AS "시간대",
        CASE
            WHEN p."구매금액" BETWEEN 1000 AND 10000 THEN '1000-10000'
            ELSE '그외'
        END AS "구매금액분류"
    FROM purprod p
    WHERE
        (p."구매일자" BETWEEN '20140101' AND '20140630')
        OR
        (p."구매일자" BETWEEN '20140701' AND '20141231')
        OR
        (p."구매일자" BETWEEN '20150101' AND '20150630')
        OR
        (p."구매일자" BETWEEN '20150701' AND '20151231')
)
SELECT
    "분기",
    "시간대",
    "구매금액분류",
    COUNT(*) AS "구매건수",
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기", "시간대", "구매금액분류"
ORDER BY "분기", "시간대", "구매금액분류";

----
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            WHEN "구매일자" BETWEEN '20140701' AND '20141231' THEN '2014년 하반기'
            WHEN "구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
            WHEN "구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
            ELSE '기타'
        END AS "분기",
        CASE
            WHEN "구매시간" BETWEEN 6 AND 11 THEN '아침'
            WHEN "구매시간" BETWEEN 12 AND 17 THEN '점심'
            WHEN "구매시간" BETWEEN 18 AND 21 THEN '저녁'
            ELSE '야간'
        END AS "시간대",
        CASE
            WHEN "구매금액" BETWEEN 0 AND 1000 THEN '~ 1천원'
            WHEN "구매금액" BETWEEN 1001 AND 10000 THEN '~ 1만원'
            WHEN "구매금액" BETWEEN 10001 AND 50000 THEN '~ 5만원'
            WHEN "구매금액" BETWEEN 50001 AND 100000 THEN '~ 10만'
            WHEN "구매금액" BETWEEN 100001 AND 1000000 THEN '~ 100만'
            WHEN "구매금액" BETWEEN 1000001 AND 10000000 THEN '~ 1000만'
            ELSE '1000만 초과'
        END AS "구매금액분류"
    FROM purprod
    WHERE
        ("구매일자" BETWEEN '20140101' AND '20140630')
        OR
        ("구매일자" BETWEEN '20140701' AND '20141231')
        OR
        ("구매일자" BETWEEN '20150101' AND '20150630')
        OR
        ("구매일자" BETWEEN '20150701' AND '20151231')
)
SELECT
    "분기",
    "시간대",
    "구매금액분류",
    COUNT(*) AS "구매건수",
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기", "시간대", "구매금액분류"
ORDER BY "분기", "시간대", "구매금액분류";

---------------------------------------

select * from custdemo;      --        고객번호, 성별, 연령대, 거주지역
select * from compet;

select 구매금액
from purprod
where 구매금액 = 10000;

--고객에 따라서 분류해서 한번해보자.
--고객이 2015년 상반기 2015년 하반기의 구매한 건수를 따라서 고객번호가 같은것끼리(같은고객)을 비교.
--고객의 정보 성별 연령대 등을 포함한뒤..
--무엇으로 비교할거냐면..... 구매건수..



--고객에 따라 구매 건수를 분류하고 고객의 정보를 포함한 쿼리를 만들려면 다음과 같이 수정할 수 있습니다
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            WHEN "구매일자" BETWEEN '20140701' AND '20141231' THEN '2014년 하반기'
            WHEN "구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
            WHEN "구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
            ELSE '기타'
        END AS "분기",
        CASE
            WHEN "구매시간" BETWEEN 6 AND 11 THEN '아침'
            WHEN "구매시간" BETWEEN 12 AND 17 THEN '점심'
            WHEN "구매시간" BETWEEN 18 AND 21 THEN '저녁'
            ELSE '야간'
        END AS "시간대",
        CASE
            WHEN "구매금액" BETWEEN 0 AND 1000 THEN '천원 미만'
            WHEN "구매금액" BETWEEN 1000 AND 10000 THEN '천원-1만'
            WHEN "구매금액" BETWEEN 10000 AND 50000 THEN '1만-5만'
            WHEN "구매금액" BETWEEN 50000 AND 100000 THEN '5만-10만'
            WHEN "구매금액" BETWEEN 100000 AND 1000000 THEN '10만-100만'
            WHEN "구매금액" BETWEEN 1000000 AND 10000000 THEN '100만-1000만'
            ELSE '1000만 이상'
        END AS "구매금액분류"
    FROM purprod
    WHERE
        ("구매일자" BETWEEN '20140101' AND '20140630')
        OR
        ("구매일자" BETWEEN '20140701' AND '20141231')
        OR
        ("구매일자" BETWEEN '20150101' AND '20150630')
        OR
        ("구매일자" BETWEEN '20150701' AND '20151231')
)
SELECT
    "분기",
    "시간대",
    "구매금액분류",
    COUNT(*) AS "구매건수",
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기", "시간대", "구매금액분류"
ORDER BY "분기", "시간대", "구매금액분류";


---
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            ELSE '기타'
        END AS "분기",
        CASE
            WHEN "구매시간" BETWEEN 6 AND 11 THEN '아침'
            WHEN "구매시간" BETWEEN 12 AND 17 THEN '점심'
            WHEN "구매시간" BETWEEN 18 AND 21 THEN '저녁'
            ELSE '야간'
        END AS "시간대",
        CASE
            WHEN "구매금액" BETWEEN 0 AND 1000 THEN '천원 미만'
            WHEN "구매금액" BETWEEN 1000 AND 10000 THEN '천원-1만'
            WHEN "구매금액" BETWEEN 10000 AND 50000 THEN '1만-5만'
            WHEN "구매금액" BETWEEN 50000 AND 100000 THEN '5만-10만'
            WHEN "구매금액" BETWEEN 100000 AND 1000000 THEN '10만-100만'
            WHEN "구매금액" BETWEEN 1000000 AND 10000000 THEN '100만-1000만'
            ELSE '1000만 이상'
        END AS "구매금액분류"
    FROM purprod
    WHERE
        ("구매일자" BETWEEN '20140101' AND '20140630')
)
SELECT
    "분기",
    "시간대",
    "구매금액분류",
    COUNT(*) AS "구매건수",
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기", "시간대", "구매금액분류"
ORDER BY "분기", "시간대", "구매금액분류";


--------------------------------------------------------------------------------------

- 소분류 데이터 값

SELECT
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    PP.고객번호,
    PP.구매일자,
    MAX(PP.구매시간) AS 구매시간,
    PP.구매금액,
    CASE
        WHEN TO_NUMBER(SUBSTR(MAX(PP.구매시간), 1, 2)) BETWEEN 6 AND 11 THEN '아침'
        WHEN TO_NUMBER(SUBSTR(MAX(PP.구매시간), 1, 2)) BETWEEN 12 AND 17 THEN '점심'
        WHEN TO_NUMBER(SUBSTR(MAX(PP.구매시간), 1, 2)) BETWEEN 18 AND 21 THEN '저녁'
        ELSE '야간'
    END AS 시간대
FROM PURPROD PP
JOIN PRODCLS PC ON PP.소분류코드 = PC.소분류코드
WHERE PP.제휴사 = 'A' -- A제휴사만 필터링
  AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
  AND PP.구매금액 BETWEEN 1000 AND 10000
GROUP BY
    PP.제휴사,
    PP.소분류코드,
    PC.소분류명,
    PP.고객번호,
    PP.구매일자,
    PP.구매금액
ORDER BY TO_NUMBER(SUBSTR(MAX(PP.구매시간), 1, 2)), PP.고객번호;



SELECT
    PC.소분류명,
    COUNT(*) AS 거래건수,
    SUM(PP.구매금액) AS 총구매금액
FROM PURPROD PP
JOIN PRODCLS PC ON PP.소분류코드 = PC.소분류코드
WHERE PP.제휴사 = 'A' -- A제휴사만 필터링
  AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
  AND PP.구매금액 BETWEEN 1000 AND 10000
GROUP BY PC.소분류명
ORDER BY 거래건수 DESC, 총구매금액 ASC;


----------1122

WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            ELSE '기타'
        END AS "분기",
        CASE
            WHEN "구매시간" BETWEEN 6 AND 11 THEN '아침'
            WHEN "구매시간" BETWEEN 12 AND 17 THEN '점심'
            WHEN "구매시간" BETWEEN 18 AND 21 THEN '저녁'
            ELSE '야간'
        END AS "시간대",
        CASE
            WHEN "구매금액" BETWEEN 0 AND 1000 THEN '천원 미만'
            WHEN "구매금액" BETWEEN 1000 AND 10000 THEN '천원-1만'
            WHEN "구매금액" BETWEEN 10000 AND 50000 THEN '1만-5만'
            WHEN "구매금액" BETWEEN 50000 AND 100000 THEN '5만-10만'
            WHEN "구매금액" BETWEEN 100000 AND 1000000 THEN '10만-100만'
            WHEN "구매금액" BETWEEN 1000000 AND 10000000 THEN '100만-1000만'
            ELSE '1000만 이상'
        END AS "구매금액분류"
    FROM purprod
    WHERE
        ("구매일자" BETWEEN '20140101' AND '20140630')
)
SELECT
    "분기",
    "시간대",
    "구매금액분류",
    COUNT(*) AS "구매건수",
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기", "시간대", "구매금액분류"
ORDER BY "분기", "시간대", "구매금액분류";

----
-- 2015년 상반기

WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
            ELSE '기타'
        END AS "분기",
        CASE
            WHEN "구매시간" BETWEEN 6 AND 11 THEN '아침'
            WHEN "구매시간" BETWEEN 12 AND 17 THEN '점심'
            WHEN "구매시간" BETWEEN 18 AND 21 THEN '저녁'
            ELSE '야간'
        END AS "시간대",
        CASE
            WHEN "구매금액" BETWEEN 0 AND 1000 THEN '천원 미만'
            WHEN "구매금액" BETWEEN 1000 AND 10000 THEN '천원-1만'
            WHEN "구매금액" BETWEEN 10000 AND 50000 THEN '1만-5만'
            WHEN "구매금액" BETWEEN 50000 AND 100000 THEN '5만-10만'
            WHEN "구매금액" BETWEEN 100000 AND 1000000 THEN '10만-100만'
            WHEN "구매금액" BETWEEN 1000000 AND 10000000 THEN '100만-1000만'
            ELSE '1000만 이상'
        END AS "구매금액분류"
    FROM purprod
    WHERE
        ("구매일자" BETWEEN '20150101' AND '20150630')
)
SELECT
    "분기",
    "시간대",
    "구매금액분류",
    COUNT(*) AS "구매건수",
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기", "시간대", "구매금액분류"
ORDER BY "분기", "시간대", "구매금액분류";


--
-- 2015년 하반기

WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
            ELSE '기타'
        END AS "분기",
        CASE
            WHEN "구매시간" BETWEEN 6 AND 11 THEN '아침'
            WHEN "구매시간" BETWEEN 12 AND 17 THEN '점심'
            WHEN "구매시간" BETWEEN 18 AND 21 THEN '저녁'
            ELSE '야간'
        END AS "시간대",
        CASE
            WHEN "구매금액" BETWEEN 0 AND 1000 THEN '천원 미만'
            WHEN "구매금액" BETWEEN 1000 AND 10000 THEN '천원-1만'
            WHEN "구매금액" BETWEEN 10000 AND 50000 THEN '1만-5만'
            WHEN "구매금액" BETWEEN 50000 AND 100000 THEN '5만-10만'
            WHEN "구매금액" BETWEEN 100000 AND 1000000 THEN '10만-100만'
            WHEN "구매금액" BETWEEN 1000000 AND 10000000 THEN '100만-1000만'
            ELSE '1000만 이상'
        END AS "구매금액분류"
    FROM purprod
    WHERE
        ("구매일자" BETWEEN '20150601' AND '20151231')
)
SELECT
    "분기",
    "시간대",
    "구매금액분류",
    COUNT(*) AS "구매건수",
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기", "시간대", "구매금액분류"
ORDER BY "분기", "시간대", "구매금액분류";

--


where 소분류명 IN ('감자스낵', '고추', '과일음료', '구강청정제', '국물용기라면', '국산맥주', '국산콩나물', '기능성우유', '기타레토르트', '농산가공',
                  '다이소', '두부류', '디저트류', '떠먹는요구르트', '마시는요구르트', '막걸리', '면봉/화장솜', '바나나', '보네스빼', '봉지라면',
                  '부침두부', '뷰티상품', '샌드', '생리대', '생선', '서양델리', '소스', '소시지', '스넥(부대)', '스포츠음료',
                  '스폰지/퍼프', '양파', '어린이/액상요구르트', '어묵', '에스닉푸드', '여성헤어액세서리', '염모제', '옥수수스낵', '위생세제', '유기농채소',
                  '유제품', '일반가공식품', '일반계란', '일반소주', '일반스낵', '일반우유', '일반흰우유', '일용잡화', '전문베이커리', '제과제빵',
                  '주류', '중식델리', '즉석반찬', '채소', '청과', '친환경채소(특약)', '콘스낵', '콩나물', '쿠키', '크래커',
                  '트리트먼트/팩', '파이', '판초콜릿', '팬티라이너', '페이셜클렌저', '풋케어', '하드캔디', '핸드로션/크림', '햄', '헤어에센스',
                  '혼합탄산')

--

SELECT
    CD.고객번호,
    PC.소분류명,
    COUNT(PP.구매일자) AS 구매횟수,
    SUM(PP.구매금액) AS 총구매금액
FROM CUSTDEMO CD
JOIN PURPROD PP ON CD.고객번호 = PP.고객번호
JOIN PRODCLS PC ON PP.소분류코드 = PC.소분류코드
WHERE TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
  AND PC.소분류명 IN ('감자스낵', '고추', '과일음료', '구강청정제', '국물용기라면', '국산맥주', '국산콩나물', '기능성우유', '기타레토르트', '농산가공',
                  '다이소', '두부류', '디저트류', '떠먹는요구르트', '마시는요구르트', '막걸리', '면봉/화장솜', '바나나', '보네스빼', '봉지라면',
                  '부침두부', '뷰티상품', '샌드', '생리대', '생선', '서양델리', '소스', '소시지', '스넥(부대)', '스포츠음료',
                  '스폰지/퍼프', '양파', '어린이/액상요구르트', '어묵', '에스닉푸드', '여성헤어액세서리', '염모제', '옥수수스낵', '위생세제', '유기농채소',
                  '유제품', '일반가공식품', '일반계란', '일반소주', '일반스낵', '일반우유', '일반흰우유', '일용잡화', '전문베이커리', '제과제빵',
                  '주류', '중식델리', '즉석반찬', '채소', '청과', '친환경채소(특약)', '콘스낵', '콩나물', '쿠키', '크래커',
                  '트리트먼트/팩', '파이', '판초콜릿', '팬티라이너', '페이셜클렌저', '풋케어', '하드캔디', '핸드로션/크림', '햄', '헤어에센스',
                  '혼합탄산')
  AND PP.구매금액 BETWEEN 1000 AND 10000
GROUP BY CD.고객번호, PC.소분류명
ORDER BY 구매횟수 DESC;

--
SELECT
    CD.고객번호,
    PP.구매일자,
    PC.소분류명,
    COUNT(PP.구매일자) AS 구매횟수,
    SUM(PP.구매금액) AS 총구매금액
FROM CUSTDEMO CD
JOIN PURPROD PP ON CD.고객번호 = PP.고객번호
JOIN PRODCLS PC ON PP.소분류코드 = PC.소분류코드
WHERE TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-6-30', 'YYYY-MM-DD')
  AND PC.소분류명 IN ('감자스낵', '고추', '과일음료', '구강청정제', '국물용기라면', '국산맥주', '국산콩나물', '기능성우유', '기타레토르트', '농산가공',
                  '다이소', '두부류', '디저트류', '떠먹는요구르트', '마시는요구르트', '막걸리', '면봉/화장솜', '바나나', '보네스빼', '봉지라면',
                  '부침두부', '뷰티상품', '샌드', '생리대', '생선', '서양델리', '소스', '소시지', '스넥(부대)', '스포츠음료',
                  '스폰지/퍼프', '양파', '어린이/액상요구르트', '어묵', '에스닉푸드', '여성헤어액세서리', '염모제', '옥수수스낵', '위생세제', '유기농채소',
                  '유제품', '일반가공식품', '일반계란', '일반소주', '일반스낵', '일반우유', '일반흰우유', '일용잡화', '전문베이커리', '제과제빵',
                  '주류', '중식델리', '즉석반찬', '채소', '청과', '친환경채소(특약)', '콘스낵', '콩나물', '쿠키', '크래커',
                  '트리트먼트/팩', '파이', '판초콜릿', '팬티라이너', '페이셜클렌저', '풋케어', '하드캔디', '핸드로션/크림', '햄', '헤어에센스',
                  '혼합탄산')
  AND PP.구매금액 BETWEEN 1000 AND 10000
GROUP BY CD.고객번호, PP.구매일자, PC.소분류명
ORDER BY 구매횟수 DESC, 총구매금액 DESC;


---주어진쿼리문
 select count(*) 
 from compet CP 
 inner join purprod PP on CP.고객번호 = PP.고객번호 
 where PP.구매금액 between 1000 and 10000 
       and PP.제휴사 = 'C' 
       and to_date(PP.구매일자, 'YYYYMMDD') between to_date('2015-01-01', 'YYYY-MM-DD') and to_date('2015-06-30', 'YYYY-MM-DD')
       and to_date(CP.이용년월, 'YYYYMM') between to_date('2015-01', 'YYYY-MM') and to_date('2015-6', 'YYYY-MM'); 


-------------"이용 총 고객"
 select count(*) AS "이용 총 고객"
 from compet CP 
 inner join purprod PP on CP.고객번호 = PP.고객번호 
 where PP.구매금액 between 1000 and 10000 
       and PP.제휴사 = 'A' 
       and to_date(PP.구매일자, 'YYYYMMDD') between to_date('2015-01-01', 'YYYY-MM-DD') and to_date('2015-01-31', 'YYYY-MM-DD');
--       and CP.이용년월 = 201501;

-------------"경쟁사 동시 이용 고객"
 select count(*) AS "경쟁사 동시 이용 고객"
 from compet CP 
 inner join purprod PP on CP.고객번호 = PP.고객번호 
 where PP.구매금액 between 1000 and 10000 
       and PP.제휴사 = 'A'
       and to_date(PP.구매일자, 'YYYYMMDD') between to_date('2015-01-01', 'YYYY-MM-DD') and to_date('2015-01-31', 'YYYY-MM-DD')
       and CP.이용년월 = 201501;
       
       
