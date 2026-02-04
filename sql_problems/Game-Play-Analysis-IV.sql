1-- Write your PostgreSQL query statement below
2With Immediate_A as (
3SELECT
4    player_id,
5    device_id,
6    event_date,
7    LEAD(event_date,1) OVER (PARTITION BY player_id ORDER BY event_date) as next_event_date,
8    ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) as rn
9FROM
10    Activity A)
11
12SELECT ROUND(SUM( CASE WHEN next_event_date = event_date + 1 THEN 1 ELSE 0 END)::numeric / COUNT(1),2) as fraction
13From Immediate_A
14where rn = 1