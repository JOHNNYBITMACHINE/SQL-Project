USE MUSIC;
-- PHASE 1

select * from employee;

-- 1. Who is the senior most employee based on job title?


select concat(first_name, "  ", last_name) as employee_name , levels,title from employee order by levels desc limit 1;






-- 2. Which countries have the most Invoices?



with ct as
			(select distinct billing_country, count(*) as invoice_country from invoice group by billing_country)

select billing_country from ct where invoice_country = (select max(invoice_country) from ct);





-- 3. What are top 3 values of total invoice? 

select * from invoice;

with ct as 
			(select total, dense_rank() over( order by total desc) as rnk from invoice)
select distinct total as top_3_values from ct where rnk <4;




-- 4. Which city has the best customers?
-- We would like to throw a promotional Music Festival in the city we made the most money.
-- Write a query that returns one city that has the highest sum of invoice totals.
--  Return both the city name & sum of all invoice totals 

select * from invoice;




 with ctex as (with ct as (select billing_city, sum(total) as bill_invoice from invoice group by billing_city)
 select billing_city, bill_invoice , dense_rank() over (order by bill_invoice desc) as rnk from ct )
 select billing_city as city, round(bill_invoice,2) as Total_invoice from ctex where rnk =1;
 
 
 
 
 
 -- 5. Who is the best customer? The customer who has spent the most money will be declared the best customer.
 -- Write a query that returns the person who has spent the most money 
 
 select * from customer;
 
 
 

with cty as
					(with ctex as
										( with ct as

												(select a.customer_id,a.first_name, a.last_name, b.total from customer a right join invoice b on a.customer_id = b.customer_id)


										select first_name, last_name , sum(total) as total from ct group by 1,2 )


				select first_name, last_name, total, dense_rank() over (order by total desc) as rnk from ctex)
 
 
 select concat(first_name, "    " ,last_name) as Best_customer from cty where rnk = 1;
 
 
 
 
 -- PHASE 2
 
 
 
 -- 1.     Write query to return the email, first name, last name,
 -- & Genre of all Rock Music listeners. 
 -- Return your list ordered alphabetically by email starting with A 
 
SELECT * FROM CUSTOMER;
SELECT * FROM INVOICE;
select * from invoice_line;
select * from track;
select * from genre;



with ctf as 
				(select a.first_name,a.last_name,a.email,  count(a.track_name)  as listen_music from 

								(with final as
											(with ctx as
													(with ct as
                                                
																	(select inn.invoice_id , cu.first_name, cu.last_name, cu.email from invoice inn left join customer cu on inn.customer_id = cu.customer_id)
                                            
													select invl.track_id , res.first_name, res.last_name, res.email from invoice_line invl left join ct res on invl.invoice_id = res.invoice_id )

																				
										select rcx.first_name, rcx.last_name, rcx.email, b.genre_id, b.name as track_name  from ctx rcx  inner join 	track b on rcx.track_id = b.track_id)
                                                                                
                                                                                
								select a.first_name, a.last_name, a.email,a.track_name,  b.name from final a left join genre b on a.genre_id = b.genre_id where lower(b.name) = 'rock') a 
																																													group by 1,2 ,3 order by count(a.track_name) desc)
select concat(first_name , "  ", last_name) as Rock_music_listener, email, listen_music from ctf where lower(email) like 'a%';








 
--  2. Let's invite the artists who have written the most rock music in our dataset.
--  Write a query that returns the Artist name and total track count of the top 10 rock bands 



select * from artist; 
select * from album;
select * from track;







with ct as 
				(select artist , rock_music, dense_rank() over (order by rock_music desc )  as rnk        from   
                
								(with cty as
										(with ctx as
												(with ct as 
														(select  a.artist_id, a.name as artist , b.album_id  from album b left join artist a on a.artist_id = b.artist_id)

												select a.artist_id, a.artist,b.track_id, b.name as track_name , b.genre_id from track b left join ct a on a.album_id = b.album_id)
                                                
										select a.artist, a.track_id , a.track_name, b.name as song_name , b.genre_id  from ctx a left join genre b on a.genre_id = b.genre_id where b.genre_id=1)
                                        
								select artist, count(track_name) as rock_music from  cty group by artist) a  )

