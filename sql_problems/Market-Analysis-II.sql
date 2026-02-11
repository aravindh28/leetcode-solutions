1-- Write your PostgreSQL query statement below
2
3WITH A as (
4SELECT
5    O.order_id,
6    O.order_date,
7    O.item_id,
8    O.buyer_id,
9    O.seller_id,
10    U.favorite_brand as seller_fav_brand,
11    I.item_brand as sold_brand,
12    ROW_NUMBER() OVER (PARTITION BY O.seller_id ORDER BY O.order_date) as rn,
13    COUNT(1) OVER (PARTITION BY  O.seller_id) as num_sold
14FROM
15    Orders O
16INNER JOIN
17    Users U on U.user_id = O.seller_id
18INNER JOIN
19    Items I on I.item_id = O.item_id
20),
21Btab as (
22SELECT seller_id,
23SUM(CASE WHEN rn=2 AND seller_fav_brand = sold_brand THEN 1 ELSE 0 END) AS sale_flag
24FROM A
25where num_sold >= 2
26GROUP BY seller_id
27HAVING SUM(CASE WHEN rn=2 AND seller_fav_brand = sold_brand THEN 1 ELSE 0 END) >= 1
28)
29SELECT
30U.user_id as seller_id,
31CASE WHEN B.sale_flag =1 THEN 'yes' ELSE 'no' END as "2nd_item_fav_brand"
32FROM Users U
33LEFT JOIN Btab B on U.user_id = B.seller_id