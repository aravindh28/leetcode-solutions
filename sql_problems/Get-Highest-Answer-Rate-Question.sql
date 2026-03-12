1-- Write your PostgreSQL query statement below
2SELECT
3question_id as survey_log
4FROM
5SurveyLog SL
6WHERE
7action = 'answer'
8GROUP BY question_id
9ORDER BY COUNT(answer_id) DESC, survey_log ASC
10LIMIT 1
11