1-- Write your PostgreSQL query statement below
2SELECT
3    score,
4    DENSE_RANK() OVER (ORDER BY score DESC) as rank
5FROM
6    Scores