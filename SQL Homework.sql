use sakila;

#1a
select first_name, last_name from actor;

#1b
select concat(upper(first_name), ' ', upper(last_name)) as Actor_Name from actor;

#2a
select actor_id, first_name, last_name from actor where first_name="Joe";

#2b
select * from actor where last_name like '%gen%';

#2c
select * from actor where last_name like '%li%'
order by last_name, first_name;

#2d
select country_id, country from country
where country in ('Afghanistan', 'Bangladesh', 'China');

#3a
ALTER TABLE `sakila`.`actor` 
ADD COLUMN `description` BLOB NULL AFTER `last_update`;

#3b
ALTER TABLE `sakila`.`actor` 
DROP COLUMN `description`;

#4a
select last_name, count(last_name) as Total_Names
from actor group by last_name;

#4b
select last_name, count(last_name) as Total_Names
from actor group by last_name
having Total_Names >=2;

#4c
UPDATE actor
SET first_name = "Harpo"
WHERE first_name = "Groucho" and last_name = "Wiliams";

#4d
UPDATE actor
SET first_name = "Groucho"
WHERE first_name = "Harpo" and last_name = "Wiliams";

#5a
show create table address;

#6a
select staff.first_name, staff.last_name, address.address
from staff join address
on staff.address_id = address.address_id;

#6b
select staff.staff_id, sum(payment.amount) as Total
from staff join payment
on staff.staff_id=payment.staff_id
group by staff_id;

#6c
select film.title, count(film_actor.actor_id) as Total_Cast
from film join film_actor
on film.film_id=film_actor.film_id
group by title;

#6d
select film.title, count(inventory.film_id) as Film_Copies
from film join inventory
on film.film_id=inventory.film_id
where title="Hunchback Impossible";

#6e
select customer.customer_id, customer.first_name, customer.last_name,
sum(payment.amount) as Total_Payment 
from customer join payment
on customer.customer_id=payment.customer_id
group by customer_id order by last_name;

#7a
select title
	FROM film
    WHERE film_id
    IN (
      SELECT film_id
        FROM language
        WHERE name
        IN (
          SELECT name
            FROM language
            WHERE name = "English"
             )
             )
            AND title LIKE 'K%' or 'Q%';
            
#7b
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
  SELECT actor_id
  FROM film_actor
  WHERE film_id IN
  (
   SELECT film_id
   FROM film
   WHERE title = 'Alone Trip'
  )
);

#7c
select customer.first_name, customer.last_name, customer.email, country.country
from customer join address on customer.address_id=address.address_id
join city on address.city_id=city.city_id
join country on city.country_id=country.country_id
where country.country="Canada";

#7d
select film.title, category.name
from film join film_category on film.film_id=film_category.film_id
join category on film_category.category_id=category.category_id
where name='Family';

#7e
select film.title, count(rental.inventory_id) as Total_Rentals
from film join inventory on film.film_id=inventory.film_id
join rental on inventory.inventory_id=rental.inventory_id
group by title order by Total_Rentals desc;

#7f
select store.store_id, sum(payment.amount)
from store join staff on store.store_id=staff.store_id
join payment on staff.staff_id=payment.staff_id
group by store_id;

#7g
select store.store_id, city.city, country.country
from store join address on store.address_id=address.address_id
join city on address.city_id=city.city_id
join country on city.country_id=country.country_id;

#7h
select category.name, sum(payment.amount) as Total
from category join film_category on category.category_id=film_category.category_id
join inventory on film_category.film_id=inventory.film_id
join rental on inventory.inventory_id=rental.inventory_id
join payment on rental.rental_id=payment_id
group by name order by Total desc limit 5;

#8a
create view Top_Five_Genres as
select category.name, sum(payment.amount) as Total
from category join film_category on category.category_id=film_category.category_id
join inventory on film_category.film_id=inventory.film_id
join rental on inventory.inventory_id=rental.inventory_id
join payment on rental.rental_id=payment_id
group by name order by Total desc limit 5;

#8b
select * from Top_Five_Genres;

#8c
drop view Top_Five_Genres;