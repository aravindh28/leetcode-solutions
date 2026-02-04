1-- Write your PostgreSQL query statement below
2With A as (
3SELECT
4    num as num
5FROM
6    MyNumbers
7GROUP BY
8    num
9HAVING
10    COUNT(1) = 1
11ORDER BY num desc
12LIMIT 1)
13
14SELECT num from A
15UNION ALL
16SELECT
17    null as num
18WHERE NOT EXISTS (SELECT 1 from A)