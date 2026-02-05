1-- Write your PostgreSQL query statement below
2
3with t as (
4SELECT employee_id,
5department_id,
6primary_flag,
7COUNT(1) OVER (PARTITION BY employee_id) as cnt
8from Employee M)
9
10SELECT employee_id,
11department_id
12from t
13where cnt = 1 or (cnt > 1 and primary_flag='Y')
14