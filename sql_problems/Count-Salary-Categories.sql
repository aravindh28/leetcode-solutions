1-- Write your PostgreSQL query statement below
2with A as
3(
4SELECT
5    CASE WHEN income < 20000 THEN 'Low Salary'
6    WHEN income >=20000 AND income <=50000 THEN 'Average Salary'
7    WHEN income >= 50000 THEN 'High Salary'
8    END as category,
9    COUNT(1) as accounts_count
10FROM
11    Accounts
12GROUP BY category
13UNION ALL
14(
15SELECT
16    'Low Salary' AS category,
17    0 as accounts_count
18UNION ALL
19    SELECT
20    'Average Salary' AS category,
21    0 as accounts_count
22UNION ALL
23SELECT
24    'High Salary' AS category,
25    0 as accounts_count
26))
27SELECT category, 
28    SUM(accounts_count) as accounts_count 
29    from A
30GROUP BY category
31
32
33