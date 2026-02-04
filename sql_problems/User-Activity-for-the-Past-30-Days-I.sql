1-- Write your PostgreSQL query statement below
2SELECT
3activity_date as day,
4COUNT(DISTINCT user_id) as active_users
5FROM Activity
6WHERE activity_date <= '2019-07-27' AND activity_date >= '2019-07-27'::date - INTERVAL '29 days'
7GROUP BY activity_date
8