-- homework 1.sql
-- use courses-small.sql to create tables.


-- 1. Show the name and salary of all instructors sorted by name.
SELECT name, salary
FROM instructor
ORDER BY name;

-- 2. Show all columns for instructors in the 'Comp. Sci.' department in order by name.
--    Answer:  has 3 rows: Brandt, Katz, Srinivasan
SELECT *
FROM instructor
WHERE dept_name = 'Comp. Sci.';

-- 3. Show name, salary, department for instructors with salaries less than $50,000 in order by name.
--    Answer:  1 row for Mozart
SELECT name, salary, dept_name
FROM instructor
WHERE salary < 50000
ORDER BY name;

-- 4. Show the student name, major department and total credits for 
--    students with at least 98 credits.  Sort the list by total credits.
--    Answer: 4 rows
SELECT name, dept_name, tot_cred
FROM student
WHERE tot_cred >= 98
ORDER BY tot_cred;

-- 5. Show the student ID and name for students who are majoring in  
--    'Elec. Eng.' or 'Comp. Sci.'  and have at least 90 credits.  Sort the list by ID.
--    Answer:  2 rows. Zhang, Bourikas
SELECT ID, name
FROM student
WHERE dept_name IN ('Elec. Eng.', 'Comp. Sci.')
	AND tot_cred >= 90
ORDER BY ID;

-- 6. Show all columns of the student table with rows listed in order by student name.
SELECT * 
FROM student
ORDER BY name;

-- 7. Show the  ID, name and salary for all instructors.
--    Order by salary highest to lowest.
SELECT ID, name, salary
FROM instructor
ORDER BY salary DESC;

-- 8. Show all the student majors (the dept_name column in the student table) without duplicates.
--    Label the dept_name column as 'major'.  List the majors in alphabetical order.
--    Answer: 7 rows
SELECT DISTINCT dept_name AS major
FROM student
ORDER BY major;

-- 9.  List the course id and title for courses that have 
--     "System" or "Computer" in their title.  Order the list by course id.
--     Answer: 3 rows
SELECT course_id, title
FROM course
WHERE title LIKE '%System%' OR title LIKE '%Computer%'
ORDER BY course_id;

-- 10.  List the id and name of instructors whose name
--     start with the letter "S".  Sort the list by name.
--     Answer: 2 rows
SELECT ID, name
FROM instructor
WHERE name LIKE 'S%'
ORDER BY name;

-- 11.  Return a list of all courses with the department name and 
--     the 3 digit number of the course labeled as "course_number".
--     Order the list by department name and course number.
--     The first row of the result would be 
--     DEPT_NAME   COURSE_NUMBER
--     Biology     101 
SELECT dept_name, RIGHT(course_id, 3) AS "course_number"
FROM course
ORDER BY dept_name AND course_number;

-- 12.  Use the BETWEEN predicate to show the student ID and name 
--     of students who have total credits in the range 50 to 90 inclusive.
--     The result should be sorted by ID.
SELECT ID, name
FROM student
WHERE tot_cred BETWEEN 50 AND 90
ORDER BY ID;

-- 13. List all columns of upper division courses from the course table.
--    An upper division course has a number >= 300.
--    List the courses in order by dept_name and then course_id. 
SELECT title, RIGHT(course_id, 3) AS "course_number", dept_name, credits
FROM course
WHERE RIGHT(course_id, 3) >= 300
ORDER BY dept_name, course_number;

-- 14. List all the buildings used to teach classes from the sections table.
--    Do not list duplicates.  List the buildings alphabetically.
SELECT DISTINCT building
FROM section
ORDER BY building;

-- 15.  show the instructor id and the course_id taught by the instructor.
--     If an instructor taught a course multiple times, don't list duplicates.
--     Sort the results by instructor ID, then course_id.
SELECT DISTINCT course_id, ID
FROM teaches
ORDER BY ID, course_id;

-- 16.  for each instructor show their ID, name, monthly salary (salary divided by 12 rounded to integer) 
--     labeled as "monthly_salary".  Order the result by monthly salary largest to smallest. 
SELECT DISTINCT ID, name, ROUND(salary / 12) AS 'monthly_salary'
FROM instructor
ORDER BY monthly_salary DESC;

-- 17.  Use the section table to list all Computer Science courses taught in Spring 2009.
--     List the course_id, sec_id, building and room_number.
--     Order the result by course_id then sec_id.
select course_id, sec_id, building, room_number
FROM section
WHERE course_id LIKE 'CS%'
	AND semester = 'SPRING'
    AND year = 2009
ORDER BY course_id, sec_id;

-- 18. Which students have a null value for grade? 
--     Return the student id, course_id, year, semester in order by id;
select ID, course_id, year, semester
FROM takes
WHERE grade IS NULL
ORDER BY ID;
               