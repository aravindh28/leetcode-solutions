1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT 
4    id,
5    visit_date,
6    people,
7    MIN(id) OVER() as first_id,
8    MAX(id) OVER() as last_id,
9    MIN(people) OVER (order by visit_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as last_3_min,
10    MIN(people) OVER (order by visit_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as prev_next_3_min,
11    MIN(people) OVER (order by visit_date ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) as next_3_min
12FROM
13    Stadium
14),
15B as (
16SELECT id,
17    visit_date,
18    people
19    FROM A
20WHERE CASE 
21    WHEN id=first_id AND next_3_min >=100 THEN TRUE
22    WHEN id=last_id AND last_3_min>=100 THEN TRUE
23    WHEN (id!=first_id AND id!=last_id) AND ((id-1!=first_id AND last_3_min >= 100) OR prev_next_3_min>=100 OR (id+1!=last_id AND next_3_min >=100)) THEN TRUE
24    ELSE FALSE END
25)
26SELECT * FROM B
27