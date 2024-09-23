-- lab 5 
-- use schema file '1994-census-summary.sql';

SELECT * FROM census;

-- 1. what ‘workclass’ values appear in the data?  
--    (don’t show any duplicates)
select DISTINCT workclass
FROM census;

-- 2. what is the average age of people in the data?
--    The answer is 38.5816
select AVG(age)
FROM census;

-- 3. how many countries of birth appear in the data?
--    Your answer should be 42.
select COUNT(DISTINCT native_country)
FROM census;

-- 4. which native countries start with 'F'?
--    Answer:  France
select DISTINCT native_country
FROM census
WHERE native_country LIKE 'F%';

-- 5. which native countries end with 'a'?
--    Answer:  11 rows
select DISTINCT native_country
FROM census
WHERE native_country LIKE '%a';

-- 6. which native countries do not have 'a' anywhere in their name? 
--    (Use the predicate "not like")  Answer has 7 rows.
select DISTINCT native_country
FROM census 
WHERE native_country NOT LIKE '%a'
	AND native_country NOT LIKE 'a%'
    AND native_country NOT LIKE '%a%';

-- 7. what is the average age of people who have never worked?
--   (hint: use predicate workclass = 'Never_worked')
--   Answer is 20.5714
select AVG(age)
FROM census
WHERE workclass = 'Never_worked';

-- 8.  What is the average age for each workclass?
--     Answer has 9 rows.  
--     Use the name "average_age" for the averages. 
--     The first row is 
--     workclass     average_age
--     State_gov     39.4361
select DISTINCT workclass, AVG(age) AS average_age
FROM census
GROUP BY workclass;

-- 9. What is the average age by workclass, listed in order of average age?
select DISTINCT workclass, AVG(age) AS average_age
FROM census
GROUP BY workclass
ORDER BY average_age;

-- 10. What is the average of years-of-education by both workclass and sex?
select workclass, sex, AVG(age) AS average_age
FROM census
GROUP BY workclass, sex
ORDER BY average_age;

-- 11. What is the average, maximum, and minimum number of years of education by workclass?
select AVG(education_num) AS average, MAX(education_num) AS maximum, MIN(education_num) AS minimum
FROM census
GROUP BY workclass
ORDER BY average;

-- 12 change “NA” values of the attribute ‘workclass’ to null values, as follows:
--     1836 rows should be changed.
update census set workclass=null where workclass='NA';

-- 13. Write an SQL query to count the number of rows in the census table.
--     Answer: 32,561 rows
select COUNT(usid)
FROM census;

-- 14. Write an SQL query to count the number of ‘workclass’ values.
--     Answer: 30,725
select COUNT(workclass)
FROM census;

-- 15. What is the difference between the two count values you just found?
--  One counts the number of rows while the other counts the number of workclass
--  values that are not null.

-- 16. Write an SQL query to count the number of rows in which workclass is null.
--    Answer:  1,836 
select COUNT(*) AS null_workclass
FROM census
WHERE workclass IS NULL;