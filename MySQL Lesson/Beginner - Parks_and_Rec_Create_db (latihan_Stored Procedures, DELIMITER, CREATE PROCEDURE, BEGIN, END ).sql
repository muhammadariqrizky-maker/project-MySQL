-- Stored Procedures 
-- (mirip Temporary Tables/CTEs, ini hanya versi BISA DISIMPAN SELAMANYA dan 'menyimpan dalam bentuk kode') 
-- penjelasan: ini adalah blok kode SQL yang disimpan di dalam database sehingga dapat dipanggil dan dieksekusi berulang kali.

select *
from employee_salary
where salary >= 50000
;

create procedure large_salaries()
select *
from employee_salary
where salary >= 50000
;
# setelah RUN ini, lalu REFRESH SCHEMAS, dan 'large_salaries()' akan tersimpan di 'Stored Procedures'

-- CARA MEMANGGILNYA
call large_salaries;


-- cara Multiple Stored Procedures yg salah ❌❌❌
create procedure large_salaries2()
select *
from employee_salary
where salary >= 50000;	# setiap SELECT harus dipisah dengan pembatas ';'
select *
from employee_salary
where salary >= 10000
;	


-- cara Multiple Stored Procedures yg benar ✅✅✅

DELIMITER $$	# DELIMITER: Perintah untuk mengubah simbol penanda akhir kueri (biasanya dari ; menjadi $$)
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000; # harus ada titik koma disini, dan wajib ditambah👉(DELIMITER $$ ... BEGIN ... END $$)
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;		# DELIMITER: mengubah simbol penanda akhir kueri menjadi ; kembali

call large_salaries3;


-- cara CALL salary-nya org yg memiliki 'employee_id' tertentu
DELIMITER $$	
CREATE PROCEDURE large_salaries4(XXX int) 
BEGIN
	SELECT salary
	FROM employee_salary
	where employee_id = XXX 	# cara menjelaskan bahwa 'employee_id' yg di tabel adalah 'XXX INT'yg nantinya akan dipanggil
    ;
END $$
DELIMITER ;	

call large_salaries4(1)