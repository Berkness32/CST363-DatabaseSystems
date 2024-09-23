-- Lab 7
-- use schema from '1994-census-summary.file';
use census;

-- 1. What are the usid values and occupations of the people in the data set with the highest age?  
--    Expected output has 43 rows:
--      223,Other_service
--      1041,Other_service
--      1936,Exec_managerial
--      (etc.)
--    hint: where age = (subquery to find highest age from census table)
select usid, occupation
FROM census
WHERE age = 
	(SELECT MAX(age) 
     FROM census);

-- 2. What is the average age by number of years of education? 
--    Hint.  group by education_num
--    Answer:  there are 16 rows, the last row is 16, 47.7022
select education_num, AVG(age)
FROM census
GROUP BY education_num
ORDER BY education_num;

-- 3.  Define a view named educ_view1 using your query from #2.
create view educ_view2
AS
select education_num, AVG(age) AS avg_age
FROM census
GROUP BY education_num
ORDER BY education_num;

-- 4.  Use the view to find the highest average age. 
--     Answer:  48.4458

-- Needed to create a second view because I forgot to name the column properly ont the first view
select MAX(avg_age)
FROM educ_view2;

-- 5. Which row(s) from educ_view1 have the max(average(age)) value from #4.
--    Hint:  where average_age = ( subquery from #3 )
--    Answer:   education_num   average_age
--              4               48.4458
select *
FROM educ_view2
WHERE avg_age =
	(SELECT MAX(avg_age)
     FROM educ_view2);

-- 6. Combine queries 2, 4 and 5 together into a single query.
--    Hint:  substitute the view definition into query #4 anywhere
--           educ_view1 appears.
SELECT education_num, avg_age
FROM educ_view2
UNION
SELECT education_num, avg_age
FROM educ_view2
WHERE avg_age = (SELECT MAX(avg_age) FROM educ_view2);
                           
-- with t1 as (select education_num, avg(age) as average_age
            -- from census group by education_num) 

-- use schema from file 'courses-small.sql';
use course;

-- 7. Define a view that gives the average and highest salary by department.  
--     Name the view ‘dept_summary’.  
--     The view should have columns dept_name, average_salary, max_salary
create view dept_summary AS
SELECT d.dept_name, AVG(i.salary) as average_salary, MAX(i.salary) as max_salary
FROM department d
LEFT JOIN instructor i ON d.dept_name = i.dept_name
GROUP BY d.dept_name
ORDER BY d.dept_name;

SELECT * FROM dept_summary;

-- 8.  Use the max_dept_salary view from problem 7 to find the average salary among 
--     the instructors who are the most highly paid in their departments.
--     Answer: 75857.142857
--     Hint:  A correlated subquery on dept_name
select AVG(max_salary)
FROM dept_summary;

-- 9.  Use the avg_dept_salary view to code a query showing all instructors whose salary 
--     is greater than the average salary within their own department.
--     Answer;  4 instructors:  Wu, Einstein, Califieri, Brandt
--     Hint:  This is a correlated subquery on dept_name.
select i.name 
FROM instructor i
LEFT JOIN dept_summary d ON i.dept_name = d.dept_name
WHERE i.salary > d.average_salary;

-- 10.  Find the department(s) with the least instructors. 
--      Return the dept_name and the number of instructors.
--      Answer:   Biology, Elec. Eng. and Music have only 1 instructor.
select d.dept_name, COUNT(i.name) AS instructor_count
FROM department d
LEFT JOIN instructor i ON d.dept_name = i.dept_name
GROUP BY d.dept_name
HAVING instructor_count = 1;

USE course;
SELECT * FROM department;

EXPLAIN
select distinct i.dept_name, name,  course_id, title
from instructor i join teaches using (id)
join course using (course_id)
order by i.dept_name, name;

-- Midterm
USE census;

SELECT MIN(age) AS age
FROM census;

SELECT AVG(education_num) AS avg_education, occupation, hours_per_week
FROM census
WHERE occupation = 'Sales' AND hours_per_week >= 40
GROUP BY occupation, hours_per_week;

SELECT COUNT(DISTINCT workclass)
FROM census;

SELECT COALESCE(COUNT(usid)) AS people, age, capital_gain
FROM census
WHERE age > 30 AND capital_gain > 0
GROUP BY age, capital_gain;

SELECT COALESCE(COUNT(usid)) AS people, workclass
FROM census
GROUP BY workclass
ORDER by people DESC;

USE course;

SELECT c.course_id, s.sec_id, c.title, s.semester, s.building, s.room_number
FROM course c
LEFT JOIN section s ON c.course_id = s.course_id
WHERE s.semester = 'Fall' AND s.year = 2023
ORDER BY c.course_id, s.sec_id;

SELECT c.dept_name, COUNT(ID) AS course_enrollment
FROM course c
LEFT JOIN takes t ON c.course_id = t.course_id
LEFT JOIN department d ON c.dept_name = d.dept_name
GROUP BY c.dept_name
ORDER BY c.dept_name;

SELECT c.course_id, c.title, COALESCE(COUNT(s.sec_id)) AS section_count
FROM course c
LEFT JOIN section s ON c.course_id = s.course_id
GROUP BY course_id, title
ORDER BY section_count DESC;

SELECT i.name, COALESCE(COUNT(DISTINCT year)) AS years_taught
FROM instructor i
LEFT JOIN teaches t ON i.ID = t.ID
GROUP BY i.name;


