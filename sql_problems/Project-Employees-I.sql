1-- Write your PostgreSQL query statement below
2select P.project_id, ROUND(AVG(E.experience_years * 1.0),2) as average_years from Project P
3inner join Employee E on E.employee_id = P.employee_id
4group by P.project_id
5