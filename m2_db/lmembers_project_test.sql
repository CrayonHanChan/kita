-- 이용 총 고객 

SELECT TO_CHAR(to_date(PP.구매일자, 'YYYYMMDD'), 'YYYY-MM') AS 구매년월,
       COUNT(*) AS 거래건수
FROM compet CP
INNER JOIN purprod PP ON CP.고객번호 = PP.고객번호
WHERE PP.구매금액 BETWEEN 1000 AND 10000
      AND PP.제휴사 = 'A'
      AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
GROUP BY TO_CHAR(to_date(PP.구매일자, 'YYYYMMDD'), 'YYYY-MM')
ORDER BY 구매년월;


-- 경쟁사 동시 이용 고객  제휴사 하나하나 보기
SELECT TO_CHAR(to_date(PP.구매일자, 'YYYYMMDD'), 'YYYY-MM') AS 구매년월,
       COUNT(*) AS 거래건수
FROM compet CP
INNER JOIN purprod PP ON CP.고객번호 = PP.고객번호
WHERE PP.구매금액 BETWEEN 1000 AND 10000
      AND PP.제휴사 = 'D'
      AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-01-31', 'YYYY-MM-DD')
      and CP.이용년월 = 201501
GROUP BY TO_CHAR(to_date(PP.구매일자, 'YYYYMMDD'), 'YYYY-MM')
ORDER BY 구매년월;


-- 경쟁사 동시 이용 고객 제휴사 A,B,C,D 보기
SELECT
    TO_CHAR(to_date(PP.구매일자, 'YYYYMMDD'), 'YYYY-MM') AS 구매년월,
    SUM(CASE WHEN PP.제휴사 = 'A' THEN 1 ELSE 0 END) AS "A 거래건수",
    SUM(CASE WHEN PP.제휴사 = 'B' THEN 1 ELSE 0 END) AS "B 거래건수",
    SUM(CASE WHEN PP.제휴사 = 'C' THEN 1 ELSE 0 END) AS "C 거래건수",
    SUM(CASE WHEN PP.제휴사 = 'D' THEN 1 ELSE 0 END) AS "D 거래건수"
FROM compet CP
INNER JOIN purprod PP ON CP.고객번호 = PP.고객번호
WHERE PP.구매금액 BETWEEN 1000 AND 10000
      AND PP.제휴사 IN ('A', 'B', 'C', 'D')
      AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-03-31', 'YYYY-MM-DD')
      AND CP.이용년월 = 201501
GROUP BY TO_CHAR(to_date(PP.구매일자, 'YYYYMMDD'), 'YYYY-MM')
ORDER BY 구매년월;


----------------------------------------------------------------
--제휴사 A, B, C, D에 대한 결과를 월별로 나누어 출력 -- 이용 총 고객 

SELECT
    TO_CHAR(to_date(PP.구매일자, 'YYYYMMDD'), 'YYYY-MM') AS 구매년월,
    SUM(CASE WHEN PP.제휴사 = 'A' THEN 1 ELSE 0 END) AS "A 거래건수",
    SUM(CASE WHEN PP.제휴사 = 'B' THEN 1 ELSE 0 END) AS "B 거래건수",
    SUM(CASE WHEN PP.제휴사 = 'C' THEN 1 ELSE 0 END) AS "C 거래건수",
    SUM(CASE WHEN PP.제휴사 = 'D' THEN 1 ELSE 0 END) AS "D 거래건수"
FROM compet CP
INNER JOIN purprod PP ON CP.고객번호 = PP.고객번호
WHERE PP.구매금액 BETWEEN 1000 AND 10000
      AND PP.제휴사 IN ('A', 'B', 'C', 'D')
      AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
GROUP BY TO_CHAR(to_date(PP.구매일자, 'YYYYMMDD'), 'YYYY-MM')
ORDER BY 구매년월;


--------------------------------------------
--경쟁사 여러가지 경우로 뽑기..
--예) 상반기일때 제휴사 A,B,C,D 전부이용한 고객이랑. 제휴사 D만 이용한고객 경우를 뽑고 비교
--제휴사 

 select count(*) 
 from compet CP 
 inner join purprod PP on CP.고객번호 = PP.고객번호 
 where PP.구매금액 between 1000 and 10000 
       and PP.제휴사 = 'A'
       and to_date(PP.구매일자, 'YYYYMMDD') between to_date('2015-01-01', 'YYYY-MM-DD') and to_date('2015-06-30', 'YYYY-MM-DD')
       and to_date(CP.이용년월, 'YYYYMM') between to_date('2015-01', 'YYYY-MM') and to_date('2015-6', 'YYYY-MM');
       
