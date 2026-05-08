1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4player_id,
5match_day,
6result
7FROM
8Matches
9),
10
11B as (
12SELECT
13A.*,
14SUM(CASE WHEN result='Win' THEN 0 ELSE 1 END) OVER (PARTITION BY player_id ORDER BY match_day ASC ) as rn
15FROM A
16)
17
18-- SELECT * FROM B
19
20,
21C as (
22SELECT
23player_id,
24rn,
25SUM(CASE WHEN result='Win' THEN 1 ELSE 0 END) as streak_sum
26FROM
27B
28group by 1,2
29order by 1,2
30)
31
32SELECT player_id,
33MAX(streak_sum) as longest_streak
34FROM C
35GROUP BY
361
37order by 1