1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4    id,
5    student as current_student,
6    LAG(student,1) OVER (ORDER BY id) as prev_student,
7    LEAD(student,1) OVER (ORDER BY id) as next_student
8FROM
9Seat
10)
11SELECT
12    id,
13    CASE WHEN
14    id % 2 = 1 AND next_student is null THEN current_student
15    WHEN
16    id % 2 = 0 THEN prev_student
17    WHEN
18    id % 2 = 1 and next_student is NOT NULL THEN next_student
19    END as student
20FROM A