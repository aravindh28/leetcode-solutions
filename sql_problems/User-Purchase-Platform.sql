1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    user_id,
5    spend_date,
6    platform,
7    amount,
8    DENSE_RANK() OVER (PARTITION BY user_id,spend_date ORDER by platform ASC) as platforms_pday
9FROM Spending
10),
11B as (
12    SELECT A.*,
13    MAX(platforms_pday) OVER (PARTITION BY user_id,spend_date) as unique_platforms_pday
14    FROM A
15), D as (
16SELECT B.spend_date,
17 CASE WHEN unique_platforms_pday = 2 THEN 'both' ELSE platform END as platform,
18 B.amount,
19 B.user_id
20  FROM B),
21E as (SELECT DISTINCT S.spend_date, G.platform, G.amount, G.user_id FROM Spending S
22INNER JOIN (
23    SELECT 'both' as platform, 0 as amount, null as user_id
24    UNION ALL
25    SELECT 'desktop' as platform, 0 as amount, null as user_id
26    UNION ALL
27    SELECT 'mobile' as platform, 0 as amount, null as user_id) AS G ON 1=1
28),
29F as ( SELECT spend_date, platform, amount, user_id FROM D
30UNION ALL
31SELECT spend_date,platform,amount,user_id::int FROM E)
32
33
34SELECT spend_date,
35platform,
36SUM(amount) as total_amount,
37COUNT(DISTINCT user_id) as total_users
38FROM F
39GROUP BY 1,2