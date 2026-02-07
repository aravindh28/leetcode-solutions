1-- Write your PostgreSQL query statement below
2select user_id,
3count(follower_id) as followers_count 
4from Followers
5group by user_id
6order by user_id asc