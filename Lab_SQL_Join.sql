-- Lab SQL Join (Lesson3_01)
-- Question 1: List number of films per category
select c.name, count(a.film_id)
from film as a
join film_category as b
on a.film_id = b.film_id
join category as c
on b.category_id = c.category_id
group by c.name;

-- Question 2: Display the first and last names, as well as the address, of each staff member.
select * 
from staff;
select *
from address;

select s.address_id, s.first_name, 
s.last_name, 
a.address, a.city_id, a.postal_code
from staff as s
inner join address as a
on s.address_id = a.address_id;

-- 3  Display the total amount rung up by each staff member in August of 2005.
select a.staff_id, first_name, last_name, sum(amount) 
from payment as a
join staff as b
on a.staff_id = b.staff_id
where substr(payment_date,6,2) ='08'
group by first_name, last_name, staff_id;

-- 4 List each film and the number of actors who are listed for that film.
select a.film_id, count(*) as NumberOfActors
from film as a 
join film_actor as b
on a.film_id = b.film_id
group by a.film_id, a.title
order by count(*) desc;

-- 5 Using the tables payment and customer and the JOIN command, list
-- the total paid by each customer. List the customers alphabetically by last name.
select a.customer_id, b.first_name, b.last_name, sum(amount)
from payment as a
join customer as b
on a.customer_id = b.customer_id
group by a.customer_id, b.first_name, b.last_name;


