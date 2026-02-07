1-- Write your PostgreSQL query statement below
2SELECT
3    P.product_id,
4    COALESCE(ROUND(SUM(P.price * U.units)::numeric / SUM(U.units),2),0) as average_price
5FROM
6    Prices P
7LEFT JOIN UnitsSold U on P.product_id=U.product_id AND P.start_date <= U.purchase_date AND U.purchase_date <= P.end_date
8GROUP BY p.product_id