1-- Write your PostgreSQL query statement below
2SELECT
3    M.name
4FROM Employee M
5inner join Employee E ON M.id = E.managerId
6GROUP BY M.id, M.name
7HAVING COUNT(1) >=5