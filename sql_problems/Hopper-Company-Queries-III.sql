1-- Write your PostgreSQL query statement below
2WITH valid_months as (
3SELECT
4my,
52020 as "yr",
60 as ride_distance,
70 as ride_duration
8FROM
9generate_series(1,12,1) my
10),
11AllRides as (
12    Select R.ride_id,
13    --R.requested_at as ride_date,
14    EXTRACT(month FROM R.requested_at) as my,
15    EXTRACT(year FROM R.requested_at) as yr,
16    A.ride_distance,
17    A.ride_duration
18    FROM
19    Rides R
20    INNER JOIN AcceptedRides A
21    on R.ride_id = A.ride_id
22    WHERE EXTRACT(year FROM R.requested_at) = 2020
23)
24
25-- SELECT * FROM valid_months V
26-- LEFT JOIN AllRides A
27-- ON
28
29,
30
31agg_tab as (
32
33SELECT my,
34yr,
35ride_distance,
36ride_duration
37FROM
38    valid_months
39UNION ALL
40SELECT
41my,
42yr,
43ride_distance,
44ride_duration
45FROM
46    AllRides
47)
48,
49
50Pre_f as (
51SELECT my,yr, SUM(ride_distance) as ride_distance,
52SUM(ride_duration) as ride_duration
53from agg_tab
54GROUP BY my,yr
55ORDER BY my
56)
57
58,
59last as (
60SELECT my as "month",
61ROUND(AVG(ride_distance) OVER (ORDER BY my RANGE BETWEEN CURRENT ROW AND 2 FOLLOWING),2) as average_ride_distance,
62ROUND(AVG(ride_duration) OVER (ORDER BY my RANGE BETWEEN CURRENT ROW AND 2 FOLLOWING),2) as average_ride_duration
63FROM
64Pre_f
65)
66
67SELECT * FROM last
68WHERE "month" < 11
69