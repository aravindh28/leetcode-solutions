1-- Write your PostgreSQL query statement below
2with Asa as (
3SELECT
4    A.pid,
5    A.tiv_2015,
6    A.tiv_2016,
7    A.lat,
8    A.lon
9FROM Insurance A
10INNER JOIN Insurance B
11ON A.tiv_2015 = B.tiv_2015 AND A.pid != B.pid
12GROUP BY 1,2,3,4,5
13),
14B as (
15    SELECT
16    A.pid
17FROM Asa A
18INNER JOIN Insurance B
19ON A.pid != B.pid AND A.lat = B.lat AND A.lon = B.lon
20GROUP BY A.pid
21)
22SELECT ROUND(SUM(I.tiv_2016)::numeric,2) as tiv_2016
23FROM INSURANCE I
24INNER JOIN Asa A ON A.pid = I.pid
25LEFT JOIN B B on A.pid = B.pid
26WHERE B.pid IS NULL