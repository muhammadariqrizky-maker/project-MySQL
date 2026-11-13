-- Window Functions vs GROUP BY
# Berbeda dengan klausul 'GROUP BY' yang menggabungkan dan merangkum baris data menjadi satu baris tunggal, 
# 'window function' melakukan perhitungan di atas sekumpulan baris (window) tanpa menghilangkan identitas atau baris unik aslinya

select *
from employee_demographics
;
select *
from employee_salary
;



-- CONTOH:
-- 'GROUP BY' akan menggabungkannya ke dalam 1 baris.
select *
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
;
# UPGRADE 👇👇👇
select gender, avg(salary) 		# kalau ada 'avg(),sum(),dkk' harus ada 'GROUP BY'
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender
;



-- CONTOH:
-- WINDOW FUNCTION: melakukan 'avg(),sum(),dkk' tanpa menghilangkan identitas atau baris unik aslinya

select gender, avg(salary) over()		
				# cara baca: "average salary over everything"
                # cara baca: "rata2 salary untuk semuanya"
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
-- group by gender
				# tanpa 'group by'
;



-- CONTOH
-- PARTITION BY: untuk mengelompokkan perhitungan dalam window tertentu, seperti menghitung total gaji berdasarkan gender.
-- PARTITION BY ini gabungan antara 'GROUP BY' dan 'WINDOW FUNCTION biasa [over()]'
-- dia ini menghitung rata2 masing2 gender (bukan keseluruhan gender) lalu menaruhnya di tiap barus tanpa menghilangkan identitas atau baris unik aslinya.

select gender, avg(salary) over(partition by gender)		
				# cara baca: "average salary over partition by gender"
				# cara baca: "rata2 salary utk berdasarkan gender"
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
-- group by gender
				# tanpa 'group by'
;


-- PARTITION BY ini jauh lebih fleksibel dibanding 'GROUP BY'
-- BUKTI 👇👇👇

select dem.first_name, dem.last_name, gender, avg(salary) 		# kalau ada 'avg(),sum(),dkk' harus ada 'GROUP BY'
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
group by dem.first_name, dem.last_name, gender
;		--  'avg(salary)' TIDAK BERJALAN DENGAN BAIK ❌❌❌❌❌

select dem.first_name, dem.last_name, gender, 
avg(salary) over(partition by gender)		
				# cara baca: "average salary over partition by gender"
				# cara baca: "rata2 salary utk berdasarkan gender"
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
;		--  'avg(salary)' BERJALAN DENGAN BAIK ✅✅✅✅✅



-- ROW_NUMBER(): Seperti nomor antrean di bank, di mana setiap orang dijamin mendapat nomor unik berurutan meskipun datang bersamaan.
-- RANK(): Seperti juara lomba lari dengan nilai kembar di posisi ke-2, di mana peringkat berikutnya melompat posisinya (1, 2, 2, 4).
-- DENSE_RANK(): Mirip juara kembar, tetapi nomor peringkat berikutnya tidak melompat (1, 2, 2, 3).

# ❌❌❌ malah jadi 'Rolling Total' (menjumlahkan angka sebelunya)
select dem.first_name, dem.last_name, gender, salary, 
SUM(salary) over(partition by gender ORDER BY dem.employee_id)		
				# cara baca: "jumlah salary utk berdasarkan gender, dan diurutkan (Asc) beradasrkan urutan 'employee_id'."
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

# ✅✅✅
select dem.employee_id, dem.first_name, dem.last_name, gender, salary, 
row_number() over()	
			# cara baca: "beri angka urutan utk semuanya"
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

# ✅✅✅
select dem.employee_id, dem.first_name, dem.last_name, gender, salary, 
row_number() over(partition by gender)	
		# cara baca: "beri angka urutan utk berdasarkan gender"
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

# ✅✅✅
select dem.employee_id, dem.first_name, dem.last_name, gender, salary, 
row_number() over(partition by gender order by salary desc) as 'row_number',
		# cara baca: "beri angka urutan utk berdasarkan gender, diurutkan (Desc) berdasarkan 'salary'"
rank() over(partition by gender order by salary desc) as 'rank',
		# cara baca: "beri angka urutan utk berdasarkan gender, diurutkan (Desc) berdasarkan 'salary'"
dense_rank() over(partition by gender order by salary desc)	as 'dense_rank'
		# cara baca: "beri angka urutan utk berdasarkan gender, diurutkan (Desc) berdasarkan 'salary'"
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
;