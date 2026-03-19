1-- Write your PostgreSQL query statement below
2WITH AllUsers as (
3    SELECT
4    user1_id,
5    user2_id
6    FROM
7    Friendship
8    UNION ALL
9    SELECT
10    user2_id as user1_id,
11    user1_id as user2_id
12    FROM
13    Friendship
14),
15B AS (
16    SELECT
17    F.user1_id as user_id,
18    F.user2_id as user2_id,
19    L.user_id as liker_id,
20    L.page_id
21    FROM
22    AllUsers F
23    INNER JOIN Likes L ON
24    F.user2_id = L.user_id
25    WHERE NOT EXISTS(
26        SELECT 1
27        FROM
28        Likes E
29        where E.user_id = F.user1_id AND E.page_id = L.page_id 
30    )
31)
32SELECT user_id,
33page_id,
34COUNT(liker_id) as friends_likes FROM B
35GROUP BY 1,2