1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    user_id,
5    visit_date,
6    LEAD(visit_date,1) OVER (PARTITION BY user_id ORDER BY visit_date ASC) as next_date
7FROM
8    UserVisits
9)
10-- SELECT * FROM A
11SELECT user_id,
12    MAX(COALESCE(next_date,'2021-01-01'::DATE) - visit_date::date) as biggest_window
13FROM
14    A
15GROUP BY 1
16ORDER BY 1
17
18