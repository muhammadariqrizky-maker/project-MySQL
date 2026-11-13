select *
from parks_and_recreation.employee_salary;

select *
from parks_and_recreation.employee_demographics;

select *
from parks_and_recreation.employee_salary
where age >= 40 
;
# ambil semua data yg umurnya >= 40 (lebih besar sama dengan)

select *
from parks_and_recreation.employee_salary
where first_name = 'leslie'
;
# ambil semua data yg first_name nya 'Leslie'

select *
from parks_and_recreation.employee_salary
where salary >= 50000
;
# ambil semua data yg salary nya >= 50000 (lebih besar sama dengan)

select *
from parks_and_recreation.employee_demographics 
where gender != 'female'
;
# tampilkan semua data yg BUKAN female

select *
from parks_and_recreation.employee_demographics 
where birth_date >= '1980-01-01'
;
# tampilkan semua data yg kelatihan lebih dari tahun sekian


-- [AND, OR, NOT] -- Logical Operators
select *
from parks_and_recreation.employee_demographics 
where birth_date >= '1980-01-01'
and not gender = 'male'
;
# sama dengan 👇👇👇

select *
from parks_and_recreation.employee_demographics 
where birth_date >= '1980-01-01'
and gender = 'female'
;
# sama dengan ☝️☝️☝️

select *
from parks_and_recreation.employee_demographics 
where (first_name = 'leslie' and age = 44)
or age > 44
;
# intinya: fungsi () ini adalah mencari hal-hal yg spesifik

-- LIKE STATEMENT
-- [%, _]
# [%] : cari yg mirip2, yg pnting sudah ada sedikit keyword
select *
from parks_and_recreation.employee_demographics 
where first_name like '%a%'
;

# [_] : mencari karakter sebanyak '_' yg aku pasang, tdk kurang tdk lebih
select *
from parks_and_recreation.employee_demographics 
where first_name like 'a__' # cari 2 karakter, karena aku memasang _ sebanyak 2
;
select *
from parks_and_recreation.employee_demographics 
where birth_date like '1989%' # cari birth_date yg 1989-sekian
;
select *
from parks_and_recreation.employee_demographics 
where first_name like 'a__%' # kombinasi: cari 2 karakter setelah a, lalu cari jika ada punya lebihan
;