-- AGGREGATE FUNCTIONS
CREATE TABLE students 
(
Stud_id NUMBER(6),
Stud_name VARCHAR2(50),
Year_of_study NUMBER(6),
Maths NUMBER(6),
Physics NUMBER(6),
Chemistry NUMBER(6),
Biology NUMBER(6)
);

/*
min()
max()
sum()
avg()
count()
*/

SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT SUM(salary) FROM employees;
SELECT COUNT(salary) FROM employees;
SELECT AVG(salary) FROM employees;

----------------------

-- We can not select non-aggregate column with aggregate column.

-- select first_name,max(salary) from employees;
-- ORA-00937: not a single-group group function

select department_id,max(salary) from employees group by department_id;

-- whenever we want to use wise keyword, use group by.

-- Filter condition on resultant of group by clause - We have to use having clause.

-- Having clause is always come with group by group by + having

SELECT department_id, SUM(salary) FROM employees GROUP BY department_id;

SELECT department_id, SUM(salary) FROM employees GROUP BY department_id HAVING SUM(salary) > 50000;

SELECT first_name, MAX(salary) FROM employees;
--ORA-00937: not a single-group group function

select first_name,max(salary) from employees group by first_name;
-- wrong logic

SELECT department_id, SUM(salary) 
FROM employees 
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING SUM(salary) > 50000
ORDER BY 1;

The order of keywords in any oracle SQL statement.

1.from
2.where
3.group by
4.having
5.order by

SELECT e.department_id, d.department_name, SUM(salary)
FROM employees e, departments d
WHERE e.department_id = d.department_id AND e.department_id IS NOT NULL
GROUP BY e.department_id, d.department_name
HAVING SUM(salary) > 50000 ORDER BY 1;

--select the department where more than 30 employees are working;

SELECT e.department_id, d.department_name, COUNT(*)
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
GROUP BY e.department_id, d.department_name
HAVING COUNT(*) > 30;

-- country wise employees count

SELECT 
l.country_id,
c.country_name,
COUNT(*) 
FROM employees e, departments d, locations l, countries c
WHERE e.department_id = d.department_id 
AND d.location_id = l.location_id 
AND l.country_id = c.country_id
GROUP BY l.country_id, c.country_name;

-- 1) Find total number of
employees

select count (*) from employee; --
26
--2) Find city wise total number of employees
select city,count (*) from employee group by
city;
-- 3) Find the total number of employees in each
country
select country,count (*) from employee group by
country;
--4) Find the total number of employees in
India
select count (*) from employee where country='India';
--5) Find the cities where more than 3 employees are working in
India
select city,count (*) from employee where country='India' group by city having count(*) >3;
-- 6) who is the youngest person?
select max(dob) from employee;
select * From employee where dob = (select max(dob) from
employee);
-- 7) who is the eldest employee?
select * From employee where dob = (select min(dob) from
employee);

-- 8) In which skillset, the highest number of employees are
--working?

select skillset,count(*) from employee group by skillset order by 2
desc;
-- 9) Is there any employee with the same
name?
select emp_name,count(*) from employee group by emp_name;
select emp_name,count(*) from employee group by emp_name having count(*) >1;
-- 10) is there any duplicate employee_id?
select emp_id,count(*) from employee group by emp_id having count(*) >1;
