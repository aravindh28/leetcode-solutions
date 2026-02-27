1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    customer_id,
5    product_id,
6    COUNT(order_id) as order_count
7FROM
8Orders
9GROUP BY 1,2
10),
11B as (
12    SELECT
13    customer_id,
14    product_id,
15    order_count,
16    MAX(order_count) OVER (PARTITION by customer_id) as max_per_cust
17    FROM A
18)
19SELECT
20B.customer_id,
21B.product_id,
22P.product_name
23FROM
24B
25INNER JOIN Products P on B.product_id = P.product_id
26WHERE order_count = max_per_cust
27-- SELECT * FROM B