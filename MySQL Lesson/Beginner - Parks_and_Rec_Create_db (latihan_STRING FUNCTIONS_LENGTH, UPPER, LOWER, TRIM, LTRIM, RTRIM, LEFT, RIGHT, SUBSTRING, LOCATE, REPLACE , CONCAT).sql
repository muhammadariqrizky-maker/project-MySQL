-- STRING FUNCTIONS
select *
from employee_demographics
;
select *
from employee_salary
;

# LENGTH : Mengukur jumlah karakter
select first_name, length(first_name) as lg
from employee_demographics
order by 2
# order by lg (sama saja)
;

# UPPER : format penulisan huruf menjadi huruf kapital seluruhnya.
select first_name, upper(first_name) as up
from employee_demographics
order by 2
# order by lg (sama saja)
;

# LOWER : format penulisan huruf menjadi huruf kecil seluruhnya.
select first_name, lower(first_name) as lw
from employee_demographics
order by 2
# order by lg (sama saja)
;



# TRIM, LTRIM, RTRIM (Menghilangkan spasi kosong yang tidak disengaja di awal (leading), akhir (trailing), atau kedua sisi string.)
select 
trim('            SALJnasf           '),
ltrim('            SALJnasf            '),
rtrim('            SALJnasf            ')
;

# LEFT, RIGHT, SUBSTRING : Mengambil sebagian karakter dari sisi kiri, kanan, atau posisi tertentu di tengah string.
select 
left('april mop', 4),        # ambil 4 dari awal
right('april mop', 3),		 # ambil 3 dari akhir
substring('april mop', 3, 2) # ambil mulai dari 3 sebanyak 2 karakter
;

select *
from employee_demographics
;
select birth_date, substring(birth_date, 6, 2) as 'bulan lahir'
from employee_demographics
; # hanya ambil bulan lahirnya saja



# LOCATE, REPLACE 
# LOCATE: Menemukan posisi angka/huruf tertentu dalam teks 
# REPLACE: menukar karakter lama dengan karakter baru 
select *
from employee_demographics
;

select first_name, replace(first_name, 'a', 'z')
from employee_demographics
; # mengganti hurup 'a' menjadi 'z' pada kolom first_name

select locate('x', 'alexander')
; # mencari letak huruf 'x' dari kata 'alexander'

select first_name, locate('An', first_name)
from employee_demographics
; # mencari letak karakter 'An' dari kolom first_name



# CONCAT (Menyambungkan dua atau lebih kolom teks (misalnya nama depan dan nama belakang) menjadi satu kolom utuh.)
select first_name, 
last_name, 
concat(first_name,' ', last_name) as 'Full name'
from employee_demographics
;