select * from `rama adi`.layoffs;

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

insert into `rama adi`.layoffs_staging select *,
	row_number() over(
    partition by `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions` ) as row_num
from `rama adi`.layoffs;

select * from `rama adi`.layoffs_staging;

select * from `rama adi`.layoffs_staging where row_num > 1;

select * from `rama adi`.layoffs_staging where company = 'Yahoo';

delete from `rama adi`.layoffs_staging where row_num > 1;

