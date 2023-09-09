use hicounselor_pro2;




-- Find the average age of employees in each department and gender group. ( Round average  age up to two decimal places if needed)



select employee.department, employee.gender , round(AVG(employee.age),2) as avgerage_age from employee group by employee.department, employee.gender ;


-- List the top 3 departments with the highest average training scores. ( Round average scores up to two decimal places if needed)



SELECT department, ROUND(AVG(avg_training_score), 2) AS average_training_score
FROM employee
GROUP BY department
ORDER by average_training_score desc
LIMIT 3;


-- Find the percentage of employees who have won awards in each region. 


select region, round(count(*) *100 / (select sum(awards_won) from employee),2) as awards_won 
from employee where awards_won != 0 group by region;




-- Show the number of employees who have met more than 80% of KPIs for each recruitment channel and education level.

select education, recruitment_channel, count(employee_id) from employee
where kpis_met_more_than_80 !=0 group by education, recruitment_channel ;



-- Find the average length of service for employees in each department, considering only employees with previous year ratings greater than or equal to 4.

select department, round(avg(length_of_service),2) from employee where previous_year_rating  >=4 group by department;


-- List the top 5 regions with the highest average previous year ratings.

select region, round(avg(previous_year_rating),2) as average_previous_year_rating from employee group by region order by average_previous_year_rating desc limit 5;


-- List the departments with more than 100 employees having a length of service greater than 5 years.

select department, count(employee_id) as employee_count from employee where length_of_service >5 group by department having employee_count >100;


-- Show the average length of service for employees who have attended more than 3 trainings, grouped by department and gender.


select department , gender, round(avg(length_of_service),2) from employee where no_of_trainings >3 group by department, gender;

-- Find the percentage of female employees who have won awards, per department. Also show the number of female employees who won awards and total female employees.


 SELECT department, 
       ROUND(COUNT(CASE WHEN gender = 'f' and awards_won = 1 then employee_id end)/
       COUNT(CASE WHEN gender = 'f' then employee_id end) * 100, 2) AS female_award_winners_percentage,
       COUNT(CASE WHEN gender = 'f' and awards_won = 1 then employee_id end) AS females_won_award,
       COUNT(CASE WHEN gender = 'f' then employee_id end) AS total_females
FROM employee
GROUP BY department;



-- Calculate the percentage of employees per department who have a length of service between 5 and 10 years.

select department, 

round((count(case when length_of_service between 5 and 10 then 1 end)/ count(*)*100),2) as percentage
from employee group by department;



-- Find the top 3 regions with the highest number of employees who have met more than 80% of their KPIs and received at least one award, grouped by department and region.

select department , region , count(employee_id) as total_employees from employee where awards_won >= 1 
and kpis_met_more_than_80 >=1 
group by region , department order by total_employees desc limit 3;


-- Calculate the average length of service for employees per education level and gender, considering only those employees who have completed more than 2 trainings and have an average training score greater than 75 

select education, gender , round(avg(length_of_service),2) from employee where no_of_trainings >2 and avg_training_score>75
group by 1,2;




-- For each department and recruitment channel, find the total number of employees who have met more than 80% of their KPIs, have a previous_year_rating of 5, and have a length of service greater than 10 years.

select department , recruitment_channel, count(employee_id) as total_employee

from employee where previous_year_rating = 5 and length_of_service >10 and 
kpis_met_more_than_80 >= 1 group by 1,2;






-- Calculate the percentage of employees in each department who have received awards, have a previous_year_rating of 4 or 5, and an average training score above 70, grouped by department and gender

select department, gender, 
round((count(case when previous_year_rating in (4,5) and avg_training_score >70
and awards_won = 1 then 1 end 


) / count(*)*100),2) as award_percentage from employee

group by department, gender;








-- List the top 5 recruitment channels with the highest average length of service for employees who have met more than 80% of their KPIs, have a previous_year_rating of 5, and an age between 25 and 45 years, grouped by department and recruitment channel. 

select recruitment_channel, department, round(avg(length_of_service),2) as average_service_length

from employee

where previous_year_rating = 5 and
kpis_met_more_than_80 = 1 and 
age between 25 and 45
group by 1,2
order by average_service_length desc

limit 5;










