1-- Write your PostgreSQL query statement below
2
3SELECT x,
4y,
5z,
6CASE WHEN ((x+y >z) AND (y+z > x) AND (z+x > y)) THEN 'Yes' ELSE 'No' END as triangle
7from Triangle