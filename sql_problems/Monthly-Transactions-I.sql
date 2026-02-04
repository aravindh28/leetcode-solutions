1-- Write your PostgreSQL query statement below
2SELECT
3    TO_CHAR(trans_date,'YYYY-MM') as month,
4    country,
5    COUNT(1) as trans_count,
6    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) as approved_count,
7    SUM(amount) as trans_total_amount,
8    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) as approved_total_amount
9FROM
10    Transactions
11GROUP BY
12    month,
13    country