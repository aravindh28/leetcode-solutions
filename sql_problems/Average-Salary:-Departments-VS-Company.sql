1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    TO_CHAR(S.pay_date, 'yyyy-mm') as pay_month,
5    S.id,
6    S.employee_id,
7    E.department_id,
8    AVG(amount) OVER (PARTITION BY TO_CHAR(S.pay_date, 'yyyy-mm')) AS COMP_AVG_MONTH_SAL,
9    AVG(amount) OVER (PARTITION BY TO_CHAR(S.pay_date, 'yyyy-mm'),E.department_id) AS DEPT_AVG_MONTH_SAL
10FROM
11    Salary S
12INNER JOIN
13    Employee E
14    on S.employee_id = E.employee_id
15),
16B as (
17SELECT pay_month,
18    department_id,
19    AVG(COMP_AVG_MONTH_SAL) as COMP_AVG_MONTH_SAL,
20    AVG(DEPT_AVG_MONTH_SAL) as DEPT_AVG_MONTH_SAL
21FROM A
22GROUP BY 1,2)
23SELECT pay_month,
24    department_id,
25    CASE WHEN COMP_AVG_MONTH_SAL > DEPT_AVG_MONTH_SAL THEN 'lower'
26        WHEN COMP_AVG_MONTH_SAL = DEPT_AVG_MONTH_SAL THEN 'same'
27        WHEN COMP_AVG_MONTH_SAL < DEPT_AVG_MONTH_SAL THEN 'higher'
28    END as comparison
29FROM B