1-- Write your PostgreSQL query statement below
2WITH RECURSIVE R as (
3    SELECT
4    employee_id
5    FROM
6    Employees
7    WHERE employee_id = 1
8    UNION ALL
9    SELECT
10    E2.employee_id
11    FROM
12    Employees E2
13    INNER JOIN R on R.employee_id = E2.manager_id 
14    WHERE E2.employee_id != 1
15)
16SELECT * FROM R
17where employee_id != 1