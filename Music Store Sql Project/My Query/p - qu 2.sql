use music;

-- 2. Which countries have the most Invoices?

select count(*) from invoice;



with ct as
			(select distinct billing_country, count(*) as invoice_country from invoice group by billing_country)

select billing_country from ct where invoice_country = (select max(invoice_country) from ct);