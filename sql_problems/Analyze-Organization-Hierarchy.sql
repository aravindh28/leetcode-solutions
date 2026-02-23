1-- Write your PostgreSQL query statement below
2WITH RECURSIVE RA as (
3    SELECT employee_id,
4    employee_name,
5    manager_id,
6    salary,
7    1 as level
8    FROM Employees
9    where manager_id is NULL
10    UNION ALL
11    SELECT
12    E2.employee_id,
13    E2.employee_name,
14    E2.manager_id,
15    E2.salary,
16    RA.level +1
17    FROM RA
18    INNER JOIN Employees E2 on RA.employee_id = E2.manager_id 
19),
20cte2 as (
21    SELECT
22    employee_id as manager_id,
23    employee_name as manager_name,
24    manager_id as employee_id,
25    employee_name,
26    salary
27    FROM
28    Employees
29    UNION ALL
30    SELECT
31    E2.manager_id,
32    cte2.manager_name,
33    E2.employee_id as employee_id,
34    E2.employee_name as employee_name,
35    cte2.salary
36    FROM
37    cte2
38    INNER JOIN Employees E2 on E2.employee_id = cte2.manager_id
39    AND E2.manager_id is not NULL
40),
41-- SELECT * FROM cte2
42-- order by manager_id asc
43cte3 as (
44SELECT manager_id,
45COUNT(1) - 1 as cnt,
46SUM(salary) as sal FROM cte2
47GROUP BY 1
48order by manager_id asc
49)
50SELECT RA.employee_id,
51RA.employee_name,
52RA.level,
53cte3.cnt as team_size,
54cte3.sal as budget
55FROM
56RA 
57inner join cte3 on cte3.manager_id = RA.employee_id
58ORDER BY level asc,budget desc, RA.employee_name asc