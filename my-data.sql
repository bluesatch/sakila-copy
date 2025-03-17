-- CREATE A TEMPORARY TABLE--

-- CREATE A TEMPORARY TABLE OF EVERY ACTOR WHOSE LAST NAME BEGINS WITH 'J'
CREATE TEMPORARY TABLE actors_j
(actor_id SMALLINT(5),
first_name VARCHAR(45),
last_name VARCHAR(45)
);

-- INSERT DATA INTO TEMPORARY TABLE 
INSERT INTO actors_j
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE 'J%';

-- WHERE CLAUSE => ALLOWS US TO FILTER THROUGH DATA

-- GET ALL RATED G FILMS THAT CAN BE KEPT FOR AT LEAST A WEEK
SELECT title FROM FILM 
WHERE rating = 'G' AND rental_duration >= 7;

SELECT title FROM FILM 
WHERE rating = 'PG-13' AND rental_duration <= 5;

-- GET ALL RATED G FILMS OR CAN BE KEPT FOR AT LEAST A WEEK 
SELECT title FROM film 
WHERE rating = 'G' OR rental_duration >= 7;

-- (RATED G AND ARE AVAILABLE FOR 7 OR MORE DAYS) OR (RATED PG-13 AND ARE AVAILABLE 3 OR FEWER DAYS)

SELECT title, rating, rental_duration 
FROM film 
WHERE (rating = 'G' AND rental_duration >= 7)
OR (rating = 'PG-13' AND rental_duration < 4);

-- GROUP BY and HAVING clauses
-- GROUP BY is used to group data by column values
-- HAVING allows you to filter grouped data in the same way the WHERE clause lets you filter raw data

-- FIND ALL CUSTOMERS WHO HAVE RENTED 40 OR MORE FILMS 
SELECT c.first_name, c.last_name, count(*)
FROM customer c
JOIN rental USING (customer_id)
GROUP BY c.first_name, c.last_name 
HAVING count(*) >= 40;

SELECT customer.first_name, customer.last_name, count(*) 
FROM customer
INNER JOIN rental 
ON customer.customer_id = rental.customer_id
GROUP BY customer.first_name, customer.last_name 
HAVING count(*) >= 40;

-- ORDER BY 
-- SORTS DATA
-- GET ALL CUSTOMERS WHO RENTED A FILM ON JUNE 14, 2005
SELECT c.first_name, c.last_name, time(r.rental_date) rental_time
FROM customer c 
JOIN rental r USING (customer_id)
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY c.last_name, c.first_name;

-- DESCENDING DESC
SELECT c.first_name, c.last_name, time(r.rental_date) rental_time
FROM customer c 
JOIN rental r USING (customer_id)
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY time(r.rental_date) DESC;

-- CHALLENGE #1
-- RETRIEVE THE ACTOR ID, FIRST NAME, AND LAST NAME FOR ALL ACTORS. SORT BY LAST NAME AND THEN BY FIRST NAME
SELECT actor_id, first_name, last_name 
FROM actor 
ORDER BY last_name, first_name;

-- CHALLENGE #2
--RETRIEVE THE ACTOR ID, FIRST NAME, AND LAST NAME FOR ALL ACTORS WHOSE LAST NAME EQUALS 'WILLIAMS' OR 'DAVIS'
SELECT actor_id, first_name, last_name 
FROM actor 
WHERE (last_name = 'WILLIAMS') OR (last_name = 'DAVIS');

-- CHALLENGE #3
--WRITE A QUERY AGAINST THE RENTAL TABLE THAT RETURNS THE IDS OF THE CUSTOMERS WHO RENTED A FILM ON JULY 5, 2005 (USE THE RENTAL.RENTAL_DATE COLUMN, AND YOU CAN USE THE DATE() FUNCTION TO IGNORE THE TIME COMPONENT). INCLUDE A SINGLE ROW FOR EACH DISTINCT CUSTOMER ID
SELECT DISTINCT customer_id, rental_date
FROM rental 
WHERE date(rental_date) = '2005-07-05';


-- -----------------------Filtering ----------------------------------------------

