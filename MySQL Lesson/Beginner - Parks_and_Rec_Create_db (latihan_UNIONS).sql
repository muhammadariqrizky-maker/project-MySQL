-- UNIONS (menggabungkan baris data dari dua atau lebih tabel)

select *
from employee_demographics
;
select *
from employee_salary
;

# cara salah ❌❌❌
select age, gender
from employee_demographics
union
select first_name, last_name
from employee_salary
;

# cara yg benar ✅✅✅
select first_name, last_name
from employee_demographics
union
select first_name, last_name
from employee_salary
; # hanya menampilkan first_name & last_name yg ada, TANPA menampilkan yg double

select first_name, last_name
from employee_demographics
union distinct # 'distinct' ini boleh ditulis boleh tidak, sama seperti yg di atas
select first_name, last_name
from employee_salary
;

select first_name, last_name
from employee_demographics
union all 
select first_name, last_name
from employee_salary
; # 'all' ini utk menampilkan semua nama yg ada TANPA terlewatkan

# cara menambahkan label 'old' bagi age > 50
select first_name, last_name, 'Old' as label
from employee_demographics
where age > 50
; 

select first_name, last_name, 'Old' as label
from employee_demographics
where age > 50
union
select first_name, last_name, 'highly paid employee' as label
from employee_salary 
where salary > 70000
; 

select first_name, last_name, 'Old man' as label
from employee_demographics
where age > 40 and gender = 'male'
union
select first_name, last_name, 'Old lady' as label
from employee_demographics
where age > 40 and gender = 'female'
union
select first_name, last_name, 'highly paid employee' as label
from employee_salary 
where salary > 70000
; 

select first_name, last_name, 'Old man' as label
from employee_demographics
where age > 40 and gender = 'male'
union
select first_name, last_name, 'Old lady' as label
from employee_demographics
where age > 40 and gender = 'female'
union
select first_name, last_name, 'highly paid employee' as label
from employee_salary 
where salary > 70000
order by first_name, last_name
; 


