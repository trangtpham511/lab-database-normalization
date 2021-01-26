
/*Get all pairs of actors that worked together.
Get all pairs of customers that have rented the same film more than 3 times.
Get all possible pairs of actors and films.*//

-- 1
SELECT 
    fa1.film_id,
    fa1.actor_id AS actor_id1,
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor_name1,
    fa2.actor_id AS actor_id2,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor_name2
FROM
    actor AS a1
        JOIN
    film_actor AS fa1 ON a1.actor_id = fa1.actor_id
        JOIN
    film_actor AS fa2 ON fa1.actor_id <> fa2.actor_id
        AND fa1.actor_id < fa2.actor_id
        AND fa1.film_id = fa2.film_id
        JOIN
    actor AS a2 ON a2.actor_id = fa2.actor_id
ORDER BY film_id , actor_id1 , actor_id2;
-- 2
select count(f1.title) as n_movies, 
	c1.customer_id as customer_1, CONCAT(c1.first_name, ' ', c1.last_name) AS customer1 , 
	c2.customer_id as customer_2, CONCAT(c2.first_name, ' ', c2.last_name) as customer2
from sakila.customer as c1
	join sakila.rental as r1 on c1.customer_id = r1.customer_id
	join sakila.inventory as i1 on r1.inventory_id=i1.inventory_id
	join sakila.film as f1 on i1.film_id=f1.film_id
    #going the path backwards to find customer with the same rented movies 
    join sakila.inventory as i2 on i2.film_id=f1.film_id
    join sakila.rental as r2 on i2.inventory_id =r2.inventory_id
    join sakila.customer as c2 on r2.customer_id=c2.customer_id
where c1.customer_id>c2.customer_id
group by c1.customer_id, c1.first_name, c1.last_name, c2.customer_id, c2.first_name, c2.last_name
Having n_movies>3
order by n_movies desc;
-- 3 Get all possible pairs of actors and films.
select f1.title, CONCAT(a1.first_name, ' ', a1.last_name) AS actor1 , CONCAT(a2.first_name, ' ', a2.last_name) as actor2
from film_actor fa1 join film f1 on fa1.film_id = f1.film_id 
join actor a1 on fa1.actor_id = a1.actor_id
join film_actor fa2 on fa1.actor_id > fa2.actor_id
and fa1.film_id = fa2.film_id
join film f2 on fa2.film_id = f2.film_id
join actor a2 on fa2.actor_id = a2.actor_id;

