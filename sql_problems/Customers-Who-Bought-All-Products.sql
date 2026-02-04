1-- Write your PostgreSQL query statement below
2
3SELECT
4    customer_id
5FROM
6    Customer
7GROUP BY customer_id
8HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) from Product)