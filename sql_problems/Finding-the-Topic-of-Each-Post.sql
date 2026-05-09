1-- Write your PostgreSQL query statement below
2WITH A as (
3SELECT
4P.post_id,
5P.content,
6K.topic_id,
7K.word
8FROM
9Posts P
10LEFT JOIN Keywords K ON
11--LOWER(P.content) LIKE CONCAT('%',LOWER(K.word),' %') OR LOWER(P.content) LIKE CONCAT('% ',LOWER(K.word),'%')
12LOWER(P.content) LIKE CONCAT(LOWER(K.word),' %') OR LOWER(P.content) LIKE CONCAT('% ',LOWER(K.word)) OR LOWER(P.content) LIKE CONCAT('% ',LOWER(K.word),' %')
13)
14,
15-- SELECT post_id,
16-- COALESCE(string_agg(DISTINCT topic_id::varchar, ',' order by topic_id asc),'Ambiguous!') as topic
17-- FROM A
18-- GROUP BY post_id
19B as (
20SELECT post_id,
21topic_id
22FROM A
23GROUP BY post_id,topic_id
24)
25
26SELECT post_id,
27COALESCE(string_agg( topic_id::varchar, ',' order by topic_id asc),'Ambiguous!')::varchar as topic
28FROM B
29GROUP BY post_id