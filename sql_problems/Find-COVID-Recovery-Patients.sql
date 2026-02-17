1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    P.patient_id,
5    P.patient_name,
6    P.age,
7    C.test_id,
8    C.test_date,
9    C.result,
10    SUM(CASE WHEN result='Positive' THEN 1 ELSE 0 END) OVER (PARTITION BY P.patient_id) as count_positives,
11    SUM(CASE WHEN result='Negative' THEN 1 ELSE 0 END) OVER (PARTITION BY P.patient_id) as count_negatives
12FROM
13    patients P
14INNER JOIN covid_tests C on P.patient_id = C.patient_id
15),
16
17B as (
18SELECT A.*,
19MIN(CASE WHEN result ='Positive' THEN test_date ELSE NULL END) OVER (PARTITION BY patient_id) as min_pos_date
20FROM A
21where count_positives > 0 AND count_negatives > 0
22),
23
24C as (
25SELECT B.*,
26MIN(CASE WHEN result ='Negative' THEN test_date ELSE NULL END) OVER (PARTITION BY patient_id) as min_neg_date FROM B
27WHERE result='Negative' AND min_pos_date < test_date)
28
29SELECT
30    patient_id,
31    patient_name,
32    age,
33    min_neg_date::date - min_pos_date::date as recovery_time
34FROM
35C
36group by 1,2,3,4
37ORDER BY recovery_time,patient_name
38