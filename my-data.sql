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