-- EQUALITY CONDITIONS
-- GET ALL EMAILS FROM EACH CUSTOMER WHO RENTED ON JUNE 14, 2005 
SELECT c.email 
FROM customer c 
JOIN rental r USING (customer_id)
WHERE date(r.rental_date) = '2005-06-14';

-- GET ALL EMAILS, FIRST AND LAST NAME OF EACH CUSTOMER WHO RENTED ON JULY 3, 2005;
SELECT DISTINCT c.email, c.first_name, c.last_name 
FROM customer c 
JOIN rental r USING (customer_id)
WHERE date(r.rental_date) = '2005-06-15';

-- <> => NOT EQUAL 
--GET ALL EMAILS FROM EACH CUSTOMER THAT DID NOT RENT ON JUNE 14, 2005  
SELECT c.email 
FROM customer c 
JOIN rental r USING (customer_id)
WHERE date(r.rental_date) <> '2005-06-14';

-- RANGE CONDITIONS
-- CHECK TO SEE IF DATA FALLS WITHIN A RANGE
-- GET EVERY CUSTOMER ID WHO RENTED BEFORE MAY 25, 2005
SELECT customer_id, rental_date 
FROM rental 
WHERE rental_date < '2005-05-25';

-- GET EVERY CUSTOMER ID FOR THOSE WHO RENTED BETWEEN JUNE 14, 2005 AND JUNE 16, 2005
SELECT customer_id, rental_date 
FROM rental 
WHERE (rental_date <= '2005-06-16') AND (rental_date >= '2005-06-14');

-- USING THE BETWEEN OPERATOR
SELECT customer_id, rental_date 
FROM rental 
WHERE rental_date BETWEEN '2005-06-14' AND '2005-06-16';
--WHEN USING THE BETWEEN OPERATOR, YOU MUST ALWAYS SPECIFY THE LOWER LIMIT FIRST

-- GET CUSTOMER ID, PAYMENT DATE AND AMOUNT WHERE PAYMENT IS BETWEEN 10.0 AND 11.99
SELECT c.first_name, c.last_name, p.payment_date, p.amount
FROM payment p 
JOIN customer c USING (customer_id) 
WHERE p.amount BETWEEN 10.0 AND 11.99
ORDER BY p.amount DESC;

--GET EVERY LAST AND FIRST NAME OF CUSTOMERS WHOSE LAST NAME FALLS BETWEEN FA AND FR
SELECT last_name, first_name 
FROM customer 
WHERE last_name BETWEEN 'FA' AND 'HU';

-- GET EVERY TITLE AND RATING THAT HAS A RATING OF G OR PG
SELECT title, rating
FROM film 
WHERE (rating = 'G') OR (rating = 'PG');

-- REWRITING
SELECT title, rating
FROM film 
WHERE rating IN ('G', 'PG');

-- WITH IN OPERATOR, YOU CAN WRITE A SINGLE CONDITION NO MATTER HOW MANY EXPRESSIONS ARE IN THE SET

-- NOT IN
SELECT title, rating 
FROM film 
WHERE rating NOT IN ('PG-13', 'R', 'NC-17');

-- WILDCARDS
-- FOR SEARCHING PARTIAL STRING MATCHES

-- % (ANY NUMBER OF CHARACTERS) OR _ (A SINGLE CHARACTER)

SELECT last_name, first_name FROM customer
WHERE last_name LIKE '_A_T%S';

-- GET ALL FILMS THAT HAVE AN 'ER' IN THE TITLE
SELECT title FROM film 
WHERE title LIKE '%ER%';

-- GET EVERY ACTOR WHOSE LAST NAME INCLUDES A AS THE SECOND LETTER
SELECT last_name, first_name FROM actor
WHERE last_name LIKE '_A%';


-- CHALLENGE #1
-- CONSTRUCT A QUERY THAT RETRIEVES ALL ROWS FROM THE PAYMENTS TABLE WHERE THE AMOUNT IS EITHER 1.98, 7.98, OR 9.98

SELECT customer_id, amount FROM payment
WHERE amount IN (1.98, 7.98, 9.98) ORDER BY amount;

