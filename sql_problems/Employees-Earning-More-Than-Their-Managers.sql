1-- Write your PostgreSQL query statement below
2Select
3    E1.name as Employee
4FROM
5    Employee E1
6INNER JOIN Employee E2 on E1.managerId = E2.id
7WHERE E1.salary > E2.salary