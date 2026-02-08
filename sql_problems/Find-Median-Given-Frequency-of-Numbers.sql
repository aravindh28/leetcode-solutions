1-- Write your PostgreSQL query statement below
2WITH A as (
3    SELECT
4        num,
5        frequency,
6        SUM(frequency) OVER (order by num) as rs_freq_end,
7        SUM(frequency) OVER() as tot_counts
8    from
9        Numbers
10),
11B as (
12SELECT *, rs_freq_end - frequency + 1 as rs_freq_start FROM A
13),
14C as (
15SELECT *,CASE 
16WHEN (tot_counts%2 = 0 AND ((tot_counts::numeric/2 IN (rs_freq_start, rs_freq_end)) OR ((tot_counts::numeric/2) + 1 BETWEEN rs_freq_start AND rs_freq_end))) THEN TRUE WHEN tot_counts%2 = 1 AND CEIL(tot_counts::numeric/2) BETWEEN rs_freq_start AND rs_freq_end THEN TRUE 
17ELSE FALSE END as flag
18FROM B)
19SELECT avg(num) as median FROM C
20where flag is TRUE
21