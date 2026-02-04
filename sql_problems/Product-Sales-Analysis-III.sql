1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    product_id,
5    year,
6    quantity,
7    price,
8    MIN(year) OVER (PARTITION BY product_id) as min_year
9FROM
10    Sales)
11SELECT product_id,
12    year as first_year,
13    quantity as quantity,
14    price as price
15FROM A
16where year = min_year
17