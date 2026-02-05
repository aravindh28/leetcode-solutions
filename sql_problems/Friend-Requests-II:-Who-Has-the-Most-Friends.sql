1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4requester_id,
5accepter_id
6FROM
7RequestAccepted
8UNION
9SELECT
10accepter_id AS requester_id,
11requester_id AS accepter_id
12FROM
13RequestAccepted
14),
15B as (
16SELECT
17requester_id as id,
18COUNT(1) as num
19FROM A
20GROUP BY id
21)
22SELECT
23id,
24num
25FROM B
26WHERE num = (SELECT MAX(num) from B)