--
-- 상반기 동안 제휴사 A, B, C, D를 모두 이용한 고객 수 --수정필요..
SELECT COUNT(*) AS "상반기 모든 제휴사 이용 고객 수"
FROM (
    SELECT CP.고객번호
    FROM compet CP
    INNER JOIN purprod PP ON CP.고객번호 = PP.고객번호
    WHERE PP.구매금액 BETWEEN 1000 AND 10000
          AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
          AND TO_DATE(CP.이용년월, 'YYYYMM') BETWEEN TO_DATE('2015-01', 'YYYY-MM') AND TO_DATE('2015-06', 'YYYY-MM')
          AND PP.제휴사 IN ('A')
    GROUP BY CP.고객번호
    HAVING COUNT(DISTINCT PP.제휴사) = 1
);

--총이용고객 -수정필요..
SELECT COUNT(*) AS "총 이용 고객 수"
FROM (
    SELECT CP.고객번호
    FROM compet CP
    INNER JOIN purprod PP ON CP.고객번호 = PP.고객번호
    WHERE PP.구매금액 BETWEEN 1000 AND 10000
          AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
--          AND TO_DATE(CP.이용년월, 'YYYYMM') BETWEEN TO_DATE('2015-01', 'YYYY-MM') AND TO_DATE('2015-06', 'YYYY-MM')
          AND PP.제휴사 IN ('B','C')
    GROUP BY CP.고객번호
    HAVING COUNT(DISTINCT PP.제휴사) = 2
);

--경쟁사 교집합 고객, 기간, 제휴사별로....  
SELECT COUNT(*) AS "총 이용 수", CP.고객번호
    FROM compet CP
    INNER JOIN purprod PP ON CP.고객번호 = PP.고객번호
    WHERE PP.구매금액 BETWEEN 1000 AND 10000
          AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
          AND TO_DATE(CP.이용년월, 'YYYYMM') BETWEEN TO_DATE('2015-01', 'YYYY-MM') AND TO_DATE('2015-01', 'YYYY-MM')
          AND PP.제휴사 IN ('D')
    GROUP BY CP.고객번호
--    HAVING COUNT(DISTINCT PP.제휴사) = 4
    order by "총 이용 수" DESC
;

-------------------------
--그 위의 쿼리문에서 고객을 딱 집어서해보기
SELECT COUNT(*) AS "총 이용 수", CP.고객번호
    FROM compet CP
    INNER JOIN purprod PP ON CP.고객번호 = PP.고객번호
    WHERE PP.구매금액 BETWEEN 1000 AND 10000
          AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
--          AND TO_DATE(CP.이용년월, 'YYYYMM') BETWEEN TO_DATE('2015-12', 'YYYY-MM') AND TO_DATE('2015-12', 'YYYY-MM')
          AND PP.제휴사 IN ('D')
          AND PP.고객번호 = 14923
    GROUP BY CP.고객번호
--    HAVING COUNT(DISTINCT PP.제휴사) = 4
    order by "총 이용 수" DESC
;

----------------------------------
--
SELECT PC.소분류명, COUNT(*) AS 개수
FROM purprod PP
JOIN PRODCLS PC ON PP.대분류코드 = PC.대분류코드
WHERE PP.고객번호 = 18989
AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
AND PC.소분류명 IN ('감자스낵', '고추', '과일음료', '구강청정제', '국물용기라면', '국산맥주', '국산콩나물', '기능성우유', '기타레토르트', '농산가공',
                  '다이소', '두부류', '디저트류', '떠먹는요구르트', '마시는요구르트', '막걸리', '면봉/화장솜', '바나나', '보네스빼', '봉지라면',
                  '부침두부', '뷰티상품', '샌드', '생리대', '생선', '서양델리', '소스', '소시지', '스넥(부대)', '스포츠음료',
                  '스폰지/퍼프', '양파', '어린이/액상요구르트', '어묵', '에스닉푸드', '여성헤어액세서리', '염모제', '옥수수스낵', '위생세제', '유기농채소',
                  '유제품', '일반가공식품', '일반계란', '일반소주', '일반스낵', '일반우유', '일반흰우유', '일용잡화', '전문베이커리', '제과제빵',
                  '주류', '중식델리', '즉석반찬', '채소', '청과', '친환경채소(특약)', '콘스낵', '콩나물', '쿠키', '크래커',
                  '트리트먼트/팩', '파이', '판초콜릿', '팬티라이너', '페이셜클렌저', '풋케어', '하드캔디', '핸드로션/크림', '햄', '헤어에센스',
                  '혼합탄산')
