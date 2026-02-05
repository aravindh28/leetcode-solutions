1-- Write your PostgreSQL query statement below
2SELECT
3    E.reports_to as employee_id,
4    M.name as name,
5    COUNT(1) as reports_count,
6    ROUND(AVG(E.age),0) as average_age
7FROM
8    Employees E
9INNER JOIN Employees M on E.reports_to = M.employee_id
10GROUP BY
11E.reports_to, M.name
12ORDER BY
13E.reports_to