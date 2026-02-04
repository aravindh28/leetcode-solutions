1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    delivery_id,
5    customer_id,
6    order_date,
7    customer_pref_delivery_date,
8    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date asc) as rn
9FROM
10    Delivery)
11SELECT ROUND(SUM(CASE WHEN rn = 1 AND order_date = customer_pref_delivery_date THEN 1 ELSE 0 END)::numeric / COUNT(DISTINCT customer_id) * 100,2) as immediate_percentage
12from A
13