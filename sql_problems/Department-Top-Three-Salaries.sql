1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    D.name as Department,
5    E.name as Employee,
6    E.salary as Salary,
7    DENSE_RANK() OVER (PARTITION BY D.id ORDER BY Salary DESC) as rn
8FROM
9    Employee E
10INNER JOIN
11    Department D on E.departmentId = D.Id
12)
13SELECT
14    Department,
15    Employee,
16    Salary
17FROM
18    A
19where rn <=3
20