GROUP BY PC.소분류명
ORDER BY 개수 DESC, PC.소분류명;







--대분류코드 = 1 2015년 상반기
SELECT PC.소분류명, COUNT(*) AS 개수
FROM purprod PP
JOIN PRODCLS PC ON PP.대분류코드 = PC.대분류코드
WHERE PP.고객번호 = 13911
AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
--AND PC.소분류명 IN ('감자스낵', '고추', '과일음료', '구강청정제', '국물용기라면', '국산맥주', '국산콩나물', '기능성우유', '기타레토르트', '농산가공',
--                  '다이소', '두부류', '디저트류', '떠먹는요구르트', '마시는요구르트', '막걸리', '면봉/화장솜', '바나나', '보네스빼', '봉지라면',
--                  '부침두부', '뷰티상품', '샌드', '생리대', '생선', '서양델리', '소스', '소시지', '스넥(부대)', '스포츠음료',
--                  '스폰지/퍼프', '양파', '어린이/액상요구르트', '어묵', '에스닉푸드', '여성헤어액세서리', '염모제', '옥수수스낵', '위생세제', '유기농채소',
--                  '유제품', '일반가공식품', '일반계란', '일반소주', '일반스낵', '일반우유', '일반흰우유', '일용잡화', '전문베이커리', '제과제빵',
--                  '주류', '중식델리', '즉석반찬', '채소', '청과', '친환경채소(특약)', '콘스낵', '콩나물', '쿠키', '크래커',
--                  '트리트먼트/팩', '파이', '판초콜릿', '팬티라이너', '페이셜클렌저', '풋케어', '하드캔디', '핸드로션/크림', '햄', '헤어에센스',
--                  '혼합탄산')
AND PP.대분류코드 = 1
AND PC.대분류코드 = 1
GROUP BY PC.소분류명
ORDER BY 개수 DESC, PC.소분류명;

--대분류코드 = 1 2015년 하반기
SELECT PC.소분류명, COUNT(*) AS 개수
FROM purprod PP
JOIN PRODCLS PC ON PP.대분류코드 = PC.대분류코드
WHERE PP.고객번호 = 13911
AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
--AND PC.소분류명 IN ('감자스낵', '고추', '과일음료', '구강청정제', '국물용기라면', '국산맥주', '국산콩나물', '기능성우유', '기타레토르트', '농산가공',
--                  '다이소', '두부류', '디저트류', '떠먹는요구르트', '마시는요구르트', '막걸리', '면봉/화장솜', '바나나', '보네스빼', '봉지라면',
--                  '부침두부', '뷰티상품', '샌드', '생리대', '생선', '서양델리', '소스', '소시지', '스넥(부대)', '스포츠음료',
--                  '스폰지/퍼프', '양파', '어린이/액상요구르트', '어묵', '에스닉푸드', '여성헤어액세서리', '염모제', '옥수수스낵', '위생세제', '유기농채소',
--                  '유제품', '일반가공식품', '일반계란', '일반소주', '일반스낵', '일반우유', '일반흰우유', '일용잡화', '전문베이커리', '제과제빵',
--                  '주류', '중식델리', '즉석반찬', '채소', '청과', '친환경채소(특약)', '콘스낵', '콩나물', '쿠키', '크래커',
--                  '트리트먼트/팩', '파이', '판초콜릿', '팬티라이너', '페이셜클렌저', '풋케어', '하드캔디', '핸드로션/크림', '햄', '헤어에센스',
--                  '혼합탄산')
AND PP.대분류코드 = 1
AND PC.대분류코드 = 1
GROUP BY PC.소분류명
ORDER BY 개수 DESC, PC.소분류명;



-----------------------------




