-- Subqueries

select *
from employee_demographics
;
select *
from employee_salary
;


select *
from employee_demographics
where employee_id in 
		(select employee_id # HANYA BOLEH SATU 
        from employee_salary
        where dept_id = 1  	# "ambil employee_id yg memiliki dept_id=1 "
)
; 
# jadi, secara keseluruhan:
# "tampilkan semua informasi employee_demographics karyawan yg memiliki dept_id=1 "
# hanya menggunakan Subqueries karena 'dept_id' hanya ada di 'employee_salary'
# makanya, kami menarik 'dept_id' dari 'employee_salary' agar bisa memunculkannya di 'employee_demographics"



select first_name, salary, avg(salary)
from employee_salary
group by first_name, salary
;
# ❌❌❌ bukan ini yg diinginkan
# yg diinginkan: 'avg(salary)' dari keseluruhan salary org2 yg ada 
# catatan: AVG,MAX,MIN,COUNT ini termasuk 'agregat', wajib ada fungsi 'group by'

# ✅✅✅ cara yg benar (pakai SUBQUERIE di 'select')
select first_name, salary, 
(select avg(salary)
from employee_salary) # cari avg(salary) dari tabel employee_salary
from employee_salary
;
# jdnya: "munculkan kolom 'first_name, salary, avg(salary)'


select gender, AVG(age), MAX(age), MIN(age), COUNT(age)
from employee_demographics
group by gender; 
# ini aman ✅✅✅✅✅✅✅✅✅✅
# karena gender-nya hanya ada 2
# catatan: AVG,MAX,MIN,COUNT ini termasuk 'agregat', wajib ada fungsi 'group by'

select *
from 
(select gender, AVG(age), MAX(age), MIN(age), COUNT(age)
from employee_demographics
group by gender) as aokwaokawok ; 
# hasilnya sama kyk yg di atasnya ☝️☝️☝️

Select AVG(max_age)
FROM
(SELECT gender,
AVG(age) AS avg_age,
MAX(age) AS max_age,
MIN(age) AS min_age,
COUNT(age)
FROM employee_demographics
GROUP BY gender) as agg_table
;