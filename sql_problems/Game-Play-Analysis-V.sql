1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    event_date,
5    ROW_NUMBER() OVER (PARTITION BY player_id ORDER by event_date) as rn,
6    LEAD(event_date,1) OVER (PARTITION BY player_id ORDER by event_date) as next_date
7    FROM Activity
8)
9SELECT event_date as install_dt,
10    COUNT(1) as installs,
11    ROUND(SUM(CASE WHEN event_date + INTERVAL '1 day' = next_date THEN 1 ELSE 0 END)::numeric / COUNT(1),2) as Day1_retention from A where rn = 1
12    GROUP BY event_date
13