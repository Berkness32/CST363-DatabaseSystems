--    The following questions use the tables from product database:
--    tables product, pc, laptop and printer.
--    Use the file productDB.sql to create these tables 
--    with data.
--
-- 1.	What PC models have a speed of at least 3.00?  
--      List the results in order by model.
--      Answer:  3 rows
select model
FROM pc
WHERE speed >= 3.00 AND speed IS NOT NULL
ORDER BY speed;

-- 2.	List all manufacturers that makes laptops with a hard disk 
--       of at least 100GB?  List in order by maker.
--       Answer:  5 rows
select DISTINCT maker
FROM laptop l
LEFT JOIN product p ON l.model = p.model;

-- 3.	Find the model number and price of all products (of any 
--      type) made by manufacturer B?  
--      The result should be in order by model number and then by
--      price (low to high)  [hint:  use a union]
--      Answer:  4 rows
SELECT p.model, price
FROM product p
INNER JOIN laptop l ON p.model = l.model AND p.maker = 'B'
UNION
SELECT p.model, price
FROM product p
INNER JOIN pc ON p.model = pc.model AND p.maker = 'B'
UNION
SELECT p.model, price
FROM product p
INNER JOIN printer ON p.model = printer.model AND p.maker = 'B'
ORDER BY model, price;


-- 4.	Find the model numbers for all color laser printers.  
--      Order by model.
--      Answer:  2 rows
select *
FROM printer
WHERE color = 1 AND type = 'laser'
ORDER BY model;

-- 5.	Find those manufacturers that sell laptops but not pc’s. 
--      Sort result by maker.
--      Answer:  F and G
select DISTINCT maker
FROM product p
LEFT JOIN laptop l ON p.model = l.model
WHERE EXISTS
	(SELECT * 
    FROM pc
    WHERE maker = 'F' OR maker = 'G');

-- 6.	Find those hard-drive sizes that occur in two or more PC’s.   
--      Sort the list low to high. [hint: use group and having]
--      Answer:  80, 160, 250
select hd
FROM pc
GROUP BY hd
HAVING COUNT(hd) >= 2
ORDER BY hd;

-- 7.	Find those pairs of PC models that have both the same speed 
--      and RAM.  The output should have 2 columns,  "model1" and
--      "model2".  A pair should be listed only once:  e.g. if 
--      (model1, model2) is in the result then (model2, model1) 
--      should not appear.   Sort the output by the first column.
--      Answer:  1 rows (1004, 1012)
SELECT DISTINCT pc1.model AS model1, pc2.model AS model2
FROM pc pc1
JOIN pc pc2 ON pc1.model < pc2.model 
           AND pc1.speed = pc2.speed
           AND pc1.ram = pc2.ram
ORDER BY model1;


-- 8.	Find the maker(s) of the color printer with the lowest 
--      price. Order by maker.
--      Answer:  E
select product.maker
FROM printer
LEFT JOIN product ON printer.model = product.model
WHERE printer.price =
	(SELECT MIN(printer.price)
	 FROM printer)
ORDER BY product.maker;

-- 9.	Find the manufacturer of PC’s with at least three different 
--      speeds.  Order by maker.
--      Answer:  A, D and E
SELECT product.maker
FROM pc
JOIN product ON pc.model = product.model
GROUP BY product.maker
HAVING COUNT(DISTINCT pc.speed) >= 3
ORDER BY product.maker;


-- 10.	Find those manufacturers of at least two different computers 
--     (PC’s or laptops)  with speeds of at least 2.80.  
--      Order the result by maker. 
--      Answer:  B, E
SELECT maker
FROM product
WHERE model IN (
    SELECT model
    FROM laptop
    WHERE speed >= 2.8
    UNION
    SELECT model
    FROM pc
    WHERE speed >= 2.8
)
GROUP BY maker
HAVING COUNT(DISTINCT model) >= 2
ORDER BY maker;


-- 11.  Find the manufacturer(s) of the computer (PC or laptop) with
--      the highest speed.  
--      If there are multiple makers, order by maker.
--      Answer: B 


