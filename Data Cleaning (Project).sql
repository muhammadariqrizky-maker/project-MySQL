-- Data Cleaning (Project)

select *
from layoffs;

-- 1. Menghapus Duplikat:  Menggunakan fungsi ROW_NUMBER() dan CTE (Common Table Expression) untuk mengidentifikasi serta menghapus baris data yang ganda 
-- 2. Standardisasi Data:  Membersihkan spasi berlebih dengan TRIM, menyamakan penulisan industri (seperti mengubah 'Cryptocurrency' menjadi 'Crypto'), dan memperbaiki kesalahan penulisan negara 
-- 3. Konversi Tipe Data:  Mengubah kolom date yang awalnya berupa teks menjadi format tanggal (date format) yang benar 
-- 4. Menangani Nilai Null dan Kosong:  Mengisi data yang hilang dengan melakukan join pada tabel yang sama, serta menghapus baris yang tidak memiliki informasi penting (total laid off dan percentage kosong) 
-- 5. Finalisasi:  Menghapus kolom bantuan (seperti row_num) untuk mendapatkan tabel data yang sudah bersih dan siap dianalisis 


-- SEBELUM MULAI (ini yg bisa dunia pekerjaan lakukan)
-- Staging Table: Membuat tabel staging untuk melakukan perubahan data agar data asli tetap terjaga
create table layoffs_staging
like layoffs;

select *
from layoffs_staging;

insert layoffs_staging
select *
from layoffs;


-- 1. Menghapus Duplikat:  Menggunakan fungsi ROW_NUMBER() dan CTE (Common Table Expression) untuk mengidentifikasi serta menghapus baris data yang ganda 
# Identifikasi Duplikat: 
# Karena tabel tidak memiliki kolom ID unik, digunakan fungsi 'row_number()' dengan 'PARTITION BY' untuk buat ID 1 hingga seterusnya.

	-- CARA UTK MENEMUKAN DUPLIKAT 👇👇👇
SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging; 	# 'PARTITION BY' diisi dengan variable2 yg sekiranya akan memiliki duplikat

with duplicate_CTE as
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
select *
from duplicate_CTE
where row_num > 1;
		# INILAH YG MEMILIKI DUPLIIKAT !!! ☝️☝️☝️☝️☝️☝️

	-- CEK DATA DUPLIKAT
