1
2WITH A as (
3SELECT
4    U.name,
5    COUNT(1)
6FROM
7    MovieRating MR
8INNER JOIN
9    Movies M on M.movie_id = MR.movie_id
10INNER JOIN
11    Users U on U.user_id = MR.user_id
12GROUP BY
13    MR.user_id, U.name
14),
15A_res as (
16SELECT name as results
17FROM A
18WHERE count = (SELECT MAX(count) from A)
19ORDER BY name
20LIMIT 1
21),
22B as (
23SELECT movie_id,
24AVG(rating) as avg
25FROM MovieRating
26WHERE TO_CHAR(created_at, 'yyyy-mm') = '2020-02'
27GROUP BY movie_id
28),
29B_res as (
30    SELECT M.title as results
31    FROM B
32    inner join Movies M on B.movie_id = M.movie_id
33    WHERE B.avg = (SELECT MAX(avg) from B)
34    ORDER BY M.title
35    LIMIT 1
36)
37SELECT results from A_res
38UNION ALL
39SELECT results from B_res
40