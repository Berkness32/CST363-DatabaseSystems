-- Lab 1.0
-- create a database named patientdb
drop database if exists patientdb;
create database patientdb; 
use patientdb;

-- create a table named patient 
-- patient_no  last_name  first_name  sex  date_of_birth  ward
-- 454         Smith      John        M    8/14/1978      6
-- 223         Jones      Peter       M    12/7/1985      8
-- 597         Brown      Brenda      F    6/17/1961      3
-- 234         Jenkins    Alan        M    1/29/1972      7
-- 244         Wells      Chris       F    2/25/1996      6 
--
-- Use DATE data type for the column date_of_birth.
-- To insert a DATE value use a string value in the format 'YYYY-MM-DD'

CREATE TABLE patient (
	patient_no INT,
    last_name VARCHAR(10),
    first_name VARCHAR(10),
    sex VARCHAR(1),
    date_of_birth DATE,
    ward TINYINT
); 

-- execute the following insert statement to insert the rows.
insert into patient 
(patient_no, last_name, first_name, sex, date_of_birth, ward) 
values 
(454, 'Smith', 'John', 'M', '1978-08-14', 6),
(223, 'Jones', 'Peter', 'M', '1985-12-7', 8), 
(597, 'Brown', 'Brenda', 'F', '1961-06-17', 3), 
(234, 'Jenkins', 'Alan', 'M', '1972-01-29', 7), 
(244, 'Wells', 'Chris', 'F', '1996-02-25', 6);

-- execute the following select to verify the contents of the patient table.
select * from patient;

-- 1. what are the first names of all the patients in alphabetical order? 
select first_name
FROM patient
ORDER BY first_name;

-- 2. What are the first names of all the patients in order Z-A?
select first_name
FROM patient
ORDER BY first_name DESC;

-- 3. what is the last name of patient 234?
select last_name
FROM patient
where patient_no = 234;

-- 4. which wards have patients with last name 'Smith'?
select ward
FROM patient
WHERE last_name = 'Smith';

-- 5. what are all the attributes of patients in ward 6?
select *
FROM patient
WHERE ward = 6;

-- 6. what are the first and last names of the female patients in order by last name?
select first_name, last_name
FROM patient
WHERE sex = 'F';

-- 7. what are the patient numbers between 200 and 300, inclusive?
select patient_no
FROM patient
WHERE patient_no BETWEEN 200 AND 300;

-- 8. what are the first and last names of patients are in either ward 6 or ward 7?  
--   Return the list in alphabetical order by last name, first name
select first_name, last_name
FROM patient
WHERE ward = 6 OR ward = 7
ORDER BY last_name, first_name;

-- 9. what are the last names of patients that are either in ward 3 or are male?
select last_name
FROM patient
WHERE ward = 3 OR sex = 'M';
