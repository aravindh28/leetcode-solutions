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
17-- F.user1_id,
18-- F.user2_id,
19COUNT(distinct song_id) as song_count
20FROM Song_Date S
21-- LEFT JOIN Friendship F on S.left_id != F.user1_id OR S.right_id != F.user2_id
22-- WHERE user1_id is NOT NULL AND user2_id is NOT NULL
23WHERE NOT EXISTS (SELECT 1 from Friendship F where S.left_id = F.user1_id and S.right_id = F.user2_id)
24GROUP BY 1,2,3
25HAVING COUNT(distinct song_id) > 2
26)
27SELECT
28left_id as user_id,
29right_id as recommended_id
30FROM pairs
31UNION
32SELECT
33right_id as user_id,
34left_id as recommended_id
35FROM pairs
36-- select * from pairs