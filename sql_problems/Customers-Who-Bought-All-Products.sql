1-- Write your PostgreSQL query statement below
2
3WITH A as (
4SELECT
5    customer_id,
6    COUNT(DISTINCT product_key) as count
7FROM
8    Customer
9GROUP BY customer_id
10)
11SELECT customer_id from A
12where count = (SELECT COUNT(product_key) from Product)