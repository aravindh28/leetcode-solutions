1-- Write your PostgreSQL query statement below
2select Q.query_name,
3ROUND(SUM(Q.rating *1.0 / Q.position) / COUNT(1),2) as quality,
4ROUND(SUM(CASE WHEN Q.rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(1),2) as poor_query_percentage
5from Queries Q
6group by Q.query_name