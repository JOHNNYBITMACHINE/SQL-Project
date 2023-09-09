

-- 1. Who is the senior most employee based on job title?
use music;

select * from employee;

select concat(first_name, "  ", last_name) as employee_name , levels from employee order by levels desc limit 1;


select concat(first_name, "  ", last_name) as employee_name , country, title, levels from employee;