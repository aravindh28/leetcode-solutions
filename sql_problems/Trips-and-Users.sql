1-- Write your PostgreSQL query statement below
2WITH A as (
3    SELECT 
4    T.id,
5    T.client_id,
6    T.driver_id,
7    T.status,
8    T.request_at,
9    U1.banned as client_banned,
10    U2.banned as driver_banned,
11    CASE WHEN U1.banned = 'No' AND U2.banned = 'No' THEN 1 ELSE 0 END as valid_cancel
12    FROM
13        Trips T
14    INNER JOIN
15        Users U1 on T.client_id = U1.users_id AND U1.role = 'client'
16    INNER JOIN
17        Users U2 on T.driver_id = U2.users_id AND U2.role = 'driver'
18    WHERE request_at::date >= DATE '2013-10-01' AND request_at::date <= DATE '2013-10-03'
19)
20SELECT
21    request_at as "Day",
22    ROUND(SUM(CASE WHEN status IN ('cancelled_by_client','cancelled_by_driver') THEN 1 ELSE 0 END)::numeric / COUNT(1)::numeric,2) as "Cancellation Rate"
23FROM A
24    where valid_cancel = 1
25GROUP BY
26    "Day"
27