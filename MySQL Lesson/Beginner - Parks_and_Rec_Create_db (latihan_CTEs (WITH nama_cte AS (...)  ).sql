-- CTEs { WITH nama_cte AS (...) }:
-- Penjelasan: CTE adalah subkueri yang diberi nama di awal menggunakan kata kunci WITH, sehingga terlihat seperti tabel virtual mandiri yang bersih sebelum dipanggil di kueri utama.
-- Analogi Intuitif: Ini seperti membuat resep bumbu dasar sebelum memasak hidangan utama. Alih-alih mencampur semua bahan rumit langsung di dalam panci utama yang membuat bingung (subkueri bertumpuk), 
-- Anda meraciknya terlebih dahulu di mangkuk terpisah, melabelinya dengan jelas ("Bumbu A"), lalu tinggal menuangkannya ke masakan utama.
select *
from employee_demographics
;
select *
from employee_salary
;
SELECT gender, AVG(salary), MAX(salary), MIN(salary), COUNT(salary)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;



-- CONTOH SIMPLE:

WITH CTE_Example as
(
select *
from employee_demographics
)
select *
from CTE_Example 
;
# 'WITH' sbg CTE-nya
# dengan membuat 'WITH'/CTE, kita mudah memanggil apa saja
# kita tinggal memanggil 'CTE_Example' utk menampilkan yg kita inginkan
# mirip dengan fungsi 'def' pada python

WITH CTE_Example as
(
SELECT gender, AVG(salary) as avg_sal, MAX(salary) as max_sal, MIN(salary) as min_sal, COUNT(salary) as count_sal
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
select *
from CTE_Example 
;
			-- CARA LAIN UTK RENAME PADA CTAs, tanpa menggunakan fungsi 'as'
WITH CTE_Example (gender, avg_sal, max_sal, min_sal, count_sal) as
(
SELECT gender, AVG(salary) , MAX(salary), MIN(salary), COUNT(salary)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
select *
from CTE_Example 
;

WITH CTE_Example as
(
SELECT gender, AVG(salary) as avg_sal, MAX(salary), MIN(salary), COUNT(salary)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
select avg(avg_sal)
from CTE_Example 
;
		-- HASILNYA SAMA 👇👇👇☝️☝️☝️
select avg(avg_sal)
from (
SELECT gender, AVG(salary) as avg_sal, MAX(salary), MIN(salary), COUNT(salary)
FROM employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
) as example_subquery
;



-- MULTIPLE CTEs

WITH CTE_Example as
(
SELECT employee_id, gender, birth_date
FROM employee_demographics as dem
where birth_date > '1980-01-01' 
),
CTE_Example2 as
(
select employee_id, salary
from employee_salary as sal
where salary >= 50000
)
select *
from CTE_Example 
join CTE_Example2
	on CTE_Example.employee_id = CTE_Example2.employee_id
;
# "tampilkan semua tabel pada CTE_Example dan CTE_Example2, hanya yg memiliki 'employee_id' yg sama."
