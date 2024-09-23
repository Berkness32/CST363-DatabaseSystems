-- homework 3.sql
-- The tables used in this exercise come from 'courses-small.sql';

-- 1.  List the Comp. Sci. courses taught in Spring 2009.
--     List the course id, title in order by course_id.
SELECT course_id, semester, year
FROM section
WHERE semester = 'Spring' 
	AND year = 2009 
    AND LEFT(course_id, 2) = 'CS'
ORDER BY course_id;

-- 2.  For the spring 2009 semester, show the department name
--     and number of students enrolled in courses from each department
--     Label the number of students as "enrollment". 
--     Order the result by department name.
--
--     Count the the unique ID with the same course_id
--     Need to join with course
select dept_name, COUNT(t.ID) AS enrollment
FROM takes t
INNER JOIN course c
ON t.course_id = c.course_id
WHERE semester = 'Spring' AND year = 2009
GROUP BY t.course_id
ORDER BY dept_name;

-- 3.  List all instructors ID , name and department with the number of courses taught with the 
--     label "courses_taught".   If an instructor did not teach, they are listed with a value of 0.
--     Order by result by ID.  A correct result will have 3 instructors with 0 courses. 
SELECT instructor.ID, name, dept_name, COALESCE(COUNT(teaches.ID), 0) AS courses_taught
FROM instructor
LEFT JOIN teaches
ON instructor.ID = teaches.ID
GROUP BY instructor.ID
ORDER BY instructor.ID;

-- 4.  List the student majors (student.dept_name) and the number of students in each major
--     with the label "count" in order by major.
select student.dept_name AS major, COUNT(ID) AS count
FROM student
GROUP BY student.dept_name;

-- 5.  Same as #4 but only list majors with more than 2 students.
select student.dept_name AS major, COUNT(ID) AS count
FROM student
GROUP BY student.dept_name
HAVING count > 2;

-- 6.  List all departments and the number of students majoring in that department (use label "count")
--      and have more than 90 total credits.  Order by department name.
--      Answer:  7 department rows. History, Music and Physics departments have 0 students 
SELECT department.dept_name AS major, COALESCE(COUNT(student.ID), 0) AS count
FROM department
LEFT JOIN student ON department.dept_name = student.dept_name AND student.tot_cred > 90
GROUP BY department.dept_name
ORDER BY department.dept_name;


-- 7.  show the instructor id, name, course title and number of times taught. 
--     label the output columns id, name, title, count. 
--     order the result by id, then title.
--     List all instructor.  If an instructor has not taught any courses
--     then list title as null and count as 0. 
--     Answer:  Gold, Califeri and Singh have not taught courses.
SELECT instructor.ID AS id, instructor.name AS name, course.title AS title, COALESCE(COUNT(teaches.course_id), 0) AS count
FROM instructor
LEFT JOIN teaches ON instructor.ID = teaches.ID
LEFT JOIN course ON teaches.course_id = course.course_id
GROUP BY instructor.ID, course.title
ORDER BY instructor.ID, course.title;

-- 8.  List students ID and name with more than 90 credits or have taken more than 2 courses. 
--     order the result by ID.
--     Hint: Use UNION operator.
--     Answer:  6 rows
SELECT student.ID, student.name
FROM student
WHERE tot_cred > 90
UNION
SELECT takes.ID, NULL AS name
FROM takes
GROUP BY takes.ID
HAVING COUNT(course_id) > 2
ORDER BY ID;


-- 9. Calculate the GPA for each student. 
--    Multiply the sum of numeric value of the grade times the course credits 
--    and divide by the sum of course credits for all courses taken.
--    The numeric value of a grade can be found in the grade_points table.
--    The course credit value is in the course table.
--    label the columns id, name, gpa and list the rows by student id
--    Answer:  Zhang has a gpa 3.87143, Snow has a null gpa
SELECT 
    takes.ID AS ID,
    student.name AS name,
    COALESCE(
        (SUM(grade_points.points * course.credits) / SUM(course.credits)),
        NULL
    ) AS gpa
FROM takes
LEFT JOIN course ON takes.course_id = course.course_id
LEFT JOIN student ON takes.ID = student.ID
LEFT JOIN grade_points ON takes.grade = grade_points.grade
GROUP BY takes.ID, student.name
ORDER BY takes.ID;

-- 10.  Find the department(s)  with the most students. 
--     Return department name and the count of students labeled as "students" 
--     Your should find that Comp. Sci. has the most students with 4.
SELECT dept_name, COUNT(ID) AS students
FROM student
GROUP BY dept_name
ORDER BY students DESC;

