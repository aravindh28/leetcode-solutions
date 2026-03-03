1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    PP.user_id,
5    PP.product_id,
6    PP.quantity,
7    PI.category
8FROM
9    ProductPurchases PP
10INNER JOIN ProductInfo PI on PP.product_id = PI.product_id
11),
12
13B as (
14
15SELECT
16cat1.category as category1,
17cat2.category as category2,
18-- COUNT(DISTINCT user_id) as customer_count
19cat1.user_id as id1,
20cat2.user_id as id2
21FROM
22A cat1 INNER JOIN 
23A cat2 on cat1.category < cat2.category
24where cat1.user_id = cat2.user_id 
25GROUP BY category1,category2,id1,id2
26ORDER BY 1,2,3,4
27)
28
29SELECT
30category1,
31category2,
32COUNT(1) as customer_count
33FROM B
34GROUP BY 1,2
35HAVING COUNT(1) > 2
36ORDER BY customer_count DESC, category1 ASC, category2 ASC