select artist, rock_music from ct where rnk <11;
 ;







-- 3. Return all the track names that have a song length longer than the average song length.
 -- Return the Name and Milliseconds for each track. 
 -- Order by the song length with the longest songs listed first


select * from track;

with ct as 
	(select name, milliseconds, avg(milliseconds) over () as avg_length from track)
				select name as Song_name, milliseconds as Track_length from ct where milliseconds>avg_length order by milliseconds desc
;


-- PHASE - 3


-- 1. Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent 





select * from invoice_line ;
select * from track;
select * from artist;



select a.customer_name, a.artist_name,sum(a.unit_price * a.quantity) as total_spent_amount from


	(with ctt as 
				(with final as 
							(with cty as
										(with cttra as 
													(with ct as
																(select concat(cus.first_name,"  " , cus.last_name) as customer_name, inv.invoice_id from customer cus right join invoice inv on cus.customer_id =inv.customer_id)

													select a.customer_name, b.track_id, b.unit_price as inv_unit, b.quantity from ct a right join invoice_line b on a.invoice_id = b.invoice_id)
                                                    
										select a.customer_name, a.inv_unit, a.quantity, b.album_id, b.name as song_name , b.unit_price  from cttra a  join track b on a.track_id = b.track_id)

							select a.customer_name, a.inv_unit, a.quantity, a.song_name,  b.artist_id , a.unit_price from cty a left join album b on a.album_id = b.album_id)
                            
				select a.customer_name, b.name as artist_name,a.song_name, a.inv_unit, a.quantity, a.unit_price  from final a left join artist b on a.artist_id = b.artist_id)
                
	select distinct song_name, customer_name, artist_name, inv_unit, quantity , unit_price from ctt) 

a 
group by 1,2  order by a.customer_name asc;




-- 2. We want to find out the most popular music Genre for each country. 
-- We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre.
-- For countries where the maximum number of purchases is shared return all Genres



select * from invoice;


select a.billing_country, a.genre_name  from 

						(with cty as 
									(with final as
													(with ctx as 
															(with ct as 
																		(select a.billing_country,  b.unit_price, b.quantity, b.track_id from invoice a right join invoice_line b on a.invoice_id = b.invoice_id)
													
															select a.billing_country, a.unit_price, a.quantity , b.genre_id from ct a left join track b on a.track_id = b.track_id)
                                                    
													select a.billing_country, a.unit_price, a.quantity, b.name from ctx a left join genre b on a.genre_id = b.genre_id)
														
									select billing_country , name as genre_name, sum(unit_price* quantity) as amount_purchases from final group by 1,2)

						select billing_country, genre_name, amount_purchases , first_value(amount_purchases) over (partition by billing_country order by amount_purchases desc ) as firstt from cty) 
a

where a.amount_purchases = firstt

;



-- 3. Write a query that determines the customer that has spent the most on music for each country.
--  Write a query that returns the country along with the top customer and how much they spent.
--  For countries where the top amount spent is shared, provide all customers who spent this amount




select * from customer;
select * from invoice;
select * from invoice_line;

select a.billing_country, a.customer, round(a.amount_spent,2) as Total_spent from
			(with ct as 
							(select a.customer, a.billing_country, sum(a.unit_price* a.quantity) as amount_spent from 
                            
										(with ct as
                                        
												(select concat(a.first_name, "  ", last_name) as customer , b.billing_country , b.invoice_id from customer a right join invoice b on a.customer_id = b.customer_id)
                                                
										select a.customer , a.billing_country, b.unit_price, b.quantity from ct a right join invoice_line b on a.invoice_id = b.invoice_id)
							a     group by 1,2)
                            
			select customer, billing_country, amount_spent , dense_rank() over (partition by billing_country order by amount_spent desc) as rnk from ct)
a
where rnk = 1;
;






 
 