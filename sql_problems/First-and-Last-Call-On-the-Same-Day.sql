1-- Write your PostgreSQL query statement below
2WITH All_Calls as (
3SELECT
4caller_id,
5recipient_id,
6call_time
7FROM Calls
8UNION ALL
9SELECT
10recipient_id as caller_id,
11caller_id AS recipient_id,
12call_time
13FROM Calls
14),
15B as (
16    SELECT
17    caller_id,
18    recipient_id,
19    call_time::DATE as doy,
20    FIRST_VALUE(recipient_id) OVER (PARTITION BY caller_id,DATE(call_time) ORDER BY call_time ASC) as first_caller,
21    FIRST_VALUE(recipient_id) OVER (PARTITION BY caller_id,DATE(call_time) ORDER BY call_time DESC) as last_caller
22    from
23    All_Calls
24)
25SELECT caller_id as user_id FROM B
26WHERE first_caller IN (caller_id,recipient_id) AND last_caller in (caller_id,recipient_id)
27GROUP BY caller_id
28