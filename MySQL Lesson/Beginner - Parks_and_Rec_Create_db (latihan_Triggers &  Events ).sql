-- Triggers &  Events

-- Triggers:
-- Skrip yang disetel untuk merespons perubahan data secara instan pada tabel tertentu 
-- (misalnya, begitu data gaji karyawan baru masuk, sistem otomatis mencatat nama mereka ke tabel demografi).

select *
from employee_demographics
;

select *
from employee_salary
;


-- CARA MEMBUAT TRIGGER (Pemicu)

DELIMITER $$
create trigger employee_insert				# kita buat pemicu (trigger) yg bernama 'employee_insert'
	after insert on employee_salary			# Pemicu ini akan aktif setelah ada data baru yang dimasukkan (INSERT) ke dalam tabel 'employee_salary'
		# pakai 'AFTER' utk penyisipan di 'employee_salary'
		# pakai 'BEFORE' utk penghapusan/pembaruan di 'employee_salary'
    for each row							# Pemicu ini akan dijalankan satu kali untuk setiap baris data yang baru saja ditambahkan.
begin										# BEGIN ... END $$ : Menandai awal dan akhir dari blok logika yang akan dijalankan oleh pemicu tsb.
	insert into employee_demographics (employee_id, first_name, last_name)	# Inti dari pemicunya: menyalin data (employee_id, first_name, last_name) dari tabel salary ke tabel 'employee_demographics'.
	value (new.employee_id, new.first_name, new.last_name);					# Kata kunci NEW merujuk pada data yang baru saja masuk (baris yang baru di-insert).
		# pakai 'NEW' utk disisipkan ke baris baru.
        # pakai 'old' utk diperbarui atau mengambil baris yg dihapus.
end $$
DELIMITER ;
	# TRIGGER SUKSES DIBENTUK
    
-- CARA INSERT (MENYISIPKAN) DATA
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation,
salary, dept_id)
VALUES(13, 'Muhammad Ariq', 'Rizky', 'Exntertainment 720 CEO',1000000, NULL)
;


-- VALUES (Alarm Otomatis / Jadwal Berkala)
-- Seperti mesin penyiram tanaman otomatis di taman kota yang diatur menyala setiap pukul 6 pagi atau setiap 30 menit sekali, terlepas dari apakah ada orang yang memantaunya atau tidak.

-- TRIGGER digunakan saat sesuatu sdg berlangsung
-- VALUES digunakan ketika dijadwalkan

SELECT *
from employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees	
ON SCHEDULE EVERY 30 SECOND		# buat 'event' setiap 30 detik
DO								# ini event-nya 👇👇👇
BEGIN
	DELETE
	FROM employee_demographics
	WHERE age >= 60;			# event tsb adalah "hapus data 'employee_demographics' yg memiliki usia > 60"
END $$
DELIMITER ;

-- CARA UNTUK MEMASTIKANNYA EVENT BERJALAN DENGAN BAIK
show variables;
show variables like '%event%';