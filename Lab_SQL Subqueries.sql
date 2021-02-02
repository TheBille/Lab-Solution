-- Lab | SQL Subqueries
-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
select title, count(inventory_id)
from film as a
join inventory as b
on a.film_id = b.film_id
where a.title = 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average of all the films.
select title, length
from film 
where length > (select avg(length) from film)
order by length;

-- 3. Use subqueries to display all actors who appear in the film Alone Trip. (This could also be done with joins)
select *
from actor
where actor_id in (
	(select actor_id 
	from film_actor 
	where film_id = 
		(select film_id 
        from film  where title = "Alone Trip")));

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies 
-- categorized as family films.

select film_id, title
from film
where film_id in (select film_id from film_category	
where category_id in ((select category_id from category where name = "Family")))
order by film_id;

-- 5.  Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will
-- have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

select first_name, last_name, email
from customer 
where address_id in 
	((select address_id from address
		where city_id in 
			((select city_id from city 
				where country_id = 
					(select country_id from country 
						where country = "Canada")))));
                        
-- with joins:
select first_name, last_name, email
from customer as a
join address as b
on a.address_id = b.address_id
join city as c
on c.city_id = b.city_id
join country as d
on d.country_id = c.country_id
where country = 'Canada';

-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined 
-- as the actor that has acted in the most number of films. First you will have to find 
-- the most prolific actor and then use that actor_id to find the different films that 
-- he/she starred.
-- select film_id, actor_id
-- from film_actor
-- order by count(film_id) actor_id;

select a.film_id, title, c.first_name, c.last_name -- c.actor_id, c.first_name, c.last_name, count(a.film_id) # actor-id 107 has starred in 42 movies
from film as a
join film_actor as b
on a.film_id = b.film_id
join actor as c
on b.actor_id = c.actor_id
where c.actor_id = 107;
-- group by c.actor_id
-- order by count(a.film_id) desc

-- 7. Films rented by most profitable customer. You can use the customer table and payment
--  table to find the most profitable customer ie the customer that has made the largest 
-- sum of payments
-- step 1
select a.customer_id, a.first_name, a.last_name, sum(b.amount)
from customer as a
join payment as b
on a.customer_id = b.customer_id
group by customer_id
order by sum(b.amount) desc
limit 1;

-- step 2 
select a.film_id, a.title 
from film as a 
join inventory as b
on a.film_id = b.film_id
join rental as c
on b.inventory_id = c.inventory_id
	where c.customer_id = (select a.customer_id
							from customer as a
						join payment as b
						on a.customer_id = b.customer_id
						group by customer_id
						order by sum(b.amount) desc
						limit 1);

-- 8. Customers who spent more than the average payments.
-- average payments and dividing all amounts by the total customers which rented a movie
select sum(amount)/count(distinct(customer_id)) as avg_payments 
from payment;

select a.customer_id, b.first_name, b.last_name, sum(amount) as amount_paid
from payment as a
join customer as b
on a.customer_id = b.customer_id
group by a.customer_id
having amount_paid > (select sum(amount)/count(distinct(customer_id)) from payment)
order by sum(amount);