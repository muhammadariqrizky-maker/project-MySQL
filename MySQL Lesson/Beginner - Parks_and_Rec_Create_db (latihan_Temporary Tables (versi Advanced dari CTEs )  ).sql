-- Temporary tables (tabel sementara) [mirip dengan CTE, tapi lebih Advanced]

-- CARA 1: CARA MANUAL (BUAT TABEL MANUAL)
-- SIAPKAH TABEL: (CREATE TEMPORARY TABLE ... SELECT * FROM ... )
-- MASUKKAN DATA/ISI TABELNYA : (INSERT INTO ... VALUES ... SELECT * FROM ...)

-- SIAPKAN TABELNYA 
create temporary table temp_table	# tinggal panggil 'temp_table'
(
first_name varchar(50),
last_name varchar(50),
favorite_movie	varchar(100)
);

select *
from temp_table;

-- MASUKKAN DATA/ISI TABELNYA
INSERT INTO temp_table
VALUES('Alex', 'Freberg', 'Lord of the Rings: The Two Towers');

select *
from temp_table;



-- CARA 2: tdk perlu bikin datanya, melainkan hanya memilih data dari tabel yg sdh ada.
-- PILIH DATA YG DIINGINKAN: ((misal: CREATE TEMPORARY TABLE ... SELECT * FROM ... WHERE ...)

select *
from employee_salary;

-- PILIH DATA YG DIINGINKAN
create temporary table salary_over_50k
select *
from employee_salary
where salary >= 50000;

select *
from salary_over_50k; 
# 👈JIKA KITA HANYA MENGAMBIL INI SAJA DI TAB BARU, MAKA BERFUNGSI DENGAN BAIK
# KARENA, DATA SUDAH TERSIMPAN DI SOFTWARE.
# namun, jika kita menutup aplikasi MySQL, maka tdk akan berfungsi.
