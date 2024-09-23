-- use the view vcampaign created in Lab 13.
use campaign;

-- 1. For the 3 occupations 'STUDENT', 'TEACHER', and 'LAWYER',
-- show the occupation, and average dollar contribution rounded to an whole number 
-- use the view "vcampaign" and order by occupation 
-- Answer: The average contribution by STUDENT should be 538.

SELECT occupation, ROUND(AVG(amount))
FROM vcampaign
WHERE occupation = 'STUDENT'
GROUP BY occupation
UNION
SELECT occupation, ROUND(AVG(amount))
FROM vcampaign
WHERE occupation = 'LAWYER'
GROUP BY occupation
UNION
SELECT occupation, ROUND(AVG(amount))
FROM vcampaign
WHERE occupation = 'TEACHER'
GROUP BY occupation
ORDER BY occupation;

-- 2. How many occupations have an occupation that contains the string 'lawyer'  
-- Answer: 28
SELECT COUNT(DISTINCT occupation)
FROM vcampaign
WHERE occupation LIKE '%LAWYER' OR occupation LIKE 'LAWYER%';


-- 3. List all the ways that lawyers list their occupation.
SELECT DISTINCT occupation
FROM vcampaign
WHERE occupation LIKE '%LAWYER' OR occupation LIKE 'LAWYER%';

-- 4. how many contributors have the occupation listed as 'LAWYER' exactly.
-- Answer: 553
select COUNT(DISTINCT contbr_id)
FROM vcampaign
WHERE occupation = 'LAWYER';

-- 5. what is the average number (not amount) of contributions per zip code.
-- Answer:  95.5416
SELECT AVG(cnt) AS avg_contributions_per_zip
FROM (
    SELECT COUNT(contbr_id) AS cnt
    FROM vcampaign
    GROUP BY zip
) AS counts;


-- 6. list the top 20 zip codes by number of contributors in the zip code
-- use only the first 5 digits of the zip code. Order by count.
select cnt, SUBSTRING(zip, 1, 5) AS zip_code
FROM (
    SELECT COUNT(contbr_id) AS cnt, zip
    FROM vcampaign
    GROUP BY zip
) AS counts
ORDER BY cnt DESC
LIMIT 20;

-- 7. list the top 20 zip codes by total amount of contributions in the zip code
-- use only the first 5 digits of the zip code. Order by total.
select SUM(amount) AS total_amount, SUBSTRING(zip, 1, 5) AS zip_code
FROM vcampaign
GROUP BY zip
ORDER BY total_amount DESC
LIMIT 20;

-- 8. show the date and amount of contribution made by 'BATTS, ERIC'.  Order by amount (largest to smallest)
select amount, date
FROM vcampaign
WHERE contbr_name = 'BATTS, ERIC'
ORDER BY amount DESC;

-- 9. list the top 20 contributors from the city of SALINAS and the total amount contributed by each contributor.
-- return the name and total amount contributed ordered by total from largest amount to smallest
select contbr_name, total_amount
FROM (
	SELECT contbr_name, SUM(amount) AS total_amount
    FROM vcampaign
    WHERE city = 'SALINAS'
    GROUP BY contbr_name
) AS total_cont
ORDER BY total_amount DESC 
LIMIT 20;

-- 10. for each candidate, list the percentage of total contribution amount made up by positive contributions under $1,000
--     Result should have columns cand_name, percentage and be ordered by candidate name.
--     Ignore a contribution if amount is negative.
--     Answer includes : Bernard Sanders has percentage 0.776584
SELECT cand_name,(total_amount / total_sum) AS percentage
FROM (
    SELECT cand_name, SUM(amount) AS total_amount
    FROM vcampaign
    WHERE amount > 0 AND amount < 1000
    GROUP BY cand_name
) AS total_cont,
(
    SELECT SUM(amount) AS total_sum
    FROM vcampaign
    WHERE amount > 0 AND amount < 1000
) AS total_sum_table
ORDER BY cand_name;


-- 11. for each candidate, which zip code(s) contributed the highest amount to the candidate
--     Result should have candidate name, 5 digit zip code and total amount contributed as "total"
--     Order the result by candiate name.
--     Ignore a contribution if amount is negative.
--     Answer includes:  Hilary Clinton, zip 90049  
--                       George Pataki, zip 94549 and 95608 are tied with $5400.00 each.
SELECT cand_name, zip, total
FROM (
    SELECT cand_name, zip, SUM(amount) AS total
    FROM vcampaign
    WHERE amount > 0
    GROUP BY cand_name, zip
) AS zip_contbr
WHERE 
    (cand_name, total) IN 
    (
        SELECT cand_name, MAX(total) AS max_total
        FROM 
            (
                SELECT cand_name, zip, SUM(amount) AS total
                FROM vcampaign
                WHERE amount > 0
                GROUP BY cand_name, zip
            ) AS max_zip_contbr
        GROUP BY cand_name
    )
ORDER BY cand_name;

