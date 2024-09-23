-- Lab 3.1
-- use the file courses-small.sql to create tables.

-- 1. insert a new student with ID 12399, name "Fred Brooks", majoring in Comp. Sci., total credits 0.
INSERT INTO student
VALUES (12399, "Fred Brooks", "Comp. Sci.", 0);

-- 2. change the tot_cred for student 12399 to 100
update student
SET tot_cred = 100
WHERE ID = 12399;

-- 3. Give all faculty a 4% increase in salary
update instructor
SET salary = salary + (salary * 0.04);

-- 4. Give all faculty in the Physics department a $3,500 salary increase
update instructor
SET salary = salary + 3500
WHERE dept_name = 'Physics';

-- 5. try to delete the course 'PHY-101'
DELETE FROM course
WHERE course_id = 'PHY-101';

-- 6. delete the course 'CS-315'
delete from course
where course_id = 'CS-315';

-- 7. Why does the delete in #5 fail while #6 works?
--  It references a foreign key.   
--   

-- 8. Student 12399 enrolls into section 
--    course_id 'CS-101', section 1, semester 'Fall', year 2009, grade null
--    insert a row into the takes table for the enrollment
INSERT INTO takes
VALUES (12399, 'CS-101', 1, 'Fall', 2009, NULL);

-- 9.  Find all the rows in the takes table with a null grade.
--      The answer should have 2 rows.
select *
FROM takes
WHERE grade IS NULL;

-- 10.  Update the grade for student 12399 in 'CS-101' to 'A'. 
update takes
SET grade = 'A'
WHERE ID = 12399;

-- reset the course tables by rerunning the script file courses-small.sql 