select *
from layoffs_staging
where company = 'Hibob'
; 		
        
	-- CARA NENGHAPUS DATA YG DUPLICATE
		# cara: layoffs_staging > Copy to clipcoard > create statement
        # lalu: ubah 'layoffs_staging' menjadi 'layoffs_staging2'
        # dan tambahkan kolom baru bernama 'rum_num'
    CREATE TABLE `layoffs_staging3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging3;

insert into layoffs_staging3
SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
;

			# TAMPILKAN DATA DUPLIKAT LAGI
select *
from layoffs_staging3
where row_num > 1
;

			# DELETE DATA DUPLIKAT
DELETE
FROM layoffs_staging3
WHERE row_num > 1;

select *
from layoffs_staging3
where row_num > 1;

select *
from layoffs_staging3;
			# BISA DILIHAT
			# DATA DUPLIKAT SUDAH DIHAPUS 👏👏👏
            
            

-- 2. Standardisasi Data:  Membersihkan spasi berlebih dengan TRIM, menyamakan penulisan industri (seperti mengubah 'Cryptocurrency' menjadi 'Crypto'), dan memperbaiki kesalahan penulisan negara 
# untuk memperbaiki ketidakkonsistenan agar data lebih akurat saat dianalisis. 

	-- MENGHAPUS SPASI BERLEBIH
select company, trim(company)
from layoffs_staging3;

update layoffs_staging3
set company = trim(company);	# # MENGUBAH 'company' MENJADI 'trim(company)'
		# INI CARA UTK UPDATE/MEMPERBARUI DATA ☝️☝️☝️
        
	-- MENYAMAKAN KATEGORI INDUSTRI
select *
from layoffs_staging3;

select industry
from layoffs_staging3;

select distinct industry
from layoffs_staging3
order by industry;
		# KETAHUAN, ADA INDSUTRI 'Crypto, Crypto Currency, CryptoCurrency'
        
        # INI CARA UTK UPDATE/MEMPERBARUI DATA 👇👇👇
select *
from layoffs_staging3
where industry like 'Crypto%'
order by industry;

update layoffs_staging3
set industry = 'Crypto'
where industry like 'Crypto%'; 	# MENGUBAH 'Crypto%' MENJADI 'Crypto'

		# CEK LAGI !!!
select distinct industry
from layoffs_staging3
order by 1;

select distinct location
from layoffs_staging3
order by 1;

select distinct country
from layoffs_staging3
order by 1; 	# ADA SATU!! 'United States'  DAN 'United States.'

		# INI CARA UTK UPDATE/MEMPERBARUI DATA 👇👇👇
update layoffs_staging3
set country = TRIM(TRAILING '.' FROM country)	-- SAMA 👈👈 set country = 'United States' 
where country like 'United States%'				-- TRAILING untuk menghapus karakter yang tidak diinginkan
;

		# CEK lAGI
select distinct country, trim(country)
from layoffs_staging3
order by 1; 	# ✅✅✅ BERHASIL



-- 3. Konversi Tipe Data
# Identifikasi Masalah: 
# Kolom date awalnya diimpor sebagai teks (text), bukan tipe date, 
# sehingga tidak bisa digunakan untuk fungsi analisis waktu 

select `date`
from layoffs_staging3;

		# CARA untuk mengubah format teks menjadi format tanggal 
select `date`, str_to_date(`date`, '%m/%d/%Y') # 'Y' kapital
# Butuh 2 parameter: kolom asal dan format tujuan (misalnya %m/%d/%Y untuk bulan/hari/tahun)
from layoffs_staging3;

		# UPDATE/PERBARUI FORMAT TEKS -> FORMAT TANGGAL 👇👇👇
update layoffs_staging3
set `date` =  str_to_date(`date`, '%m/%d/%Y');
			# NAMUN TERNYATA, INI MASIH BERSTATUS 'TEXT' DI SISTEM
        
        # UPDATE/PERBARUI STATUS TEKS -> STATUS TANGGAL 👇👇👇
alter table	layoffs_staging3
modify column `date` date;

select *
from layoffs_staging3; 	
		# BERHASIL ✅✅✅



-- 4. Menangani Nilai Null dan Kosong:  Mengisi data yang hilang dengan melakukan join pada tabel yang sama, serta menghapus baris yang tidak memiliki informasi penting (total laid off dan percentage kosong) 

# Standardisasi Format: 
# mengubah nilai 'blank' menjadi 'null' agar lebih mudah dideteksi dan diproses oleh sistem 

select *
from layoffs_staging3
where total_laid_off is null	# null tdk bisa pakai '=', harus pakai 'is'
and percentage_laid_off is null;  

		# UBAH SEMUA '' MENJADI 'NULL'
update layoffs_staging3
set industry = null
where industry = '';

select *
from layoffs_staging3
where industry is null
or industry = '';

		# KITA MULAI DARI 'Airbnb'
select *
from layoffs_staging3
where company = 'Airbnb';
			
            # LAKUKAN SELF-JOIN
select *
from layoffs_staging3 as t1
join layoffs_staging3 as t2			# CARA MEMBERITAHU SISTEM BAHWA KITA INGIN MENYAMAKAN TABEL KOSONG DENGAN TABEL YG ADA ISINYA
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null OR T1.industry = '')	# CARA MEMBERITAHU SISTEM MANA TABEL YG ADA ISINYA
and t2.industry is not null;						# CARA MEMBERITAHU SISTEM MANA TABEL YG KOSONG

			# TAMPILKAN t1.industry, t2.industry AGAR MUDAH MELIHATNYA
select t1.industry, t2.industry
from layoffs_staging3 as t1
join layoffs_staging3 as t2			
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null OR T1.industry = '')	
and t2.industry is not null;

		# KITA COBA UPDATE
update layoffs_staging3 as t1
join layoffs_staging3 as t2			
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null OR T1.industry = '')	
and t2.industry is not null;

		# CEK
select *
from layoffs_staging3
where company = 'Airbnb';

select *
from layoffs_staging3
where industry is null
or industry = '';
		# KARENA 'Bally's Interactive'  HANYA ADA 1 BARIS DATA, MAKA BIARKAN SAJA. JANGAN DIHAPUS!!



-- 5: Pembersihan Akhir: 
# Menghapus kolom dan baris yang tidak relevan yang tidak diperlukan -
# untuk tahap analisis data selanjutnya 
		
select *
from layoffs_staging3
where total_laid_off is null
and percentage_laid_off is null;

		# HAPUS DATA 'total_laid_off' & 'percentage_laid_off' YG KOSONG
        # 👇👇👇
delete
from layoffs_staging3
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging3;

		# HAPUS KOLOM 'row_num'
        # utk hapus kolom caranya beda
        # 👇👇👇
alter table layoffs_staging3
drop column row_num;

select *
from layoffs_staging3;
