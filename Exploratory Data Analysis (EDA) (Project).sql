-- Exploratory Data Analysis (EDA) 

-- 1. Analisis Dasar: Menentukan nilai maksimum layoff (12.000 orang dalam satu kejadian) dan mengidentifikasi perusahaan yang memberhentikan 100% karyawannya (persentase layoff = 1)
-- 2. Analisis Perusahaan & Industri: Mengelompokkan data berdasarkan perusahaan dan industri untuk melihat siapa yang paling terdampak, serta mengurutkannya berdasarkan jumlah total karyawan yang diberhentikan.
-- 3. Analisis Berbasis Waktu:
-- Mengamati rentang data dari Maret 2020 hingga awal 2023 
-- Melakukan perhitungan rolling total (akumulasi bulanan) menggunakan Common Table Expressions (CTE) dan fungsi window untuk melihat tren perkembangan layoff dari waktu ke waktu
-- 4. Analisis Tingkat Lanjut: Menggunakan fungsi DENSE_RANK() untuk merangking perusahaan berdasarkan jumlah layoff per tahun. Penulis mendemonstrasikan cara menggunakan beberapa CTE untuk memfilter data agar hanya menampilkan top 5 perusahaan dengan layoff terbanyak setiap tahunnya.



-- 1. Analisis Dasar: Menentukan nilai maksimum layoff (12.000 orang dalam satu kejadian) dan mengidentifikasi perusahaan yang memberhentikan 100% karyawannya (persentase layoff = 1)

select *
from layoffs_staging3;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging3;

select *
from layoffs_staging3
where percentage_laid_off = 1
order by total_laid_off desc;	# COMPANY 'Katerra' ADALAH COMPANY YG PLG BYK MELAKUKAN PHK

select *
from layoffs_staging3
where percentage_laid_off = 1
order by funds_raised_millions desc;	# COMPANY 'Britishvolt' ADALAH COMPANY YG PLG BYK MENGUMPULKAN DANA

select company, sum(total_laid_off)
from layoffs_staging3
group by company
order by 2 desc;		# SECARA TOTAL PHK, COMPANY 'Amazon' ADALAH COMPANY YG PLG BYK MELAKUKAN PHK

select *
from layoffs_staging3
where company = 'Amazon';

select min(`date`), max(`date`)
from layoffs_staging3;

select industry, sum(total_laid_off)
from layoffs_staging3
group by industry
order by 2 desc;		# INDUSTRI 'Consumer' ADALAH INDUSTRI YG PLG BYK MELAKUKAN PHK

select country, sum(total_laid_off)
from layoffs_staging3
group by country
order by 2 desc;		# NEGARA 'United States' ADALAH NEGARA YG PLG BYK MELAKUKAN PHK


-- Mengamati rentang data dari Maret 2020 hingga awal 2023
select `date`, sum(total_laid_off)
from layoffs_staging3
group by `date`
order by 2 desc;		# TANGGAL '2023-01-04' ADALAH TANGGAL PLG BYK TERJADI PHK

select year(`date`), sum(total_laid_off)
from layoffs_staging3
group by year(`date`)
order by 1 desc;		#TAHUN '2023' ADALAH TAHUN PLG BYK TERJADI PHK
						#DAN TIAP TAHUN ANGKA PHK NAIK 

select stage, sum(total_laid_off)
from layoffs_staging3
group by stage
order by 2 desc;		# SETELAH PERUSAHAAN BERSTATUS IPO (Post-IPO) BYK YG DI-PHK

select country, avg(percentage_laid_off)
from layoffs_staging3
group by country
order by 2 desc;


-- Melakukan perhitungan rolling total (akumulasi bulanan) menggunakan Common Table Expressions (CTE) dan fungsi window untuk melihat tren perkembangan layoff dari waktu ke waktu