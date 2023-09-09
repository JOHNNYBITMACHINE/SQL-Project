-- phase 2
use music;
-- 1. Write query to return the email, first name, last name,
 -- & Genre of all Rock Music listeners. 
 -- Return your list ordered alphabetically by email starting with A 
 
SELECT * FROM CUSTOMER;
SELECT * FROM INVOICE;
select * from invoice_line;
select * from track;
select * from genre;



with cty as 
			(with ctf as
						(with final as
									(with ctx as
												(with ct as															

																	(select inn.invoice_id , cu.first_name, cu.last_name, cu.email from invoice inn left join customer cu on inn.customer_id = cu.customer_id)
                                            
													select invl.track_id , res.first_name, res.last_name, res.email from invoice_line invl left join ct res on invl.invoice_id = res.invoice_id )
																				
										select rcx.first_name, rcx.last_name, rcx.email, b.genre_id, b.name as track_name  from ctx rcx  inner join 	track b on rcx.track_id = b.track_id)
                                                                                
                                                                                
							select a.first_name, a.last_name, a.email,a.track_name,  b.name from final a left join genre b on a.genre_id = b.genre_id where lower(b.name) = 'rock') 
                                            
                                            
				select concat(first_name , "  ", last_name) as Rock_music_listener, email from ctf where lower(email) like 'a%')
	
select distinct Rock_music_listener , email from cty;



 

