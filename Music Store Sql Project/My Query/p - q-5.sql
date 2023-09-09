use music;

-- 5. Who is the best customer? The customer who has spent the most money will be declared the best customer.
 -- Write a query that returns the person who has spent the most money 
 
 select * from customer;
 

with cty as
					(with ctex as
										( with ct as

												
													(select a.customer_id,a.first_name, a.last_name, b.total, a.city from customer a right join invoice b on a.customer_id = b.customer_id)


										select first_name, last_name , sum(total) as total from ct group by 1,2 )


				select first_name, last_name, total, dense_rank() over (order by total desc) as rnk from ctex)
 
 
 select concat(first_name, "    " ,last_name) as Best_customer from cty where rnk = 1;
 
 