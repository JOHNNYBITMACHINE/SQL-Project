use music;
select * from invoice;

-- 3. What are top 3 values of total invoice? 

select * from invoice;

with ct as 
			(select total, dense_rank() over( order by total desc) as rnk from invoice)
					
						select distinct  total as top_3_values from ct where rnk <4;




with ctex as 
		
        ( with ct as 
        
					(select customer_id, count(*) as total_invoice  from invoice group by customer_id)

				select customer_id, total_invoice , dense_rank() over ( order by total_invoice desc ) as rnk  from ct)

select total_invoice from ctex where rnk in (1,2,3);

