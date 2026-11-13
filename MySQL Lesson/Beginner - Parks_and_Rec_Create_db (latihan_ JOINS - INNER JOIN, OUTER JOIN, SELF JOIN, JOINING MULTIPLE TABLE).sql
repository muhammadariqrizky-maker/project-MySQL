-- JOINS (untuk menyatukan dua tabel)
select *
from employee_demographics
;
select *
from employee_salary
;


-- INNER JOIN / JOIN (menggabugnkan hanya baris-baris yang memiliki kecocokan nilai di kedua tabel)
-- (boleh tulis 'join' saja, atau secara eksplisit tulis 'inner join'
select *
from employee_demographics as dem #aliaskan agar mudah penyebutannya
join employee_salary as sal #aliaskan agar mudah penyebutannya
	on dem.employee_id = sal.employee_id 
    # menyatukan dua tabel berdasarkan kolom 'employee_id'
;

select dem.employee_id, dem.first_name, dem.last_name, age, occupation, salary
# di SELECT, boleh menggunakan dem/sal, sama saja. karena memang isi dari tabelnya sama.
from employee_demographics as dem 
inner join employee_salary as sal 
	on dem.employee_id = sal.employee_id 
;


-- OUTER JOIN (RIGHT JOIN / LEFT JOIN) (Mengambil seluruh baris dari tabel utama (kiri atau kanan) meskipun tidak ada pasangan yang cocok di tabel pasangannya (diisi 'nilai kosong'/'NULL'))
-- (boleh tulis 'join' saja, atau secara eksplisit tulis 'outer join'. YG PASTI HARUS TULIS 'RIGHT' ATAUPUN 'LEFT' NYA.)
select *
from employee_demographics as dem
left join employee_salary as sal	
	on dem.employee_id = sal.employee_id 
    # menyatukan dua tabel berdasarkan kolom 'employee_id'
;

select *
from employee_demographics as dem
right join employee_salary as sal	
	on dem.employee_id = sal.employee_id 
    # menyatukan dua tabel berdasarkan kolom 'employee_id'
;


-- SELF JOIN (Menggabungkan sebuah tabel dengan dirinya sendiri dengan memberikan alias tabel yang berbeda (misalnya emp1 dan emp2))
select *
from employee_salary as emp1
join employee_salary as emp2
	on emp1.employee_id = emp2.employee_id 
    # menyatukan dua tabel berdasarkan kolom 'employee_id'
;

# kita mainkan SELECT dan alias2nya 🧑‍🩰💃🕺
select emp1.employee_id as id1,
emp1. first_name as fr1,
emp1. last_name as last1,
emp2.employee_id as id2,
emp2. first_name as fr2,
emp2. last_name as last2
from employee_salary as emp1
join employee_salary as emp2
	on emp1.employee_id + 1 = emp2.employee_id 
    # menyatukan dua tabel berdasarkan kolom 'employee_id'
;


-- JOINING MULTIPLE TABLE TOGETHER
select *
from employee_demographics as dem 
join employee_salary as sal 
	on dem.employee_id = sal.employee_id 
join parks_departments as pd
	on dept_id = department_id
    # on sal.dept_id = pd.department_id (SAMA SAJA)
;

select *
from parks_departments
;