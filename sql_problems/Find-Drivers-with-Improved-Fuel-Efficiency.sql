1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    driver_id,
5    CASE WHEN EXTRACT(MONTH FROM trip_date) BETWEEN 1 AND 6 THEN 1 ELSE 2 END as half,
6    AVG(distance_km/fuel_consumed) as avg_fuel
7--    COUNT(1) as cnt_types
8FROM
9    trips
10    GROUP BY 1,2
11),
12B as (
13SELECT driver_id,
14    ROUND(avg_fuel,2) as first_half_avg,
15    ROUND(LEAD(avg_fuel,1) OVER (partition by driver_id order by half asc),2) as second_half_avg,
16    ROUND(LEAD(avg_fuel,1) OVER (partition by driver_id order by half asc) - avg_fuel,2) as efficiency_improvement
17FROM A
18)
19SELECT
20D.driver_id,
21D.driver_name,
22first_half_avg,
23second_half_avg,
24efficiency_improvement
25FROM
26B
27INNER JOIN drivers D on B.driver_id = D.driver_id
28WHERE second_half_avg IS NOT NULL AND efficiency_improvement > 0 
29ORDER BY efficiency_improvement desc, D.driver_name asc