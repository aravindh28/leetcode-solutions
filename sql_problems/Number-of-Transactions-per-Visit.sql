1-- Write your PostgreSQL query statement below
2WITH RECURSIVE A as (
3    SELECT
4        V.user_id,
5        V.visit_date,
6        T.user_id as trans_user_id,
7        T.transaction_date,
8        T.amount
9    FROM
10        Visits V
11    LEFT JOIN Transactions T 
12        on V.user_id = T.user_id 
13        AND V.visit_date = T.transaction_date
14),
15B as (
16SELECT A.*,
17SUM(CASE WHEN trans_user_id is NOT NULL then 1 ELSE 0 END) OVER (PARTITION BY user_id,transaction_date) as transactions_count
18FROM A
19)
20
21--SELECT * FROM B
22,
23C as (
24SELECT transactions_count,
25    user_id,
26    visit_date,
27    COUNT(user_id) as visits_count
28FROM
29    B
30group by 1,2,3
31)
32,
33rec_1 AS (
34  SELECT gs AS transactions_count, 0 AS visits_count
35  FROM generate_series(0, (SELECT COALESCE(MAX(transactions_count),0) FROM C)) AS gs
36),
37D as (SELECT
38    transactions_count,
39    visits_count
40    FROM C
41    UNION ALL
42    SELECT
43    transactions_count,
44    visits_count
45    FROM rec_1)
46SELECT
47    transactions_count,
48    COUNT(visits_count) - 1 as visits_count
49    FROM D
50    group by 1
51ORDER BY transactions_count