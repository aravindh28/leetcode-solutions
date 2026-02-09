1-- Write your PostgreSQL query statement below
2WITH A as(
3SELECT
4    id,
5    month,
6    salary,
7    MAX(month) OVER (PARTITION BY id) as recent_month,
8    SUM(salary) OVER (PARTITION BY id ORDER BY month DESC RANGE BETWEEN CURRENT ROW AND 2 FOLLOWING) as three_month_range_sal
9FROM
10    Employee E
11)
12SELECT id, 
13    month, 
14    three_month_range_sal as salary 
15    FROM A
16WHERE
17    month != recent_month