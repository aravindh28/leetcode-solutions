1-- Write your PostgreSQL query statement below
2-- Write your PostgreSQL query statement below
3
4WITH A as (
5SELECT Sa, 
62020 as yr, 
7COUNT(DISTINCT D.driver_id) as active_d
8--D.join_date 
9FROM generate_series(1, 12, 1) Sa
10LEFT JOIN Drivers D ON
11  (EXTRACT(month FROM D.join_date) <= Sa AND EXTRACT(year FROM D.join_date) = 2020) 
12  OR EXTRACT(year FROM D.join_date) < 2020
13GROUP BY Sa, yr
14),
15
16B as (
17SELECT Sa,
18COUNT(DISTINCT A.driver_id) as cnt
19FROM Rides R
20INNER JOIN generate_series(1, 12, 1) Sa ON EXTRACT('month' FROM R.requested_at) = Sa
21INNER JOIN AcceptedRides A on R.ride_id = A.ride_id
22WHERE EXTRACT('year' FROM R.requested_at) = 2020
23GROUP BY Sa
24)
25
26-- SELECT * FROM B
27
28
29SELECT A.sa as "month",
30--A.active_d as active_drivers,
31CASE WHEN A.active_d = 0 THEN 0 ELSE ROUND(CASE WHEN cnt is NULL then 0 ELSE cnt*100 END / A.active_d::numeric,2) END as working_percentage FROM
32A LEFT JOIN B
33on A.Sa = B.Sa