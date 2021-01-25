-- Lab SQL Joins on mulitple tables 25.01.2021
-- 1: Write a query to display for each store its store ID, city, and country.
-- 1
select a.store_id, city, country
from store as a
join address as b
on a.address_id = b.address_id
join city as c
on b.city_id = c.city_id
join country as d
on c.country_id = d.country_id;

-- 2: Write a query to display how much business, in dollars, each store brought in.
-- I need store and payment

select store.store_id, sum(payment.amount)
from staff join payment
on staff.staff_id = payment.staff_id
join store
on store.store_id = staff.store_id
group by store.store_id;

-- 3 & 4 What is the average running time of films by category? Which film categories are longest?

select name, avg(length)
from film as f
join film_category as fc
on  f.film_id = fc.film_id
join category as c 
on fc.category_id = c.category_id
group by name
-- select name, avg(length)
from film as f
join film_category as fc
on  f.film_id = fc.film_id
join category as c 
on fc.category_id = c.category_id
group by name
having avg(length) > (select avg(length) from film)
order by avg(length) desc;

select category.name, round(avg(film.length), 2) as avg_length
from category join film_category
on category.category_id = film_category.category_id
join film
on film_category.film_id = film.film_id
group by category.category_id
order by avg_length desc;

-- Category Sports has the longest average length

-- 5: Display the most frequently rented movies in descending order.
select title, count(rental_id)
from rental as r
join inventory as i
on r.inventory_id = i.inventory_id
join film as f
on i.film_id = f.film_id
group by f.film_id
order by count(rental_id) desc;

-- 6: List the top five genres in gross revenue in descending order.
select 
c.name as Category, 
SUM(p.amount) as Amount
from category as c
join film_category as fc
on c.category_id = fc.category_id
join inventory as i 
on  fc.film_id = i.film_id
join rental as r 
on i.inventory_id = r.inventory_id
join payment as p 
on r.rental_id = p.rental_id
group by c.name 
limit 5;

-- 7: Is "Academy Dinosaur" available for rent from Store 1?
-- film and store
select s.store_id, f.title
from film as f
join inventory as i
on f.film_id = i.film_id
join store as s
on s.store_id = i.store_id
where title = 'Academy Dinosaur';



