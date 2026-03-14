1-- Write your PostgreSQL query statement below
2SELECT
3I.item_category as Category,
4SUM(CASE WHEN EXTRACT(DOW from order_date) = 1 THEN quantity ELSE 0 END) as Monday,
5SUM(CASE WHEN EXTRACT(DOW from order_date) = 2 THEN quantity ELSE 0 END) as Tuesday,
6SUM(CASE WHEN EXTRACT(DOW from order_date) = 3 THEN quantity ELSE 0 END) as Wednesday,
7SUM(CASE WHEN EXTRACT(DOW from order_date) = 4 THEN quantity ELSE 0 END) as Thursday,
8SUM(CASE WHEN EXTRACT(DOW from order_date) = 5 THEN quantity ELSE 0 END) as Friday,
9SUM(CASE WHEN EXTRACT(DOW from order_date) = 6 THEN quantity ELSE 0 END) as Saturday,
10SUM(CASE WHEN EXTRACT(DOW from order_date) = 0 THEN quantity ELSE 0 END) as Sunday
11FROM
12Orders O
13RIGHT JOIN Items I on O.item_id = I.item_id
14GROUP BY I.item_category
15ORDER BY I.item_category