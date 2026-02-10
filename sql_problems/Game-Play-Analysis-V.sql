1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    player_id,
5    device_id,
6    event_date,
7    games_played,
8    ROW_NUMBER() OVER (PARTITION BY player_id ORDER by event_date) as rn,
9    LEAD(event_date,1) OVER (PARTITION BY player_id ORDER by event_date) as next_date
10    FROM Activity
11)
12SELECT event_date as install_dt,
13    COUNT(1) as installs,
14    ROUND(SUM(CASE WHEN event_date + INTERVAL '1 day' = next_date THEN 1 ELSE 0 END)::numeric / COUNT(1),2) as Day1_retention from A where rn = 1
15    GROUP BY event_date
16