SELECT department.dept_name, COALESCE(COUNT(student.ID), 0) AS students
FROM department
LEFT JOIN student ON department.dept_name = student.dept_name
GROUP BY dept_name
ORDER BY students DESC;

-- 11.  Find courses that have not been taken by any student Return the course_id.
--     Hint: use NOT EXISTS or NOT IN predicate. 
--     Answer: BIO-399 has not been taken by any students.

SELECT course.course_id
FROM course
WHERE NOT EXISTS (
    SELECT ID
    FROM takes
    WHERE takes.course_id = course.course_id
);

-- 12.  Do #2 in another way that uses a join.
SELECT course.course_id 
FROM course
LEFT JOIN takes
ON course.course_id = takes.course_id
WHERE takes.ID IS NULL;

-- 13.  Find the courses taken by students in the Comp. Sci. department
--     that have more than 90 credits.  
--     Return the course_id and title.  List each course only once. 
--     The answers will be CS-101 and CS-347
SELECT takes.course_id 
FROM student
LEFT JOIN takes
ON student.ID = takes.ID
LEFT JOIN course
ON takes.course_id = course.course_id
WHERE student.dept_name = 'Comp. Sci.' AND tot_cred > 90;

-- 14.  Find students who passed a 4 credit course (course.credits=4)
--     A passing grade is A+, A, A-, B+, B, B-, C+, C, C-.
--     Return student ID and name ordered by student name.
--     The answer will have 8 students.
SELECT takes.ID, student.name 
FROM takes
LEFT JOIN course ON takes.course_id = course.course_id
LEFT JOIN student ON takes.ID = student.ID
LEFT JOIN grade_points ON grade_points.grade = takes.grade
WHERE grade_points.points >= 1.7 AND course.credits = 4
ORDER BY student.name;

-- I am getting 10 students but it looks like everyone matches the criteria?
SELECT *
FROM takes
LEFT JOIN course ON takes.course_id = course.course_id
LEFT JOIN student ON takes.ID = student.ID
LEFT JOIN grade_points ON grade_points.grade = takes.grade
WHERE grade_points.points >= 1.7 AND course.credits = 4
ORDER BY student.name;

-- 15.  Find the course(s) taken by the most students.  Return columns 
--     course_id, title,  enrollment (the count of students that have taken the course)
--     The answer is CS-101 with an enrollment of 7
SELECT course.course_id, course.title, COUNT(takes.ID) AS enrollment
FROM takes
LEFT JOIN course ON takes.course_id = course.course_id
GROUP BY course.course_id
ORDER BY enrollment DESC;

-- 16.  create a view named "vcourse" showing columns course_id, title, credits, enrollment
--     If no students have taken the course, the enrollment should be 0.
CREATE VIEW vcourse
AS  SELECT course.course_id, course.title, COUNT(takes.ID) AS enrollment
	FROM course
	LEFT JOIN takes ON takes.course_id = course.course_id
	LEFT JOIN student ON takes.ID = student.ID
	GROUP BY course.course_id
	ORDER BY enrollment DESC;

-- 17.  List all the rows in the view "vcourse" and verify that
--     the enrollment in BIO-399 is 0.
SELECT * FROM vcourse;

-- 18. Use the view to display the course(s) with highest enrollment.
--    Return course_id, title, enrollment 
--    Answer is same as #6.

-- #6 asks for students with more than 90 credits while this one does not?
SELECT * 
FROM vcourse
WHERE enrollment > 5;
     
-- 19.  List the instructor(s) (ID, name) in order by ID who advise the most students
--      Answer:  Einstein, Katz and Kim  advise the most students.
SELECT COUNT(instructor.ID) AS ID, instructor.name
FROM advisor
LEFT JOIN instructor
ON advisor.i_ID = instructor.ID
GROUP BY instructor.ID
ORDER BY ID DESC;

-- 20. List the course_id and title for courses that are offered both in Fall 2009 and in Spring 2010.
--     A correct answers shows that CS-101 is the only course offered both semesters.
SELECT course_id, title
FROM course c
WHERE EXISTS (
    SELECT 1
    FROM section s1
    WHERE s1.course_id = c.course_id
    AND s1.semester = 'Fall' AND s1.year = 2009
) AND EXISTS (
    SELECT 1
    FROM section s2
    WHERE s2.course_id = c.course_id
    AND s2.semester = 'Spring' AND s2.year = 2010
);


