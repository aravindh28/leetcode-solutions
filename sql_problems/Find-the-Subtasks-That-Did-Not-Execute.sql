1-- Write your PostgreSQL query statement below
2WITH RECURSIVE TaskList AS (
3    SELECT
4    task_id,
5    1 as subtask_id,
6    subtasks_count
7    FROM
8    Tasks
9    UNION ALL
10    SELECT
11    task_id,
12    subtask_id + 1 as subtask_id,
13    subtasks_count
14    FROM
15    TaskList
16    WHERE subtask_id < subtasks_count
17)
18SELECT T.task_id, T.subtask_id FROM TaskList T
19LEFT JOIN Executed E on
20T.task_id = E.task_id AND T.subtask_id = E.subtask_id
21WHERE E.subtask_id is NULL