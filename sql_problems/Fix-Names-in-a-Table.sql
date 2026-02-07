1-- Write your PostgreSQL query statement below
2SELECT
3user_id,
4CONCAT(UPPER(LEFT(name,1)),LOWER(RIGHT(name, LENGTH(name)-1))) as name
5FROM 
6Users
7order by user_id