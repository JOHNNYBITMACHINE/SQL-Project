-- 2. We want to find out the most popular music Genre for each country. 
-- We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre.
-- For countries where the maximum number of purchases is shared return all Genres

select * from invoice;

USE MUSIC;


select a.billing_country, a.genre_name   from
					(with cty as 
								(with final as 
											(with ctx as
														(with ct as 
                                                
																	(select a.billing_country,  b.unit_price, b.quantity, b.track_id from invoice a right join invoice_line b on a.invoice_id = b.invoice_id)
                                            
															select a.billing_country, a.unit_price, a.quantity , b.genre_id from ct a left join track b on a.track_id = b.track_id)
                                        
												select a.billing_country, a.unit_price, a.quantity, b.name from ctx a left join genre b on a.genre_id = b.genre_id)
                                
									select billing_country , name as genre_name, sum(unit_price* quantity) as amount_purchases from final group by 1,2)

						select billing_country, genre_name, amount_purchases , first_value(amount_purchases) over (partition by billing_country order by amount_purchases desc ) as firstt from cty ) a 
where a.amount_purchases = firstt ;











select * from genre;

select * from track;