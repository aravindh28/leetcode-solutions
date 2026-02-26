1-- Write your PostgreSQL query statement below
2WITH A as (
3    SELECT exam_id,
4    student_id,
5    score,
6    MAX(score) OVER (PARTITION BY exam_id) as highest_exam_score,
7    MIN(score) OVER (PARTITION BY exam_id) as lowest_exam_score,
8    COUNT(exam_id) OVER (PARTITION BY student_id) as exam_cnt_per_student
9    from
10    Exam
11), B as (
12SELECT A.*,
13SUM(CASE WHEN score=highest_exam_score OR score=lowest_exam_score THEN 1 ELSE 0 END) OVER (PARTITION BY student_id) as flag
14FROM A
15)
16
17
18SELECT Student.student_id,
19Student.student_name
20FROM B
21INNER JOIN Student on
22Student.student_id = B.student_id
23where flag = 0
24GROUP BY 1,2
25order by Student.student_id ASC
26