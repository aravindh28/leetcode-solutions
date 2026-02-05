1-- Write your PostgreSQL query statement below
2WITH A as (
3    SELECT
4     visited_on,
5     SUM(amount) as amount
6     FROM Customer
7     GROUP BY visited_on
8)
9,B as (
10SELECT
11    visited_on,
12    SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as amount,
13    AVG(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as average_amount,
14    LAG(visited_on, 6) OVER (ORDER BY visited_on) as window_start
15FROM
16    A
17)
18SELECT
19    visited_on,
20    amount,
21    ROUND(average_amount,2) as average_amount
22FROM B
23WHERE window_start IS NOT NULL