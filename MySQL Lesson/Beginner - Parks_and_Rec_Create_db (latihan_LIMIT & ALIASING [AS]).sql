-- LIMIT & ALIASING
select *
from employee_demographics
order by age desc
;
select *
from employee_salary;

select *
from employee_demographics
order by age desc
limit 3  #hanya menampilkan 3 baris
;

select *
from employee_demographics
order by age desc
limit 2,1  #"Lewati 2 orang pertama di antrean, lalu ambil 1 orang berikutnya."
;


-- ALIASING
select gender, avg(age) as avg_age #AS utk mengubah nama variable agar sesuai keinginan
from employee_demographics
group by gender
having avg(age) > 40
;
-- 👇👇👇☝️☝️☝️ SAMA
select gender, avg(age) as avg_age #AS utk mengubah nama variable agar sesuai keinginan
from employee_demographics
group by gender
having avg_age > 40 #di sini sudah boleh mengubah 'avg(age)' menjadi 'avg_age', karena sudah dialiaskan
;
-- 👇👇👇☝️☝️☝️ SAMA
select gender, avg(age) avg_age #AS boleh ditulis ataupun tidak, akan tetap bekerja
from employee_demographics
group by gender
having avg_age > 40 #di sini sudah boleh mengubah 'avg(age)' menjadi 'avg_age', karena sudah dialiaskan
;
