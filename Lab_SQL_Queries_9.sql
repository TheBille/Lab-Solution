-- 1
CREATE TABLE rentals_may (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `rental_date` datetime NOT NULL,
  `inventory_id` mediumint unsigned NOT NULL,
  `customer_id` smallint unsigned NOT NULL,
  `return_date` datetime DEFAULT NULL,
  `staff_id` tinyint unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rental_id`));
-- 2
insert into rentals_may
select *
from rental
where substr(rental_date,6,2) = 05;
-- 3
CREATE TABLE rentals_june (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `rental_date` datetime NOT NULL,
  `inventory_id` mediumint unsigned NOT NULL,
  `customer_id` smallint unsigned NOT NULL,
  `return_date` datetime DEFAULT NULL,
  `staff_id` tinyint unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rental_id`));
 -- 4 
insert into rentals_june
select *
from rental
where substr(rental_date,6,2) = 06;
-- 5
select a.customer_id, first_name, last_name, count(rental_id) as number_of_rentals_may
from rentals_may as a
inner join customer as b
on a.customer_id = b.customer_id
group by a.customer_id
order by count(rental_id) desc;
-- 6 
select a.customer_id, first_name, last_name, count(rental_id) as number_of_rentals_may
from rentals_june as a
inner join customer as b
on a.customer_id = b.customer_id
group by a.customer_id
order by count(rental_id) desc;