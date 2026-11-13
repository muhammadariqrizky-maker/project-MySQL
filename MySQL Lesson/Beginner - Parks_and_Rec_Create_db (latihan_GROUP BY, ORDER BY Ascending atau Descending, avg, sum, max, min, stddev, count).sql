-- GROUP BY (MENG-GRUP-KAN KOLOM)
select *
from employee_demographics;
select *
from employee_salary;

select gender
from employee_demographics
;

select gender
from employee_demographics
group by gender
;
# jadi: GROUP BY ini hanya akan menyebutkan jenis2 GENDER yg ada

select gender, avg(age), sum(age), max(age), min(age), stddev(age), count(age)
from employee_demographics
group by gender
;
# jadi: GROUP BY ini hanya akan menyebutkan jenis2 GENDER yg ada
# + avg(age) ini menambahkan rata2 AGE tiap GENDER

select occupation, salary
from employee_salary
group by occupation,salary
;


-- ORDER BY (MENGURUTKAN NAIK ATAUPUN TURUN)
select *
from employee_demographics;
select *
from employee_salary;

select *
from employee_demographics
order by first_name
;
# mengurutkan SEMUA kolom sesuai berdasarkan urutan first_name (Auto Ascending)

select *
from employee_demographics
order by gender asc
;
# tambahlan asc utk Ascending (dari A-Z / dari kecil ke besar)

select *
from employee_demographics
order by age desc
;
# tambahlan desc utk Descending (dari Z-A / dari besar ke kecil)

select *
from employee_demographics
order by gender, age desc 
;
# urutkan secara Ascending pada GENDER, lalu diikuti Descending AGE-nya
# yang Descending hanya AGE


-- MODIFIKASI 
select *
from employee_demographics
order by gender, age  
;
# 👇👇👇☝️☝️☝️ SAMA
select *
from employee_demographics
order by 5, 4  
;
# gender: kolom ke-5, age: kolom ke-4