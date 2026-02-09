1-- Write your PostgreSQL query statement below
2SELECT
3    C.name as Customers
4FROM
5    Customers C
6LEFT JOIN Orders O on O.customerId = C.id
7WHERE O.customerId is NULL