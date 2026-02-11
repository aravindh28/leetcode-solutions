1-- Write your PostgreSQL query statement below
2WITH
3new_matches as (
4    SELECT
5    match_id,
6    first_player as player,
7    first_score as score
8    FROM Matches
9    UNION ALL
10    SELECT
11    match_id,
12    second_player as player,
13    second_score as score
14    FROM Matches
15),
16B as (
17SELECT P.group_id,
18P.player_id,
19SUM(score) as total_score
20 FROM new_matches M
21INNER JOIN Players P on
22P.player_id = M.player
23GROUP BY P.group_id, P.player_id)
24,C as (
25    SELECT
26        group_id,
27        player_id,
28        total_score,
29        ROW_NUMBER() OVER (PARTITION BY group_id ORDER BY total_score DESC, player_id ASC) as rn
30        FROM B
31)
32SELECT
33    group_id,
34    player_id
35FROM C
36 where rn = 1
37