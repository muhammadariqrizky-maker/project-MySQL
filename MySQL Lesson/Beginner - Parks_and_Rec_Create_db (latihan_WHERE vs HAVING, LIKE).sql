-- HAVING vs WHERE
select *
from employee_demographics;
select *
from employee_salary;

select gender, avg(age)
from employee_demographics
where avg(age) > 40
group by gender
;
# aslinya, yg diinginkan adalah: "tampilkan tabel yg berisi group GENDER yg hanya memiliki nilai rata2 >40."
# Namun nyatanya, tidak bisa ❌
# WHERE mmg harus ditaruh sebelum GROUP BY

select gender, avg(age)
from employee_demographics
group by gender
having avg(age) > 40
;
# "tampilkan tabel yg berisi group GENDER yg hanya memiliki nilai rata2 >40."
# menjadi berhasil ✅
# berhasil selama HAVING ditaruh setelah GROUP BY


select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 60000
;
## WHERE ditaruh sebelum GROUP BY
## HAVING ditaruh setelah GROUP BY
# walaupun fungsi dari keduanya hampir mirip, yaitu 'memilih secara khusus / agregat'