1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    store_id,
5    product_name,
6    quantity,
7    price,
8    inventory_id,
9    FIRST_VALUE(inventory_id) OVER (PARTITION BY store_id ORDER BY price DESC) as most_exp_product_id,
10    FIRST_VALUE(inventory_id) OVER (PARTITION BY store_id ORDER BY price ASC) as cheapest_product_id,
11    COUNT(inventory_id) OVER (PARTITION BY store_id) as count_products
12FROM
13    inventory
14),
15B as (
16SELECT A.*,
17LEAD(product_name,1) OVER (PARTITION BY store_id ORDER BY price ASC) as most_exp_product,
18LEAD(quantity,1) OVER (PARTITION BY store_id ORDER BY price ASC) as most_exp_quantity
19FROM A
20where count_products >= 3 AND inventory_id IN (most_exp_product_id,cheapest_product_id)
21)
22SELECT S.store_id,
23    S.store_name,
24    S.location,
25    most_exp_product,
26    product_name as cheapest_product,
27    ROUND(quantity::numeric/ most_exp_quantity::numeric,2) AS imbalance_ratio
28FROM B
29INNER JOIN
30stores S on S.store_id = B.store_id
31    where
32    most_exp_product is not NULL AND quantity > most_exp_quantity
33ORDER BY imbalance_ratio DESC, S.store_name ASC
34
35    
36