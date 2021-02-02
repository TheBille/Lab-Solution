-- Lab | SQL Self and cross join (Sakila Database)

-- 1. Get all pairs of actors that worked together.
select a.actor_id, b.actor_id, a.film_id, d.title
from film_actor as a
join film_actor as b
on a.actor_id <> b.actor_id 
join actor as c
on b.actor_id = c.actor_id
join film as d
on d.film_id = a.film_id
where d.film_id = 2
group by a.actor_id
order by a.film_id
limit 500;
-- ich brauche den where Filter weil es zuviel results gibt und cih mehr ProzessorPower bräcuhte um es 
select count(*)from film_actor as a
join film_actor as b
on a.actor_id <> b.actor_id;


-- Himanshus Lösung
select * from (
select fa1.film_id , fa1.actor_id as actor1, fa2.actor_id as actor2
from film_actor fa1
join film_actor fa2
on fa1.`actor_id` <> fa2.actor_id and fa1.film_id = fa2.film_id 
where fa1.film_id =1)sub
where actor1 > actor2
order by actor1, actor2;









-- 2. Get all pairs of customers that have rented the same film more than 3 times.

select *
from
(select  in2.film_id, a1.customer_id as First_pair, a2.customer_id as Second_pair , count(*) as number_films, rank() over(partition by a1.customer_id order by a2.customer_id) as Ranks
from sakila.customer a1
inner join rental re1 on re1.customer_id = a1.customer_id
inner join inventory in1 on (re1.inventory_id = in1.inventory_id)
inner join film fa1 on in1.film_id=fa1.film_id
inner join inventory in2 on (fa1.film_id = in2.film_id)
inner join rental re2 on re2.inventory_id=in2.inventory_id
inner join customer a2 on re2.customer_id=a2.customer_id
where a1.customer_id <> a2.customer_id
group by a1.customer_id, a2.customer_id
having count(*)>3
order by number_films desc)tab
where Ranks=1;







-- 3. Get all possible pairs of actors and films.
select 
concat(a.first_name, '', a.last_name) as actor_name, f.title
from actor as a
cross join film as f;



