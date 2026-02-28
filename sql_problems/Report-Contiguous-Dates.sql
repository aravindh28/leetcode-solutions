1-- -- Write your PostgreSQL query statement below
2WITH f as (
3SELECT
4    'succeeded' as period_state,
5    success_date as eve_date
6FROM
7    Succeeded
8WHERE
9    success_date BETWEEN '2019-01-01' AND '2019-12-31'
10UNION ALL
11SELECT
12    'failed' as period_state,
13    fail_date as eve_date
14FROM
15    Failed
16WHERE
17    fail_date BETWEEN '2019-01-01' AND '2019-12-31'
18)
19-- B as (
20-- SELECT period_state,
21-- eve_date,
22-- LEAD(period_state,1) OVER (ORDER BY eve_date ASC) as next_period,
23-- LEAD(eve_date,1) OVER (ORDER BY eve_date ASC) as next_eve_date,
24-- CASE WHEN period_state = LEAD(period_state,1) OVER (ORDER BY eve_date ASC) THEN 0 ELSE 1 END as flag
25-- FROM A
26-- ORDER BY eve_date
27-- ),
28-- C as (
29-- SELECT B.*,
30-- SUM(flag) OVER (order by eve_date) as rs_flag,
31-- DENSE_RANK() OVER (order by eve_date) AS rn_curr,
32-- DENSE_RANK() OVER (order by next_eve_date) AS rn_next
33-- FROM B
34-- WHERE next_period is not NULL),
35-- D as (
36-- SELECT C.*,
37-- FIRST_VALUE(next_period) OVER (PARTITION BY rs_flag ORDER BY eve_date) as ps
38-- FROM C)
39-- -- SELECT * FROM C
40-- SELECT
41-- ps as period_state,
42-- MIN(CASE WHEN period_state != next_period THEN eve_date + INTERVAL '1 day' ELSE eve_date END)::date as start_date,
43-- MAX(next_eve_date) as end_date
44-- FROM D
45-- group by ps, rs_flag
46-- ORDER BY start_date
47,
48A as (
49    SELECT f.*,
50    ROW_NUMBER() OVER (ORDER BY eve_date asc) as asc_rn,
51    ROW_NUMBER() OVER (ORDER BY eve_date desc) as desc_rn
52    FROM f
53
54),
55Bih as (
56
57SELECT A.period_state as left_state,
58A.eve_date as left_date,
59B.period_state as right_state,
60B.eve_date as right_date,
61CASE WHEN A.period_state = B.period_state THEN A.period_state ELSE B.period_state END as final_state,
62SUM(CASE WHEN A.period_state = B.period_state THEN 0 ELSE 1 END) OVER (ORDER BY A.eve_date) as flag
63FROM
64A
65inner join A B on B.eve_date = A.eve_date + INTERVAL '1 day' OR (B.eve_date = A.eve_date AND (A.asc_rn = 1 OR A.desc_rn=1))
66)
67
68SELECT final_state as period_state,
69MIN(CASE WHEN left_state = right_state THEN left_date ELSE right_date END) as "start_date",
70MAX(CASE WHEN left_state = right_state THEN right_date ELSE right_date END) as "end_date"
71FROM Bih
72GROUP BY final_state,flag
73ORDER BY "start_date"
74
75-- SELECT * FROM Bih
76
77