SELECT PC.중분류명, COUNT(*) AS 개수
FROM purprod PP
JOIN PRODCLS PC ON PP.중분류코드 = PC.중분류코드
WHERE PP.고객번호 = 18989
AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
--AND PC.소분류명 IN ('감자스낵', '고추', '과일음료', '구강청정제', '국물용기라면', '국산맥주', '국산콩나물', '기능성우유', '기타레토르트', '농산가공',
--                  '다이소', '두부류', '디저트류', '떠먹는요구르트', '마시는요구르트', '막걸리', '면봉/화장솜', '바나나', '보네스빼', '봉지라면',
--                  '부침두부', '뷰티상품', '샌드', '생리대', '생선', '서양델리', '소스', '소시지', '스넥(부대)', '스포츠음료',
--                  '스폰지/퍼프', '양파', '어린이/액상요구르트', '어묵', '에스닉푸드', '여성헤어액세서리', '염모제', '옥수수스낵', '위생세제', '유기농채소',
--                  '유제품', '일반가공식품', '일반계란', '일반소주', '일반스낵', '일반우유', '일반흰우유', '일용잡화', '전문베이커리', '제과제빵',
--                  '주류', '중식델리', '즉석반찬', '채소', '청과', '친환경채소(특약)', '콘스낵', '콩나물', '쿠키', '크래커',
--                  '트리트먼트/팩', '파이', '판초콜릿', '팬티라이너', '페이셜클렌저', '풋케어', '하드캔디', '핸드로션/크림', '햄', '헤어에센스',
--                  '혼합탄산')
AND PP.중분류코드 = 0106
AND PC.중분류코드 = 0106
GROUP BY PC.중분류명
ORDER BY 개수 DESC;

----
SELECT PC.중분류명, COUNT(*) AS 개수
FROM purprod PP
JOIN PRODCLS PC ON PP.중분류코드 = PC.중분류코드
WHERE PP.고객번호 = 18989
AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-06-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
--AND PC.소분류명 IN ('감자스낵', '고추', '과일음료', '구강청정제', '국물용기라면', '국산맥주', '국산콩나물', '기능성우유', '기타레토르트', '농산가공',
--                  '다이소', '두부류', '디저트류', '떠먹는요구르트', '마시는요구르트', '막걸리', '면봉/화장솜', '바나나', '보네스빼', '봉지라면',
--                  '부침두부', '뷰티상품', '샌드', '생리대', '생선', '서양델리', '소스', '소시지', '스넥(부대)', '스포츠음료',
--                  '스폰지/퍼프', '양파', '어린이/액상요구르트', '어묵', '에스닉푸드', '여성헤어액세서리', '염모제', '옥수수스낵', '위생세제', '유기농채소',
--                  '유제품', '일반가공식품', '일반계란', '일반소주', '일반스낵', '일반우유', '일반흰우유', '일용잡화', '전문베이커리', '제과제빵',
--                  '주류', '중식델리', '즉석반찬', '채소', '청과', '친환경채소(특약)', '콘스낵', '콩나물', '쿠키', '크래커',
--                  '트리트먼트/팩', '파이', '판초콜릿', '팬티라이너', '페이셜클렌저', '풋케어', '하드캔디', '핸드로션/크림', '햄', '헤어에센스',
--                  '혼합탄산')
AND PP.중분류코드 = 0106
AND PC.중분류코드 = 0106
GROUP BY PC.중분류명
ORDER BY 개수 DESC;

--중분류코드
select 중분류코드, count(중분류코드) from purprod
group by 중분류코드
order by count(중분류코드) desc;

