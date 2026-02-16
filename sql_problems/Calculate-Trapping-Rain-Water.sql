1-- Write your PostgreSQL query statement below
2with A as (
3SELECT
4    id,
5    height,
6    MAX(height) OVER (order by id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as rolling_max_right,
7    MAX(height) OVER (order by id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as rolling_max_left
8FROM
9    Heights
10)
11SELECT SUM(
12LEAST(rolling_max_right - height , rolling_max_left - height )) as total_trapped_water FROM A
13
14