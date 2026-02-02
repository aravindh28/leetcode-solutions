1CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary INT) AS $$
2BEGIN
3  RETURN QUERY (
4    -- Write your PostgreSQL query statement below.
5    WITH Sal as (
6        SELECT
7        E.salary,
8        DENSE_RANK() OVER (order by E.salary DESC) as rnk
9        from
10        Employee E
11    )
12    SELECT DISTINCT S.salary
13    from Sal S where rnk = N
14    
15      
16  );
17END;
18$$ LANGUAGE plpgsql;