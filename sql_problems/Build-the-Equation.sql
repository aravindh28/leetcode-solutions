1WITH A as (
2SELECT
3T.power,
4T.factor,
5CASE WHEN T.factor = 0 THEN NULL 
6WHEN T.power = 0 AND T.factor!=0 THEN 
7CASE WHEN T.factor>0 THEN CONCAT('+',T.factor::varchar) ELSE T.factor::varchar END
8WHEN T.power = 0 AND T.factor=0 THEN NULL
9WHEN T.power>0 AND T.factor!=0 THEN
10    CASE WHEN T.power=1 THEN 
11     CASE WHEN T.factor > 0 THEN CONCAT('+',T.factor::varchar,'X')
12     ELSE  CONCAT(T.factor::varchar,'X') END
13    WHEN T.factor>0 THEN CONCAT('+',T.factor::varchar,'X^',T.power::varchar)
14     WHEN T.factor<0 THEN CONCAT(T.factor::varchar,'X^',T.power::varchar)
15    ELSE T.factor::varchar END
16ELSE NULL
17END as powx
18FROM
19Terms T
20)
21
22SELECT CONCAT(string_agg(powx, '' ORDER BY power desc),'=0') AS equation FROM A
23