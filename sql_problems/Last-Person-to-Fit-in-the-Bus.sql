1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    person_id,
5    person_name,
6    turn,
7    SUM(weight) over (ORDER BY turn) as cum_weight
8FROM
9     Queue),
10B as (
11SELECT A.person_name,
12ROW_NUMBER() OVER (ORDER BY cum_weight DESC) as rn
13FROM A
14where cum_weight <= 1000
15)
16SELECT person_name
17from B
18where rn = 1
19
20