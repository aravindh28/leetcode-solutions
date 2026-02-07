1-- Write your PostgreSQL query statement below
2SELECT
3    P.product_name,
4    SUM(O.unit) as unit
5FROM
6    Products P
7INNER JOIN Orders O on
8    P.product_id = O.product_id
9WHERE TO_CHAR(order_date::date,'yyyy-mm') = '2020-02'
10GROUP BY P.product_id, P.product_name
11HAVING SUM(O.unit) >= 100