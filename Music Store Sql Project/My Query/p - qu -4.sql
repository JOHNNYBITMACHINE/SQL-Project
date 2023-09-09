-- 4. Which city has the best customers?
-- We would like to throw a promotional Music Festival in the city we made the most money.
-- Write a query that returns one city that has the highest sum of invoice totals.
--  Return both the city name & sum of all invoice totals 

select * from invoice;


 with ctex as 

		(with ct as

				(select billing_city, sum(total) as bill_invoice from invoice group by billing_city)

		select billing_city, bill_invoice , dense_rank() over (order by bill_invoice desc) as rnk from ct )
 
 select billing_city as city, round(bill_invoice,2) as Total_invoice from ctex where rnk =1;
