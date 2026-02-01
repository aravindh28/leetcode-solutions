1-- Write your PostgreSQL query statement below
2WITH Budget as (
3    SELECT 70000::int AS salary
4),
5Seniors as (
6    SELECT
7        C.experience,
8        C.employee_id,
9        SUM(Salary) OVER (PARTITION BY experience ORDER BY salary asc) as RS_salary
10        FROM Candidates C
11        where C.experience = 'Senior'
12
13),
14SeniorHires as (
15    Select * from Seniors
16    WHERE RS_salary <= 70000
17),
18Juniors as (
19        SELECT
20        C.experience,
21        C.employee_id,
22        SUM(Salary) OVER (PARTITION BY experience ORDER BY salary asc) as RS_salary
23        FROM Candidates C
24        where C.experience = 'Junior'),
25JuniorHires as (
26    Select * from Juniors
27    WHERE RS_salary <= 70000 - (SELECT COALESCE(MAX(RS_Salary)::int,0) FROM SeniorHires)),
28
29Total as (
30    SELECT
31    experience,
32    COUNT(1) as accepted_candidates
33    FROM
34    (
35        SELECT experience,
36        employee_id
37        FROM SeniorHires
38        UNION
39        SELECT experience,
40        employee_id
41        FROM JuniorHires
42
43    )
44    GROUP BY experience
45    UNION ALL
46    (SELECT
47    experience,
48    0 as accepted_candidates
49    from Candidates
50    group by experience)
51),
52Fin_Total as (
53    SELECT experience,
54    SUM(accepted_candidates) as accepted_candidates
55    FROM
56    Total
57    GROUP BY experience
58)
59
60SELECT * from Fin_Total
61