1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    id,
5    num,
6    LEAD(num, 1) OVER (ORDER BY id) as next_num,
7    LEAD(num, 2) OVER (ORDER BY id) as next_next_num
8FROM
9    Logs
10)
11SELECT
12    DISTINCT num as ConsecutiveNums
13FROM
14    A
15WHERE num = next_num AND num = next_next_num
16
17
18