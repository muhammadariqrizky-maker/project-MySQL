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


-- Rolling Total: Menggunakan fungsi jendela (window function) dan CTE (Common Table Expression) untuk menghitung total kumulatif PHK bulan demi bulan
# pakai Window Function / CTE

select *
from layoffs_staging3;

select substring(`date`, 6, 2) as `month`,	#AMBIL KARAKTER KE-6 SEBANYAK 2 KARAKTER PADA KOLOM `date`
sum(total_laid_off)	as sum
from layoffs_staging3
group by `month`;			

select substring(`date`, 1, 7) as `month`,
sum(total_laid_off)	as sum
from layoffs_staging3
group by `month`
having `month` is not null
order by 1 asc;	
			# ☝️☝️☝️ SAMA 👇👇👇
select substring(`date`, 1, 7) as `month`,
sum(total_laid_off)	as total_off
from layoffs_staging3
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc;	


-- Rolling Total
# langkah 1: copas yg terakhir ☝️ ke dalam tanda kurung '()' 👇
with rolling_total as
(
select substring(`date`, 1, 7) as `month`,
sum(total_laid_off)	as total_off
from layoffs_staging3
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc	
)
select *
from rolling_total;

# langkah 2: GANTI 'SELECT'
with rolling_total as
(
select substring(`date`, 1, 7) as `month`,
sum(total_laid_off)	as total_off
from layoffs_staging3
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc	
)
select `month`, total_off,
sum(total_off) over(order by `month`) as rolling_total
from rolling_total;
		# PERHATIKAN KEPALA ANGKA PADA 'rolling_total'
        # PALING CEPAT BERUBAH DI AKHIR TAHUN 2022-2023

select company, `date`, sum(total_laid_off)
from layoffs_staging3
group by company, `date`;

select company, year(`date`), sum(total_laid_off)
from layoffs_staging3
group by company, year(`date`);

select company, year(`date`), sum(total_laid_off)
from layoffs_staging3
group by company, year(`date`)
order by 3 desc;		# INI MENAMPILKAN COMPANY MANA YG PLG BYK MELAKUKAN PHK,
						# DIURUTKAN BERDASARKAN JUMLAH PLG BYK DAN TAHUN-NYA
	
    # COPAS ☝️ KE DALAM TANDA KURUNG  
with company_year as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging3
group by company, year(`date`)
)
select *
from company_year;

	# ALIASKAN
with company_year (company, years, total_laid_off) as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging3
group by company, year(`date`)
)
select *
from company_year;

	# BERI RANK UTK BERDASARKAN TAHUN, DAN URUTKAN 'total_laid_off' DARI YG TERBESAR
with company_year (company, years, total_laid_off) as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging3
group by company, year(`date`)
)
select *, dense_rank() over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
order by ranking asc;
		# DENSE_RANK(): Jika ada dua perusahaan dengan jumlah 'sesuatu' yang sama, keduanya akan mendapatkan peringkat yang sama.
        # OVER(PARTITION BY years ...): Peringkat 1 akan muncul kembali untuk tahun yg sama. ini tempat utk menentukan 'sesuatu' itu
		# ORDER BY total_laid_off DESC: Mengurutkan perusahaan dalam setiap tahun berdasarkan jumlah PHK dari yang terbanyak ke terkecil.
# KESIMPULAN:
# memeringkat perusahaan berdasarkan jumlah PHK terbanyak setiap tahunnya


	# UPGRADE: Hanya ingin menampilkan (memfilter) 5 company per tahun
    # 		   Hanya ingin menampilkan 5 company per tahun yg melakukan PHK palng banyak.
# jadikan Double CTE
with company_year (company, years, total_laid_off) as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging3
group by company, year(`date`)
), company_year_rank as
(
select *, dense_rank() over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
)
select *
from company_year_rank
where ranking <= 5;