-- CHALLENGE #2
-- CONSTRUCT A QUERY THAT FINDS ALL CUSTOMERS WHOSE LAST NAME CONTAINS AN A IN THE SECOND POSITION AND A W ANYWHERE AFTER THE A

SELECT customer_id, last_name, first_name FROM customer
WHERE last_name LIKE '_A%W%';


-- ---------------- MULTIPLE TABLES ------------------------------------- --

-- JOIN => HOW WE CAN CONNECT MULTIPLE TABLES

-- GET ALL CUSTOMER'S FIRST AND LAST NAMES AND STREET ADDRESS
-- LET'S MAKE A MISTAKE
SELECT c.first_name, c.last_name, a.address
FROM customer c JOIN address a;

-- INNER JOIN
SELECT c.first_name, c.last_name, a.address 
FROM customer c 
INNER JOIN address a 
ON c.address_id = a.address_id;

SELECT c.first_name as first, c.last_name as last, a.address as address
FROM customer c 
JOIN address a USING (address_id);

SELECT c.first_name, c.last_name, a.address 
FROM address a 
JOIN customer c USING (address_id);


-- GET CUSTOMERS WHOSE POSTAL CODE IS 52137 
SELECT c.first_name, c.last_name, a.address
FROM customer c, address a
WHERE c.address_id = a.address_id
AND a.postal_code = 52137;

SELECT c.first_name, c.last_name, a.address
FROM customer c 
JOIN address a USING (address_id)
WHERE a.postal_code = 52137;


-- JOIN THREE OR MORE TABLES
-- RETURN CUSTOMER'S FIRST AND LAST NAME, CITY

-- Desc address
--Desc city

SELECT c.first_name, c.last_name, ct.city
FROM customer c 
JOIN address a 
ON c.address_id = a.address_id
JOIN city ct 
ON a.city_id = ct.city_id;


-- USE SUBQUERY AS TABLE
-- GET CUSTOMER'S FIRST AND LAST NAME, ADDRESS, AND CITY
SELECT c.first_name, c.last_name, addr.address, addr.city
FROM customer c 
JOIN 
    (SELECT a.address_id, a.address, ct.city
    FROM address a 
    JOIN city ct 
    ON a.city_id = ct.city_id
    WHERE a.district = 'California') addr
ON c.address_id = addr.address_id;

-- USING THE SAME TABLE TWICE
-- FIND ALL OF THE FILMS IN WHICH TWO SPECIFIC ACTORS APPEAR
SELECT f.title
FROM film f 
JOIN film_actor fa USING (film_id)
JOIN actor a ON fa.actor_id = a.actor_id
WHERE ((a.first_name = 'CATE' AND a.last_name = 'MCQUEEN')
    OR (a.first_name = 'CUBA' AND a.last_name = 'BIRCH'));

SELECT f.title 
FROM film f 
    JOIN film_actor fa1 
    ON f.film_id = fa1.film_id
    JOIN actor a1 
    ON fa1.actor_id = a1.actor_id
    JOIN film_actor fa2
    ON f.film_id = fa2.film_id
    JOIN actor a2 
    ON fa2.actor_id = a2.actor_id
WHERE (a1.first_name = 'CATE' AND a1.last_name = 'MCQUEEN')
    AND (a2.first_name = 'CUBA' AND a2.last_name = 'BIRCH');

-- WHO IS IN BLOOD ARGONAUTS?? USING A PIVOT TABLE
SELECT a.first_name, a.last_name FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id 
JOIN film f ON fa.film_id = f.film_id 
WHERE f.title = 'BLOOD ARGONAUTS';


-- GARY PHOENIX, MINNIE ZELLWEGER, SUSAN DAVIS
-- EMPTY SET

-- CHALLENGE #1
-- FILL IN THE BLANKS; SHOULD RETURN 9 ROWS
-- WHAT IS THE NAME IN THE SECOND ENTRY?

SELECT c.first_name, c.last_name, a.address, ct.city
FROM customer c 
    JOIN address a
    ON c.address_id = a.address_id
    JOIN city ct 
    ON a.city_id = ct.city_id
