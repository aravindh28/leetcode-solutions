1-- Write your PostgreSQL query statement below
2
3WITH A as (
4SELECT Sa, 
52020 as yr, 
6COUNT(DISTINCT D.driver_id) as active_d
7--D.join_date 
8FROM generate_series(1, 12, 1) Sa
9LEFT JOIN Drivers D ON
10  (EXTRACT(month FROM D.join_date) <= Sa AND EXTRACT(year FROM D.join_date) = 2020) 
11  OR EXTRACT(year FROM D.join_date) < 2020
12GROUP BY Sa, yr
13),
14
15B as (
16SELECT Sa,
17COUNT(1) as cnt
18FROM Rides R
19INNER JOIN generate_series(1, 12, 1) Sa ON EXTRACT('month' FROM R.requested_at) = Sa
20INNER JOIN AcceptedRides A on R.ride_id = A.ride_id
21WHERE EXTRACT('year' FROM R.requested_at) = 2020
22GROUP BY Sa
23)
24
25SELECT A.sa as "month",
26A.active_d as active_drivers,
27CASE WHEN cnt is NULL then 0 ELSE cnt END as accepted_rides FROM
28A LEFT JOIN B
29on A.Sa = B.Sa