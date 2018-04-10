use sakila;

-- 1a --
select first_name,last_name
from actor

-- 1b --
select concat(first_name,' ',last_name) as ACTOR_NAME
from actor

-- 2a --
select actor_id,first_name,last_name
from actor
where first_name = 'joe'

-- 2b --
select *
from actor
where last_name like '%gen%'

-- 2c --
SELECT *
from actor
where last_name like '%LI%'
ORDER BY last_name, first_name

-- 2d --
select country, country_id
from country
where country in ('Afghanistan', 'Bangladesh', 'China')

-- 3a --
ALTER TABLE actor
ADD middle_name varchar(30) after first_name;

-- 3b --
ALTER TABLE actor
CHANGE COLUMN middle_name middle_name BLOB;

-- 3c --
ALTER TABLE ACTOR
DROP COLUMN middle_name;

-- 4a --
select last_name, count(*) as c
FROM actor
GROUP BY last_name

-- 4b --
select last_name, count(*) as c
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1

-- 4c --
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

-- 4d --
UPDATE actor
SET first_name = 'GROUCHO'
WHERE actor_id = 172;

-- 5a --
SHOW CREATE TABLE address

-- 6a --
SELECT staff.first_name, staff.last_name, staff.address_id,address.address_id,address.address
FROM staff
INNER JOIN address ON
staff.address_id = address.address_id;

-- 6b --
CREATE TABLE test_table(
SELECT staff.first_name, staff.last_name, staff.staff_id,payment.payment_date,sum(payment.amount)
FROM staff
INNER JOIN payment ON
staff.staff_id = payment.staff_id
Where payment_date between "2005-08-01" and "2005-09-01"
GROUP BY staff.first_name, staff.last_name, staff.staff_id,payment.staff_id,payment.payment_date);

select first_name,last_name,staff_id, sum(amount) as total_amount
from test_table
group by test_table.first_name, test_table.last_name, test_table.staff_id;

-- 6c --
select film.title, count(actor.actor_id)
from film 
inner join film_actor 
on (film.film_id = actor.film_id)
group by film.title;

-- 6d --
select count(inventory.film_id)
from inventory 
join film 
on (film.film_id = inventory.film_id)
where film.title = 'Hunchback Impossible';

-- 6e --
select customer.first_name, customer.last_name, sum(payment.amount)
from payment 
join customer 
on (customer.customer_id = customer.customer_id)
group by customer.last_name, first_name; 
-- below works for others but not for me as solution--

-- select sum(p.amount), c.first_name, c.last_name
-- from payment p
-- join customer c
-- on (c.customer_id = p.customer_id)
-- group by c.last_name; 

-- 7a --
select film.title
from film 
join language 
on (language.language_id = film.language_id)
where film.title LIKE 'K%' OR film.title like'Q%'
and language.name = 'English';

-- 7b --
select first_name, last_name
from actor
where actor_id in (
	select actor_id
    from film_actor
    where film_id in(
		select film_id
		from film
		where title = 'Alone Trip')
);

-- 7c--
select customer.first_name, customer.last_name, customer.email
from customer
	join address 
		on (customer.address_id = address.address_id)
	join city 
		on (address.city_id = city.city_id)
	join country
		on (city.country_id = country.country_id)
	where country.country = 'Canada';
    
-- 7d--
select title
from film
where film_id in (
	select film_id
    from film_category
    where category_id in(
		select category_id
        from category
        where name = 'family')
        );
    
-- 7e --
 select film.title, count(rental.inventory_id)
 from film 
	join inventory
		on (film.film_id = inventory.film_id)
	join rental 
		on (inventory.inventory_id = rental.inventory_id)
group by film.title
ORDER BY count(rental.inventory_id) DESC;

-- 7f--
select store.store_id, sum(payment.amount)
from payment 
	join staff 
		on (payment.staff_id = staff.staff_id)
	join store
		on (store.store_id = staff.store_id)
	group by store.store_id;

-- 7g--
select store.store_id, city.city, country.country
from store 
	join address address
		on (store.address_id = address.address_id)
	join city 
		on (city.city_id = address.city_id)
	join country
		on (city.country_id = country.country_id)
group by store.store_id

-- 7h--
select category.name, sum(payment.amount)
from payment 
	join rental 
		on (payment.rental_id = rental.rental_id)
	join inventory 
		on (inventory.inventory_id = rental.inventory_id)
	join film 
		on (film.film_id = inventory.film_id)
	join film_category 
		on (film_category.film_id = film.film_id)
	join category 
		on (category.category_id = film_category.category_id)
	group by category.name
	ORDER BY sum(payment.amount) DESC
    LIMIT 5;
    
-- 8a -- 
CREATE VIEW top5_genre as
select category.name, sum(payment.amount)
from payment 
	join rental 
		on (payment.rental_id = rental.rental_id)
	join inventory 
		on (inventory.inventory_id = rental.inventory_id)
	join film 
		on (film.film_id = inventory.film_id)
	join film_category 
		on (film_category.film_id = film.film_id)
	join category 
		on (category.category_id = film_category.category_id)
	group by category.name
	ORDER BY sum(payment.amount) DESC
    LIMIT 5;
-- 8b --
select * from top5_genre;

-- 8c --
drop view if exists top5_genre;




