

-- Project Phase III
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


a group by 1,2  order by a.customer_name desc;






