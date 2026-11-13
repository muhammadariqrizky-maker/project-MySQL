select *
from parks_and_recreation.employee_demographics;

select first_name,
last_name, 
employee_id,
age,
age + 10,
(age + 10) * 9 
from parks_and_recreation.employee_demographics;
# PEMDAS (CATATAN)

select distinct gender
from parks_and_recreation.employee_demographics;
# hanya akan menampilkan jenis 'gender' yg ada

select distinct first_name, gender
from parks_and_recreation.employee_demographics;
# 'hanya menampilkan jenis' menjadi tidk berlaku, karena namanya beda2. SQL-pun menganggap jenis dari 'nama' itu berbeda2.
