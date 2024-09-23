-- Lab 6
-- use schema from files  'courses-small.sql';
USE course;

-- 1. Show the names of all students who have taken course "CS-190" as well as the year they took the course.
--    use a join of the student and takes tables.
--    Answer:  Shankar and Williams took the course in 2009.
select s.name, t.course_id
FROM student s
LEFT JOIN takes t
ON s.ID = t.ID
WHERE course_id = 'CS-190';

-- 2. For every Comp. Sci. course taught, show the instructor's name, 
--    the course_id and the course_title.
--    Do not show duplicates.
--    Sort the result by instructor name and then course_id.
--    Join the instructor, teaches and course tables.
--    Answer has 7 rows.
select DISTINCT t.course_id, i.name, c.title 
FROM teaches t
LEFT JOIN instructor i
ON t.ID = i.ID
LEFT JOIN course c
ON t.course_id = c.course_id
WHERE i.dept_name = 'Comp. Sci.'
ORDER BY i.name, t.course_id;

-- 3.  Do a natural join on student and takes tables
--     for students in the 'Physics' department.
--     Answer has 4 rows.
select *
FROM student
NATURAL JOIN takes
WHERE dept_name = 'Physics';

-- 4. Do a  left outer join on student and takes tables
--    for students in the 'Physics' department.
--    Answer has 5 rows.
select *
FROM student s
LEFT JOIN takes t
ON s.ID = t.ID
WHERE dept_name = 'Physics';

-- 5. What difference do you observe in the results of #3 compared to #4
--    The student table has Snow in Physics but the takes table does not have
--    Snow. The causes LEFT JOIN to have 5 row and NATURAL JOIN to have 4

-- 6. Return the names of students who have not taken any classes. 
--    Hint:  use "is null" 
--    Answer:  One row, name = 'Snow'   
select s.name
FROM student s
LEFT JOIN takes t
ON s.ID = t.ID
WHERE course_id IS NULL;

-- 7. Give the course_id for courses that have never been taught. 
--    Answer:  BIO-399 
select c.course_id 
FROM course c
LEFT JOIN teaches t
ON c.course_id = t.course_id
WHERE t.course_id IS NULL;

-- 8. Give the student ID, name and the count of number of courses taken.  
--    If a student has not taken any course, show the student ID, name and a count of 0.
--    Answer:  14 rows.  Student 70557, Snow is listed with a count of 0
select s.ID, s.name, COALESCE(COUNT(t.ID), 0) AS count
FROM student s
LEFT JOIN takes t
ON s.ID = t.ID
GROUP BY s.ID
ORDER BY count;

-- 9.  List the departments and the number of students 
--     for departments with less than 4 students.
--     Answer:  Biology, Finance, History and Music have 1 student.
--              Elec. Eng. has 2, and Physics has 3.
select dept_name, COUNT(dept_name) AS count
FROM department
NATURAL JOIN student
GROUP BY dept_name
HAVING count < 4
ORDER BY count DESC;
