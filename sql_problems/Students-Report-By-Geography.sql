1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    name,
5    continent,
6    ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name ASC) as rn
7FROM
8    Student
9),
10AM as (
11    SELECT name,
12    rn
13    FROM
14    A
15    WHERE continent = 'America'
16),
17Asia as (
18    SELECT name,
19    rn
20    FROM
21    A
22    WHERE continent = 'Asia'
23),
24EU as (
25    SELECT name,
26    rn
27    FROM
28    A
29    WHERE continent = 'Europe'
30)
31SELECT
32AM.name as America,
33Asia.name as Asia,
34EU.name as Europe
35FROM
36AM AM
37LEFT JOIN Asia Asia on AM.rn = Asia.rn
38LEFT JOIN EU EU on AM.rn = EU.rn