--제품 대분류코드순, 상반기, 제휴사 = D.. 수정필요
select purprod.대분류코드, count(purprod.대분류코드)
from purprod, prodcls, custdemo
where TO_DATE(purprod.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
AND custdemo."고객번호" = purprod."고객번호"
AND custdemo.고객번호 = 6868
AND prodcls.대분류코드 = purprod.대분류코드
AND prodcls.제휴사 = purprod.제휴사
AND purprod.제휴사 = 'D'
group by purprod.대분류코드
order by count(purprod.대분류코드) desc;

--수정본..  제품 대분류코드순, 상반기, 제휴사 = D
SELECT purprod.대분류코드, COUNT(DISTINCT purprod.고객번호) AS 제품수
FROM purprod
JOIN prodcls ON purprod.대분류코드 = prodcls.대분류코드
WHERE TO_DATE(purprod.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
  AND purprod.제휴사 = 'D'
  AND 고객번호 = 16129         
GROUP BY purprod.대분류코드
ORDER BY 제품수 DESC;

SELECT 대분류코드, COUNT(대분류코드) AS 제품수
FROM purprod
GROUP BY 대분류코드
ORDER BY 제품수 DESC;

select * from purprod order by "대분류코드";

--소분류명
select 소분류명, count(소분류명) from prodcls
group by 소분류명
order by count(소분류명) desc;

--서로 같은 소분류명
select prodcls.소분류명, count(prodcls.소분류명) from prodcls, purprod
where prodcls."소분류코드" = purprod."소분류코드"
group by prodcls.소분류명
order by count(prodcls.소분류명) desc;


--고객별 구매순위 상반기
select custdemo.고객번호, count(custdemo."고객번호")
from custdemo, purprod
where TO_DATE(purprod.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
AND custdemo.고객번호 = purprod."고객번호"
AND purprod.제휴사 = 'D'
group by custdemo."고객번호"
order by count(custdemo."고객번호") desc
;
--상위 10명 고객별 구매순위 상반기
--고객번호, 카운트.
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

--고객별 구매순위 하반기
select custdemo.고객번호, count(custdemo."고객번호")
from custdemo, purprod
where TO_DATE(purprod.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
AND custdemo.고객번호 = purprod."고객번호"
AND purprod.제휴사 = 'D'
group by custdemo."고객번호"
order by count(custdemo."고객번호") desc
;
--상위 10명 고객별 구매순위 하반기
--고객번호, 카운트.
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

--고객별(상위10명), 

--
SELECT PC.중분류명, COUNT(*) AS 개수
FROM purprod PP
JOIN PRODCLS PC ON PP.중분류코드 = PC.중분류코드
WHERE PP.고객번호 = 18989
AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-06-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
AND PP.중분류코드 = 0106
AND PC.중분류코드 = 0106
GROUP BY PC.중분류명
ORDER BY 개수 DESC;


--상반기
SELECT
    CD.고객번호,
    SUM(PP.구매금액) AS 총구매금액,
    COUNT(PP.구매일자) AS 총구매횟수,
    PC.소분류명
FROM CUSTDEMO CD
JOIN PURPROD PP ON CD.고객번호 = PP.고객번호
JOIN PRODCLS PC ON PP.소분류코드 = PC.소분류코드
WHERE CD.고객번호 = 16129   
  AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('20150101', 'YYYYMMDD') AND TO_DATE('20150630', 'YYYYMMDD')
  AND PP.구매금액 BETWEEN 1000 AND 10000
GROUP BY CD.고객번호, PC.소분류명
order by 총구매횟수 desc;

--하반기
SELECT
    CD.고객번호,
    SUM(PP.구매금액) AS 총구매금액,
    COUNT(PP.구매일자) AS 총구매횟수,
    PC.소분류명
FROM CUSTDEMO CD
JOIN PURPROD PP ON CD.고객번호 = PP.고객번호
JOIN PRODCLS PC ON PP.소분류코드 = PC.소분류코드
WHERE CD.고객번호 = 16129   
  AND TO_DATE(PP.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('20150701', 'YYYYMMDD') AND TO_DATE('20151231', 'YYYYMMDD')
  AND PP.구매금액 BETWEEN 1000 AND 10000
GROUP BY CD.고객번호, PC.소분류명
order by 총구매횟수 desc;

----
WITH TimeBasedData AS (
    SELECT
        CASE
            WHEN "구매일자" BETWEEN '20140101' AND '20140630' THEN '2014년 상반기'
            WHEN "구매일자" BETWEEN '20140701' AND '20141231' THEN '2014년 하반기'
            WHEN "구매일자" BETWEEN '20150101' AND '20150630' THEN '2015년 상반기'
            WHEN "구매일자" BETWEEN '20150701' AND '20151231' THEN '2015년 하반기'
            ELSE '기타'
        END AS "분기"
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
    SUM(COUNT(*)) OVER (PARTITION BY "분기") AS "분기별_합산_구매건수"
FROM TimeBasedData
GROUP BY "분기"
ORDER BY "분기";

-----

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
--고객별 구매순위 상반기
select custdemo.고객번호, count(custdemo."고객번호")
from custdemo, purprod
where TO_DATE(purprod.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-06-30', 'YYYY-MM-DD')
AND custdemo.고객번호 = purprod."고객번호"
AND purprod.제휴사 = 'D'
group by custdemo."고객번호"
order by count(custdemo."고객번호") desc
;

--고객별 구매순위 하반기
select custdemo.고객번호, count(custdemo."고객번호")
from custdemo, purprod
where TO_DATE(purprod.구매일자, 'YYYYMMDD') BETWEEN TO_DATE('2015-07-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD')
AND custdemo.고객번호 = purprod."고객번호"
AND purprod.제휴사 = 'D'
group by custdemo."고객번호"
order by count(custdemo."고객번호") desc
;

