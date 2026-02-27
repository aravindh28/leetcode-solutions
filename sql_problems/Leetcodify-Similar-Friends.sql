1-- Write your PostgreSQL query statement below
2WITH Song_Date as (
3    SELECT
4    L1.song_id,
5    L1.day,
6    L1.user_id as left_id,
7    L2.user_id as right_id
8    FROM
9    Listens L1
10    INNER JOIN Listens L2 on L1.song_id = L2.song_id AND L1.day = L2.day
11    WHERE L1.user_id < L2.user_id
12),
13pairs as (
14SELECT S.left_id,
15S.right_id,
16S.day,
17COUNT(distinct song_id) as song_count
18FROM Song_Date S
19WHERE EXISTS (SELECT 1 from Friendship F where S.left_id = F.user1_id and S.right_id = F.user2_id)
20GROUP BY 1,2,3
21HAVING COUNT(distinct song_id) > 2
22)
23SELECT
24left_id as user1_id,
25right_id as user2_id
26FROM pairs
27GROUP BY 1,2
28-- UNION
29-- SELECT
30-- right_id as user_id,
31-- left_id as recommended_id
32-- FROM pairs
33-- select * from pairs