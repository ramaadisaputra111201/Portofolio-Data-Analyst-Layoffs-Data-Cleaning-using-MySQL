select * from `rama adi`.layoffs;

# Hapus Data Duplikat#
#1
CREATE TABLE `layoffs_staging` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` bigint DEFAULT NULL,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

#2
insert into `rama adi`.layoffs_staging 
select *,
	row_number() over(
    partition by `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions` ) as row_num
from `rama adi`.layoffs;

#3
select 	* from `rama adi`.layoffs_staging;

#4
select * from `rama adi`.layoffs_staging where row_num > 1;

select * from `rama adi`.layoffs_staging where company = 'Yahoo';

#5
delete from `rama adi`.layoffs_staging where row_num > 1;

# Standardizing data #
# 1.mengecak company sudah rapi atau belum
select company, trim(company) from `rama adi`.layoffs_staging;

update `rama adi`.layoffs_staging set company = trim(company);

# 2. location (sudah rapi)
select distinct(location) from `rama adi`.layoffs_staging order by 1;

# 3. industry
select distinct(industry) from `rama adi`.layoffs_staging order by 1;

# 3.1 mengubah crypto% ke crypto
select * from `rama adi`.layoffs_staging where industry like 'Crypto%';

update `rama adi`.layoffs_staging set industry = 'Crypto' where industry like 'Crypto%';

#3.2 menyamakan kode yang 0 / null
select * from `rama adi`.layoffs_staging where industry is null or industry ='';

select * from `rama adi`.layoffs_staging where company = 'Airbnb';

select * from `rama adi`.layoffs_staging t1 
join `rama adi`.layoffs_staging t2
	on t1.company = t2.company
	and t1.location = t2.location
where t1.industry is null or t1.industry=''
and t2.industry is not null;

select t1.industry, t2.industry 
from `rama adi`.layoffs_staging t1 
join `rama adi`.layoffs_staging t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry='')
and t2.industry is not null;

update `rama adi`.layoffs_staging set industry = null
	where industry = '';

update `rama adi`.layoffs_staging t1  
join `rama adi`.layoffs_staging t2
	on t1.company = t2.company
set t1.industry = t2.industry 
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

# 4. Country
select distinct country from `rama adi`.layoffs_staging order by 1;

select * from `rama adi`.layoffs_staging where country like '%United States%';

select distinct country, trim(trailing '.' from country) from `rama adi`.layoffs_staging order by 1;

update `rama adi`.layoffs_staging 
set country = trim(trailing '.' from country)
where country like 'United States%';

# 5. Tanggal / Date
select `date`, str_to_date(`date`, '%m/%d/%Y')
from `rama adi`.layoffs_staging;

update `rama adi`.layoffs_staging
set date = str_to_date(`date`, '%m/%d/%Y'); #merubah bentuk ke mont-date-years menjadi lebih rapi dan urut

select `date` from `rama adi`.layoffs_staging;

alter table `rama adi`.layoffs_staging
modify column `date` Date; #mengubah dari text ke date

# 6. Total_laif_off
select * from `rama adi`.layoffs_staging where total_laid_off is null and percentage_laid_off is null ;

delete from `rama adi`.layoffs_staging where total_laid_off is null and percentage_laid_off is null;

# 7. menghapus row_num
alter table `rama adi`.layoffs_staging
drop column row_num;


select * from `rama adi`.layoffs_staging;