1-- Write your PostgreSQL query statement below
2WITH
3RECURSIVE S as (
4    SELECT
5    product_id,
6    period_start,
7    period_end,
8    GREATEST(MAKE_DATE(EXTRACT(YEAR FROM period_start)::int,1,1), period_start) as max_start,
9    LEAST(MAKE_DATE(EXTRACT(YEAR FROM period_start)::int,12,31), period_end) as min_end,
10    average_daily_sales
11    FROM
12    Sales
13    UNION ALL
14    SELECT
15    S.product_id,
16    S.period_start,
17    S.period_end,
18    GREATEST(MAKE_DATE(EXTRACT(YEAR FROM S.max_start)::int + 1,1,1),S.period_start) as max_start,
19    LEAST(MAKE_DATE(EXTRACT(YEAR FROM S.min_end)::int + 1,12,31),S.period_end) as min_end,
20    S.average_daily_sales
21    FROM
22    S
23    WHERE S.max_start < S.min_end
24)
25
26SELECT S.product_id,
27P.product_name,
28TO_CHAR(S.max_start,'YYYY') as report_year,
29((S.min_end - S.max_start)::int + 1 ) * average_daily_sales as total_amount FROM S
30INNER JOIN Product P on P.product_id = S.product_id
31where max_start <= min_end
32order by product_id, report_year
33