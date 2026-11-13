-- Case Statements (CASE WHEN ... THEN ... END)
select *
from employee_demographics
;

select first_name,
last_name,
age,
case
	when age <= 30 then 'young'				# utk age <= 30, maka 'young'
    when age between 31 and 50 then 'old'	# utk age di antara 31-50, maka 'old'
	when age > 50 then "on death's door"	# utk age >= 50, maka "on death's door"
end as 'status'
from employee_demographics
;


-- Pay Increase and Bonus
-- < 50000 = 5% bonus
-- > 50000 = 7% bonus
-- Finance = 10% bonus
select *
from employee_salary
;

select first_name, 
last_name,
salary,
case
	when salary < 50000 then salary + (salary*0.05)
    when salary >= 50000 then salary + (salary*0.07)
end as 'New salary (salary + bonus)',
case
	when dept_id = 6  then salary + (salary*0.10)
end as bonus
from employee_salary
;


select *
from employee_salary
;
select *
from parks_departments
;

