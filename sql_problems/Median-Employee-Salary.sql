1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    id,
5    company,
6    salary,
7    DENSE_RANK() OVER (PARTITION BY company order by salary ASC, id) as rn,
8    COUNT(1) OVER (PARTITION BY company) as cnt
9FROM
10    Employee
11)
12SELECT
13    id,
14    company,
15    salary
16FROM
17    A
18WHERE
19    CASE WHEN (cnt%2=0 AND rn IN(cnt/2,(cnt/2)+1)) OR (cnt%2=1 AND rn = (cnt/2)+1) THEN TRUE ELSE FALSE END