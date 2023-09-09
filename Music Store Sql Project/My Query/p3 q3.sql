-- 3. Write a query that determines the customer that has spent the most on music for each country.
--  Write a query that returns the country along with the top customer and how much they spent.
--  For countries where the top amount spent is shared, provide all customers who spent this amount


select * from customer;
select * from invoice;
select * from invoice_line;

select a.billing_country, a.customer, round(a.amount_spent,2) as Total_spent 
		
        from 
		(with ct as 
				(select a.customer, a.billing_country, sum(a.unit_price* a.quantity) as amount_spent 
								from 
											
								(with ct as 
													(select concat(a.first_name, "  ", last_name) as customer , b.billing_country , b.invoice_id from customer a right join invoice b on a.customer_id = b.customer_id)
                                        
									select a.customer , a.billing_country, b.unit_price, b.quantity from ct a right join invoice_line b on a.invoice_id = b.invoice_id)  a
                                    
									group by 1,2)
				select customer, billing_country, amount_spent , dense_rank() over (partition by billing_country order by amount_spent desc) as rnk from ct) 		a
			where rnk = 1;
;
