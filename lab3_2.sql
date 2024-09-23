-- Lab 3.2
--  Create a table actor, with fields 
--  ID integer primary key
--  name varchar(30)
--  birthyear  int  with check constraint that year must be greater than 1900
CREATE TABLE actor (
	ID INT,
    name VARCHAR(30),
    birthyear INT CHECK (birthyear > 1900),
	PRIMARY KEY (ID)
);

-- 1. Try to insert actor Simon Pegg (born 1970) twice.  Use an ID value of 1 both times.
INSERT INTO actor
VALUES (1, 'Simon Pegg', 1970-01-01);

--    What constraint is violated?
--    Using the same PRIMARY KEY without a REFERENTIAL KEY

-- 2.  Try to insert an actor into the actor table with ID 3, name 'Neil Old', and birthyear 1754.
INSERT INTO actor
VALUES (3, 'Neil Old', 1980-01-01);
--    What constraint is violated?
--    Missing ID 2

-- 3. Create another table 'movie', with fields 
--     title  varchar(30)
--     yearMovie  integer check that yearMovie is greater than 1880
--     director varchar(30)  
--     Define the primary key to be the attributes title and yearMovie.   
create table movie (
	title VARCHAR(30), 
    yearMovie INT CHECK (yearMovie > 1880),
    director VARCHAR(30),
    PRIMARY KEY (title, yearMovie)
);

-- 4. Insert a movie into the movie table, with title 'Paul', year 2011, and director 'Greg Mottola’. 
insert into movie
VALUES ('Paul', 2011, 'Greg Mottola');
--    What constraint is violated?
--     Using a VARCHAR for the primary key


-- 5.  Create another table 'appears’  with fields 
--    actor_ID integer  
--    title  varchar(30) 
--    yearMovie integer  
--    Add two constraints so that the actor_ID is the ID of an actor in the actor table, 
--    and title, yearMovie identify a movie in the movie table.   
--    The primary key should be the attributes actor_ID, title, yearMovie.
CREATE TABLE appears (
    actor_ID INT,
    title VARCHAR(30),
    yearMovie INT,
    PRIMARY KEY (actor_ID, title, yearMovie),
    FOREIGN KEY (actor_ID) REFERENCES actor(actor_ID),
    FOREIGN KEY (title, yearMovie) REFERENCES movie(title, yearMovie)
);


-- 6. Insert a row into the 'appears' table with actor_ID = 1, title = 'Paul', and year = 2010 (NOT 2011).
insert INTO appears
VALUES (1, 'Paul', 2010);
--    What constraint is violated?
--     Breaks referential integrity.