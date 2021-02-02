-- Lab | SQL Advanced queries
-- 1. List each pair of actors that have worked together.
select * from actor;
select * from film_actor;


select distinct a.actor_id, b.actor_id, a.film_id, c.title
from film_actor as a
join film_actor as b
on a.film_id = b.film_id and a.actor_id <> b.actor_id
join film as c
on c.film_id = b.film_id
where a.actor_id > b.actor_id
order by a.actor_id;

-- 2. For each film, list actor that has acted in more films.
-- we need film, film_actor, 

select a.actor_id, b.film_id, title
from film_actor as a
join film as b
on a.film_id = b.film_id
where b.film_id in  
(select film_id 
from film_actor
where actor_id in
(select actor_id from 
(select actor_id, count(*) 
from film_actor
group by actor_id
having count(film_id)>1)sub));
