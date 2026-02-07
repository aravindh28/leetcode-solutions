1-- Write your PostgreSQL query statement below
2SELECT
3    class
4FROM
5    Courses
6GROUP BY class
7HAVING count(1) >=5