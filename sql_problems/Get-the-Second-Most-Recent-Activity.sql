1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    username,
5    activity,
6    startDate,
7    endDate,
8    ROW_NUMBER() OVER (PARTITION BY username order by startDate DESC) as rn,
9    COUNT(1) OVER (PARTITION BY username) as act_cnt
10FROM
11    UserActivity
12)
13SELECT username,
14    activity,
15    startDate,
16    endDate
17    from A
18    WHERE (act_cnt = 1 AND rn=1) OR (act_cnt > 1 AND rn=2)