WHERE a.district = 'California'
ORDER BY c.last_name, c.first_name;

-- CHALLENGE #2 
-- WRITE A QUERY THAT RETURNS THE TITLE OF EVERY FILM IN WHICH AN ACTOR WITH THE FIRST NAME 'JOHN' APPEARED
SELECT f.title
FROM film f 
JOIN film_actor fa USING (film_id)
JOIN actor a USING (actor_id)
WHERE a.first_name = 'JOHN';



--CHALLENGE #3
-- CONSTRUCT A QUERY THAT RETURNS ALL ADDRESSES THAT ARE IN THE SAME CITY. YOU WILL NEED TO JOIN THE ADDRESS TABLE TO ITSELF, AND EACH ROW SHOULD INCLUDE TWO DIFFERENT ADDRESSES

SELECT a1.address addr1, a2.address addr2, a1.city_id
FROM address a1 
JOIN address a2  
WHERE a1.city_id = a2.city_id 
AND a1.address_id <> a2.address_id;

SELECT a1.address, a2.address 
FROM address a1 
JOIN city c 
ON c.city_id = a1.city_id
JOIN address a2
ON a2.city_id = c.city_id
WHERE a2.city_id = a1.city_id AND a1.address <> a2.address;

-- ----------- SET OPERATORS ------------------------------------------

-- SET OPERATORS UNION, INTERSECT, EXCEPT
-- GET ALL FIRST AND LAST NAMES
SELECT 'CUST' typ, c.first_name, c.last_name
FROM customer c 
UNION ALL
SELECT 'ACTR' typ, a.first_name, a.last_name
FROM actor a;

-- UNION ALL DOES NOT REMOVE DUPLICATES
--GET EACH NAME WHERE FIRST NAME BEGINS WITH 'J' AND LAST NAME BEGINS WITH 'D' 
SELECT c.first_name, c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
UNION ALL 
SELECT a.first_name, a.last_name
FROM actor a 
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';

-- EXCLUDE DUPLICATES USE UNION INSTEAD OF UNION ALL

SELECT c.first_name, c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
UNION 
SELECT a.first_name, a.last_name
FROM actor a 
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';

-- INTERSECT
SELECT c.first_name, c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
INTERSECT
SELECT a.first_name, a.last_name
FROM actor a 
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';

-- EXCEPT
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
EXCEPT
SELECT c.first_name, c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';


-- SORTING COMPOUND QUERY RESULTS
-- USE ORDER BY AND BEST TO GIVE ALIAS IN FIRST QUERY

SELECT 'CUST' typ, c.first_name first , c.last_name last
FROM customer c 
UNION ALL
SELECT 'ACTR' typ, a.first_name , a.last_name 
FROM actor a
ORDER BY last, first;

-- CHALLENGE #1 
-- IF SET A = {L,M,N,O,P} AND SET B = {P, Q, R, S, T}, WHAT SETS ARE GENERATED BY THE FOLLOWING OPERATIONS
    -- A UNION B => { L M N O P Q R S T }
    -- A UNION ALL B => { L M N O P P Q R S T }
    -- A INTERSECT B => { P }
    -- A EXCEPT B => { L M N O }

-- CHALLENGE #2
-- WRITE A COMPOUND QUERY THAT FINDS THE FIRST AND LAST NAMES OF ALL ACTORS AND CUSTOMERS WHOSE LAST NAME STARTS WITH L.

SELECT 'CUST' typ, c.first_name, c.last_name
FROM customer c
WHERE c.last_name LIKE 'L%'
UNION 
SELECT 'ACTR' typ, a.first_name, a.last_name
FROM actor a 
WHERE a.last_name LIKE 'L%';

-- CHALLENGE #3
-- SORT THE RESULTS FROM CHALLENGE 2 BY THE last_name COLUMN

SELECT 'CUST' typ, c.first_name first, c.last_name last
FROM customer c
WHERE c.last_name LIKE 'L%'
UNION 
SELECT 'ACTR' typ, a.first_name, a.last_name
FROM actor a 
WHERE a.last_name LIKE 'L%'
ORDER BY last, first;