1-- Write your PostgreSQL query statement below
2SELECT
3    S.user_id,
4    ROUND(SUM(CASE WHEN C.action='confirmed' THEN 1::numeric ELSE 0 END) / COUNT(1),2) AS confirmation_rate
5FROM
6    Confirmations C
7RIGHT JOIN Signups S on S.user_id = C.user_id
8GROUP BY S.user_id