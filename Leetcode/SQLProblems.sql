-- 584. Find Customer Referee
SELECT name FROM Customer WHERE referee_id IS NULL OR referee_id <> 2


-- 595. Big Countries
SELECT name, population, area FROM World WHERE area >= 3000000 OR population >= 25000000


-- 577. Employee Bonus
SELECT emp.name, Bonus.bonus
FROM Employee AS emp
LEFT OUTER JOIN Bonus
ON Bonus.empId = emp.empID
WHERE Bonus.bonus < 1000 OR Bonus.bonus IS NULL


-- 570. Managers with at Least 5 Direct Reports
SELECT mgr.name
FROM Employee emp
INNER JOIN Employee mgr
ON mgr.id = emp.managerID
GROUP BY name
HAVING COUNT(1) >= 5

-- 1193. Monthly Transactions I

WITH cte AS (
SELECT country, DATE_FORMAT(trans_date,"%Y-%m") as month
,amount
,CASE WHEN state = 'approved' THEN 1 ELSE 0 END AS approved_cnt
,CASE WHEN state = 'approved' THEN amount ELSE 0 END AS approved_amount
FROM Transactions)

SELECT month, country
, count(1) as trans_count
, SUM(approved_cnt) AS approved_count
, SUM(amount) AS trans_total_amount
, SUM(approved_amount) AS approved_total_amount
FROM cte 
GROUP BY 1,2


-- 1148. Article Views I
SELECT author_id
FROM Views
WHERE author_id = viewer_id
GROUP BY author_id
ORDER BY author_id
;


-- 1683. Invalid Tweets
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15


-- 185. Department Top Three Salaries
-- The top earner in each department
WITH msal AS (
select departmentId, max(salary) as max_sal
from Employee
group by departmentId
)
select e.*, msal.*
from Employee e
inner join msal
on msal.departmentId = e.departmentId
where msal.max_sal = e.salary
;

-- This is the answer they were looking for.
with cte as (
select distinct e.departmentId, e.salary from (
select distinct departmentId
,      dense_rank() over (partition by departmentId order by salary desc) as rnk
,      salary
from Employee) e
where rnk <= 3) 
select dep.name as department, emp.name as Employee, emp.salary
from cte
inner join Employee emp
on emp.departmentId = cte.departmentId
and emp.salary = cte.salary
inner join Department dep
on dep.id = emp.departmentId
;


-- 262. Trips and Users
https://cloud.google.com/certification/guides/data-engineer



-- 601. Human Traffic of Stadium

with cte1 as (select * from Stadium where people >= 100)
, cte2 as (
select *
, LAG(id,1,id) over (order by id) as lag1
, LAG(id,2,id) over (order by id) as lag2
from cte1
)
, cte3 as (
select id, visit_date, people, CASE WHEN (id - lag1) + (lag1 - lag2) = 2 then TRUE ELSE FALSE END AS toggle
from cte2)
-- select * from cte3
, cte4 as (
select cte1.id, cte1.visit_date, cte1.people
from cte3
inner join cte1
on cte1.id = cte3.id
or cte1.id = cte3.id - 1
or cte1.id = cte3.id - 2
where cte3.toggle = 1
)
select distinct id, visit_date, people from cte4 order by id
